From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 3/8] xdiff: handle appended chunks better with -W
Date: Sat, 28 May 2016 17:00:28 +0200
Message-ID: <5749B28C.5010006@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 17:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fjE-0005Fy-By
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbcE1PAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:00:36 -0400
Received: from mout.web.de ([212.227.15.14]:55920 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbcE1PAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:00:35 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lvw4L-1bZzMG2Gmj-017pLD; Sat, 28 May 2016 17:00:29
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5749AF59.2070704@web.de>
X-Provags-ID: V03:K0:HR+hcuc7HllKFOkRIKG7eyk8BjqOCErIchuAZWk3hxydyOUDkKy
 X5/llZSQ1PHEumpbyPeDAP1wQ4C829Mr3sUWcks9LXxPx5BAeDLJb6WoBjHVA2VKJs8ZGJw
 rQhlm/M+Z0EVMx3lQp7yUKwYwEXs4+zBJL/6Ec5aXAV1tnvckpY95oTdl0YHaTpqTp0Fays
 HhaWCyxg16yYhbxP/Lkjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q1UfvHos+Gs=:zst5JR/VxAVBIbKQo3zdUl
 npObwS5EaGZr3kwfTGr3b+FBwG2HnoSK12zkRm/x2NoCMmNh5VTiBTEJb9gF8r5tIfWTbYVsw
 dFPc559oIV4haAYjR7PgfuAz3njvCH3BtqdFHvzs3wk56/FNt3yNiTrEKl9CNdzZqfLEvdPFd
 ltMBydVHnOuPUSuCie1H2v5bBaTbAz8LZv3CmNJcO8vUTcjdvRIJZroe38jDUf+5z5Vhffmp2
 TnT2LwEUWx7u/PdQt00jVzdODgIEnb8nNJoUvtd/W+QmGSMLbUZwwVHBYWDHKeCqjGeT7FTbi
 iKCImYWFdUioh/kK6myxu7tIOMS9HVAL5I1lixEX6glg69fg8DwOu6H1G4EZ7N7nzkAtMSveu
 nM3+ueOD3/mLmaqfmTDDjPbMM/NZ3zJStGxv1VsvgyNL+idjO5TaYBka0BwLdtRCMFvh/3VVe
 tNu0j5v/+5FsC6kNd3TzDRnrzzeTXcr57s590xe5kCxR+FpEYTzR0h2yFup55zBvnapJRK4kq
 57++u8MYNs/3IFc9sTkYzJqAJzFEI0P1eZ0oV58BYPLqJfji7gm9s67lw5a6fRT21FNfS9KEa
 6dp4h3jr911j/tUTr+kgpwsW8KLJVAwZScXDH1sW5fdrSFiJCsiN8nz9HDonTHYirRxOXqNeB
 jMB4aY+o63ouY8E6tQw3gZzwxF0HxRdGQdT82p5P0jO8CgpHuM9MMihD4+4y7FZvuaErIxVcO
 4ZTVLiLXoHSuG85JbC3diHG8wdIuei9aQGIasZ+b9acneqBS3cRitOTiw00mKGIY/GsUI83u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295819>

If lines are added at the end of a file, diff -W shows the whole file.
That's because get_func_line() only considers the pre-image and gives up
if it sees a record index beyond its end.

Consider the post-image as well to see if the added lines already make
up a full function.  If it doesn't then search for the previous function
line by starting from the bottom of the pre-image, thereby avoiding to
confuse get_func_line().

Reuse the existing label called "again", as it's exactly where we need
to jump to when we're done handling the pre-context, but rename it to
"post_context_calculation" in order to document its new purpose better.

Reported-by: Junio C Hamano <gitster@pobox.com>
Initial-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh |  2 +-
 xdiff/xemit.c                    | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index a3adba4..d78461d 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -131,7 +131,7 @@ test_expect_success ' context includes end' '
 	grep "^[+].*End of second part" extended.diff
 '
 
-test_expect_failure ' context does not include other functions' '
+test_expect_success ' context does not include other functions' '
 	test $(grep -c "^[ +-].*Begin" extended.diff) -le 2
 '
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 0c87637..969100d 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -171,7 +171,28 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
 
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
-			long fs1 = get_func_line(xe, xecfg, NULL, xch->i1, -1);
+			long fs1, i1 = xch->i1;
+
+			/* Appended chunk? */
+			if (i1 >= xe->xdf1.nrec) {
+				char dummy[1];
+
+				/*
+				 * We don't need additional context if
+				 * a whole function was added.
+				 */
+				if (match_func_rec(&xe->xdf2, xecfg, xch->i2,
+						   dummy, sizeof(dummy)) >= 0)
+					goto post_context_calculation;
+
+				/*
+				 * Otherwise get more context from the
+				 * pre-image.
+				 */
+				i1 = xe->xdf1.nrec - 1;
+			}
+
+			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
 			if (fs1 < 0)
 				fs1 = 0;
 			if (fs1 < s1) {
@@ -180,7 +201,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			}
 		}
 
- again:
+ post_context_calculation:
 		lctx = xecfg->ctxlen;
 		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
 		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
@@ -209,7 +230,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 				if (l <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
-					goto again;
+					goto post_context_calculation;
 				}
 			}
 		}
-- 
2.8.3
