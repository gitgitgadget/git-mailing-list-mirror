From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4.skipSubmitEdit
Date: Mon, 17 Oct 2011 20:45:00 -0400
Message-ID: <20111018004500.GA31768@arf.padd.com>
References: <1315514452.10046.0.camel@uncle-pecos>
 <4E6DB5F0.7080303@diamand.org>
 <1315847540.10046.29.camel@uncle-pecos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: "L. A. Linden Levy" <alevy@mobitv.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 02:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFxnv-0005ES-1e
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 02:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab1JRApG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 20:45:06 -0400
Received: from honk.padd.com ([74.3.171.149]:38688 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab1JRApF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 20:45:05 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 978C71FEA;
	Mon, 17 Oct 2011 17:45:03 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B58F55AEBA; Mon, 17 Oct 2011 20:45:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1315847540.10046.29.camel@uncle-pecos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183846>

alevy@mobitv.com wrote on Mon, 12 Sep 2011 10:12 -0700:
> I agree with almost all your points. I have answered them each in-line
> below.
> 
> On Mon, 2011-09-12 at 03:34 -0400, Luke Diamand wrote:
> > On 08/09/11 21:40, L. A. Linden Levy wrote:
> > > Hi All,
> > >
> > > I have been using git-p4 for a while and it has allowed me to completely
> > > change the way I develop and still be able to use perforce which my
> > > company has for its main VCS. One thing that was driving me nuts was
> > > that "git p4 submit" cycles through all of my individual commits and
> > > asks me if I want to change them. The way I develop I often am checking
> > > in 20 to 50 different small commits each with a descriptive git comment.
> > > I felt like I was doing double duty by having emacs open on every commit
> > > into perforce. So I modified git-p4 to have an option to skip the
> > > editor. This option coupled with git-p4.skipSubmitEditCheck will make
> > > the submission non-interactive for "git p4 submit".
> > 
> > 
> > Sorry - I've not had a chance to look at this before now. But a couple 
> > of comments:
> > 
> >   - Is there a line wrap problem in the patch? It doesn't seem to want 
> > to apply for me.
> 
> Probably. Below are the results from following the patch submission
> instructions. 

Sorry I sat on this for a month.  It is a good idea.  Your
patches were good in content, but they didn't apply well due to
being line-wrapped and having one duplicate.

Reading the code, though, I decided that the whole
skipSubmitEdit* checking was a bit convoluted even before you got
to it.  So I moved it all to a separate function.  And added a
unit test.

Tell me if you think this is okay instead.  If I got a bit too
wordy in the doc, please help with that too.

		-- Pete

--- 8< ---

Subject: [PATCH] git-p4: introduce skipSubmitEdit

Add a configuration variable to skip invoking the editor in the
submit path.

The existing variable skipSubmitEditCheck continues to make sure
that the submit template was indeed modified by the editor; but,
it is not considered is skipSubmitEdit is true.

Reported-by: Loren A. Linden Levy <lindenle@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4     |   60 +++++++++++++++++++----------
 contrib/fast-import/git-p4.txt |   19 ++++++++-
 t/t9804-skip-submit-edit.sh    |   82 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 24 deletions(-)
 create mode 100755 t/t9804-skip-submit-edit.sh

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index f885d70..abd6778 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -847,6 +847,39 @@ class P4Submit(Command, P4UserMap):
 
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
+            print "return true for skipSubmitEditCheck"
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
 
@@ -1001,7 +1034,7 @@ class P4Submit(Command, P4UserMap):
 
             separatorLine = "######## everything below this line is just the diff #######\n"
 
-            [handle, fileName] = tempfile.mkstemp()
+            (handle, fileName) = tempfile.mkstemp()
             tmpFile = os.fdopen(handle, "w+")
             if self.isWindows:
                 submitTemplate = submitTemplate.replace("\n", "\r\n")
@@ -1009,25 +1042,9 @@ class P4Submit(Command, P4UserMap):
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
@@ -1039,11 +1056,12 @@ class P4Submit(Command, P4UserMap):
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
 
diff --git a/t/t9804-skip-submit-edit.sh b/t/t9804-skip-submit-edit.sh
new file mode 100755
index 0000000..734ccf2
--- /dev/null
+++ b/t/t9804-skip-submit-edit.sh
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
1.7.7
