From: Luke Diamand <luke@diamand.org>
Subject: [RFC/PATCHv1] git-p4: improved import of labels from p4
Date: Sat, 17 Mar 2012 10:44:41 +0000
Message-ID: <1331981081-25598-2-git-send-email-luke@diamand.org>
References: <1331981081-25598-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 11:45:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8r8F-0002CE-UP
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 11:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478Ab2CQKo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 06:44:59 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53115 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996Ab2CQKoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 06:44:55 -0400
Received: by wejx9 with SMTP id x9so4614312wej.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 03:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=G98awG7YY/g/C1sfcf+4Mkfymbklkq/skC6/UD9jOk8=;
        b=XmZcuBAemX9ZAIVOfmL5x5infG+BY2MLqIRabWPoynn0UI943hRpFuGvKx0rKMzeCt
         +SGUd1hwpT9fO4bTLU4W9oLpq+khpZKZVMm88qbqsozmgyUeiNc+Sgb1AR5aado36Huo
         ozrL60fEQ/QIAKl3B/lrw40RH3dQbBczDNPZwMZ0SqQe5oc43DaYL6Oj5YfQkiM7lZvv
         9qgZHjOjGvQI5WVZ7ObbZm+wM9wSRN80T5gqTUqVMnSCJheW6IGDHpfaBs+4jKVFeMmO
         wzlxkHGZeeHOtF2UrsX3YRHYcgvnryi3BgyXZIONVvt+2pDHZ4VrrBobgkkrPEBD5Qpc
         502A==
Received: by 10.216.136.100 with SMTP id v78mr3411320wei.88.1331981093265;
        Sat, 17 Mar 2012 03:44:53 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id j3sm10811407wiw.1.2012.03.17.03.44.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 03:44:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.1.gab923
In-Reply-To: <1331981081-25598-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQk73TvAumRwiG9U3lAH3+Uv4lYnR4BZ4mYJO8YkWCMQQ1iTRsZuuTdfwQtOz+0CGTzwA8S8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193317>

The existing label import code looks at each commit
being imported, and then checks for labels at that
commit. This doesn't work in the real world though
because it will drop labels applied on changelists
that have already been imported, a common pattern.

This change adds a new --import-labels option. With
this option, at the end of the sync, git-p4 gets lists
of labels in p4 and git, and then creates a git tag
for each missing p4 label.

This means that tags created on older changelists are
still imported.

Tags that could not be imported are added to an ignore
list.
---
 Documentation/git-p4.txt       |   15 +++-
 contrib/fast-import/git-p4     |  152 +++++++++++++++++++++++++++++++---------
 t/t9811-git-p4-label-import.sh |  116 ++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+), 35 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index b7c7929..c3eedab 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -205,7 +205,11 @@ git repository:
 
 --detect-labels::
 	Query p4 for labels associated with the depot paths, and add
-	them as tags in git.
+	them as tags in git. Limited usefulness as only imports labels
+	associated with new changelists. Deprecated.
+
+--import-labels::
+	Import labels from p4 into git.
 
 --import-local::
 	By default, p4 branches are stored in 'refs/remotes/p4/',
@@ -434,6 +438,15 @@ git-p4.branchList::
 	enabled.  Each entry should be a pair of branch names separated
 	by a colon (:).  This example declares that both branchA and
 	branchB were created from main:
+
+git-p4.ignoredP4Labels::
+	List of p4 labels to ignore. This is built automatically as
+	unimportabled labels are discovered.
+
+git-p4.validLabelRegexp::
+	Only labels matching this regular expression will be imported. The
+	default value is '[A-Z0-9_\-]+$'.
+
 -------------
 git config       git-p4.branchList main:branchA
 git config --add git-p4.branchList main:branchB
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c5362c4..a57443d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1544,6 +1544,7 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--changesfile", dest="changesFile"),
                 optparse.make_option("--silent", dest="silent", action="store_true"),
                 optparse.make_option("--detect-labels", dest="detectLabels", action="store_true"),
+                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
                 optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
                                      help="Import into refs/heads/ , not refs/remotes"),
@@ -1568,6 +1569,7 @@ class P4Sync(Command, P4UserMap):
         self.branch = ""
         self.detectBranches = False
         self.detectLabels = False
+        self.importLabels = False
         self.changesFile = ""
         self.syncWithOrigin = True
         self.verbose = False
@@ -1829,6 +1831,33 @@ class P4Sync(Command, P4UserMap):
         else:
             return "%s <a@b>" % userid
 
