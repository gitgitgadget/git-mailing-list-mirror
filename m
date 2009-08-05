From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 13/13] Changes for new vcs-helper series
Date: Wed, 5 Aug 2009 01:02:25 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050056210.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:03:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYeE-0007Gg-5D
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbZHEFCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933217AbZHEFCg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:02:36 -0400
Received: from iabervon.org ([66.92.72.58]:37030 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933060AbZHEFC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:02:26 -0400
Received: (qmail 18336 invoked by uid 1000); 5 Aug 2009 05:02:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:02:25 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These changes are:

 - helper is called git remote-<name>, no longer git vcs-<name>
 - import capability has to be declared
 - refs in list have to be prefixed with '?' for unknown sha1
 - command line must be "git remote-<name> <remote> [<url>]

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                            |    2 +-
 git-vcs-cvs.py => git-remote-cvs.py |    7 +--
 t/t9800-foreign-vcs-cvs-basic.sh    |   82 ++++++++++++++++++-----------------
 t/t9801-foreign-vcs-cvs-fetch.sh    |    6 +-
 4 files changed, 49 insertions(+), 48 deletions(-)
 rename git-vcs-cvs.py => git-remote-cvs.py (99%)

diff --git a/Makefile b/Makefile
index 98f0782..958c49f 100644
--- a/Makefile
+++ b/Makefile
@@ -344,7 +344,7 @@ SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
-SCRIPT_PYTHON += git-vcs-cvs.py
+SCRIPT_PYTHON += git-remote-cvs.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
diff --git a/git-vcs-cvs.py b/git-remote-cvs.py
similarity index 99%
rename from git-vcs-cvs.py
rename to git-remote-cvs.py
index 04a52a6..b43138d 100755
--- a/git-vcs-cvs.py
+++ b/git-remote-cvs.py
@@ -482,7 +482,7 @@ def do_list (*args):
 		else:
 			s = " changed"
 			changed += 1
-		print "%s%s" % (git_ref, s)
+		print "? %s%s" % (git_ref, s)
 
 	progress.finish("Found %i CVS symbols (%i changed, %i unchanged)" % (
 	                changed + unchanged, changed, unchanged))
@@ -492,6 +492,7 @@ def do_list (*args):
 def do_capabilities (*args):
 	"""Do the 'capabilities' command; report supported features"""
 	if args: die_usage("'capabilities' takes no parameters")
+	print "import"
 	print "marks %s" % (work_path("marks"))
 #	print "export"
 #	print "export-branch"
@@ -630,10 +631,8 @@ def main (*args):
 	### Main program loop
 
 	import_refs = [] # accumulate import commands here
-	# iterate over command lines on command line, then standard input
 	# cannot use "for line in sys.stdin" for buffering (?) reasons
-	line = " ".join(args[2:])
-	if not line: line = sys.stdin.readline()
+	line = sys.stdin.readline()
 	while (line):
 		cmdline = line.strip().split()
 		if not cmdline: break # blank line means we're about to quit
diff --git a/t/t9800-foreign-vcs-cvs-basic.sh b/t/t9800-foreign-vcs-cvs-basic.sh
index 78f5a98..e318c62 100755
--- a/t/t9800-foreign-vcs-cvs-basic.sh
+++ b/t/t9800-foreign-vcs-cvs-basic.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git vcs-cvs basic tests'
+test_description='git remote-cvs basic tests'
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON; then
@@ -21,7 +21,7 @@ GITREMOTE=cvsremote
 
 if ! type $CVS_EXEC >/dev/null 2>&1
 then
-	say 'skipping vcs-cvs tests, $CVS_EXEC not found'
+	say 'skipping remote-cvs tests, $CVS_EXEC not found'
 	test_done
 fi
 
@@ -72,10 +72,11 @@ test_expect_success 'set up CVS repo as a foreign remote' '
 
 '
 
-test_expect_success '#1: git-vcs-cvs "capabilities" command' '
+test_expect_success '#1: git-remote-cvs "capabilities" command' '
 
-	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "capabilities" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
+import
 marks .git/info/cvs/$GITREMOTE/marks
 
 EOF
@@ -83,20 +84,20 @@ EOF
 
 '
 
-test_expect_success '#1: git-vcs-cvs "list" command' '
+test_expect_success '#1: git-remote-cvs "list" command' '
 
-	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "list" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
-refs/cvs/$GITREMOTE/HEAD changed
+? refs/cvs/$GITREMOTE/HEAD changed
 
 EOF
 	test_cmp expect actual
 
 '
 
-test_expect_success '#1: git-vcs-cvs "import" command' '
+test_expect_success '#1: git-remote-cvs "import" command' '
 
-	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 # Importing CVS revision o_fortuna:1.1
 blob
@@ -166,7 +167,7 @@ EOF
 
 '
 
-test_expect_success '#1: Passing git-vcs-cvs output to git-fast-import' '
+test_expect_success '#1: Passing git-remote-cvs output to git-fast-import' '
 
 	git fast-import --quiet \
 		--export-marks=".git/info/cvs/$GITREMOTE/marks" \
@@ -177,7 +178,7 @@ test_expect_success '#1: Passing git-vcs-cvs output to git-fast-import' '
 
 test_expect_success '#1: Verifying correctness of import' '
 
-	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+	echo "verify HEAD" | git remote-cvs "$GITREMOTE"
 
 '
 
@@ -211,10 +212,11 @@ EOF
 	)
 '
 
