Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DA71F597
	for <e@80x24.org>; Thu, 26 Jul 2018 07:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeGZIgh (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 04:36:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:59730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728584AbeGZIgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 04:36:37 -0400
Received: (qmail 21729 invoked by uid 109); 26 Jul 2018 07:21:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Jul 2018 07:21:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14180 invoked by uid 111); 26 Jul 2018 07:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 26 Jul 2018 03:21:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2018 03:21:05 -0400
Date:   Thu, 26 Jul 2018 03:21:05 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] automatically ban strcpy()
Message-ID: <20180726072105.GA6057@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
 <20180724092618.GA3288@sigill.intra.peff.net>
 <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
 <20180726065840.GA27349@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180726065840.GA27349@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 02:58:40AM -0400, Jeff King wrote:

> On Tue, Jul 24, 2018 at 01:20:58PM -0400, Eric Sunshine wrote:
> 
> > On Tue, Jul 24, 2018 at 5:26 AM Jeff King <peff@peff.net> wrote:
> > >   1. We'll only trigger with -Wimplicit-function-declaration
> > >      (and only stop compilation with -Werror). These are
> > >      generally enabled by DEVELOPER=1. If you _don't_ have
> > >      that set, we'll still catch the problem, but only at
> > >      link-time, with a slightly less useful message:
> > >
> > >      If instead we convert this to a reference to an
> > >      undefined variable, that always dies immediately. But
> > >      gcc seems to print the set of errors twice, which
> > >      clutters things up.
> > 
> > The above does a pretty good job of convincing me that this ought to
> > be implemented via an undefined variable rather than undefined
> > function, exactly because it is the newcomer or casual contributor who
> > is most likely to trip over a banned function, and almost certainly
> > won't have DEVELOPER=1 set. The gcc clutter seems a minor point
> > against the benefit this provides to that audience.
> 
> OK. I was on the fence, but it should be pretty trivial to switch. Let
> me see if I can just make a replacement for patch 1, or if the whole
> thing needs to be rebased on top.

The rest apply cleanly (because they're far enough away textually from
the definition of BANNED).

So here's a replacement for just patch 1 (I'm assuming this creates less
work than re-posting them all, but it may not be if Junio prefers
dealing with a whole new mbox rather than a "rebase -i", "reset --hard
HEAD^", "git am" -- let me know if you'd prefer it the other way).

-- >8 --
Subject: [PATCH] automatically ban strcpy()

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
     function (which is what I did for the functions here).

  2. If this ends up generating false positives, it's going
     to be harder to disable (as opposed to a separate
     linter, which may have mechanisms for overriding a
     particular case).

     But the intent is to only ban functions which are
     obviously bad, and for which we accept using an
     alternative even when this particular use isn't buggy
     (e.g., the xsnprintf alternative above).

The implementation here is simple: we'll define a macro for
the banned function which replaces it with a reference to a
descriptively named but undeclared identifier.  Replacing it
with any invalid code would work (since we just want to
break compilation).  But ideally we'd meet these goals:

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
a checkout with 022d2ac1f3 reverted, which removed the final
strcpy from blame.c):

      CC builtin/blame.o
  In file included from ./git-compat-util.h:1246,
                   from ./cache.h:4,
                   from builtin/blame.c:8:
  builtin/blame.c: In function ‘cmd_blame’:
  ./banned.h:11:22: error: ‘sorry_strcpy_is_a_banned_function’ undeclared (first use in this function)
   #define BANNED(func) sorry_##func##_is_a_banned_function
                        ^~~~~~
  ./banned.h:14:21: note: in expansion of macro ‘BANNED’
   #define strcpy(x,y) BANNED(strcpy)
                       ^~~~~~
  builtin/blame.c:1074:4: note: in expansion of macro ‘strcpy’
      strcpy(repeated_meta_color, GIT_COLOR_CYAN);
      ^~~~~~
  ./banned.h:11:22: note: each undeclared identifier is reported only once for each function it appears in
   #define BANNED(func) sorry_##func##_is_a_banned_function
                        ^~~~~~
  ./banned.h:14:21: note: in expansion of macro ‘BANNED’
   #define strcpy(x,y) BANNED(strcpy)
                       ^~~~~~
  builtin/blame.c:1074:4: note: in expansion of macro ‘strcpy’
      strcpy(repeated_meta_color, GIT_COLOR_CYAN);
      ^~~~~~

This prominently shows the phrase "strcpy is a banned
function", along with the original callsite in blame.c and
the location of the ban code in banned.h. Which should be
enough to get even a developer seeing this for the first
time pointed in the right direction.

This doesn't match our ideals perfectly, but it's a pretty
good balance. A few alternatives I tried:

  1. Instead of using an undeclared variable, using an
     undeclared function. This shortens the message, because
     the "each undeclared identifier" message is not needed
     (and as you can see above, it triggers a separate
     mention of each of the expansion points).

     But it doesn't actually stop compilation unless you use
     -Werror=implicit-function-declaration in your CFLAGS.
     This is the case for DEVELOPER=1, but not for a default
     build (on the other hand, we'd eventually produce a
     link error pointing to the correct source line with the
     descriptive name).

  2. The linux kernel uses a similar mechanism in its
     BUILD_BUG_ON_MSG(), where they actually declare the
     function but do so with gcc's error attribute. But
     that's not portable to other compilers (and it also
     runs afoul of our error() macro).

     We could make a gcc-specific technique and fallback on
     other compilers, but it's probably not worth the
     complexity. It also isn't significantly shorter than
     the error message shown above.

  3. We could drop the BANNED() macro, which would shorten
     the number of lines in the error. But curiously,
     removing it (and just expanding strcpy directly to the
     bogus identifier) causes gcc _not_ to report the
     original line of code.

So this strategy seems to be an acceptable mix of
information, portability, simplicity, and robustness,
without _too_ much extra clutter. I also tested it with
clang, and it looks as good (actually, slightly less
cluttered than with gcc).

Signed-off-by: Jeff King <peff@peff.net>
---
 banned.h          | 16 ++++++++++++++++
 git-compat-util.h |  6 ++++++
 2 files changed, 22 insertions(+)
 create mode 100644 banned.h

diff --git a/banned.h b/banned.h
new file mode 100644
index 0000000000..1a3e526570
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
+#define BANNED(func) sorry_##func##_is_a_banned_function
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
2.18.0.795.g7103b4bd43

