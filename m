From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 4/5] git p4: import/export of labels to/from p4
Date: Tue, 24 Apr 2012 09:08:16 +0100
Message-ID: <1335254897-15242-5-git-send-email-luke@diamand.org>
References: <1335254897-15242-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:08:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SManu-00082N-2k
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab2DXIIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:08:43 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45004 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab2DXIIa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:08:30 -0400
Received: by wejx9 with SMTP id x9so230942wej.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=U1mmYAgzzRCSrnT0bh3Q7eiyNvCEkuCkdLqiqxeWRsg=;
        b=A7/OYe5+XNISkqwpCUgfnqr7MDPniwuwjouD6f87YQsnF+17jTWNjCHZXylaDm/mci
         gEl+D1Tl6SoA8k0xBR4bHUdyI7NNDFglRLGOvB6f7vWfUIU4+2tWzLheJAHHzh2KuqFl
         PS+9m4K6lCJRBEi9MpS7aRvV3FEUZudvrLhX9mky1yySS9izqO2vSKX2bB/nKmA0bDyP
         v1wHg3idD4QKJeKmKFzyNRAkrzVL5S05dxCevMFX0uo8rlNkKfV1LyK9u5vziNYLXBn3
         p9gYtclz96w8m1kfDN0xeRAzmtkoZEweFdkzg6u2pna8T7xyffho9uwlFmvOdgyTujOz
         OLkA==
Received: by 10.180.82.132 with SMTP id i4mr28769159wiy.12.1335254908531;
        Tue, 24 Apr 2012 01:08:28 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fl2sm44448146wib.2.2012.04.24.01.08.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:08:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.381.gb484f
In-Reply-To: <1335254897-15242-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQljg0094UGmmYDxf1xA5LcAdgAEba7Nl3nZydGrAdgLE+OD/AXtqxENFzGO6XDpaJuadjmr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196207>

The existing label import code looks at each commit being
imported, and then checks for labels at that commit. This
doesn't work in the real world though because it will drop
labels applied on changelists that have already been imported,
a common pattern.

This change adds a new --import-labels option. With this option,
at the end of the sync, git p4 gets sets of labels in p4 and git,
and then creates a git tag for each missing p4 label.

This means that tags created on older changelists are
still imported.

Tags that could not be imported are added to an ignore
list.

The same sets of git and p4 tags and labels can also be used to
derive a list of git tags to export to p4. This is enabled with
--export-labels in 'git p4 submit'.

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-p4.txt       |   43 ++++++-
 git-p4.py                      |  260 ++++++++++++++++++++++++++++++++++------
 t/t9811-git-p4-label-import.sh |  202 +++++++++++++++++++++++++++++++
 3 files changed, 466 insertions(+), 39 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3fac413..368a45b 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -198,7 +198,11 @@ git repository:
 
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
@@ -263,6 +267,16 @@ These options can be used to modify 'git p4 submit' behavior.
 	Re-author p4 changes before submitting to p4.  This option
 	requires p4 admin privileges.
 
+--export-labels::
+	Export tags from git as p4 labels. Tags found in git are applied
+	to the perforce working directory.
+
+Rebase options
+~~~~~~~~~~~~~~
+These options can be used to modify 'git p4 rebase' behavior.
+
+--import-labels::
+	Import p4 labels.
 
 DEPOT PATH SYNTAX
 -----------------
@@ -427,6 +441,18 @@ git-p4.branchList::
 	enabled.  Each entry should be a pair of branch names separated
 	by a colon (:).  This example declares that both branchA and
 	branchB were created from main:
+
+git-p4.ignoredP4Labels::
+	List of p4 labels to ignore. This is built automatically as
+	unimportable labels are discovered.
+
+git-p4.importLabels::
+	Import p4 labels into git, as per --import-labels.
+
+git-p4.labelImportRegexp::
+	Only p4 labels matching this regular expression will be imported. The
+	default value is '[a-zA-Z0-9_\-.]+$'.
+
 -------------
 git config       git-p4.branchList main:branchA
 git config --add git-p4.branchList main:branchB
@@ -481,10 +507,17 @@ git-p4.skipUserNameCheck::
 	submission regardless.
 
 git-p4.attemptRCSCleanup:
-    If enabled, 'git p4 submit' will attempt to cleanup RCS keywords
-    ($Header$, etc). These would otherwise cause merge conflicts and prevent
-    the submit going ahead. This option should be considered experimental at
-    present.
+	If enabled, 'git p4 submit' will attempt to cleanup RCS keywords
+	($Header$, etc). These would otherwise cause merge conflicts and prevent
+	the submit going ahead. This option should be considered experimental at
+	present.
+
+git-p4.exportLabels::
+	Export git tags to p4 labels, as per --export-labels.
+
+git-p4.labelExportRegexp::
+	Only p4 labels matching this regular expression will be exported. The
+	default value is '[a-zA-Z0-9_\-.]+$'.
 
 IMPLEMENTATION DETAILS
 ----------------------
