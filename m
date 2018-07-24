Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B471F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbeGXKbx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 06:31:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:57158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726367AbeGXKbx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 06:31:53 -0400
Received: (qmail 7627 invoked by uid 109); 24 Jul 2018 09:26:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 09:26:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25602 invoked by uid 111); 24 Jul 2018 09:26:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 05:26:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 05:26:18 -0400
Date:   Tue, 24 Jul 2018 05:26:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] automatically ban strcpy()
Message-ID: <20180724092618.GA3288@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180724092329.GA24250@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few standard C functions (like strcpy) which are
easy to misuse. E.g.:

  char path[PATH_MAX];
  strcpy(path, arg);

may overflow the "path" buffer. Sometimes there's an earlier
constraint on the size of "arg", but even in such a case
it's hard to verify that the code is correct. If the size
really is unbounded, you're better off using a dynamic
helper like strbuf:

  struct strbuf path = STRBUF_INIT;
  strbuf_addstr(path, arg);

or if it really is bounded, then use xsnprintf to show your
expectation (and get a run-time assertion):

  char path[PATH_MAX];
  xsnprintf(path, sizeof(path), "%s", arg);

which makes further auditing easier.

We'd usually catch undesirable code like this in a review,
but there's no automated enforcement. Adding that
enforcement can help us be more consistent and save effort
(and a round-trip) during review.

This patch teaches the compiler to report an error when it
sees strcpy (and will become a model for banning a few other
functions). This has a few advantages over a separate
linting tool:

  1. We know it's run as part of a build cycle, so it's
     hard to ignore. Whereas an external linter is an extra
     step the developer needs to remember to do.

  2. Likewise, it's basically free since the compiler is
     parsing the code anyway.

  3. We know it's robust against false positives (unlike a
     grep-based linter).

The two big disadvantages are:

  1. We'll only check code that is actually compiled, so it
     may miss code that isn't triggered on your particular
     system. But since presumably people don't add new code
     without compiling it (and if they do, the banned
     function list is the least of their worries), we really
     only care about failing to clean up old code when
     adding new functions to the list. And that's easy
     enough to address with a manual audit when adding a new
     function.

  2. If this ends up generating false positives, it's going
     to be harder to disable (as opposed to a separate
     linter, which may have mechanisms for overriding a
     particular case).

     But the intent is to only ban functions which are
     obviously bad, and for which we accept using an
     alternative even when this particular use isn't buggy
     (e.g., the xsnprintf alternative above).

The implementation here is simple: we'll define a macro for
the banned function which replaces it with a descriptively
named but undefined function.  Replacing it with any invalid
code would work (since we just want to break compilation).
But ideally we'd meet these goals:

 - it should be portable; ideally this would trigger
   everywhere, and does not need to be part of a DEVELOPER=1
   setup (because unlike warnings which may depend on the
   compiler or system, this is a clear indicator of
   something wrong in the code).

 - it should generate a readable error that gives the
   developer a clue what happened

 - it should avoid generating too much other cruft that
   makes it hard to see the actual error

 - it should mention the original callsite in the error

The output with this patch looks like this (using gcc 7, on
a checkout without 022d2ac1f3, which removes the final
strcpy from blame.c):

      CC builtin/blame.o
  In file included from ./git-compat-util.h:1242:0,
                   from ./cache.h:4,
                   from builtin/blame.c:8:
  builtin/blame.c: In function ‘cmd_blame’:
  ./banned.h:11:22: error: implicit declaration of function ‘sorry_strcpy_is_a_banned_function’ [-Werror=implicit-function-declaration]
   #define BANNED(func) sorry_##func##_is_a_banned_function()
                        ^
  ./banned.h:13:21: note: in expansion of macro ‘BANNED’
   #define strcpy(x,y) BANNED(strcpy)
                       ^~~~~~
  builtin/blame.c:1074:4: note: in expansion of macro ‘strcpy’
      strcpy(repeated_meta_color, GIT_COLOR_CYAN);
      ^~~~~~

This pretty clearly shows the original callsite along with
the descriptive function name, and it mentions banned.h,
which contains more information.

What's not perfectly ideal is:

  1. We'll only trigger with -Wimplicit-function-declaration
     (and only stop compilation with -Werror). These are
     generally enabled by DEVELOPER=1. If you _don't_ have
     that set, we'll still catch the problem, but only at
     link-time, with a slightly less useful message:

       /usr/bin/ld: builtin/blame.o: in function `cmd_blame':
       /home/peff/tmp/builtin/blame.c:1074: undefined reference to `sorry_strcpy_is_a_banned_function'
       collect2: error: ld returned 1 exit status

     If instead we convert this to a reference to an
     undefined variable, that always dies immediately. But
     gcc seems to print the set of errors twice, which
     clutters things up.

  2. The expansion through BANNED() adds an extra layer of
     error. Curiously, though, removing it (and just
     expanding strcpy directly to the bogus function name)
     causes gcc _not_ to report the original line of code.

So experimentally, this seems to behave pretty well on gcc.
Clang looks OK, too, though:

 - it actually produces a better message for the undeclared
   identifier than for the implicit function (it doesn't
   double the errors, and for the implicit function it
   actually produces an extra complaint about
   strict-prototypes).

 - the BANNED indirection has no effect (it shows the
   original line of code either way)

So if we want to optimize for clang's output, we could
switch both of those decisions.

Note that the linux kernel has a similar mechanism which
goes by BUILD_BUG_ON_MSG(). It works by declaring a one-off
function with gcc's error attribute. That doesn't work for
us here, because we'd like to work even on non-gcc
compilers (and in my opinion the compiler output is actually
_less_ readable).

Signed-off-by: Jeff King <peff@peff.net>
---
 banned.h          | 16 ++++++++++++++++
 git-compat-util.h |  6 ++++++
 2 files changed, 22 insertions(+)
 create mode 100644 banned.h

diff --git a/banned.h b/banned.h
new file mode 100644
index 0000000000..c50091ad7d
--- /dev/null
+++ b/banned.h
@@ -0,0 +1,16 @@
+#ifndef BANNED_H
+#define BANNED_H
+
+/*
+ * This header lists functions that have been banned from our code base,
+ * because they're too easy to misuse (and even if used correctly,
+ * complicate audits). Including this header turns them into compile-time
+ * errors.
+ */
+
+#define BANNED(func) sorry_##func##_is_a_banned_function()
+
+#undef strcpy
+#define strcpy(x,y) BANNED(strcpy)
+
+#endif /* BANNED_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998b24..89d37095c7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1239,4 +1239,10 @@ extern void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
 
+/*
+ * This include must come after system headers, since it introduces macros that
+ * replace system names.
+ */
+#include "banned.h"
+
 #endif
-- 
2.18.0.542.g2bf2fc4f7e

