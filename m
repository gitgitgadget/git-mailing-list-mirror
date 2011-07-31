From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/4] git-p4: make tests work on p4d eval server
Date: Sat, 30 Jul 2011 20:39:13 -0400
Message-ID: <20110731003913.GC4867@arf.padd.com>
References: <20110731003557.GA4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 02:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnK3t-0000f5-3f
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 02:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab1GaAjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 20:39:17 -0400
Received: from honk.padd.com ([74.3.171.149]:36338 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab1GaAjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 20:39:16 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id BB87D223A;
	Sat, 30 Jul 2011 17:39:15 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5C58B31731; Sat, 30 Jul 2011 20:39:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110731003557.GA4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178224>

The "evaluation" license for p4d allows only two users.  One of
the users will be auto-created as super when generating the first
commit or adding the first new user.  So we cannot have both an
Alice and Bob as well as super.  Instead, adapt the tests to work
with just a single Alice user.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   44 ++++++++++++++++++++++++++++++--------------
 1 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index aec3ba1..04d8413 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -149,6 +149,13 @@ p4_grant_admin() {
 	p4 protect -i
 }
 
+p4_ungrant_admin() {
+    name=$1
+    p4 protect -o |\
+	grep -v $name |\
+	p4 protect -i
+}
+
 p4_check_commit_author() {
     file=$1
     user=$2
@@ -167,22 +174,30 @@ make_change_by_user() {
 	git commit --author "$name <$email>" -m "a change by $name"
 }
 
-# Test username support, submitting as user 'alice'
+marshal_dump() {
+	what=$1
+	python -c 'import marshal, sys; d = marshal.load(sys.stdin); print d["'$what'"]'
+}
+
+# Test username support, submitting as user 'alice'.  Second user will be
+# whoever is running these tests.  Cannot avoid having p4d auto-create that
+# user, and the eval version only supports two users.
 test_expect_success 'preserve users' '
+	bobuser=$(p4 -G users | marshal_dump User) &&
+	bobemail=$(p4 -G users | marshal_dump Email) &&
 	p4_add_user alice Alice &&
-	p4_add_user bob Bob &&
 	p4_grant_admin alice &&
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	cd "$git" &&
 	echo "username: a change by alice" >> file1 &&
-	echo "username: a change by bob" >> file2 &&
+	echo "username: a change by $bobuser" >> file2 &&
 	git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
-	git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
+	git commit --author "$bobuser <$bobemail>" -m "a change by $bobuser" file2 &&
 	git config git-p4.skipSubmitEditCheck true &&
 	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
 	p4_check_commit_author file1 alice &&
-	p4_check_commit_author file2 bob
+	p4_check_commit_author file2 $bobuser
 '
 
 # Test username support, submitting as bob, who lacks admin rights. Should
@@ -191,9 +206,10 @@ test_expect_success 'refuse to preserve users without perms' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	cd "$git" &&
-	echo "username-noperms: a change by alice" >> file1 &&
-	git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
-	! P4EDITOR=touch P4USER=bob P4PASSWD=secret "$GITP4" commit --preserve-user &&
+	p4_ungrant_admin alice &&
+	echo "username-noperms: a change by $bobuser" >> file1 &&
+	git commit --author "$bobuser <$bobemail>" -m "perms: a change by $bobuser" file1 &&
+	! P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
 	! git diff --exit-code HEAD..p4/master > /dev/null
 '
 
@@ -202,9 +218,10 @@ test_expect_success 'preserve user where author is unknown to p4' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	cd "$git" &&
-	git config git-p4.skipSubmitEditCheck true
-	echo "username-bob: a change by bob" >> file1 &&
-	git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
+	git config git-p4.skipSubmitEditCheck true &&
+	p4_grant_admin alice &&
+	echo "username-bob: a change by $bobuser" >> file1 &&
+	git commit --author "$bobuser <$bobemail>" -m "preserve: a change by $bobuser" file1 &&
 	echo "username-unknown: a change by charlie" >> file1 &&
 	git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
 	! P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
@@ -226,11 +243,10 @@ test_expect_success 'not preserving user with mixed authorship' '
 	test_when_finished cleanup_git &&
 	cd "$git" &&
 	git config git-p4.skipSubmitEditCheck true &&
-	p4_add_user derek Derek &&
 
-	make_change_by_user usernamefile3 Derek derek@localhost &&
+	make_change_by_user usernamefile3 $bobuser $bobemail &&
 	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
-	grep "git author derek@localhost does not match" actual &&
+	grep "git author $bobemail does not match" actual &&
 
 	make_change_by_user usernamefile3 Charlie charlie@localhost &&
 	P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit >actual &&
-- 
1.7.5.4