diff --git a/git-p4.py b/git-p4.py
index ead0c44..6ce88ff 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -14,6 +14,8 @@ import re, shutil
 
 verbose = False
 
+# Only labels/tags matching this will be imported/exported
+defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
@@ -253,6 +255,26 @@ def getP4OpenedType(file):
     else:
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
+# Return the set of all p4 labels
+def getP4Labels(depotPaths):
+    labels = set()
+    if isinstance(depotPaths,basestring):
+        depotPaths = [depotPaths]
+
+    for l in p4CmdList(["labels"] + ["%s..." % p for p in depotPaths]):
+        label = l['label']
+        labels.add(label)
+
+    return labels
+
+# Return the set of all git tags
+def getGitTags():
+    gitTags = set()
+    for line in read_pipe_lines(["git", "tag"]):
+        tag = line.strip()
+        gitTags.add(tag)
+    return gitTags
+
 def diffTreePattern():
     # This is a simple generator for the diff tree regex pattern. This could be
     # a class variable if this and parseDiffTreeEntry were a part of a class.
@@ -792,6 +814,7 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("-M", dest="detectRenames", action="store_true"),
                 # preserve the user, requires relevant p4 permissions
                 optparse.make_option("--preserve-user", dest="preserveUser", action="store_true"),
+                optparse.make_option("--export-labels", dest="exportLabels", action="store_true"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -801,6 +824,7 @@ class P4Submit(Command, P4UserMap):
         self.verbose = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.isWindows = (platform.system() == "Windows")
+        self.exportLabels = False
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
@@ -1228,6 +1252,71 @@ class P4Submit(Command, P4UserMap):
                    + "Please review/edit and then use p4 submit -i < %s to submit directly!"
                    % (fileName, fileName))
 
+    # Export git tags as p4 labels. Create a p4 label and then tag
+    # with that.
+    def exportGitTags(self, gitTags):
+        validLabelRegexp = gitConfig("git-p4.labelExportRegexp")
+        if len(validLabelRegexp) == 0:
+            validLabelRegexp = defaultLabelRegexp
+        m = re.compile(validLabelRegexp)
+
+        for name in gitTags:
+
+            if not m.match(name):
+                if verbose:
+                    print "tag %s does not match regexp %s" % (name, validTagRegexp)
+                continue
+
+            # Get the p4 commit this corresponds to
+            logMessage = extractLogMessageFromGitCommit(name)
+            values = extractSettingsGitLog(logMessage)
+
+            if not values.has_key('change'):
+                # a tag pointing to something not sent to p4; ignore
+                if verbose:
+                    print "git tag %s does not give a p4 commit" % name
+                continue
+            else:
+                changelist = values['change']
+
+            # Get the tag details.
+            inHeader = True
+            isAnnotated = False
+            body = []
+            for l in read_pipe_lines(["git", "cat-file", "-p", name]):
+                l = l.strip()
+                if inHeader:
+                    if re.match(r'tag\s+', l):
+                        isAnnotated = True
+                    elif re.match(r'\s*$', l):
+                        inHeader = False
+                        continue
+                else:
+                    body.append(l)
+
+            if not isAnnotated:
+                body = ["lightweight tag imported by git p4\n"]
+
+            # Create the label - use the same view as the client spec we are using
+            clientSpec = getClientSpec()
+
+            labelTemplate  = "Label: %s\n" % name
+            labelTemplate += "Description:\n"
+            for b in body:
+                labelTemplate += "\t" + b + "\n"
+            labelTemplate += "View:\n"
+            for mapping in clientSpec.mappings:
+                labelTemplate += "\t%s\n" % mapping.depot_side.path
+
+            p4_write_pipe(["label", "-i"], labelTemplate)
+
+            # Use the label
+            p4_system(["tag", "-l", name] +
+                      ["%s@%s" % (mapping.depot_side.path, changelist) for mapping in clientSpec.mappings])
+
+            if verbose:
+                print "created p4 label for tag %s" % name
+
     def run(self, args):
         if len(args) == 0:
             self.master = currentGitBranch()
@@ -1317,6 +1406,16 @@ class P4Submit(Command, P4UserMap):
             rebase = P4Rebase()
             rebase.rebase()
 
