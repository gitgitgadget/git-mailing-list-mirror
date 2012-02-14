From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3] git-p4: add initial support for RCS keywords
Date: Tue, 14 Feb 2012 22:33:55 +0000
Message-ID: <1329258835-17223-2-git-send-email-luke@diamand.org>
References: <1329258835-17223-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 23:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQwn-0001Zf-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab2BNWd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:33:58 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33444 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab2BNWd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:33:56 -0500
Received: by wgbdt10 with SMTP id dt10so338164wgb.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:33:55 -0800 (PST)
Received: by 10.180.24.7 with SMTP id q7mr31951696wif.14.1329258835617;
        Tue, 14 Feb 2012 14:33:55 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ec3sm29765151wib.1.2012.02.14.14.33.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 14:33:54 -0800 (PST)
X-Mailer: git-send-email 1.7.9.259.ga92e
In-Reply-To: <1329258835-17223-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQlORUhCMcE3xPh24+3r9zcgzybw5/fu0pkTMQFis32A6i7VeYN0JDFOXldoZERQWCt7jvPu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190782>

RCS keywords cause problems for git-p4 as perforce always
expands them (if +k is set) and so when applying the patch,
git reports that the files have been modified by both sides,
when in fact they haven't.

This change means that when git-p4 detects a problem applying
a patch, it will check to see if keyword expansion could be
the culprit. If it is, it strips the keywords in the p4
repository so that they match what git is expecting. It then
has another go at applying the patch.

This behaviour is enabled with a new git-p4 configuration
option and is off by default.

Improved-by: Pete Wyckoff <pw@padd.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt   |    5 +
 contrib/fast-import/git-p4 |  116 +++++++++++++++--
 t/t9810-git-p4-rcs.sh      |  304 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+), 10 deletions(-)
 create mode 100755 t/t9810-git-p4-rcs.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 8b92cc0..7fa47c8 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -483,6 +483,11 @@ git-p4.skipUserNameCheck::
 	user map, 'git p4' exits.  This option can be used to force
 	submission regardless.
 
+git-p4.attemptRCSCleanup:
+    If enabled, 'git p4 submit' will attempt to sort cleanup RCS keywords
+    ($Header$, etc). These would otherwise cause merge conflicts and prevent
+    the submit going ahead. This option should be considered experimental at
+    present.
 
 IMPLEMENTATION DETAILS
 ----------------------
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a78d9c5..8130447 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -10,7 +10,7 @@
 
 import optparse, sys, os, marshal, subprocess, shelve
 import tempfile, getopt, os.path, time, platform
-import re
+import re, shutil
 
 verbose = False
 
@@ -186,6 +186,44 @@ def split_p4_type(p4type):
         mods = s[1]
     return (base, mods)
 
+#
+# return the raw p4 type of a file (text, text+ko, etc)
+#
+def p4_type(file):
+    files = p4_read_pipe_lines(["files", file])
+    info = files[0]
+    m = re.search(r'\(([a-z0-9A-Z+]+)\)\s*$', info)
+    if m:
+        ret = m.group(1)
+        if verbose:
+            print "%s => %s" % (file, ret)
+        return ret
+    else:
+        die("Could not extract file type from '%s'" % info)
+
+#
+# Given a type base and modifier, return a regexp matching
+# the keywords that can be expanded in the file
+#
+def p4_keywords_regexp_for_type(base, type_mods):
+    if base in ("text", "unicode", "binary"):
+        if "ko" in type_mods:
+            return r'\$(Id|Header)[^$]*\$'
+        elif "k" in type_mods:
+            return r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$'
+        else:
+            return None
+    else:
+        return None
+
+#
+# Given a file, return a regexp matching the possible
+# RCS keywords that will be expanded, or None for files
+# with kw expansion turned off.
+#
+def p4_keywords_regexp_for_file(file):
+    (type_base, type_mods) = split_p4_type(p4_type(file))
+    return p4_keywords_regexp_for_type(type_base, type_mods)
 
 def setP4ExecBit(file, mode):
     # Reopens an already open file and changes the execute bit to match
