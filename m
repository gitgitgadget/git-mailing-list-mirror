From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/2] git-p4: remove bash-ism in t9800
Date: Sun, 26 Feb 2012 10:37:27 -0500
Message-ID: <1330270647-8817-3-git-send-email-pw@padd.com>
References: <1330270647-8817-1-git-send-email-pw@padd.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 16:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1gAy-0004z1-C2
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 16:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab2BZPiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 10:38:11 -0500
Received: from honk.padd.com ([74.3.171.149]:41132 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2BZPiK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 10:38:10 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id C46F824A6;
	Sun, 26 Feb 2012 07:38:09 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AAC7F313D8; Sun, 26 Feb 2012 10:38:07 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.288.g74b75
In-Reply-To: <1330270647-8817-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191566>

This works in both bash and dash:

    arf$ bash -c 'VAR=1 env' | grep VAR
    VAR=1
    arf$ dash -c 'VAR=1 env' | grep VAR
    VAR=1

But the variables are not propagated through a function
in dash:

    arf$ bash -c 'f() { "$@"
    }; VAR=1 f "env"' | grep VAR
    VAR=1
    arf$ dash -c 'f() { "$@"
    }; VAR=1 f "env"' | grep VAR

Fix constructs like this, in particular, setting variables
through test_must_fail.

Based-on-patch-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 04ee20e..9f17cdb 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -234,8 +234,11 @@ test_expect_success 'refuse to preserve users without perms' '
 		git config git-p4.skipSubmitEditCheck true &&
 		echo "username-noperms: a change by alice" >>file1 &&
 		git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
-		P4EDITOR=touch P4USER=bob P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
-		test_must_fail git diff --exit-code HEAD..p4/master
+		# dashism: test_must_fail does not propagate variables
+		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
+		export P4EDITOR P4USER P4PASSWD &&
+		test_must_fail "$GITP4" commit --preserve-user &&
+		! git diff --exit-code HEAD..p4/master
 	)
 '
 
@@ -250,13 +253,15 @@ test_expect_success 'preserve user where author is unknown to p4' '
 		git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
 		echo "username-unknown: a change by charlie" >>file1 &&
 		git commit --author "Charlie <charlie@localhost>" -m "preserve: a change by charlie" file1 &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
-		test_must_fail git diff --exit-code HEAD..p4/master &&
+		P4EDITOR=touch P4USER=alice P4PASSWD=secret &&
+		export P4EDITOR P4USER P4PASSWD &&
+		test_must_fail "$GITP4" commit --preserve-user &&
+		! git diff --exit-code HEAD..p4/master &&
 
 		echo "$0: repeat with allowMissingP4Users enabled" &&
 		git config git-p4.allowMissingP4Users true &&
 		git config git-p4.preserveUser true &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit &&
+		"$GITP4" commit &&
 		git diff --exit-code HEAD..p4/master &&
 		p4_check_commit_author file1 alice
 	)
@@ -275,20 +280,22 @@ test_expect_success 'not preserving user with mixed authorship' '
 		p4_add_user derek Derek &&
 
 		make_change_by_user usernamefile3 Derek derek@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
+		export P4EDITOR P4USER P4PASSWD &&
+		"$GITP4" commit |\
 		grep "git author derek@localhost does not match" &&
 
 		make_change_by_user usernamefile3 Charlie charlie@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		"$GITP4" commit |\
 		grep "git author charlie@localhost does not match" &&
 
 		make_change_by_user usernamefile3 alice alice@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" |\
+		"$GITP4" commit |\
 		test_must_fail grep "git author.*does not match" &&
 
 		git config git-p4.skipUserNameCheck true &&
 		make_change_by_user usernamefile3 Charlie charlie@localhost &&
-		P4EDITOR=cat P4USER=alice P4PASSWD=secret "$GITP4" commit |\
+		"$GITP4" commit |\
 		test_must_fail grep "git author.*does not match" &&
 
 		p4_check_commit_author usernamefile3 alice
-- 
1.7.9.2.288.g74b75
