From: Jeff King <peff@peff.net>
Subject: [PATCH 18/25] t1301: use modern test_* helpers
Date: Fri, 20 Mar 2015 06:13:11 -0400
Message-ID: <20150320101311.GR12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvg-0005qT-Hr
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbCTKNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:35714 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbbCTKNO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:14 -0400
Received: (qmail 5920 invoked by uid 102); 20 Mar 2015 10:13:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:14 -0500
Received: (qmail 21634 invoked by uid 107); 20 Mar 2015 10:13:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:11 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265892>

This shortens the code and fixes some &&-chaining.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1301-shared-repo.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 7eecfb8..ac10875 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,12 +12,11 @@ setfacl -k . 2>/dev/null
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '
+	test_when_finished "rm -rf sub" &&
 	mkdir sub && (
-		cd sub && git init --shared=0400
+		cd sub &&
+		test_must_fail git init --shared=0400
 	)
-	ret="$?"
-	rm -rf sub
-	test $ret != "0"
 '
 
 modebits () {
@@ -33,7 +32,7 @@ do
 			git init --shared=1 &&
 			test 1 = "$(git config core.sharedrepository)"
 		) &&
-		actual=$(ls -l sub/.git/HEAD)
+		actual=$(ls -l sub/.git/HEAD) &&
 		case "$actual" in
 		-rw-rw-r--*)
 			: happy
@@ -90,10 +89,8 @@ do
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(modebits .git/info/refs)" &&
-		test "x$actual" = "x-$y" || {
-			ls -lt .git/info
-			false
-		}
+		verbose test "x$actual" = "x-$y"
+
 	'
 
 	umask 077 &&
@@ -102,10 +99,7 @@ do
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(modebits .git/info/refs)" &&
-		test "x$actual" = "x-$x" || {
-			ls -lt .git/info
-			false
-		}
+		verbose test "x$actual" = "x-$x"
 
 	'
 
-- 
2.3.3.520.g3cfbb5d
