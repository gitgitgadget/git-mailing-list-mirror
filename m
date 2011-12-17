From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 04/11] git-p4: test cloning with two dirs, clarify doc
Date: Sat, 17 Dec 2011 13:52:15 -0500
Message-ID: <1324147942-21558-5-git-send-email-pw@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzOj-0002kC-P1
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab1LQSyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:54:13 -0500
Received: from honk.padd.com ([74.3.171.149]:48983 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab1LQSyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:54:12 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id A6D771C89;
	Sat, 17 Dec 2011 10:54:08 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3B0BD31544; Sat, 17 Dec 2011 13:53:43 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
In-Reply-To: <1324147942-21558-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187393>

Document how git-p4 currently works when specifying multiple
depot paths:

1.  No branches or directories are named.

2.  Conflicting files are silently ignored---the last change
    wins.

2.  Option --destination is required, else the last path is construed
    to be a directory.

3.  Revision specifiers must be the same on all paths for them to
    take effect.

Test this behavior.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt |   11 +++++++-
 t/t9800-git-p4.sh        |   60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index c981407..c15b3b7 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -276,8 +276,15 @@ p4 revision specifier on the end:
 "//depot/my/project@1,6"::
     Import only changes 1 through 6.
 
-"//depot/proj1 //depot/proj2@all"::
-    Import all changes from both named depot paths.
+"//depot/proj1@all //depot/proj2@all"::
+    Import all changes from both named depot paths into a single
+    repository.  Only files below these directories are included.
+    There is not a subdirectory in git for each "proj1" and "proj2".
+    You must use the '--destination' option when specifying more
+    than one depot path.  The revision specifier must be specified
+    identically on each depot path.  If there are files in the
+    depot paths with the same name, the path with the most recently
+    updated version of the file is the one that appears in git.
 
 See 'p4 help revisions' for the full syntax of p4 revision specifiers.
 
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 272de3f..04ee20e 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -65,6 +65,66 @@ test_expect_success 'git-p4 sync new branch' '
 	)
 '
 
+test_expect_success 'clone two dirs' '
+	(
+		cd "$cli" &&
+		mkdir sub1 sub2 &&
+		echo sub1/f1 >sub1/f1 &&
+		echo sub2/f2 >sub2/f2 &&
+		p4 add sub1/f1 &&
+		p4 submit -d "sub1/f1" &&
+		p4 add sub2/f2 &&
+		p4 submit -d "sub2/f2"
+	) &&
+	"$GITP4" clone --dest="$git" //depot/sub1 //depot/sub2 &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git ls-files >lines &&
+		test_line_count = 2 lines &&
+		git log --oneline p4/master >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_expect_success 'clone two dirs, @all' '
+	(
+		cd "$cli" &&
+		echo sub1/f3 >sub1/f3 &&
+		p4 add sub1/f3 &&
+		p4 submit -d "sub1/f3"
+	) &&
+	"$GITP4" clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git ls-files >lines &&
+		test_line_count = 3 lines &&
+		git log --oneline p4/master >lines &&
+		test_line_count = 3 lines
+	)
+'
+
+test_expect_success 'clone two dirs, @all, conflicting files' '
+	(
+		cd "$cli" &&
+		echo sub2/f3 >sub2/f3 &&
+		p4 add sub2/f3 &&
+		p4 submit -d "sub2/f3"
+	) &&
+	"$GITP4" clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git ls-files >lines &&
+		test_line_count = 3 lines &&
+		git log --oneline p4/master >lines &&
+		test_line_count = 4 lines &&
+		echo sub2/f3 >expected &&
+		test_cmp expected f3
+	)
+'
+
 test_expect_success 'exit when p4 fails to produce marshaled output' '
 	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
 	mkdir "$badp4dir" &&
-- 
1.7.8.258.g45cc3c
