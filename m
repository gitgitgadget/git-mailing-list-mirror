Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AD4C4332F
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245236AbiDAP4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354812AbiDAPMc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:12:32 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A192B04F8
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:55:46 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIDs-009TW3-69; Fri, 01 Apr 2022 15:25:55 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 05/22] git-p4: convert descriptive class and function comments into docstrings
Date:   Fri,  1 Apr 2022 15:24:47 +0100
Message-Id: <20220401142504.58995-6-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, a small number of functions, methods and classes were
documented using comments. This patch improves consistency by converting
these into docstrings similar to those that already exist in the script.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 164 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 70 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 10b51b17de..892b964eec 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -458,7 +458,7 @@ def p4_sync(f, *options):
 
 
 def p4_add(f):
-    # forcibly add file names with wildcards
+    """Forcibly add file names with wildcards."""
     if wildcard_present(f):
         p4_system(["add", "-f", f])
     else:
@@ -526,12 +526,10 @@ def p4_describe(change, shelved=False):
     return d
 
 
-#
-# Canonicalize the p4 type and return a tuple of the
-# base type, plus any modifiers.  See "p4 help filetypes"
-# for a list and explanation.
-#
 def split_p4_type(p4type):
+    """Canonicalize the p4 type and return a tuple of the base type, plus any
+       modifiers.  See "p4 help filetypes" for a list and explanation.
+       """
 
     p4_filetypes_historical = {
         "ctempobj": "binary+Sw",
@@ -562,19 +560,18 @@ def split_p4_type(p4type):
     return (base, mods)
 
 
-#
-# return the raw p4 type of a file (text, text+ko, etc)
-#
 def p4_type(f):
+    """Return the raw p4 type of a file (text, text+ko, etc)."""
+
     results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
 
-#
-# Given a type base and modifier, return a regexp matching
-# the keywords that can be expanded in the file
-#
 def p4_keywords_regexp_for_type(base, type_mods):
+    """Given a type base and modifier, return a regexp matching the keywords
+       that can be expanded in the file.
+       """
+
     if base in ("text", "unicode", "binary"):
         if "ko" in type_mods:
             return re_ko_keywords
@@ -586,12 +583,11 @@ def p4_keywords_regexp_for_type(base, type_mods):
         return None
 
 
-#
-# Given a file, return a regexp matching the possible
-# RCS keywords that will be expanded, or None for files
-# with kw expansion turned off.
-#
 def p4_keywords_regexp_for_file(file):
+    """Given a file, return a regexp matching the possible RCS keywords that
+       will be expanded, or None for files with kw expansion turned off.
+       """
+
     if not os.path.exists(file):
         return None
     else:
@@ -600,8 +596,9 @@ def p4_keywords_regexp_for_file(file):
 
 
 def setP4ExecBit(file, mode):
-    # Reopens an already open file and changes the execute bit to match
-    # the execute bit setting in the passed in mode.
+    """Reopens an already open file and changes the execute bit to match the
+       execute bit setting in the passed in mode.
+       """
 
     p4Type = "+x"
 
@@ -616,7 +613,7 @@ def setP4ExecBit(file, mode):
 
 
 def getP4OpenedType(file):
-    # Returns the perforce file type for the given file.
+    """Returns the perforce file type for the given file."""
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
     match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
@@ -626,8 +623,9 @@ def getP4OpenedType(file):
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
 
-# Return the set of all p4 labels
 def getP4Labels(depotPaths):
+    """Return the set of all p4 labels."""
+
     labels = set()
     if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
@@ -639,8 +637,9 @@ def getP4Labels(depotPaths):
     return labels
 
 
-# Return the set of all git tags
 def getGitTags():
+    """Return the set of all git tags."""
+
     gitTags = set()
     for line in read_pipe_lines(["git", "tag"]):
         tag = line.strip()
@@ -691,8 +690,9 @@ def parseDiffTreeEntry(entry):
 
 
 def isModeExec(mode):
-    # Returns True if the given git mode represents an executable file,
-    # otherwise False.
+    """Returns True if the given git mode represents an executable file,
+       otherwise False.
+       """
     return mode[-3:] == "755"
 
 
@@ -1201,13 +1201,14 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
 
 
 def p4PathStartsWith(path, prefix):
-    # This method tries to remedy a potential mixed-case issue:
-    #
-    # If UserA adds  //depot/DirA/file1
-    # and UserB adds //depot/dira/file2
-    #
-    # we may or may not have a problem. If you have core.ignorecase=true,
-    # we treat DirA and dira as the same directory
+    """This method tries to remedy a potential mixed-case issue:
+
+       If UserA adds  //depot/DirA/file1
+       and UserB adds //depot/dira/file2
+
+       we may or may not have a problem. If you have core.ignorecase=true,
+       we treat DirA and dira as the same directory.
+       """
     if gitConfigBool("core.ignorecase"):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
@@ -1259,12 +1260,14 @@ def getClientRoot():
     return entry["Root"]
 
 
-#
-# P4 wildcards are not allowed in filenames.  P4 complains
-# if you simply add them, but you can force it with "-f", in
-# which case it translates them into %xx encoding internally.
-#
 def wildcard_decode(path):
+    """Decode P4 wildcards into %xx encoding
+
+       P4 wildcards are not allowed in filenames.  P4 complains if you simply
+       add them, but you can force it with "-f", in which case it translates
+       them into %xx encoding internally.
+       """
+
     # Search for and fix just these four characters.  Do % last so
     # that fixing it does not inadvertently create new %-escapes.
     # Cannot have * in a filename in windows; untested as to
@@ -1278,6 +1281,8 @@ def wildcard_decode(path):
 
 
 def wildcard_encode(path):
+    """Encode %xx coded wildcards into P4 coding."""
+
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
                .replace("*", "%2A") \
@@ -1524,7 +1529,7 @@ def p4UserId(self):
         die("Could not find your p4 user id")
 
     def p4UserIsMe(self, p4User):
-        # return True if the given p4 user is actually me
+        """Return True if the given p4 user is actually me."""
         me = self.p4UserId()
         if not p4User or p4User != me:
             return False
@@ -1727,7 +1732,9 @@ def prepareLogMessage(self, template, message, jobs):
         return result
 
     def patchRCSKeywords(self, file, regexp):
-        # Attempt to zap the RCS keywords in a p4 controlled file matching the given regex
+        """Attempt to zap the RCS keywords in a p4 controlled file matching the
+           given regex.
+           """
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
@@ -1745,7 +1752,9 @@ def patchRCSKeywords(self, file, regexp):
         print("Patched up RCS keywords in %s" % file)
 
     def p4UserForCommit(self,id):
-        # Return the tuple (perforce user,git email) for a given git commit id
+        """Return the tuple (perforce user,git email) for a given git commit
+           id.
+           """
         self.getUserMapFromPerforceServer()
         gitEmail = read_pipe(["git", "log", "--max-count=1",
                               "--format=%ae", id])
@@ -1756,7 +1765,7 @@ def p4UserForCommit(self,id):
             return (self.emails[gitEmail],gitEmail)
 
     def checkValidP4Users(self,commits):
-        # check if any git authors cannot be mapped to p4 users
+        """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             (user,email) = self.p4UserForCommit(id)
             if not user:
@@ -1767,10 +1776,12 @@ def checkValidP4Users(self,commits):
                     die("Error: %s\nSet git-p4.allowMissingP4Users to true to allow this." % msg)
 
     def lastP4Changelist(self):
-        # Get back the last changelist number submitted in this client spec. This
-        # then gets used to patch up the username in the change. If the same
-        # client spec is being used by multiple processes then this might go
-        # wrong.
+        """Get back the last changelist number submitted in this client spec.
+
+           This then gets used to patch up the username in the change. If the
+           same client spec is being used by multiple processes then this might
+           go wrong.
+           """
         results = p4CmdList(["client", "-o"])        # find the current client
         client = None
         for r in results:
@@ -1786,7 +1797,7 @@ def lastP4Changelist(self):
         die("Could not get changelist number for last submit - cannot patch up user details")
 
     def modifyChangelistUser(self, changelist, newUser):
-        # fixup the user field of a changelist after it has been submitted.
+        """Fixup the user field of a changelist after it has been submitted."""
         changes = p4CmdList(["change", "-o", changelist])
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
@@ -1809,8 +1820,9 @@ def modifyChangelistUser(self, changelist, newUser):
         die("Could not modify user field of changelist %s to %s" % (changelist, newUser))
 
     def canChangeChangelists(self):
-        # check to see if we have p4 admin or super-user permissions, either of
-        # which are required to modify changelists.
+        """Check to see if we have p4 admin or super-user permissions, either
+           of which are required to modify changelists.
+           """
         results = p4CmdList(["protects", self.depotPath])
         for r in results:
             if 'perm' in r:
@@ -2262,9 +2274,11 @@ def applyCommit(self, id):
                 os.remove(fileName)
         return submitted
 
-    # Export git tags as p4 labels. Create a p4 label and then tag
-    # with that.
     def exportGitTags(self, gitTags):
+        """Export git tags as p4 labels. Create a p4 label and then tag with
+           that.
+           """
+
         validLabelRegexp = gitConfig("git-p4.labelExportRegexp")
         if len(validLabelRegexp) == 0:
             validLabelRegexp = defaultLabelRegexp
@@ -2787,8 +2801,8 @@ def __init__(self):
         self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
         self.labels = {}
 
-    # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
+        """Force a checkpoint in fast-import and wait for it to finish."""
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
         self.gitStream.flush()
@@ -2934,10 +2948,12 @@ def encodeWithUTF8(self, path):
                 print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
         return path
 
-    # output one file from the P4 stream
-    # - helper for streamP4Files
-
     def streamOneP4File(self, file, contents):
+        """Output one file from the P4 stream.
+
+           This is a helper for streamP4Files().
+           """
+
         file_path = file['depotFile']
         relPath = self.stripRepoPath(decode_path(file_path), self.branchPrefixes)
 
@@ -3029,8 +3045,8 @@ def streamOneP4Deletion(self, file):
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
 
-    # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
+        """Handle another chunk of streaming data."""
 
         # catch p4 errors and complain
         err = None
@@ -3094,8 +3110,9 @@ def streamP4FilesCb(self, marshalled):
 
         self.stream_have_file_info = True
 
-    # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
+        """Stream directly from "p4 files" into "git fast-import."""
+
         filesForCommit = []
         filesToRead = []
         filesToDelete = []
@@ -3199,15 +3216,18 @@ def hasBranchPrefix(self, path):
         return hasPrefix
 
     def findShadowedFiles(self, files, change):
-        # Perforce allows you commit files and directories with the same name,
-        # so you could have files //depot/foo and //depot/foo/bar both checked
-        # in.  A p4 sync of a repository in this state fails.  Deleting one of
-        # the files recovers the repository.
-        #
-        # Git will not allow the broken state to exist and only the most recent
-        # of the conflicting names is left in the repository.  When one of the
-        # conflicting files is deleted we need to re-add the other one to make
-        # sure the git repository recovers in the same way as perforce.
+        """Perforce allows you commit files and directories with the same name,
+           so you could have files //depot/foo and //depot/foo/bar both checked
+           in.  A p4 sync of a repository in this state fails.  Deleting one of
+           the files recovers the repository.
+
+           Git will not allow the broken state to exist and only the most
+           recent of the conflicting names is left in the repository.  When one
+           of the conflicting files is deleted we need to re-add the other one
+           to make sure the git repository recovers in the same way as
+           perforce.
+           """
+
         deleted = [f for f in files if f['action'] in self.delete_actions]
         to_check = set()
         for f in deleted:
@@ -3324,8 +3344,11 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
                     print("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
-    # Build a dictionary of changelists and labels, for "detect-labels" option.
     def getLabels(self):
+        """Build a dictionary of changelists and labels, for "detect-labels"
+           option.
+           """
+
         self.labels = {}
 
         l = p4CmdList(["labels"] + ["%s..." % p for p in self.depotPaths])
@@ -3351,11 +3374,12 @@ def getLabels(self):
         if self.verbose:
             print("Label changes: %s" % self.labels.keys())
 
-    # Import p4 labels as git tags. A direct mapping does not
-    # exist, so assume that if all the files are at the same revision
-    # then we can use that, or it's something more complicated we should
-    # just ignore.
     def importP4Labels(self, stream, p4Labels):
+        """Import p4 labels as git tags. A direct mapping does not exist, so
+           assume that if all the files are at the same revision then we can
+           use that, or it's something more complicated we should just ignore.
+           """
+
         if verbose:
             print("import p4 labels: " + ' '.join(p4Labels))
 
-- 
2.35.GIT