+        if gitConfig("git-p4.exportLabels", "--bool") == "true":
+            self.exportLabels = true
+
+        if self.exportLabels:
+            p4Labels = getP4Labels(self.depotPath)
+            gitTags = getGitTags()
+
+            missingGitTags = gitTags - p4Labels
+            self.exportGitTags(missingGitTags)
+
         return True
 
 class View(object):
@@ -1544,6 +1643,7 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--changesfile", dest="changesFile"),
                 optparse.make_option("--silent", dest="silent", action="store_true"),
                 optparse.make_option("--detect-labels", dest="detectLabels", action="store_true"),
+                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
                 optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
                                      help="Import into refs/heads/ , not refs/remotes"),
@@ -1568,6 +1668,7 @@ class P4Sync(Command, P4UserMap):
         self.branch = ""
         self.detectBranches = False
         self.detectLabels = False
+        self.importLabels = False
         self.changesFile = ""
         self.syncWithOrigin = True
         self.verbose = False
@@ -1829,6 +1930,38 @@ class P4Sync(Command, P4UserMap):
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
+        print "labelDetails=",labelDetails
+        if labelDetails.has_key('Description'):
+            description = labelDetails['Description']
+        else:
+            description = 'Label from git p4'
+
+        gitStream.write("data %d\n" % len(description))
+        gitStream.write(description)
+        gitStream.write("\n")
+
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
@@ -1893,25 +2026,7 @@ class P4Sync(Command, P4UserMap):
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
@@ -1923,6 +2038,7 @@ class P4Sync(Command, P4UserMap):
                     print ("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
+    # Build a dictionary of changelists and labels, for "detect-labels" option.
     def getLabels(self):
         self.labels = {}
 
@@ -1949,6 +2065,69 @@ class P4Sync(Command, P4UserMap):
         if self.verbose:
             print "Label changes: %s" % self.labels.keys()
 
+    # Import p4 labels as git tags. A direct mapping does not
+    # exist, so assume that if all the files are at the same revision
+    # then we can use that, or it's something more complicated we should
+    # just ignore.
+    def importP4Labels(self, stream, p4Labels):
+        if verbose:
+            print "import p4 labels: " + ' '.join(p4Labels)
+
+        ignoredP4Labels = gitConfigList("git-p4.ignoredP4Labels")
+        validLabelRegexp = gitConfig("git-p4.labelImportRegexp")
+        if len(validLabelRegexp) == 0:
+            validLabelRegexp = defaultLabelRegexp
+        m = re.compile(validLabelRegexp)
+
+        for name in p4Labels:
+            commitFound = False
+
+            if not m.match(name):
+                if verbose:
+                    print "label %s does not match regexp %s" % (name,validLabelRegexp)
+                continue
+
+            if name in ignoredP4Labels:
+                continue
+
+            labelDetails = p4CmdList(['label', "-o", name])[0]
+
+            # get the most recent changelist for each file in this label
+            change = p4Cmd(["changes", "-m", "1"] + ["%s...@%s" % (p, name)
+                                for p in self.depotPaths])
+
+            if change.has_key('change'):
+                # find the corresponding git commit; take the oldest commit
+                changelist = int(change['change'])
+                gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
+                     "--reverse", ":/\[git-p4:.*change = %d\]" % changelist])
+                if len(gitCommit) == 0:
+                    print "could not find git commit for changelist %d" % changelist
+                else:
+                    gitCommit = gitCommit.strip()
+                    commitFound = True
+                    # Convert from p4 time format
+                    try:
+                        tmwhen = time.strptime(labelDetails['Update'], "%Y/%m/%d %H:%M:%S")
+                    except ValueError:
+                        print "Could not convert label time %s" % labelDetail['Update']
+                        tmwhen = 1
+
+                    when = int(time.mktime(tmwhen))
+                    self.streamTag(stream, name, labelDetails, gitCommit, when)
+                    if verbose:
+                        print "p4 label %s mapped to git commit %s" % (name, gitCommit)
+            else:
+                if verbose:
+                    print "Label %s has no changelists - possibly deleted?" % name
+
+            if not commitFound:
+                # We can't import this label; don't try again as it will get very
+                # expensive repeatedly fetching all the files for labels that will
+                # never be imported. If the label is moved in the future, the
+                # ignore will need to be removed manually.
+                system(["git", "config", "--add", "git-p4.ignoredP4Labels", name])
+
     def guessProjectName(self):
         for p in self.depotPaths:
             if p.endswith("/"):
@@ -2425,7 +2604,6 @@ class P4Sync(Command, P4UserMap):
 
         self.depotPaths = newPaths
 
