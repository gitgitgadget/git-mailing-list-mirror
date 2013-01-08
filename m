From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 2/7] contrib/subtree: Use %B for Split Subject/Body
Date: Tue,  8 Jan 2013 06:09:52 -0600
Message-ID: <1357646997-28675-3-git-send-email-greened@obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
Cc: Techlive Zheng <techlivezheng@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 13:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsY1e-00022P-7h
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 13:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab3AHMLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 07:11:04 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51749 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755857Ab3AHMLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 07:11:03 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TsY8q-0003z5-Em; Tue, 08 Jan 2013 06:18:53 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357646997-28675-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> Use %B to format
    the commit message and body to avoid an extra newline if a commit only has
    a subject line. Signed-off-by: Techlive Zheng <techlivezheng@gmail.com> [...]
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
     
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212957>

From: Techlive Zheng <techlivezheng@gmail.com>

Use %B to format the commit message and body to avoid an extra newline
if a commit only has a subject line.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |    6 +++++-
 contrib/subtree/t/t7900-subtree.sh |   15 +++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..5341b36 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -296,7 +296,11 @@ copy_commit()
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
-	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
+	# Use %B rather than %s%n%n%b to handle the special case of a
+	# commit that only has a subject line.  We don't want to
+	# introduce a newline after the subject, causing generation of
+	# a new hash.
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
