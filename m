From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 03/10] Call 'say' outside test_expect_success
Date: Wed, 18 Mar 2009 22:27:05 +0100
Message-ID: <9d346b6be9eb260b94a8f1bcd995932a311f03af.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Ks-000574-V7
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbZCRV1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbZCRV1m
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46765 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CACE5CDF8C;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 881E560E6E;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113682>

There were some uses of 'say' inside test_expect_success. But if the tests
were not run in verbose mode, this message went to /dev/null. Pull them out
of test_expect_success.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0050-filesystem.sh |    9 +++++++--
 t/t3600-rm.sh         |    3 ++-
 t/t7005-editor.sh     |   29 +++++++++++++----------------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 7edf49d..a449580 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -8,6 +8,7 @@ auml=`printf '\xc3\xa4'`
 aumlcdiar=`printf '\x61\xcc\x88'`
 
 case_insensitive=
+unibad=
 test_expect_success 'see if we expect ' '
 
 	test_case=test_expect_success
@@ -19,7 +20,6 @@ test_expect_success 'see if we expect ' '
 	then
 		test_case=test_expect_failure
 		case_insensitive=t
-		say "will test on a case insensitive filesystem"
 	fi &&
 	rm -fr junk &&
 	mkdir junk &&
@@ -27,13 +27,18 @@ test_expect_success 'see if we expect ' '
 	case "$(cd junk && echo *)" in
 	"$aumlcdiar")
 		test_unicode=test_expect_failure
-		say "will test on a unicode corrupting filesystem"
+		unibad=t
 		;;
 	*)	;;
 	esac &&
 	rm -fr junk
 '
 
+test "$case_insensitive" &&
+	say "will test on a case insensitive filesystem"
+test "$unibad" &&
+	say "will test on a unicode corrupting filesystem"
+
 if test "$case_insensitive"
 then
 test_expect_success "detection of case insensitive filesystem during repo init" '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 74ea8e0..2aefbcf 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -21,10 +21,11 @@ embedded'
 embedded' &&
      git commit -m 'add files with tabs and newlines'
      else
-         say 'Your filesystem does not allow tabs in filenames.'
          test_tabs=n
      fi"
 
+test "$test_tabs" = n && say 'Your filesystem does not allow tabs in filenames.'
+
 # Later we will try removing an unremovable path to make sure
 # git rm barfs, but if the test is run as root that cannot be
 # arranged.
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 2d919d6..2f8404a 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -87,30 +87,27 @@ do
 	'
 done
 
+if ! echo 'echo space > "$1"' > "e space.sh"
+then
+	say "Skipping; FS does not support spaces in filenames"
+	test_done
+	exit
+fi
+
 test_expect_success 'editor with a space' '
 
-	if echo "echo space > \"\$1\"" > "e space.sh"
-	then
-		chmod a+x "e space.sh" &&
-		GIT_EDITOR="./e\ space.sh" git commit --amend &&
-		test space = "$(git show -s --pretty=format:%s)"
-	else
-		say "Skipping; FS does not support spaces in filenames"
-	fi
+	chmod a+x "e space.sh" &&
+	GIT_EDITOR="./e\ space.sh" git commit --amend &&
+	test space = "$(git show -s --pretty=format:%s)"
 
 '
 
 unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
 
-	if test -f "e space.sh"
-	then
-		git config core.editor \"./e\ space.sh\" &&
-		git commit --amend &&
-		test space = "$(git show -s --pretty=format:%s)"
-	else
-		say "Skipping; FS does not support spaces in filenames"
-	fi
+	git config core.editor \"./e\ space.sh\" &&
+	git commit --amend &&
+	test space = "$(git show -s --pretty=format:%s)"
 
 '
 
-- 
1.6.2.1.224.g2225f