-
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
@@ -2489,22 +2667,31 @@ class P4Sync(Command, P4UserMap):
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
+        if gitConfig("git-p4.importLabels", "--bool") == "true":
+            self.importLabels = true
+
+        if self.importLabels:
+            p4Labels = getP4Labels(self.depotPaths)
+            gitTags = getGitTags()
+
+            missingP4Labels = p4Labels - gitTags
+            self.importP4Labels(self.gitStream, missingP4Labels)
 
         self.gitStream.close()
         if importProcess.wait() != 0:
@@ -2523,13 +2710,18 @@ class P4Sync(Command, P4UserMap):
 class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
-        self.options = [ ]
+        self.options = [
+                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
+                optparse.make_option("--verbose", dest="verbose", action="store_true"),
+        ]
+        self.verbose = False
+        self.importLabels = False
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
index 0000000..fb00ffa
--- /dev/null
+++ b/t/t9811-git-p4-label-import.sh
@@ -0,0 +1,202 @@
+#!/bin/sh
+
+test_description='git p4 label tests'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+# Basic p4 label import tests.
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
+		p4 tag -l this_tag_will_be\ skipped main/... &&
+
+		echo f4 >main/f4 &&
+		p4 add main/f4 &&
+		p4 submit -d "main/f4" &&
+
+		p4 label -i <<-EOF &&
+		Label: TAG_LONG_LABEL
+		Description:
+		   A Label first line
+		   A Label second line
+		View:	//depot/...
+		EOF
+
+		p4 tag -l TAG_LONG_LABEL ... &&
+
+		p4 labels ... &&
+
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git config git-p4.labelImportRegexp ".*TAG.*" &&
+		git p4 sync --import-labels --verbose &&
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
+		git show TAG_LONG_LABEL | grep -q "A Label second line"
+	)
+'
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
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git p4 sync --import-labels &&
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
+# Export some git tags to p4
+test_expect_success 'export git tags to p4' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git tag -m "A tag created in git:xyzzy" GIT_TAG_1 &&
+		echo "hello world" >main/f10 &&
+		git add main/f10 &&
+		git commit -m "Adding file for export test" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit &&
+		git tag -m "Another git tag" GIT_TAG_2 &&
+		git tag LIGHTWEIGHT_TAG &&
+		git p4 rebase --import-labels --verbose &&
+		git p4 submit --export-labels --verbose
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync ... &&
+		p4 labels ... | grep GIT_TAG_1 &&
+		p4 labels ... | grep GIT_TAG_2 &&
+		p4 labels ... | grep LIGHTWEIGHT_TAG &&
+		p4 label -o GIT_TAG_1 | grep "tag created in git:xyzzy" &&
+		p4 sync ...@GIT_TAG_1 &&
+		! test -f main/f10
+		p4 sync ...@GIT_TAG_2 &&
+		test -f main/f10
+	)
+'
+
+# Export a tag from git where an affected file is deleted later on
+# Need to create git tags after rebase, since only then can the
+# git commits be mapped to p4 changelists.
+test_expect_success 'export git tags to p4 with deletion' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git p4 sync --import-labels &&
+		echo "deleted file" >main/deleted_file &&
+		git add main/deleted_file &&
+		git commit -m "create deleted file" &&
+		git rm main/deleted_file &&
+		echo "new file" >main/f11 &&
+		git add main/f11 &&
+		git commit -m "delete the deleted file" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit &&
+		git p4 rebase --import-labels --verbose &&
+		git tag -m "tag on deleted file" GIT_TAG_ON_DELETED HEAD~1 &&
+		git tag -m "tag after deletion" GIT_TAG_AFTER_DELETION HEAD &&
+		git p4 submit --export-labels --verbose
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync ... &&
+		p4 sync ...@GIT_TAG_ON_DELETED &&
+		test -f main/deleted_file &&
+		p4 sync ...@GIT_TAG_AFTER_DELETION &&
+		! test -f main/deleted_file &&
+		echo "checking label contents" &&
+		p4 label -o GIT_TAG_ON_DELETED | grep "tag on deleted file"
+	)
+'
+
+# Create a tag in git that cannot be exported to p4
+test_expect_success 'tag that cannot be exported' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git checkout -b a_branch &&
+		echo "hello" >main/f12 &&
+		git add main/f12 &&
+		git commit -m "adding f12" &&
+		git tag -m "tag on a_branch" GIT_TAG_ON_A_BRANCH &&
+		git checkout master &&
+		git p4 submit --export-labels
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync ... &&
+		!(p4 labels | grep GIT_TAG_ON_A_BRANCH)
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.10.381.gb484f
