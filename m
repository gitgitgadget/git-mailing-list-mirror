From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 06/11] git p4 test: run as user "author"
Date: Tue, 21 Jan 2014 18:16:43 -0500
Message-ID: <1390346208-9207-7-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:18:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kau-0001wh-3K
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbaAUXSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:18:52 -0500
Received: from honk.padd.com ([74.3.171.149]:46547 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbaAUXSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:18:52 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 34A107112;
	Tue, 21 Jan 2014 15:18:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A3EB3200F7; Tue, 21 Jan 2014 18:18:48 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240796>

The tests use author@example.com as the canonical submitter,
but he does not have an entry in the p4 users database.
This causes the generated change description to complain
that the git and p4 users disagree.  The complaint message
is still valid, just isn't useful in tests.  It was was
introduced in 848de9c (git-p4: warn if git authorship won't
be retained, 2011-05-13).

Fix t9813 to use @example.com instead of @localhost due to
change in p4_add_user().  Move the function into the git p4
test library so author can be added at initialization time.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh                  | 15 ++++++++++++++-
 t/t9813-git-p4-preserve-users.sh | 38 ++++++++++++++------------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index ccd918e..4ff2bb1 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -47,9 +47,10 @@ P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 
 P4PORT=localhost:$P4DPORT
 P4CLIENT=client
+P4USER=author
 P4EDITOR=:
 unset P4CHARSET
-export P4PORT P4CLIENT P4EDITOR P4CHARSET
+export P4PORT P4CLIENT P4USER P4EDITOR P4CHARSET
 
 db="$TRASH_DIRECTORY/db"
 cli="$TRASH_DIRECTORY/cli"
@@ -96,12 +97,24 @@ start_p4d() {
 		return 1
 	fi
 
+	# build a p4 user so author@example.com has an entry
+	p4_add_user author
+
 	# build a client
 	client_view "//depot/... //client/..." &&
 
 	return 0
 }
 
+p4_add_user() {
+	name=$1 &&
+	p4 user -f -i <<-EOF
+	User: $name
+	Email: $name@example.com
+	FullName: Dr. $name
+	EOF
+}
+
 kill_p4d() {
 	pid=$(cat "$pidfile")
 	# it had better exist for the first kill
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index f2e85e5..166b840 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -19,16 +19,6 @@ test_expect_success 'create files' '
 	)
 '
 
-p4_add_user() {
-	name=$1 fullname=$2 &&
-	p4 user -f -i <<-EOF &&
-	User: $name
-	Email: $name@localhost
-	FullName: $fullname
-	EOF
-	p4 passwd -P secret $name
-}
-
 p4_grant_admin() {
 	name=$1 &&
 	{
@@ -51,8 +41,8 @@ make_change_by_user() {
 
 # Test username support, submitting as user 'alice'
 test_expect_success 'preserve users' '
-	p4_add_user alice Alice &&
-	p4_add_user bob Bob &&
+	p4_add_user alice &&
+	p4_add_user bob &&
 	p4_grant_admin alice &&
 	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
@@ -60,8 +50,8 @@ test_expect_success 'preserve users' '
 		cd "$git" &&
 		echo "username: a change by alice" >>file1 &&
 		echo "username: a change by bob" >>file2 &&
-		git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
-		git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
+		git commit --author "Alice <alice@example.com>" -m "a change by alice" file1 &&
+		git commit --author "Bob <bob@example.com>" -m "a change by bob" file2 &&
 		git config git-p4.skipSubmitEditCheck true &&
 		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit --preserve-user &&
 		p4_check_commit_author file1 alice &&
@@ -78,7 +68,7 @@ test_expect_success 'refuse to preserve users without perms' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEditCheck true &&
 		echo "username-noperms: a change by alice" >>file1 &&
-		git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
+		git commit --author "Alice <alice@example.com>" -m "perms: a change by alice" file1 &&
 		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		test_must_fail git p4 commit --preserve-user &&
@@ -94,9 +84,9 @@ test_expect_success 'preserve user where author is unknown to p4' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEditCheck true &&
 		echo "username-bob: a change by bob" >>file1 &&
-		git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
+		git commit --author "Bob <bob@example.com>" -m "preserve: a change by bob" file1 &&
 		echo "username-unknown: a change by charlie" >>file1 &&
-		git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
+		git commit --author "Charlie <charlie@example.com>" -m "preserve: a change by charlie" file1 &&
 		P4EDITOR=touch P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		test_must_fail git p4 commit --preserve-user &&
@@ -121,24 +111,24 @@ test_expect_success 'not preserving user with mixed authorship' '
 	(
 		cd "$git" &&
 		git config git-p4.skipSubmitEditCheck true &&
-		p4_add_user derek Derek &&
+		p4_add_user derek &&
 
-		make_change_by_user usernamefile3 Derek derek@localhost &&
+		make_change_by_user usernamefile3 Derek derek@example.com &&
 		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		git p4 commit |\
-		grep "git author derek@localhost does not match" &&
+		grep "git author derek@example.com does not match" &&
 
-		make_change_by_user usernamefile3 Charlie charlie@localhost &&
+		make_change_by_user usernamefile3 Charlie charlie@example.com &&
 		git p4 commit |\
-		grep "git author charlie@localhost does not match" &&
+		grep "git author charlie@example.com does not match" &&
 
-		make_change_by_user usernamefile3 alice alice@localhost &&
+		make_change_by_user usernamefile3 alice alice@example.com &&
 		git p4 commit |\
 		test_must_fail grep "git author.*does not match" &&
 
 		git config git-p4.skipUserNameCheck true &&
-		make_change_by_user usernamefile3 Charlie charlie@localhost &&
+		make_change_by_user usernamefile3 Charlie charlie@example.com &&
 		git p4 commit |\
 		test_must_fail grep "git author.*does not match" &&
 
-- 
1.8.5.2.320.g99957e5