-test_expect_success '#2: git-vcs-cvs "capabilities" command' '
+test_expect_success '#2: git-remote-cvs "capabilities" command' '
 
-	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "capabilities" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
+import
 marks .git/info/cvs/$GITREMOTE/marks
 
 EOF
@@ -222,20 +224,20 @@ EOF
 
 '
 
-test_expect_success '#2: git-vcs-cvs "list" command' '
+test_expect_success '#2: git-remote-cvs "list" command' '
 
-	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "list" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
-refs/cvs/$GITREMOTE/HEAD changed
+? refs/cvs/$GITREMOTE/HEAD changed
 
 EOF
 	test_cmp expect actual
 
 '
 
-test_expect_success '#2: git-vcs-cvs "import" command' '
+test_expect_success '#2: git-remote-cvs "import" command' '
 
-	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 # Importing CVS revision o_fortuna:1.2
 blob
@@ -300,7 +302,7 @@ commit 9
 commit refs/cvs/$GITREMOTE/_metadata
 mark :15
 data 39
-Updated metadata used by "git vcs-cvs"
+Updated metadata used by "git remote-cvs"
 
 from refs/cvs/$GITREMOTE/_metadata^0
 M 644 :12 CVS/marks
@@ -313,7 +315,7 @@ EOF
 
 '
 
-test_expect_success '#2: Passing git-vcs-cvs output to git-fast-import' '
+test_expect_success '#2: Passing git-remote-cvs output to git-fast-import' '
 
 	git fast-import --quiet \
 		--import-marks=".git/info/cvs/$GITREMOTE/marks" \
@@ -325,7 +327,7 @@ test_expect_success '#2: Passing git-vcs-cvs output to git-fast-import' '
 
 test_expect_success '#2: Verifying correctness of import' '
 
-	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+	echo "verify HEAD" | git remote-cvs "$GITREMOTE"
 
 '
 
@@ -340,9 +342,9 @@ test_expect_success '#3: update cvs module' '
 
 '
 
-test_expect_success '#3: git-vcs-cvs "capabilities" command' '
+test_expect_success '#3: git-remote-cvs "capabilities" command' '
 
-	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "capabilities" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 marks .git/info/cvs/$GITREMOTE/marks
 
@@ -351,9 +353,9 @@ EOF
 
 '
 
-test_expect_success '#3: git-vcs-cvs "list" command' '
+test_expect_success '#3: git-remote-cvs "list" command' '
 
-	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "list" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 refs/cvs/$GITREMOTE/HEAD changed
 
@@ -362,9 +364,9 @@ EOF
 
 '
 
-test_expect_success '#3: git-vcs-cvs "import" command' '
+test_expect_success '#3: git-remote-cvs "import" command' '
 
-	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 # Importing CVS revision tick:1.1
 blob
@@ -390,7 +392,7 @@ tick:1.1
 commit refs/notes/cvs/$GITREMOTE
 mark :19
 data 43
-Annotate commits imported by "git vcs-cvs"
+Annotate commits imported by "git remote-cvs"
 
 from refs/notes/cvs/$GITREMOTE^0
 N :18 :17
