From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 12/13] contrib/subtree: Handle '--prefix' argument with a slash appended
Date: Tue,  5 Feb 2013 05:36:58 -0600
Message-ID: <1360064219-28789-13-git-send-email-greened@obbligato.org>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
Cc: Techlive Zheng <techlivezheng@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 13:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2hJe-0003CW-8F
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 13:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab3BEMHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 07:07:35 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38276 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751858Ab3BEMHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 07:07:33 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2grh-00055A-Bj; Tue, 05 Feb 2013 05:39:05 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360064219-28789-1-git-send-email-greened@obbligato.org>
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
    | 19 +++++++++++++++++++ 2 files changed, 20 insertions(+), 1 deletion(-)
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215493>

From: Techlive Zheng <techlivezheng@gmail.com>

'git subtree merge' will fail if the argument of '--prefix' has a slash
appended.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |    2 +-
 contrib/subtree/t/t7900-subtree.sh |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index c72af95..0493e47 100755
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
index 769b116..1afd544 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -239,6 +239,25 @@ test_expect_success 'merge new subproj history into subdir/ with --squash and --
 	)
 '
 
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
