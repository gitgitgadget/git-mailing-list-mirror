From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/5] diff: handle appended chunks better with -W
Date: Sat, 21 May 2016 20:45:43 +0200
Message-ID: <5740ACD7.8010404@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Bug-0001Ip-FS
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 20:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbcEUSqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 14:46:10 -0400
Received: from mout.web.de ([212.227.15.4]:58446 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbcEUSqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 14:46:08 -0400
Received: from [192.168.178.36] ([79.237.63.247]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LlJzS-1betlp14Z4-00b0be; Sat, 21 May 2016 20:45:59
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5740AC28.6010202@web.de>
X-Provags-ID: V03:K0:lxD78n9bZt64DB52RsA/iHrwbfZit3PRdWh8rCGgEp8TSLp/HJZ
 x7siJcyjmrDGJ8/gVJpaoI0V02auXZv01qsMkCbeyzkTmyXpKuvJ51LpDpJ3WczNQ4xIl2E
 Uz7Cqh7k190+qO66GaYseQiv6ERQ77JXvWeGeHWnBiGoEsKlAmOd6HPtaLglz8jNHyH6uMG
 WAAzsVRKNBXeYOejrYIFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lcjy4uM75vk=:RWZzfytYhC0ZaS5CyphWSI
 UHWS14YILAgslRDGr5/XGWKQsSGfm03IT1ggHx/bmzj4BXYKOD2qMFJO6DdYzWfVXGx0d6L84
 VfozUlCMbEeHk/o2idfXoL0uTRnf/zAuj+MQ8oVjwHHTzSR32Cp9MUFro+8Lq1zK9GWweCuQQ
 LAxJIfGiy0pp/dX1wZb5P7zLiUc+ymm3sNgFkPJSO0URZnZVKa9SrKGVjh9bpM5qi342hBbPr
 QnYUN7UAARpbC0sxpl5hCvfbnb9Kw2nQn/r5rPjoluoACR/j1Yw4+whjeOi+NeX0220ospS4k
 ZvlvY3S09i8AzzPZXbhEpbKa2jqIcb0s3umhbnkFVFrpdfUA82aZ94dmWHNGqNd/qWQ2f/zcG
 JWpVtZUJUL5tPRsiCMUzBZdBmbKsd7NVtg9o07Z95AporTHZQK0wsqhdHWBYziQKoaBqKVSNh
 dPMGwtAEZd2jdeue0SWKQj1FcvB3ff4uS/B+IaW3mHgekFPM6QPsnTyGbrC2km+wHRfMnAhSe
 ivvIVYaKky6yo5ZzVERlW+jiqBFIMEudFMOaaJtjhNw54jLJqh9O1tqSf+sdh0n2DvhVlTgp8
 dds9BZ5Goey1haaHauZuVlQcMok0QLLDlGwCiHKLQglIuO0JAEipHesn0dZz/dw1WSptICuiO
 Tc6Pi/O5VpSu68mTLnqxuFYjeesYXRjBzknebvWJo/9i/UVSVV8FgnwD2/h+6I3L3ffBFLWjd
 O5XtdXX/C0XxetSJsnGQ3X/HhxPhl6B+pGkh7LBm+c1yPLwvmXcr4N4GhpjIMbK9ixiNaIm5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295234>

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
 xdiff/xemit.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

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
