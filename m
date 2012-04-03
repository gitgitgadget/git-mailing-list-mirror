From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/2] git-p4: import/export of labels to/from p4
Date: Tue,  3 Apr 2012 08:38:35 +0100
Message-ID: <1333438715-14902-3-git-send-email-luke@diamand.org>
References: <1333438715-14902-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 09:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEyKS-0005Wo-P1
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 09:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab2DCHiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 03:38:50 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:36120 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2DCHis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 03:38:48 -0400
Received: by wejx9 with SMTP id x9so2177258wej.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 00:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=A5CtBy5RGVcizd7APTAdwE+G7Yxlkl5w5y+ybwUGa7w=;
        b=c1fArcIy8VYjlofAtr7LC0flRSzIDDKsZsec2NTZq4KdduL8dcCl2/oD59WyYsJCIM
         4UgLuEkDn6OIheJASZ8LvP1N/U79eIVDdn/F+ze3+wn+TFZkxgMwfLEAYp9wxLW+K3ha
         HtGno60JJ2hX+XSvjeJWbUI4Hxan3uzpnxViopzKHx7F1sq1JGdbopLS84KvqYMhO9NI
         5rnRTBBZvDWIlK6rJu5uGH6Ib6v4ZtjDywOeNs6Gnb1XDzBbz01COzuLSnhpEnMJM+wA
         k+iJ4eDuGz+cZl0odiioraHkmgCjAoIeS+S3Wh3TA+CUAJC+njyU35fobhq1MkLecnVD
         syfA==
Received: by 10.180.102.3 with SMTP id fk3mr33042976wib.9.1333438726540;
        Tue, 03 Apr 2012 00:38:46 -0700 (PDT)
Received: from halilbut.cam.broadcom.com (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ff2sm66101034wib.9.2012.04.03.00.38.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 00:38:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.158.gd9e55
In-Reply-To: <1333438715-14902-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQmIOX2ZJLDJ4nrWHn/gTYtJXBDAx2iXX5MqQr+882yk+A2FcMuKtSZPGg12AmK+smDDqm9h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194602>

The existing label import code looks at each commit being
imported, and then checks for labels at that commit. This
doesn't work in the real world though because it will drop
labels applied on changelists that have already been imported,
a common pattern.

This change adds a new --import-labels option. With this option,
at the end of the sync, git-p4 gets sets of labels in p4 and git,
and then creates a git tag for each missing p4 label.

This means that tags created on older changelists are
still imported.

Tags that could not be imported are added to an ignore
list.

The same sets of git and p4 tags and labels can also be used to
derive a list of git tags to export to p4. This is enabled with
--export-tags.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt       |   39 ++++++-
 contrib/fast-import/git-p4     |  249 ++++++++++++++++++++++++++++++++++------
 t/t9811-git-p4-label-import.sh |  145 +++++++++++++++++++++++
 3 files changed, 398 insertions(+), 35 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index b7c7929..04fd0da 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -205,7 +205,16 @@ git repository:
 
 --detect-labels::
 	Query p4 for labels associated with the depot paths, and add
-	them as tags in git.
+	them as tags in git. Limited usefulness as only imports labels
+	associated with new changelists. Deprecated.
+
+--import-labels::
+	Import labels from p4 into git.
+
+--export-tags:
+	Export tags from git into p4. It only makes sense to do this
+	in the sync phase, as that is when the newly updated git
+	commits, with their p4 changelist, are first available.
 
 --import-local::
 	By default, p4 branches are stored in 'refs/remotes/p4/',
@@ -270,6 +279,15 @@ These options can be used to modify 'git p4 submit' behavior.
 	Re-author p4 changes before submitting to p4.  This option
 	requires p4 admin privileges.
 
+Rebase options
+~~~~~~~~~~~~~~
+These options can be used to modify 'git p4 rebase' behavior.
+
+--import-labels::
+	Import p4 labels
+
+--export-tags::
+	Export git tags to p4
 
 DEPOT PATH SYNTAX
 -----------------
@@ -434,6 +452,25 @@ git-p4.branchList::
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
+git-p4.exportTags::
+	Export git tags to p4, as per --export-tags.
+
+git-p4.validLabelRegexp::
+	Only p4 labels matching this regular expression will be imported. The
+	default value is '[A-Z0-9_\-.]+$'.
+
+git-p4.validTagRegexp::
+	Only git tags matching this regular expression will be exported. Default
+	as for validLabelRegexp.
+
 -------------
 git config       git-p4.branchList main:branchA
 git config --add git-p4.branchList main:branchB
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c5362c4..433bac9 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -253,6 +253,24 @@ def getP4OpenedType(file):
     else:
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
+# Return the set of all p4 labels
+def getP4Labels(depotPaths):
+    labels = set()
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
@@ -1544,6 +1562,8 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--changesfile", dest="changesFile"),
                 optparse.make_option("--silent", dest="silent", action="store_true"),
                 optparse.make_option("--detect-labels", dest="detectLabels", action="store_true"),
+                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
+                optparse.make_option("--export-tags", dest="exportTags", action="store_true"),
                 optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
                                      help="Import into refs/heads/ , not refs/remotes"),
