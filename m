Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83351F597
	for <e@80x24.org>; Thu, 19 Jul 2018 20:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeGSVXu (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:23:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:53206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727523AbeGSVXu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:23:50 -0400
Received: (qmail 9062 invoked by uid 109); 19 Jul 2018 20:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 20:39:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16509 invoked by uid 111); 19 Jul 2018 20:39:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 16:39:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 16:39:01 -0400
Date:   Thu, 19 Jul 2018 16:39:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180719203901.GA8079@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180719203259.GA7869@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few standard C functions (like strcpy) which are
easy to misuse. We generally discourage these in reviews,
but we haven't put advice in CodingGuidelines, nor provided
any automated enforcement. The latter is especially
important because it's more consistent, and it can often
save a round-trip of review.

Let's start by banning strcpy() and sprintf(). It's not
impossible to use these correctly, but it's easy to do so
incorrectly, and there's always a better option.

For enforcement, we can rely on the compiler and just
introduce code which breaks compilation when it sees these
functions. This has a few advantages:

  1. We know it's run as part of a build cycle, so it's
     hard to ignore. Whereas an external linter is an extra
     step the developer needs to remember to do.

  2. Likewise, it's basically free since the compiler is
     parsing the code anyway.

  3. We know it's robust against false positives (unlike a
     grep-based linter).

The one big disadvantage is that it will only check code
that is actually compiled, so it may miss code that isn't
triggered on your particular system. But since presumably
people don't add new code without compiling it (and if they
do, the banned function list is the least of their worries),
we really only care about failing to clean up old code when
adding new functions to the list. And that's easy enough to
address with a manual audit when adding a new function
(which is what I did for the functions here).

That leaves only the question of how to trigger the
compilation error. The goals are:

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

The technique used here is to convert the banned function
into a call to a descriptive but non-existent function. The
output from gcc 7 looks like this (on a checkout without
022d2ac1f3, which removes the final strcpy from blame.c):

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

Signed-off-by: Jeff King <peff@peff.net>
---
So you might guess that I experimented mostly with gcc
(which is what I normally use), and then just double-checked
clang at the end. After seeing those results, I actually
think clang does a better job of producing good error
messages overall, and perhaps we should not cater to gcc. I
dunno. It probably doesn't matter that much either way.

I'd also be happy if somebody showed an alternative that
is even cleaner. Sadly I don't think you can trigger an
#error from the _expansion_ of a macro.

 Documentation/CodingGuidelines |  3 +++
 banned.h                       | 19 +++++++++++++++++++
 git-compat-util.h              |  2 ++
 3 files changed, 24 insertions(+)
 create mode 100644 banned.h

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfbd..232f17becd 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -391,6 +391,9 @@ For C programs:
    must be declared with "extern" in header files. However, function
    declarations should not use "extern", as that is already the default.
 
+ - A few easy-to-misuse functions like `strcpy` are banned; see
+   `banned.h` for the complete list.
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
diff --git a/banned.h b/banned.h
new file mode 100644
index 0000000000..fe81020e0f
--- /dev/null
+++ b/banned.h
@@ -0,0 +1,19 @@
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
+#define strcpy(x,y) BANNED(strcpy)
+
+#ifdef HAVE_VARIADIC_MACROS
+#define sprintf(...) BANNED(sprintf)
+#endif
+
+#endif /* BANNED_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998b24..51bece30ac 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1239,4 +1239,6 @@ extern void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
 
+#include "banned.h"
+
 #endif
-- 
2.18.0.540.g6c38643a7b

