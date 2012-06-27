From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 03/10] git p4 test: simplify quoting involving TRASH_DIRECTORY
Date: Wed, 27 Jun 2012 08:00:56 -0400
Message-ID: <1340798463-14499-4-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjqwo-0004Fo-36
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab2F0MCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:02:09 -0400
Received: from honk.padd.com ([74.3.171.149]:52773 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837Ab2F0MCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:02:08 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 8BAF470BC;
	Wed, 27 Jun 2012 05:02:06 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D801631383; Wed, 27 Jun 2012 08:02:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200716>

For temporary files that are created in the top-level TRASH_DIRECTORY,
trust that the tests do not chdir except in subshells, and avoid some
quoting.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh            | 11 +++++------
 t/t9805-git-p4-skip-submit-edit.sh |  9 ++++-----
 t/t9806-git-p4-options.sh          | 14 ++++++--------
 t/t9808-git-p4-chdir.sh            |  4 ++--
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 0f410c4..7401c21 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -126,15 +126,14 @@ test_expect_success 'clone two dirs, @all, conflicting files' '
 '
 
 test_expect_success 'exit when p4 fails to produce marshaled output' '
-	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
-	mkdir "$badp4dir" &&
-	test_when_finished "rm \"$badp4dir/p4\" && rmdir \"$badp4dir\"" &&
-	cat >"$badp4dir"/p4 <<-EOF &&
+	mkdir badp4dir &&
+	test_when_finished "rm badp4dir/p4 && rmdir badp4dir" &&
+	cat >badp4dir/p4 <<-EOF &&
 	#!$SHELL_PATH
 	exit 1
 	EOF
-	chmod 755 "$badp4dir"/p4 &&
-	PATH="$badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
+	chmod 755 badp4dir/p4 &&
+	PATH="$TRASH_DIRECTORY/badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
 	test $retval -eq 1 &&
 	test_must_fail grep -q Traceback errs
 '
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 353dcfb..fb3c8ec 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -78,20 +78,19 @@ test_expect_success 'skipSubmitEditCheck' '
 test_expect_success 'no config, edited' '
 	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
-	ed="$TRASH_DIRECTORY/ed.sh" &&
-	test_when_finished "rm \"$ed\"" &&
-	cat >"$ed" <<-EOF &&
+	test_when_finished "rm ed.sh" &&
+	cat >ed.sh <<-EOF &&
 		#!$SHELL_PATH
 		sleep 1
 		touch "\$1"
 		exit 0
 	EOF
-	chmod 755 "$ed" &&
+	chmod 755 ed.sh &&
 	(
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 5" &&
-		P4EDITOR="" EDITOR="\"$ed\"" git p4 submit &&
+		P4EDITOR="" EDITOR="\"$TRASH_DIRECTORY/ed.sh\"" git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 5 wc
 	)
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 83738fa..a37c6cb 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -39,10 +39,9 @@ test_expect_success 'clone --branch' '
 '
 
 test_expect_success 'clone --changesfile' '
-	cf="$TRASH_DIRECTORY/cf" &&
-	test_when_finished "rm \"$cf\"" &&
-	printf "1\n3\n" >"$cf" &&
-	git p4 clone --changesfile="$cf" --dest="$git" //depot &&
+	test_when_finished "rm cf" &&
+	printf "1\n3\n" >cf &&
+	git p4 clone --changesfile="$TRASH_DIRECTORY/cf" --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
@@ -55,10 +54,9 @@ test_expect_success 'clone --changesfile' '
 '
 
 test_expect_success 'clone --changesfile, @all' '
-	cf="$TRASH_DIRECTORY/cf" &&
-	test_when_finished "rm \"$cf\"" &&
-	printf "1\n3\n" >"$cf" &&
-	test_must_fail git p4 clone --changesfile="$cf" --dest="$git" //depot@all
+	test_when_finished "rm cf" &&
+	printf "1\n3\n" >cf &&
+	test_must_fail git p4 clone --changesfile="$TRASH_DIRECTORY/cf" --dest="$git" //depot@all
 '
 
 # imports both master and p4/master in refs/heads
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 2f8014a..dc92e60 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -21,7 +21,7 @@ test_expect_success 'init depot' '
 # environment variable is set
 test_expect_success 'P4CONFIG and absolute dir clone' '
 	printf "P4PORT=$P4PORT\nP4CLIENT=$P4CLIENT\n" >p4config &&
-	test_when_finished "rm \"$TRASH_DIRECTORY/p4config\"" &&
+	test_when_finished "rm p4config" &&
 	test_when_finished cleanup_git &&
 	(
 		P4CONFIG=p4config && export P4CONFIG &&
@@ -33,7 +33,7 @@ test_expect_success 'P4CONFIG and absolute dir clone' '
 # same thing, but with relative directory name, note missing $ on --dest
 test_expect_success 'P4CONFIG and relative dir clone' '
 	printf "P4PORT=$P4PORT\nP4CLIENT=$P4CLIENT\n" >p4config &&
-	test_when_finished "rm \"$TRASH_DIRECTORY/p4config\"" &&
+	test_when_finished "rm p4config" &&
 	test_when_finished cleanup_git &&
 	(
 		P4CONFIG=p4config && export P4CONFIG &&
-- 
1.7.11.1.69.gd505fd2