@@ -1568,6 +1588,8 @@ class P4Sync(Command, P4UserMap):
         self.branch = ""
         self.detectBranches = False
         self.detectLabels = False
+        self.importLabels = False
+        self.exportTags = False
         self.changesFile = ""
         self.syncWithOrigin = True
         self.verbose = False
@@ -1583,6 +1605,7 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs = None
         self.tempBranches = []
         self.tempBranchLocation = "git-p4-tmp"
+        self.defaultLabelRegexp = r'[A-Z0-9_\-.]+$'
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -1829,6 +1852,33 @@ class P4Sync(Command, P4UserMap):
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
@@ -1893,25 +1943,7 @@ class P4Sync(Command, P4UserMap):
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
@@ -1923,6 +1955,7 @@ class P4Sync(Command, P4UserMap):
                     print ("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
+    # Build a dictionary of changelists and labels, for "detect-labels" option.
     def getLabels(self):
         self.labels = {}
 
@@ -1949,6 +1982,130 @@ class P4Sync(Command, P4UserMap):
         if self.verbose:
             print "Label changes: %s" % self.labels.keys()
 
+    # Export git tags as p4 labels. Create a p4 label and then tag
+    # with that.
+    def exportGitTags(self, gitTags):
+        validTagRegexp = gitConfig("git-p4.validTagRegexp")
+        if len(validTagRegexp) == 0:
+            validTagRegexp = self.defaultLabelRegexp
+        m = re.compile(validTagRegexp)
+        commit_re = re.compile(r'\s*\[git-p4:.*change = (\d+)\s*\]')
+
+        for name in gitTags:
+
+            if not m.match(name):
+                if verbose:
+                    print "tag %s does not match regexp %s" % (name, validTagRegexp)
+                continue
+
+            # Get the p4 commit this corresponds to
+            changelist = None
+            for l in read_pipe_lines(["git", "log", "--max-count=1", name]):
+                match = commit_re.match(l)
+                if match:
+                    changelist = match.group(1)
+
+            if not changelist:
+                # a tag pointing to something not sent to p4; ignore
+                if verbose:
+                    print "git tag %s does not give a p4 commit" % name
+                continue
+
+            # Get the tag details.
+            inHeader = True
+            isAnnotated = False
+            body = []
+            for l in read_pipe_lines(["git", "cat-file", "-p", name]): 
+                if inHeader:
+                    if re.match(r'tag\s+', l):
+                        isAnnotated = True
+                elif re.match(r'^\s*$', l):
+                        inHeader = False
+                        continue
+                else:
+                    body.append(l)
+
+            if not isAnnotated:
+                body = ["lightweight tag imported by git p4\n"]
+
+            # Create the label
+            labelTemplate  = "Label: %s\n" % name
+            labelTemplate += "Description:\n"
+            for b in body:
+                labelTemplate += "\t" + b
+            labelTemplate += "View:\n"
+            for p in self.depotPaths:
+                labelTemplate += "\t%s...\n" % p
+
+            p4_write_pipe(["label", "-i"], labelTemplate)
+
+            # Use the label
+            p4_system(["tag", "-l", name] +
+                      ["%s...@%s" % (p, changelist) for p in self.depotPaths])
+
+            if verbose:
+                print "created p4 label for tag %s" % name
+            
+    # Import p4 labels as git tags. A direct mapping does not
+    # exist, so assume that if all the files are at the same revision
+    # then we can use that, or it's something more complicated we should
+    # just ignore.
+    def importP4Labels(self, stream, p4Labels):
+        ignoredP4Labels = gitConfigList("git-p4.ignoredP4Labels")
+        validLabelRegexp = gitConfig("git-p4.validLabelRegexp")
+        if len(validLabelRegexp) == 0:
+            validLabelRegexp = self.defaultLabelRegexp
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
@@ -2425,7 +2582,6 @@ class P4Sync(Command, P4UserMap):
 
         self.depotPaths = newPaths
 
-
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
@@ -2489,22 +2645,39 @@ class P4Sync(Command, P4UserMap):
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
+        if gitConfig("git-p4.exportTags", "--bool") == "true":
+            self.exportTags = true
+
+        if self.importLabels or self.exportTags:
+            p4Labels = getP4Labels(self.depotPaths)
+            gitTags = getGitTags()
+
+            if self.importLabels:
+                missingP4Labels = p4Labels - gitTags
+                self.importP4Labels(self.gitStream, missingP4Labels)
+
+            if self.exportTags:
+                missingGitTags = gitTags - p4Labels
+                self.exportGitTags(missingGitTags)
 
         self.gitStream.close()
         if importProcess.wait() != 0:
@@ -2523,13 +2696,21 @@ class P4Sync(Command, P4UserMap):
 class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
-        self.options = [ ]
+        self.options = [
+                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
+                optparse.make_option("--export-tags", dest="exportTags", action="store_true"),
+                optparse.make_option("--verbose", dest="verbose", action="store_true"),
+        ]
+        self.verbose = False
+        self.importLabels = False
+        self.exportTags = False
         self.description = ("Fetches the latest revision from perforce and "
                             + "rebases the current work (branch) against it")
-        self.verbose = False
 
     def run(self, args):
         sync = P4Sync()
+        sync.importLabels = self.importLabels
+        sync.exportTags = self.exportTags
         sync.run([])
 
         return self.rebase()
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
new file mode 100755
index 0000000..860d844
--- /dev/null
+++ b/t/t9811-git-p4-label-import.sh
@@ -0,0 +1,145 @@
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
+		p4 tag -l this_tag_will_be_skipped main/... &&
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
+		"$GITP4" clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git config git-p4.validLabelRegexp ".*TAG.*" &&
+		"$GITP4" sync --import-labels --verbose &&
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
+# Export some git tags to p4
+test_expect_success 'export git tags to p4' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot@all &&
+	(	
+		cd "$git" &&
+		git tag -m "A tag created in git" GIT_TAG_1 &&
+		echo "hello world" >main/f10 &&
+		git add main/f10 &&
+		git commit -m "Adding file for export test" &&
+		git config git-p4.skipSubmitEdit true &&
+		"$GITP4" submit &&
+		git tag -m "Another git tag" GIT_TAG_2 &&
+		git tag LIGHTWEIGHT_TAG &&
+		"$GITP4" sync --import-labels --export-tags --verbose
+	) &&
+	(
+	 	cd "$cli" &&
+		p4 sync ... &&
+		p4 labels ... | grep GIT_TAG_1 &&
+		p4 labels ... | grep GIT_TAG_2 &&
+		p4 labels ... | grep LIGHTWEIGHT_TAG &&
+		p4 label -o GIT_TAG_1 | grep "tag created in git" &&
+		p4 sync ...@GIT_TAG_1 &&
+		! test -f main/f10
+		p4 sync ...@GIT_TAG_2 &&
+		test -f main/f10
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.10.rc0.158.gd9e55