@@ -753,6 +791,28 @@ class P4Submit(Command, P4UserMap):
 
         return result
 
+    def patchRCSKeywords(self, file, pattern):
+        # Attempt to zap the RCS keywords in a p4 controlled file matching the given pattern
+        (handle, outFileName) = tempfile.mkstemp(dir='.')
+        try:
+            outFile = os.fdopen(handle, "w+")
+            inFile = open(file, "r")
+            for line in inFile.readlines():
+                line = re.sub(pattern, r'$\1$', line)
+                outFile.write(line)
+            inFile.close()
+            outFile.close()
+            # Forcibly overwrite the original file
+            os.unlink(file)
+            shutil.move(outFileName, file)
+        except:
+            # cleanup our temporary file
+            os.unlink(outFileName)
+            print "Failed to strip RCS keywords in %s" % file
+            raise
+
+        print "Patched up RCS keywords in %s" % file
+
     def p4UserForCommit(self,id):
         # Return the tuple (perforce user,git email) for a given git commit id
         self.getUserMapFromPerforceServer()
@@ -918,6 +978,7 @@ class P4Submit(Command, P4UserMap):
         filesToDelete = set()
         editedFiles = set()
         filesToChangeExecBit = {}
+
         for line in diff:
             diff = parseDiffTreeEntry(line)
             modifier = diff['status']
@@ -964,9 +1025,48 @@ class P4Submit(Command, P4UserMap):
         patchcmd = diffcmd + " | git apply "
         tryPatchCmd = patchcmd + "--check -"
         applyPatchCmd = patchcmd + "--check --apply -"
+        patch_succeeded = True
 
         if os.system(tryPatchCmd) != 0:
+            fixed_rcs_keywords = False
+            patch_succeeded = False
             print "Unfortunately applying the change failed!"
+
+            # Patch failed, maybe it's just RCS keyword woes. Look through
+            # the patch to see if that's possible.
+            if gitConfig("git-p4.attemptRCSCleanup","--bool") == "true":
+                file = None
+                pattern = None
+                kwfiles = {}
+                for line in read_pipe_lines(diffcmd):
+                    # read diff lines: for each file reported, if it can have
+                    # keywords expanded, and the diff contains keywords, then
+                    # try zapping the p4 file.
+                    m = re.match(r'^diff --git a/(.*)\s+b/(.*)', line)
+                    if m:
+                        file = m.group(1)
+                        pattern = p4_keywords_regexp_for_file(file)
+                        next
+
+                    if pattern:
+                        print line
+
+                    if pattern and re.search(pattern, line):
+                        print "got match on %s in %s in %s" % (pattern, line, file)
+                        kwfiles[file] = pattern
+
+                for file in kwfiles:
+                    if verbose:
+                        print "zapping %s with %s" % (line,pattern)
+                    self.patchRCSKeywords(file, kwfiles[file])
+                    fixed_rcs_keywords = True
+
+            if fixed_rcs_keywords:
+                print "Retrying the patch with RCS keywords cleaned up"
+                if os.system(tryPatchCmd) == 0:
+                    patch_succeeded = True
+
+        if not patch_succeeded:
             print "What do you want to do?"
             response = "x"
             while response != "s" and response != "a" and response != "w":
@@ -1585,15 +1685,11 @@ class P4Sync(Command, P4UserMap):
 
         # Note that we do not try to de-mangle keywords on utf16 files,
         # even though in theory somebody may want that.