@@ -416,7 +418,7 @@ commit 17
 commit refs/cvs/$GITREMOTE/_metadata
 mark :23
 data 39
-Updated metadata used by "git vcs-cvs"
+Updated metadata used by "git remote-cvs"
 
 from refs/cvs/$GITREMOTE/_metadata^0
 M 644 :20 CVS/marks
@@ -429,7 +431,7 @@ EOF
 
 '
 
-test_expect_success '#3: Passing git-vcs-cvs output to git-fast-import' '
+test_expect_success '#3: Passing git-remote-cvs output to git-fast-import' '
 
 	git fast-import --quiet \
 		--import-marks=".git/info/cvs/$GITREMOTE/marks" \
@@ -441,13 +443,13 @@ test_expect_success '#3: Passing git-vcs-cvs output to git-fast-import' '
 
 test_expect_success '#3: Verifying correctness of import' '
 
-	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+	echo "verify HEAD" | git remote-cvs "$GITREMOTE"
 
 '
 
-test_expect_success '#4: git-vcs-cvs "capabilities" command' '
+test_expect_success '#4: git-remote-cvs "capabilities" command' '
 
-	echo "capabilities" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "capabilities" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 marks .git/info/cvs/$GITREMOTE/marks
 
@@ -456,9 +458,9 @@ EOF
 
 '
 
-test_expect_success '#4: git-vcs-cvs "list" command' '
+test_expect_success '#4: git-remote-cvs "list" command' '
 
-	echo "list" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "list" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 refs/cvs/$GITREMOTE/HEAD unchanged
 
@@ -467,9 +469,9 @@ EOF
 
 '
 
-test_expect_success '#4: git-vcs-cvs "import" command' '
+test_expect_success '#4: git-remote-cvs "import" command' '
 
-	echo "import refs/cvs/$GITREMOTE/HEAD" | git vcs-cvs "$GITREMOTE" > actual &&
+	echo "import refs/cvs/$GITREMOTE/HEAD" | git remote-cvs "$GITREMOTE" > actual &&
 	cat <<EOF >expect &&
 blob
 mark :24
@@ -486,7 +488,7 @@ data 94
 commit refs/cvs/$GITREMOTE/_metadata
 mark :27
 data 39
-Updated metadata used by "git vcs-cvs"
+Updated metadata used by "git remote-cvs"
 
 from refs/cvs/$GITREMOTE/_metadata^0
 M 644 :24 CVS/marks
@@ -499,7 +501,7 @@ EOF
 
 '
 
-test_expect_success '#4: Passing git-vcs-cvs output to git-fast-import' '
+test_expect_success '#4: Passing git-remote-cvs output to git-fast-import' '
 
 	git fast-import --quiet \
 		--import-marks=".git/info/cvs/$GITREMOTE/marks" \
@@ -511,7 +513,7 @@ test_expect_success '#4: Passing git-vcs-cvs output to git-fast-import' '
 
 test_expect_success '#4: Verifying correctness of import' '
 
-	echo "verify HEAD" | git vcs-cvs "$GITREMOTE"
+	echo "verify HEAD" | git remote-cvs "$GITREMOTE"
 
 '
 
diff --git a/t/t9801-foreign-vcs-cvs-fetch.sh b/t/t9801-foreign-vcs-cvs-fetch.sh
index 62a2325..93d44a7 100755
--- a/t/t9801-foreign-vcs-cvs-fetch.sh
+++ b/t/t9801-foreign-vcs-cvs-fetch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git vcs-cvs basic tests'
+test_description='git remote-cvs basic tests'
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON; then
@@ -21,14 +21,14 @@ GITREMOTE=cvsremote
 
 if ! type $CVS_EXEC >/dev/null 2>&1
 then
-	say 'skipping vcs-cvs tests, $CVS_EXEC not found'
+	say 'skipping remote-cvs tests, $CVS_EXEC not found'
 	test_done
 fi
 
 verify () {
 	git log --reverse --format="--- %T%n%s%n%n%b" "$GITREMOTE/$1" >actual &&
 	test_cmp "expect.$1" actual &&
-	echo "verify $1" | git vcs-cvs "$GITREMOTE"
+	echo "verify $1" | git remote-cvs "$GITREMOTE"
 }
 
 test_expect_success 'setup CVS repo' '$CVS init'
-- 
1.6.4.rc3.27.g95032.dirty
