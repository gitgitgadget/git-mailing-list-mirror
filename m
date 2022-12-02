Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C57C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiLBLFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiLBLFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:05:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1426BC5A1
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:05:39 -0800 (PST)
Received: (qmail 28058 invoked by uid 109); 2 Dec 2022 11:05:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Dec 2022 11:05:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3343 invoked by uid 111); 2 Dec 2022 11:05:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Dec 2022 06:05:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Dec 2022 06:05:38 -0500
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid redefining system function names
Message-ID: <Y4ncAhIqHkckMljb@coredump.intra.peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
 <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
 <Y4nN2h4FIYGNjCSI@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4nN2h4FIYGNjCSI@debian.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2022 at 05:05:14PM +0700, Bagas Sanjaya wrote:

> I got many of redefinition warnings when cross-compiling on Buildroot
> with the patch above, like:
> 
> In file included from cache.h:4,
>                  from common-main.c:1:
> git-compat-util.h:1485: warning: "getc_unlocked" redefined
>  1485 | #define getc_unlocked(fh) getc(fh)
>       | 
> In file included from git-compat-util.h:216,
>                  from cache.h:4,
>                  from common-main.c:1:
> /home/bagas/repo/buildroot/output/host/aarch64-buildroot-linux-uclibc/sysroot/usr/include/stdio.h:835: note: this is the location of the previous definition
>   835 | #define getc_unlocked(_fp) __GETC_UNLOCKED(_fp)

I imagine you'd get that without my patch, too, since I didn't touch the
getc_unlocked() line at all. Or maybe it simply didn't get that far
because of the other redeclared functions.

Anyway, we probably want this on top of the other patch.

-- >8 --
Subject: [PATCH] git-compat-util: undefine system names before redeclaring
 them

When we define a macro to point a system function (e.g., flockfile) to
our custom wrapper, we should make sure that the system did not already
define it as a macro. This is rarely a problem, but can cause
compilation failures if both of these are true:

  - we decide to define our own wrapper even though the system provides
    the function; we know this happens at least with uclibc, which may
    declare flockfile, etc, without _POSIX_THREAD_SAFE_FUNCTIONS

  - the system version is declared as a macro; we know this happens at
    least with uclibc's version of getc_unlocked()

So just handling getc_unlocked() would be sufficient to deal with the
real-world case we've seen. But since it's easy to do, we may as well be
defensive about the other macro wrappers added in the previous patch.

Signed-off-by: Jeff King <peff@peff.net>
---
There may be other similar cases lurking throughout the code base, but I
don't think it's worth anybody's time to go looking for them. If one of
them triggers on a real platform, we can deal with it then.

 git-compat-util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 83ec7b7941..76e4b11131 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -346,6 +346,7 @@ static inline int git_setitimer(int which UNUSED,
 				struct itimerval *newvalue UNUSED) {
 	return 0; /* pretend success */
 }
+#undef setitimer
 #define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
 #endif
 
@@ -1480,6 +1481,9 @@ static inline void git_funlockfile(FILE *fh UNUSED)
 {
 	; /* nothing */
 }
+#undef flockfile
+#undef funlockfile
+#undef getc_unlocked
 #define flockfile(fh) git_flockfile(fh)
 #define funlockfile(fh) git_funlockfile(fh)
 #define getc_unlocked(fh) getc(fh)
-- 
2.39.0.rc1.456.gb53e2f823e

