From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] xdiff: print post-image for common records instead of pre-image
Date: Fri, 06 Jan 2012 18:13:00 +0100
Message-ID: <4F072B9C.1030005@lsrfire.ath.cx>
References: <7vlipx4q3r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 18:13:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjDM1-0007a6-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 18:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837Ab2AFRNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 12:13:16 -0500
Received: from india601.server4you.de ([85.25.151.105]:43922 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758808Ab2AFRNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 12:13:15 -0500
Received: from [192.168.2.105] (p4FFDA94D.dip.t-dialin.net [79.253.169.77])
	by india601.server4you.de (Postfix) with ESMTPSA id AED512F8060;
	Fri,  6 Jan 2012 18:13:12 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vlipx4q3r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188036>

Normally it doesn't matter if we show the pre-image or th post-image
for the common parts of a diff because they are the same.  If
white-space changes are ignored they can differ, though.  The
new text after applying the diff is more interesting in that case,
so show that instead of the old contents.

Note: GNU diff shows the pre-image.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t4015-diff-whitespace.sh |   14 +++++++-------
 xdiff/xemit.c              |   12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 9059bcd..cc3db13 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -103,7 +103,7 @@ test_expect_success 'another test, with -w --ignore-space-at-eol' 'test_cmp expe
 git diff -w -b --ignore-space-at-eol > out
 test_expect_success 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'
 
-tr 'Q' '\015' << EOF > expect
+tr 'Q_' '\015 ' << EOF > expect
 diff --git a/x b/x
 index d99af23..8b32fb5 100644
 --- a/x
@@ -111,19 +111,19 @@ index d99af23..8b32fb5 100644
 @@ -1,6 +1,6 @@
 -whitespace at beginning
 +	whitespace at beginning
- whitespace change
+ whitespace 	 change
 -whitespace in the middle
 +white space in the middle
- whitespace at end
+ whitespace at end__
  unchanged line
- CR at endQ
+ CR at end
 EOF
 git diff -b > out
 test_expect_success 'another test, with -b' 'test_cmp expect out'
 git diff -b --ignore-space-at-eol > out
 test_expect_success 'another test, with -b --ignore-space-at-eol' 'test_cmp expect out'
 
-tr 'Q' '\015' << EOF > expect
+tr 'Q_' '\015 ' << EOF > expect
 diff --git a/x b/x
 index d99af23..8b32fb5 100644
 --- a/x
@@ -135,9 +135,9 @@ index d99af23..8b32fb5 100644
 +	whitespace at beginning
 +whitespace 	 change
 +white space in the middle
- whitespace at end
+ whitespace at end__
  unchanged line
- CR at endQ
+ CR at end
 EOF
 git diff --ignore-space-at-eol > out
 test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect out'
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 2e669c3..d11dbf9 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -87,7 +87,7 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
 
 static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
                            xdemitconf_t const *xecfg) {
-	xdfile_t *xdf = &xe->xdf1;
+	xdfile_t *xdf = &xe->xdf2;
 	const char *rchg = xdf->rchg;
 	long ix;
 
@@ -204,8 +204,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		/*
 		 * Emit pre-context.
 		 */
-		for (; s1 < xch->i1; s1++)
-			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+		for (; s2 < xch->i2; s2++)
+			if (xdl_emit_record(&xe->xdf2, s2, " ", ecb) < 0)
 				return -1;
 
 		for (s1 = xch->i1, s2 = xch->i2;; xch = xch->next) {
@@ -213,7 +213,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			 * Merge previous with current change atom.
 			 */
 			for (; s1 < xch->i1 && s2 < xch->i2; s1++, s2++)
-				if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+				if (xdl_emit_record(&xe->xdf2, s2, " ", ecb) < 0)
 					return -1;
 
 			/*
@@ -239,8 +239,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		/*
 		 * Emit post-context.
 		 */
-		for (s1 = xche->i1 + xche->chg1; s1 < e1; s1++)
-			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+		for (s2 = xche->i2 + xche->chg2; s2 < e2; s2++)
+			if (xdl_emit_record(&xe->xdf2, s2, " ", ecb) < 0)
 				return -1;
 	}
 
-- 
1.7.8.2
