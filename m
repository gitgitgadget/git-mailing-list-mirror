From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 2/2] git-p4: initial demonstration of possible RCS keyword fixup
Date: Thu,  9 Feb 2012 11:03:29 +0000
Message-ID: <1328785409-30936-3-git-send-email-luke@diamand.org>
References: <1328785409-30936-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 12:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvRmz-0004xN-O5
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 12:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab2BILDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 06:03:36 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:52971 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab2BILDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 06:03:34 -0500
Received: by werb13 with SMTP id b13so1115565wer.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 03:03:33 -0800 (PST)
Received: by 10.180.90.212 with SMTP id by20mr2030262wib.12.1328785413113;
        Thu, 09 Feb 2012 03:03:33 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id er8sm4432794wib.9.2012.02.09.03.03.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 03:03:32 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.128.gfce41.dirty
In-Reply-To: <1328785409-30936-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQkCrNViJjXi99VKe00fsI0kdfKl4qtGb3x0ZErilkKr6wZdrP6+8vETzASm9kyFw+FU3SLc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190287>

This change has a go at showing a possible way to fixup RCS
keyword handling in git-p4.

It does not cope with deleted files.
It does not have good test coverage.
It does not solve the problem of the incorrect error messages.
But it does at least work after a fashion, and could provide
a starting point.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |   43 +++++++++++++++++++++++++++++++++++++++++--
 t/t9810-git-p4-rcs.sh      |    1 +
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a78d9c5..205fefd 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -753,6 +753,23 @@ class P4Submit(Command, P4UserMap):
 
         return result
 
+    def patchRCSKeywords(self, file):
+        # Attempt to zap the RCS keywords in a p4 controlled file
+        p4_edit(file)
+        (handle, outFileName) = tempfile.mkstemp()
+        outFile = os.fdopen(handle, "w+")
+        inFile = open(file, "r")
+        for line in inFile.readlines():
+            line = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$',
+                   r'$\1$', line)
+            outFile.write(line)
+        inFile.close()
+        outFile.close()
+        # Forcibly overwrite the original file
+        system("cat %s" % outFileName)
+        system(["mv", "-f", outFileName, file])
+        print "Patched up RCS keywords in %s" % file
+
     def p4UserForCommit(self,id):
         # Return the tuple (perforce user,git email) for a given git commit id
         self.getUserMapFromPerforceServer()
@@ -918,6 +935,7 @@ class P4Submit(Command, P4UserMap):
         filesToDelete = set()
         editedFiles = set()
         filesToChangeExecBit = {}
+
         for line in diff:
             diff = parseDiffTreeEntry(line)
             modifier = diff['status']
@@ -964,9 +982,30 @@ class P4Submit(Command, P4UserMap):
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
+                for line in read_pipe_lines(diffcmd):
+                    m = re.match(r'^diff --git a/(.*)\s+b/(.*)', line)
+                    if m:
+                        file = m.group(1)
+                    if re.match(r'.*\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$', line):
+                        self.patchRCSKeywords(file)
+                        fixed_rcs_keywords = True
+            if fixed_rcs_keywords:
+                print "Retrying the patch with RCS keywords cleaned up"
+                if os.system(tryPatchCmd) == 0:
+                    patch_succeeded = True
+
+        if not patch_succeeded:
             print "What do you want to do?"
             response = "x"
             while response != "s" and response != "a" and response != "w":
@@ -1588,11 +1627,11 @@ class P4Sync(Command, P4UserMap):
         if type_base in ("text", "unicode", "binary"):
             if "ko" in type_mods:
                 text = ''.join(contents)
-                text = re.sub(r'\$(Id|Header):[^$]*\$', r'$\1$', text)
+                text = re.sub(r'\$(Id|Header)[^$]*\$', r'$\1$', text)
                 contents = [ text ]
             elif "k" in type_mods:
                 text = ''.join(contents)
-                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', text)
+                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$', r'$\1$', text)
                 contents = [ text ]
 
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index bad6272..dc38dcc 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -49,6 +49,7 @@ test_expect_failure 'cope with rcs keyword expansion damage' '
  "$GITP4" clone --dest="$git" //depot &&
  cd "$git" &&
  git config git-p4.skipSubmitEdit true &&
+ git config git-p4.attemptRCSCleanup true &&
  (cd ../cli && p4_append_to_file kwfile1.c) &&
  perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
  git add kwfile1.c &&
-- 
1.7.9.rc2.128.gfce41.dirty
