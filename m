From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2] git-p4: introduce skipSubmitEdit
Date: Sun, 4 Dec 2011 19:22:45 -0500
Message-ID: <20111205002245.GA8035@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Loren A. Linden Levy" <lindenle@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 01:23:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXMKh-0007Z5-14
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 01:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab1LEAWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 19:22:51 -0500
Received: from honk.padd.com ([74.3.171.149]:35374 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937Ab1LEAWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 19:22:50 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id AAEB827EE;
	Sun,  4 Dec 2011 16:22:48 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EE68831833; Sun,  4 Dec 2011 19:22:45 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186276>

Add a configuration variable to skip invoking the editor in the
submit path.

The existing variable skipSubmitEditCheck continues to make sure
that the submit template was indeed modified by the editor; but,
it is not considered if skipSubmitEdit is true.

Reported-by: Loren A. Linden Levy <lindenle@gmail.com>
Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---

This was talked about and reviewed back in September 2011.
I think it's ready to include in the next release.
Thanks,

		-- Pete

 contrib/fast-import/git-p4     |   59 ++++++++++++++++++----------
 contrib/fast-import/git-p4.txt |   19 ++++++++-
 t/t9805-skip-submit-edit.sh    |   82 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 24 deletions(-)
 create mode 100755 t/t9805-skip-submit-edit.sh

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index b975d67..7fd8bf0 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -847,6 +847,38 @@ class P4Submit(Command, P4UserMap):
 
         return template
 
+    def edit_template(self, template_file):
+        """Invoke the editor to let the user change the submission
+           message.  Return true if okay to continue with the submit."""
+
+        # if configured to skip the editing part, just submit
+        if gitConfig("git-p4.skipSubmitEdit") == "true":
+            return True
+
+        # look at the modification time, to check later if the user saved
+        # the file
+        mtime = os.stat(template_file).st_mtime
+
+        # invoke the editor
+        if os.environ.has_key("P4EDITOR"):
+            editor = os.environ.get("P4EDITOR")
+        else:
+            editor = read_pipe("git var GIT_EDITOR").strip()
+        system(editor + " " + template_file)
+
+        # If the file was not saved, prompt to see if this patch should
+        # be skipped.  But skip this verification step if configured so.
+        if gitConfig("git-p4.skipSubmitEditCheck") == "true":
+            return True
+
+        if os.stat(template_file).st_mtime <= mtime:
+            while True:
+                response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+                if response == 'y':
+                    return True
+                if response == 'n':
+                    return False
+
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
 
@@ -1001,7 +1033,7 @@ class P4Submit(Command, P4UserMap):
 
             separatorLine = "######## everything below this line is just the diff #######\n"
 
-            [handle, fileName] = tempfile.mkstemp()
+            (handle, fileName) = tempfile.mkstemp()
             tmpFile = os.fdopen(handle, "w+")
             if self.isWindows:
                 submitTemplate = submitTemplate.replace("\n", "\r\n")
@@ -1009,25 +1041,9 @@ class P4Submit(Command, P4UserMap):
                 newdiff = newdiff.replace("\n", "\r\n")
             tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
             tmpFile.close()
-            mtime = os.stat(fileName).st_mtime
-            if os.environ.has_key("P4EDITOR"):
-                editor = os.environ.get("P4EDITOR")
-            else:
-                editor = read_pipe("git var GIT_EDITOR").strip()
-            system(editor + " " + fileName)
 
-            if gitConfig("git-p4.skipSubmitEditCheck") == "true":
-                checkModTime = False
-            else:
-                checkModTime = True
-
-            response = "y"
-            if checkModTime and (os.stat(fileName).st_mtime <= mtime):
-                response = "x"
-                while response != "y" and response != "n":
-                    response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
-
-            if response == "y":
+            if self.edit_template(fileName):
+                # read the edited message and submit
                 tmpFile = open(fileName, "rb")
                 message = tmpFile.read()
                 tmpFile.close()
@@ -1039,11 +1055,12 @@ class P4Submit(Command, P4UserMap):
                 if self.preserveUser:
                     if p4User:
                         # Get last changelist number. Cannot easily get it from
-                        # the submit command output as the output is unmarshalled.
+                        # the submit command output as the output is
+                        # unmarshalled.
                         changelist = self.lastP4Changelist()
                         self.modifyChangelistUser(changelist, p4User)
-
             else:
+                # skip this patch
                 for f in editedFiles:
                     p4_revert(f)
                 for f in filesToAdd:
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 52003ae..5044a12 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -202,11 +202,24 @@ able to find the relevant client.  This client spec will be used to
 both filter the files cloned by git and set the directory layout as
 specified in the client (this implies --keep-path style semantics).
 
-git-p4.skipSubmitModTimeCheck
+git-p4.skipSubmitEdit
 
-  git config [--global] git-p4.skipSubmitModTimeCheck false
+  git config [--global] git-p4.skipSubmitEdit false
 
-If true, submit will not check if the p4 change template has been modified.
+Normally, git-p4 invokes an editor after each commit is applied so
+that you can make changes to the submit message.  Setting this
+variable to true will skip the editing step, submitting the change as is.
+
+git-p4.skipSubmitEditCheck
+
+  git config [--global] git-p4.skipSubmitEditCheck false
+
+After the editor is invoked, git-p4 normally makes sure you saved the
+change description, as an indication that you did indeed read it over
+and edit it.  You can quit without saving to abort the submit (or skip
+this change and continue).  Setting this variable to true will cause
+git-p4 not to check if you saved the change description.  This variable
+only matters if git-p4.skipSubmitEdit has not been set to true.
 
 git-p4.preserveUser
 
diff --git a/t/t9805-skip-submit-edit.sh b/t/t9805-skip-submit-edit.sh
new file mode 100755
index 0000000..734ccf2
--- /dev/null
+++ b/t/t9805-skip-submit-edit.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='git-p4 skipSubmitEdit config variables'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "change 1"
+	)
+'
+
+# this works because EDITOR is set to :
+test_expect_success 'no config, unedited, say yes' '
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		echo line >>file1 &&
+		git commit -a -m "change 2" &&
+		echo y | "$GITP4" submit &&
+		p4 changes //depot/... >wc &&
+		test_line_count = 2 wc
+	)
+'
+
+test_expect_success 'no config, unedited, say no' '
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		echo line >>file1 &&
+		git commit -a -m "change 3 (not really)" &&
+		printf "bad response\nn\n" | "$GITP4" submit
+		p4 changes //depot/... >wc &&
+		test_line_count = 2 wc
+	)
+'
+
+test_expect_success 'skipSubmitEdit' '
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		# will fail if editor is even invoked
+		git config core.editor /bin/false &&
+		echo line >>file1 &&
+		git commit -a -m "change 3" &&
+		"$GITP4" submit &&
+		p4 changes //depot/... >wc &&
+		test_line_count = 3 wc
+	)
+'
+
+test_expect_success 'skipSubmitEditCheck' '
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		echo line >>file1 &&
+		git commit -a -m "change 4" &&
+		"$GITP4" submit &&
+		p4 changes //depot/... >wc &&
+		test_line_count = 4 wc
+	)
+'
+
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.8.rc4.30.g3c9dc