-        if type_base in ("text", "unicode", "binary"):
-            if "ko" in type_mods:
-                text = ''.join(contents)
-                text = re.sub(r'\$(Id|Header):[^$]*\$', r'$\1$', text)
-                contents = [ text ]
-            elif "k" in type_mods:
-                text = ''.join(contents)
-                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', text)
-                contents = [ text ]
+        pattern = p4_keywords_regexp_for_type(type_base, type_mods)
+        if pattern:
+            text = ''.join(contents)
+            text = re.sub(pattern, r'$\1$', text)
+            contents = [ text ]
 
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
 
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
new file mode 100755
index 0000000..77eebd2
--- /dev/null
+++ b/t/t9810-git-p4-rcs.sh
@@ -0,0 +1,304 @@
+#!/bin/sh
+
+test_description='git-p4 rcs keywords'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+#
+# Make one file with keyword lines at the top, and
+# enough plain text to be able to test modifications
+# far away from the keywords.
+#
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		cat <<-\EOF >filek &&
+		$Id$
+		/* $Revision$ */
+		# $Change$
+		line4
+		line5
+		line6
+		line7
+		line8
+		EOF
+		cp filek fileko &&
+		sed -i "s/Revision/Revision: do not scrub me/" fileko
+		cp fileko file_text &&
+		sed -i "s/Id/Id: do not scrub me/" file_text
+		p4 add -t text+k filek &&
+		p4 submit -d "filek" &&
+		p4 add -t text+ko fileko &&
+		p4 submit -d "fileko" &&
+		p4 add -t text file_text &&
+		p4 submit -d "file_text"
+	)
+'
+
+#
+# Generate these in a function to make it easy to use single quote marks.
+#
+write_scrub_scripts() {
+	cat >"$TRASH_DIRECTORY/scrub_k.py" <<-\EOF &&
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', sys.stdin.read()))
+	EOF
+	cat >"$TRASH_DIRECTORY/scrub_ko.py" <<-\EOF
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\$(Id|Header):[^$]*\$', r'$\1$', sys.stdin.read()))
+	EOF
+}
+
+test_expect_success 'scrub scripts' '
+	write_scrub_scripts
+'
+
+#
+# Compare $cli/file to its scrubbed version, should be different.
+# Compare scrubbed $cli/file to $git/file, should be same.
+#
+scrub_k_check() {
+	file=$1 &&
+	scrub="$TRASH_DIRECTORY/$file" &&
+	"$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_k.py" <"$git/$file" >"$scrub" &&
+	! test_cmp "$cli/$file" "$scrub" &&
+	test_cmp "$git/$file" "$scrub" &&
+	rm "$scrub"
+}
+scrub_ko_check() {
+	file=$1 &&
+	scrub="$TRASH_DIRECTORY/$file" &&
+	"$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_ko.py" <"$git/$file" >"$scrub" &&
+	! test_cmp "$cli/$file" "$scrub" &&
+	test_cmp "$git/$file" "$scrub" &&
+	rm "$scrub"
+}
+
+#
+# Modify far away from keywords.  If no RCS lines show up
+# in the diff, there is no conflict.
+#
+test_expect_success 'edit far away from RCS lines' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		sed -i "s/^line7/line7 edit/" filek &&
+		git commit -m "filek line7 edit" filek &&
+		"$GITP4" submit &&
+		scrub_k_check filek
+	)
+'
+
+#
+# Modify near the keywords.  This will require RCS scrubbing.
+#
+test_expect_success 'edit near RCS lines' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "s/^line4/line4 edit/" filek &&
+		git commit -m "filek line4 edit" filek &&
+		"$GITP4" submit &&
+		scrub_k_check filek
+	)
+'
+
+#
+# Modify the keywords themselves.  This also will require RCS scrubbing.
+#
+test_expect_success 'edit keyword lines' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "/Revision/d" filek &&
+		git commit -m "filek remove Revision line" filek &&
+		"$GITP4" submit &&
+		scrub_k_check filek
+	)
+'
+
+#
+# Scrubbing text+ko files should not alter all keywords, just Id, Header.
+#
+test_expect_success 'scrub ko files differently' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "s/^line4/line4 edit/" fileko &&
+		git commit -m "fileko line4 edit" fileko &&
+		"$GITP4" submit &&
+		scrub_ko_check fileko &&
+		! scrub_k_check fileko
+	)
+'
+
+# hack; git-p4 submit should do it on its own
+test_expect_success 'cleanup after failure' '
+	(
+		cd "$cli" &&
+		p4 revert ...
+	)
+'
+
+#
+# Do not scrub anything but +k or +ko files.  Sneak a change into
+# the cli file so that submit will get a conflict.  Make sure that
+# scrubbing doesn't make a mess of things.
+#
+# Assumes that git-p4 exits leaving the p4 file open, with the
+# conflict-generating patch unapplied.
+#
+# This might happen only if the git repo is behind the p4 repo at
+# submit time, and there is a conflict.
+#
+test_expect_success 'do not scrub plain text' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "s/^line4/line4 edit/" file_text &&
+		git commit -m "file_text line4 edit" file_text &&
+		(
+			cd "$cli" &&
+			p4 open file_text &&
+			sed -i "s/^line5/line5 p4 edit/" file_text &&
+			p4 submit -d "file5 p4 edit"
+		) &&
+		! "$GITP4" submit &&
+		(
+			# exepct something like:
+			#    file_text - file(s) not opened on this client
+			# but not copious diff output
+			cd "$cli" &&
+			p4 diff file_text >wc &&
+			test_line_count = 1 wc
+		)
+	)
+'
+
+# hack; git-p4 submit should do it on its own
+test_expect_success 'cleanup after failure 2' '
+	(
+		cd "$cli" &&
+		p4 revert ...
+	)
+'
+
+create_kw_file() {
+	cat <<\EOF >"$1"
+/* A file
+	Id: $Id$
+	Revision: $Revision$
+	File: $File$
+ */
+int main(int argc, const char **argv) {
+	return 0;
+}
+EOF
+}
+
+test_expect_success 'add kwfile' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "file 1" &&
+		create_kw_file kwfile1.c &&
+		p4 add kwfile1.c &&
+		p4 submit -d "Add rcw kw file" kwfile1.c
+	)
+'
+
+p4_append_to_file() {
+	f=$1 &&
+	p4 edit -t ktext "$f" &&
+	echo "/* $(date) */" >>"$f" &&
+	p4 submit -d "appending a line in p4"
+}
+
+# Create some files with RCS keywords. If they get modified
+# elsewhere then the version number gets bumped which then
+# results in a merge conflict if we touch the RCS kw lines,
+# even though the change itself would otherwise apply cleanly.
+test_expect_success 'cope with rcs keyword expansion damage' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		(cd ../cli && p4_append_to_file kwfile1.c) &&
+		old_lines=$(wc -l <kwfile1.c) &&
+		perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
+		new_lines=$(wc -l <kwfile1.c) &&
+		expr $new_lines == $old_lines - 1 &&
+
+		git add kwfile1.c &&
+		git commit -m "Zap an RCS kw line" &&
+		"$GITP4" submit &&
+		"$GITP4" rebase &&
+		git diff p4/master &&
+		"$GITP4" commit &&
+		echo "try modifying in both" &&
+		cd "$cli" &&
+		p4 edit kwfile1.c &&
+		echo "line from p4" >>kwfile1.c &&
+		p4 submit -d "add a line in p4" kwfile1.c &&
+		cd "$git" &&
+		echo "line from git at the top" | cat - kwfile1.c >kwfile1.c.new &&
+		mv kwfile1.c.new kwfile1.c &&
+		git commit -m "Add line in git at the top" kwfile1.c &&
+		"$GITP4" rebase &&
+		"$GITP4" submit
+	)
+'
+
+test_expect_success 'cope with rcs keyword file deletion' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		echo "\$Revision\$" >kwdelfile.c &&
+		p4 add -t ktext kwdelfile.c &&
+		p4 submit -d "Add file to be deleted" &&
+		cat kwdelfile.c &&
+		grep -q 1 kwdelfile.c
+	) &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		grep -q Revision kwdelfile.c &&
+		git rm -f kwdelfile.c &&
+		git commit -m "Delete a file containing RCS keywords" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		"$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		[ ! -f kwdelfile.c ]
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.9.259.ga92e