+    # Stream a p4 tag
+    def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
+        if verbose:
+            print "writing tag %s for commit %s" % (labelName, commit)
+        gitStream.write("tag %s\n" % labelName)
+        gitStream.write("from %s\n" % commit)
+
+        if labelDetails.has_key('Owner'):
+            owner = labelDetails["Owner"]
+        else:
+            owner = None
+
+        # Try to use the owner of the p4 label, or failing that,
+        # the current p4 user id.
+        if owner:
+            email = self.make_email(owner)
+        else:
+            email = self.make_email(self.p4UserId())
+        tagger = "%s %s %s" % (email, epoch, self.tz)
+
+        gitStream.write("tagger %s\n" % tagger)
+
+        description = labelDetails["Description"]
+        gitStream.write("data %d\n" % len(description))
+        gitStream.write(description)
+        gitStream.write("\n")
+
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
@@ -1893,25 +1922,7 @@ class P4Sync(Command, P4UserMap):
                     cleanedFiles[info["depotFile"]] = info["rev"]
 
                 if cleanedFiles == labelRevisions:
-                    self.gitStream.write("tag tag_%s\n" % labelDetails["label"])
-                    self.gitStream.write("from %s\n" % branch)
-
-                    owner = labelDetails["Owner"]
-
-                    # Try to use the owner of the p4 label, or failing that,
-                    # the current p4 user id.
-                    if owner:
-                        email = self.make_email(owner)
-                    else:
-                        email = self.make_email(self.p4UserId())
-                    tagger = "%s %s %s" % (email, epoch, self.tz)
-
-                    self.gitStream.write("tagger %s\n" % tagger)
-
-                    description = labelDetails["Description"]
-                    self.gitStream.write("data %d\n" % len(description))
-                    self.gitStream.write(description)
-                    self.gitStream.write("\n")
+                    self.streamTag(self.gitStream, 'tag_%s' % labelDetails['label'], labelDetails, branch, epoch)
 
                 else:
                     if not self.silent:
