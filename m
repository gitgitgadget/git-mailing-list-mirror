From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 6/8] contrib/subtree: Handle '--prefix' argument with a slash appended
Date: Mon, 18 Feb 2013 14:56:51 -0600
Message-ID: <1361221013-12756-7-git-send-email-greened@obbligato.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7XnI-0005RN-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755752Ab3BRU6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:58:12 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45288 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755553Ab3BRU6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:58:07 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7Xoi-0000E4-Iu; Mon, 18 Feb 2013 15:00:05 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1361221013-12756-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> 'git subtree
    merge' will fail if the argument of '--prefix' has a slash appended. Signed-off-by:
    Techlive Zheng <techlivezheng@gmail.com> Signed-off-by: David A. Greene <greened@obbligato.org>
    --- contrib/subtree/git-subtree.sh | 2 +- contrib/subtree/t/t7900-subtree.sh
    | 20 ++++++++++++++++++++ 2 files changed, 21 insertions(+), 1 deletion(-)
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- -- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216526>

From: Techlive Zheng <techlivezheng@gmail.com>

'git subtree merge' will fail if the argument of '--prefix' has a slash
appended.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |    2 +-
 contrib/subtree/t/t7900-subtree.sh |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 6c3929b..1b3df99 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -82,7 +82,7 @@ while [ $# -gt 0 ]; do
 		--annotate) annotate="$1"; shift ;;
 		--no-annotate) annotate= ;;
 		-b) branch="$1"; shift ;;
-		-P) prefix="$1"; shift ;;
+		-P) prefix="${1%/}"; shift ;;
 		-m) message="$1"; shift ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index eee032d..5c6c73d 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -255,6 +255,26 @@ test_expect_success 'merge new subproj history into subdir/ with --squash and --
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
+		test_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
 #
 # Tests for 'git subtree split'
 #
-- 
1.7.10.4
