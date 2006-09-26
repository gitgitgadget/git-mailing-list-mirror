From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Remove empty ref directories that prevent creating a ref.
Date: Tue, 26 Sep 2006 07:23:37 +0200
Message-ID: <20060926072337.39dbb9f4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 07:17:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS5K5-0000bU-QR
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 07:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWIZFRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 01:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIZFRe
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 01:17:34 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:14752 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751090AbWIZFRe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 01:17:34 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id E0E68758E7;
	Tue, 26 Sep 2006 07:17:32 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27774>

Junio wrote:
"BTW, the second issue exists without packed ref; currently we
cannot do

    git branch foo/bar
    git branch -d foo/bar
    git branch foo"

This patch also add Linus and Junio test cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This fixed patch also applies to master, that's why it doesn't
contain test cases using "git pack-refs". I will send a separate
patch for them latter.

 git-branch.sh     |   16 ++++++++++++++++
 t/t3200-branch.sh |   12 ++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index e0501ec..834888d 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -112,6 +112,22 @@ rev=$(git-rev-parse --verify "$head") ||
 git-check-ref-format "heads/$branchname" ||
 	die "we do not like '$branchname' as a branch name."
 
+LF='
+'
+
+if [ -d "$GIT_DIR/refs/heads/$branchname" ]
+then
+	OLD_IFS="$IFS"
+	IFS="$LF"
+	for refdir in `find "$GIT_DIR/refs/heads/$branchname" -type d | sort -r`
+	do
+		rmdir "$refdir" || \
+		    die "Could not delete '$refdir'," \
+		    "there may still be a ref there."
+	done
+	IFS="$OLD_IFS"
+fi
+
 if [ -e "$GIT_DIR/refs/heads/$branchname" ]
 then
 	if test '' = "$force"
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5b04efc..6907cbc 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -61,4 +61,16 @@ test_expect_success \
 	 test -f .git/logs/refs/heads/g/h/i &&
 	 diff expect .git/logs/refs/heads/g/h/i'
 
+test_expect_success \
+    'git branch j/k should work after branch j has been deleted' \
+       'git-branch j &&
+        git-branch -d j &&
+        git-branch j/k'
+
+test_expect_success \
+    'git branch l should work after branch l/m has been deleted' \
+       'git-branch l/m &&
+        git-branch -d l/m &&
+        git-branch l'
+
 test_done
-- 
1.4.2.1.ged17-dirty