@@ -1923,6 +1934,7 @@ class P4Sync(Command, P4UserMap):
                     print ("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
+    # Build a dictionary of changelists and labels, for "detect-labels" option.
     def getLabels(self):
         self.labels = {}
 
@@ -1949,6 +1961,74 @@ class P4Sync(Command, P4UserMap):
         if self.verbose:
             print "Label changes: %s" % self.labels.keys()
 
+    # Return a list of all p4 labels
+    def getP4Labels(self):
+        labels = []
+        for l in p4CmdList(["labels"] + ["%s..." % p for p in self.depotPaths]):
+            labels.append(l['label'])
+        return labels
+
+    def getMissingLabels(self, p4Labels):
+        gitLabels = {}
+        for line in read_pipe_lines(["git", "tag"]):
+            label = line.strip()
+            gitLabels[label] = 1
+
+        missingGitLabels = []
+        for p4label in p4Labels:
+            if not gitLabels.has_key(p4label):
+                missingGitLabels.append(p4label)
+
+        return missingGitLabels
+
+    # Import p4 labels as git tags. A direct mapping does not
+    # exist, so assume that if all the files are at the same revision
+    # then we can use that, or it's something more complicated we should
+    # just ignore.
+    def importP4Labels(self, stream, depotPaths):
+        p4Labels = self.getMissingLabels(self.getP4Labels())
+        ignoredP4Labels = gitConfigList("git-p4.ignoredP4Labels")
+        validLabelRegexp = gitConfig("git-p4.validLabelRegexp")
+        if len(validLabelRegexp) == 0:
+            validLabelRegexp = r'[A-Z0-9_\-]+$'
+        m = re.compile(validLabelRegexp)
+
+        for name in p4Labels:
+            commitFound = False
+
+            if not m.match(name):
+                if verbose:
+                    print "label %s does not match regexp" % name
+                continue
+
+            if name in ignoredP4Labels:
+                continue
+
+            labelDetails = p4CmdList(['label', "-o", name])[0]
+
+            # get the most recent changelist for each file in this label
+            change = p4Cmd(["changes", "-m", "1"] + ["%s...@%s" % (p, name)
+                                for p in depotPaths])
+
+            if change.has_key('change'):
+                # find the corresponding git commit; take the oldest commit
+                changelist = int(change['change'])
+                gitCommit = read_pipe(["git", "log", "-n", "1", "--reverse", "--grep", "\[git-p4:.*change = %d\]$" % changelist, "--format=format:%H", 'p4/master'])
+                if len(gitCommit) == 0:
+                    print "could not find git commit for changelist %d" % changelist
+                else:
+                    commitFound = True
+                    # Convert from p4 time format; raises ValueError if it fails
+                    tmwhen = time.strptime(labelDetails['Update'], "%Y/%m/%d %H:%M:%S")
+                    when = int(time.mktime(tmwhen))
+                    self.streamTag(stream, name, labelDetails, gitCommit, when)
+                    if verbose:
+                        print "p4 label %s mapped to git commit %s" % (name, gitCommit)
+
+            if not commitFound:
+                # We can't import this label; don't try again
+                system(["git", "config", "--add", "git-p4.ignoredP4Labels", name])
+
     def guessProjectName(self):
         for p in self.depotPaths:
             if p.endswith("/"):
@@ -2425,7 +2505,6 @@ class P4Sync(Command, P4UserMap):
 
         self.depotPaths = newPaths
 
-
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
@@ -2489,22 +2568,24 @@ class P4Sync(Command, P4UserMap):
             if len(changes) == 0:
                 if not self.silent:
                     print "No changes to import!"
-                return True
+            else:
+                if not self.silent and not self.detectBranches:
+                    print "Import destination: %s" % self.branch
 
-            if not self.silent and not self.detectBranches:
-                print "Import destination: %s" % self.branch
+                self.updatedBranches = set()
 
-            self.updatedBranches = set()
+                self.importChanges(changes)
 
-            self.importChanges(changes)
+                if not self.silent:
+                    print ""
+                    if len(self.updatedBranches) > 0:
+                        sys.stdout.write("Updated branches: ")
+                        for b in self.updatedBranches:
+                            sys.stdout.write("%s " % b)
+                        sys.stdout.write("\n")
 
-            if not self.silent:
-                print ""
-                if len(self.updatedBranches) > 0:
-                    sys.stdout.write("Updated branches: ")
-                    for b in self.updatedBranches:
-                        sys.stdout.write("%s " % b)
-                    sys.stdout.write("\n")
+        if self.importLabels:
+            self.importP4Labels(self.gitStream, self.depotPaths)
 
         self.gitStream.close()
         if importProcess.wait() != 0:
@@ -2523,13 +2604,16 @@ class P4Sync(Command, P4UserMap):
 class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
-        self.options = [ ]
+        self.options = [
+                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
+                optparse.make_option("--verbose", dest="verbose", action="store_true"),
+        ]
         self.description = ("Fetches the latest revision from perforce and "
                             + "rebases the current work (branch) against it")
-        self.verbose = False
 
     def run(self, args):
         sync = P4Sync()
+        sync.importLabels = self.importLabels
         sync.run([])
 
         return self.rebase()
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
new file mode 100755
index 0000000..f496bda
--- /dev/null
+++ b/t/t9811-git-p4-label-import.sh
@@ -0,0 +1,116 @@
+#!/bin/sh
+
+test_description='git-p4 p4 label tests'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+# Basic p4 label tests.
+#
+test_expect_success 'basic p4 labels' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		mkdir -p main &&
+
+		echo f1 >main/f1 &&
+		p4 add main/f1 &&
+		p4 submit -d "main/f1" &&
+
+		echo f2 >main/f2 &&
+		p4 add main/f2 &&
+		p4 submit -d "main/f2" &&
+
+		echo f3 >main/file_with_\$metachar &&
+		p4 add main/file_with_\$metachar &&
+		p4 submit -d "file with metachar" &&
+
+		p4 tag -l TAG_F1_ONLY main/f1 &&
+		p4 tag -l TAG_WITH\$_SHELL_CHAR main/... &&
+		p4 tag -l this_tag_will_be_skipped &&
+
+		echo f4 >main/f4 &&
+		p4 add main/f4 &&
+		p4 submit -d "main/f4" &&
+
+		p4 label -i <<-EOF &&
+		Label: LONG_LABEL
+		Description:
+		   A Label first line
+		   A Label second line
+		View:	//depot/...
+		EOF
+
+		p4 tag -l LONG_LABEL ... &&
+
+		p4 labels ... &&
+
+		"$GITP4" clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		"$GITP4" sync --import-labels &&
+
+		git tag &&
+		git tag >taglist &&
+		test_line_count = 3 taglist &&
+
+		cd main &&
+		git checkout TAG_F1_ONLY &&
+		! test -f f2 &&
+		git checkout TAG_WITH\$_SHELL_CHAR &&
+		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
+
+		git show LONG_LABEL | grep -q "A Label second line"
+	)
+'
+
+# Test some label corner cases:
+#
+# - two tags on the same file; both should be available
+# - a tag that is only on one file; this kind of tag
+#   cannot be imported (at least not easily).
+
+test_expect_success 'two labels on the same changelist' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		mkdir -p main &&
+
+		p4 edit main/f1 main/f2 &&
+		echo "hello world" >main/f1 &&
+		echo "not in the tag" >main/f2 &&
+		p4 submit -d "main/f[12]: testing two labels" &&
+
+		p4 tag -l TAG_F1_1 main/... &&
+		p4 tag -l TAG_F1_2 main/... &&
+
+		p4 labels ... &&
+
+		"$GITP4" clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		"$GITP4" sync --import-labels &&
+
+		git tag | grep TAG_F1 &&
+		git tag | grep -q TAG_F1_1 &&
+		git tag | grep -q TAG_F1_2 &&
+
+		cd main &&
+
+		git checkout TAG_F1_1 &&
+		ls &&
+		test -f f1 &&
+
+		git checkout TAG_F1_2 &&
+		ls &&
+		test -f f1
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
1.7.10.rc0.158.gd9e55
