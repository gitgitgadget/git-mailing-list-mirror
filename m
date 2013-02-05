From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 02/13] contrib/subtree: Use %B for Split Subject/Body
Date: Mon,  4 Feb 2013 22:06:02 -0600
Message-ID: <1360037173-23291-3-git-send-email-greened@obbligato.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:08:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ZpC-0005jF-R1
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383Ab3BEEHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:07:33 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38000 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754584Ab3BEEHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:07:32 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2Zpe-0003ZD-R5; Mon, 04 Feb 2013 22:08:31 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360037173-23291-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> Use %B to format
    the commit message and body to avoid an extra newline if a commit only has
    a subject line. Signed-off-by: Techlive Zheng <techlivezheng@gmail.com> Signed-off-by:
    David A. Greene <greened@obbligato.org> --- contrib/subtree/git-subtree.sh
    | 2 +- contrib/subtree/t/t7900-subtree.sh | 15 +++++++++++++++ 2 files changed,
    16 insertions(+), 1 deletion(-) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215442>

From: Techlive Zheng <techlivezheng@gmail.com>

Use %B to format the commit message and body to avoid an extra newline
if a commit only has a subject line.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |    2 +-
 contrib/subtree/t/t7900-subtree.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..5598210 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -296,7 +296,7 @@ copy_commit()
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
-	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
+	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
 	(
 		read GIT_AUTHOR_NAME
 		read GIT_AUTHOR_EMAIL
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 6cf9fb9..3f17f55 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -74,6 +74,10 @@ test_expect_success 'add sub1' '
         git branch -m master subproj
 '
 
+# Save this hash for testing later.
+
+subdir_hash=`git rev-parse HEAD`
+
 test_expect_success 'add sub2' '
         create sub2 &&
         git commit -m "sub2" &&
@@ -211,6 +215,17 @@ test_expect_success 'check split with --branch' '
         check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
 '
 
+test_expect_success 'check hash of split' '
+        spl1=$(git subtree split --prefix subdir) &&
+        undo &&
+        git subtree split --prefix subdir --branch splitbr1test &&
+        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
+        git checkout splitbr1test &&
+        new_hash=$(git rev-parse HEAD~2) &&
+        git checkout mainline &&
+        check_equal ''"$new_hash"'' "$subdir_hash"
+'
+
 test_expect_success 'check split with --branch for an existing branch' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
-- 
1.7.10.4
