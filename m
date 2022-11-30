Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C710FC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 21:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiK3VPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 16:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3VPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 16:15:17 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F15B85676
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 13:15:15 -0800 (PST)
Received: (qmail 19167 invoked by uid 109); 30 Nov 2022 21:15:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Nov 2022 21:15:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8398 invoked by uid 111); 30 Nov 2022 21:15:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Nov 2022 16:15:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Nov 2022 16:15:14 -0500
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] git-compat-util: avoid redefining system function names
Message-ID: <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 12:01:35AM -0500, Jeff King wrote:

> All this points to 15b52a44e0 being a bit too loose with its
> assumptions. It is assuming that if the posix flag is not defined, we
> are free to use those system names. But here's an example where that is
> not true. And the only way around it is with a macro, which is what we
> had before that commit.
> 
> So I think we'd want to revert the flockfile() bits of that commit. And
> I'd guess setitimer is in the same boat (the system may declare it, but
> for whatever reason somebody may choose not to use it by feeding
> NO_SETITIMER to make, at which point the compiler will complain about
> the duplicate declaration.

After sleeping on this, here's a best-of-both-worlds solution.

Junio: this is perhaps maint material in the long run, but the breakage
goes back to v2.29.0, so definitely not urgent for the release period.
Note that if you go farther back than what will become maint-2.39,
there's a minor textual conflict around the UNUSED markers.

-- >8 --
Subject: [PATCH] git-compat-util: avoid redefining system function names

Our git-compat-util header defines a few noop wrappers for system
functions if they are not available. This was originally done with a
macro, but in 15b52a44e0 (compat-util: type-check parameters of no-op
replacement functions, 2020-08-06) we switched to inline functions,
because it gives us basic type-checking.

This can cause compilation failures when the system _does_ declare those
functions but we choose not to use them, since the compiler will
complain about the redeclaration. This was seen in the real world when
compiling against certain builds of uclibc, which may leave
_POSIX_THREAD_SAFE_FUNCTIONS unset, but still declare flockfile() and
funlockfile().

It can also be seen on any platform that has setitimer() if you choose
to compile without it (which plausibly could happen if the system
implementation is buggy). E.g., on Linux:

  $ make NO_SETITIMER=IWouldPreferNotTo git.o
      CC git.o
  In file included from builtin.h:4,
                   from git.c:1:
  git-compat-util.h:344:19: error: conflicting types for ‘setitimer’; have ‘int(int,  const struct itimerval *, struct itimerval *)’
    344 | static inline int setitimer(int which UNUSED,
        |                   ^~~~~~~~~
  In file included from git-compat-util.h:234:
  /usr/include/x86_64-linux-gnu/sys/time.h:155:12: note: previous declaration of ‘setitimer’ with type ‘int(__itimer_which_t,  const struct itimerval * restrict,  struct itimerval * restrict)’
    155 | extern int setitimer (__itimer_which_t __which,
        |            ^~~~~~~~~
  make: *** [Makefile:2714: git.o] Error 1

Here I think the compiler is complaining about the lack of "restrict"
annotations in our version, but even if we matched it completely (and
there is no way to match all platforms anyway), it would still complain
about a static declaration following a non-static one. Using macros
doesn't have this problem, because the C preprocessor rewrites the name
in our code before we hit this level of compilation.

One way to fix this would just be to revert most of 15b52a44e0. What we
really cared about there was catching build problems with
precompose_argv(), which most platforms _don't_ build, and which is our
custom function. So we could just switch the system wrappers back to
macros; most people build the real versions anyway, and they don't
change. So the extra type-checking isn't likely to catch bugs.

But with a little work, we can have our cake and eat it, too. If we
define the type-checking wrappers with a unique name, and then redirect
the system names to them with macros, we still get our type checking,
but without redeclaring the system function names.

Signed-off-by: Jeff King <peff@peff.net>
---
I confirmed that this builds on Linux with NO_SETITIMER, and still
catches type problems if you intentionally break one of the callers.

Technically these should probably all have "#undef flockfile" and so on,
but we've never done that, and we haven't seen an actual platform that
complains. So I didn't include that here. I don't mind if somebody wants
to, but it should be a separate patch on top.

 git-compat-util.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a76d0526f7..83ec7b7941 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -341,11 +341,12 @@ struct itimerval {
 #endif
 
 #ifdef NO_SETITIMER
-static inline int setitimer(int which UNUSED,
-			    const struct itimerval *value UNUSED,
-			    struct itimerval *newvalue UNUSED) {
+static inline int git_setitimer(int which UNUSED,
+				const struct itimerval *value UNUSED,
+				struct itimerval *newvalue UNUSED) {
 	return 0; /* pretend success */
 }
+#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
 #endif
 
 #ifndef NO_LIBGEN_H
@@ -1471,14 +1472,16 @@ int open_nofollow(const char *path, int flags);
 #endif
 
 #ifndef _POSIX_THREAD_SAFE_FUNCTIONS
-static inline void flockfile(FILE *fh UNUSED)
+static inline void git_flockfile(FILE *fh UNUSED)
 {
 	; /* nothing */
 }
-static inline void funlockfile(FILE *fh UNUSED)
+static inline void git_funlockfile(FILE *fh UNUSED)
 {
 	; /* nothing */
 }
+#define flockfile(fh) git_flockfile(fh)
+#define funlockfile(fh) git_funlockfile(fh)
 #define getc_unlocked(fh) getc(fh)
 #endif
 
-- 
2.39.0.rc1.456.gb53e2f823e

