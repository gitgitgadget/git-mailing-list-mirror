From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v5] git-p4: warn if git authorship won't be retained
Date: Thu, 12 May 2011 06:05:56 +0100
Message-ID: <1305176756-27046-2-git-send-email-luke@diamand.org>
References: <1305176756-27046-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 07:06:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKO6O-0006oU-Bb
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 07:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120Ab1ELFGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 01:06:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50533 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab1ELFGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 01:06:14 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so878044wya.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 22:06:14 -0700 (PDT)
Received: by 10.217.2.202 with SMTP id p52mr6646778wes.28.1305176773997;
        Wed, 11 May 2011 22:06:13 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id d54sm408283wej.10.2011.05.11.22.06.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2011 22:06:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1305176756-27046-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173440>

If the git commits you are submitting contain changes made by
other people, the authorship will not be retained. Change git-p4
to warn of this and to note that --preserve-user can be used
to solve the problem (if you have suitable permissions).
The warning can be disabled.

Add a test case and update documentation.

Acked-by: Pete Wyckoff <pw@padd.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4     |   33 ++++++++++++++++++++++++++-
 contrib/fast-import/git-p4.txt |    7 ++++++
 t/t9800-git-p4.sh              |   47 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index bd8c761..021b985 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -614,6 +614,7 @@ class P4Submit(Command, P4UserMap):
         self.verbose = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.isWindows = (platform.system() == "Windows")
+        self.myP4UserId = None
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
@@ -721,6 +722,25 @@ class P4Submit(Command, P4UserMap):
                     return 1
         return 0
 
+    def p4UserId(self):
+        if self.myP4UserId:
+            return self.myP4UserId
+
+        results = p4CmdList("user -o")
+        for r in results:
+            if r.has_key('User'):
+                self.myP4UserId = r['User']
+                return r['User']
+        die("Could not find your p4 user id")
+
+    def p4UserIsMe(self, p4User):
+        # return True if the given p4 user is actually me
+        me = self.p4UserId()
+        if not p4User or p4User != me:
+            return False
+        else:
+            return True
+
     def prepareSubmitTemplate(self):
         # remove lines in the Files section that show changes to files outside the depot path we're committing into
         template = ""
@@ -750,8 +770,7 @@ class P4Submit(Command, P4UserMap):
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
 
-        if self.preserveUser:
-            (p4User, gitEmail) = self.p4UserForCommit(id)
+        (p4User, gitEmail) = self.p4UserForCommit(id)
 
         if not self.detectRenames:
             # If not explicitly set check the config variable
@@ -887,6 +906,11 @@ class P4Submit(Command, P4UserMap):
                     newdiff += "+" + line
                 f.close()
 
+            if self.checkAuthorship and not self.p4UserIsMe(p4User):
+                submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
+                submitTemplate += "######## Use git-p4 option --preserve-user to modify authorship.\n"
+                submitTemplate += "######## Use git-p4 config git-p4.skipUserNameCheck hides this message.\n"
+
             separatorLine = "######## everything below this line is just the diff #######\n"
 
             [handle, fileName] = tempfile.mkstemp()
@@ -998,6 +1022,11 @@ class P4Submit(Command, P4UserMap):
             commits.append(line.strip())
         commits.reverse()
 
+        if self.preserveUser or (gitConfig("git-p4.skipUserNameCheck") == "true"):
+            self.checkAuthorship = False
+        else:
+            self.checkAuthorship = True
+
         if self.preserveUser:
             self.checkValidP4Users(commits)
 
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index d46b7a5..3c7c138 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -226,6 +226,13 @@ stop. With allowMissingPerforceUsers set to true, git-p4 will use the
 current user (i.e. the behavior without --preserve-user) and carry on with
 the perforce commit.
 
+git-p4.skipUserNameCheck
+
+  git config [--global] git-p4.skipUserNameCheck false
+
+When submitting, git-p4 checks that the git commits are authored by the current
+p4 user, and warns if they are not. This disables the check.
+
 Implementation Details...
 =========================
 
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 4fb0e24..888ad54 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -160,6 +160,15 @@ p4_check_commit_author() {
     fi
 }
 
+make_change_by_user() {
+	file=$1
+	name=$2
+	email=$3
+	echo "username: a change by $name" >> $file &&
+	git add $file &&
+	git commit --author "$name <$email>" -m "a change by $name"
+}
+
 # Test username support, submitting as user 'alice'
 test_expect_success 'preserve users' '
 	p4_add_user alice Alice &&
@@ -213,6 +222,44 @@ test_expect_success 'preserve user where author is unknown to p4' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+# If we're *not* using --preserve-user, git-p4 should warn if we're submitting
+# changes that are not all ours.
+# Test: user in p4 and user unknown to p4.
+# Test: warning disabled and user is the same.
+test_expect_success 'not preserving user with mixed authorship' '
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+	cd "$git" &&
+	git config git-p4.skipSubmitEditCheck true &&
+	p4_add_user derek Derek &&
+
+	make_change_by_user usernamefile3 Derek derek@localhost &&
+	(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
+		grep "git author derek@localhost does not match" > /dev/null) &&
+	git diff --exit-code HEAD..p4/master &&
+
+	make_change_by_user usernamefile3 Charlie charlie@localhost &&
+	(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
+		grep "git author charlie@localhost does not match" > /dev/null) &&
+	git diff --exit-code HEAD..p4/master &&
+
+	make_change_by_user usernamefile3 alice alice@localhost &&
+	!(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
+		grep "does not match" > /dev/null) &&
+	git diff --exit-code HEAD..p4/master &&
+
+	git config git-p4.skipUserNameCheck true &&
+	make_change_by_user usernamefile3 Charlie charlie@localhost &&
+	!(P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |
+		grep "git author charlie@localhost does not match" > /dev/null) &&
+	git diff --exit-code HEAD..p4/master &&
+
+	p4_check_commit_author usernamefile3 alice
+	) &&
+	rm -rf "$git" && mkdir "$git"
+'
+
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.1
