From: David Greene <greened@obbligato.org>
Subject: [PATCH 7/7] contrib/subtree: Handle '--prefix' argument with a slash appended
Date: Thu,  5 Nov 2015 21:35:03 -0600
Message-ID: <1446780903-22156-8-git-send-email-greened@obbligato.org>
References: <1446780903-22156-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com,
	"David A . Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 05:20:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuYW7-00076B-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 05:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031254AbbKFEUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 23:20:43 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48859 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030793AbbKFEUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 23:20:42 -0500
X-Greylist: delayed 2718 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2015 23:20:42 EST
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1ZuXpJ-0005Zp-VX; Thu, 05 Nov 2015 21:36:34 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446780903-22156-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280952>

From: Techlive Zheng <techlivezheng@gmail.com>

'git subtree merge' will fail if the argument of '--prefix' has a slash
appended.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |  2 +-
 contrib/subtree/t/t7900-subtree.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 308b777..edf36f8 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -90,7 +90,7 @@ while [ $# -gt 0 ]; do
 		--annotate) annotate="$1"; shift ;;
 		--no-annotate) annotate= ;;
 		-b) branch="$1"; shift ;;
-		-P) prefix="$1"; shift ;;
+		-P) prefix="${1%/}"; shift ;;
 		-m) message="$1"; shift ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 2683d7d..751aee3 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -257,6 +257,26 @@ test_expect_success 'merge the added subproj again, should do nothing' '
 	)
 '
 
+next_test
+test_expect_success 'merge new subproj history into subdir/ with a slash appended to the argument of --prefix' '
+	test_create_repo "$test_count" &&
+	test_create_repo "$test_count/subproj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subproj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree add --prefix=subdir/ FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/subproj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subproj master &&
+		git subtree merge --prefix=subdir/ FETCH_HEAD &&
+		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
 #
 # Tests for 'git subtree split'
 #
-- 
2.6.1
