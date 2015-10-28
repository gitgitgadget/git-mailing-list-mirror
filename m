From: Etienne Girard <etienne.g.girard@gmail.com>
Subject: [PATCH] git-p4: Handle p4 submit failure
Date: Wed, 28 Oct 2015 14:12:21 +0100
Message-ID: <CAJA=mv4Tr_DoBMwR8hK_fEJ1PFCYTu17HHvEnFWMANGFcf0Wpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 14:12:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrQX2-0006gf-ML
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 14:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965455AbbJ1NMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 09:12:44 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33380 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965526AbbJ1NMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 09:12:21 -0400
Received: by igvi2 with SMTP id i2so2432107igv.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=B5BLRrG3s/1N4kf3HNdjGqt/DRwIaxeeB7u36BsrAjo=;
        b=FPXRjhGJM2nLL8O0z0b38YX64e1bZdM0a9ELgWkqk0oZj4H7FIbkK6hLYyixNju2EJ
         P3Bm9tkyb121HDH16nJxlnp7Kem6/fP+8yXwnB9EY+8v5WbnXBOOkLieHDJ0vYnd/V83
         rGZG82jHxrDJAmyKPJMVFjMDUbMabg0KG/Pykn46VI4911elShk03vtgF9NRbfv3Nprn
         pJLLixEI/Sd48oLgLL3vQOjxHdiJmTBiOiuXRe5xGmxoABy5oCuUc6RGt+AphGqoZ9ht
         MqL6B4Pt4BOQBUYTm5WL1bpx29u+9KnIy/Gy6brsoEOSMuwZmebZ5NU5gYAOllvUCbQO
         Cv0A==
X-Received: by 10.50.122.106 with SMTP id lr10mr2695898igb.86.1446037941384;
 Wed, 28 Oct 2015 06:12:21 -0700 (PDT)
Received: by 10.64.87.170 with HTTP; Wed, 28 Oct 2015 06:12:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280362>

Clean the workspace if p4_write_pipe raised SystemExit,
so that the user don't have to do it themselves.

Signed-off-by: GIRARD Etienne <egirard@murex.com>
---
 git-p4.py | 71 +++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

The p4 submit command may fail, for example if the changelist contains
a job that does not exist in the Jobs section. If this is the case,
p4_write_pipe will exit the script. This change makes it so that the
workspace is reverted before letting the script die.

diff --git a/git-p4.py b/git-p4.py
index 0093fa3..d535904 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1538,44 +1538,47 @@ class P4Submit(Command, P4UserMap):
         #
         # Let the user edit the change description, then submit it.
         #
-        if self.edit_template(fileName):
-            # read the edited message and submit
-            ret = True
-            tmpFile = open(fileName, "rb")
-            message = tmpFile.read()
-            tmpFile.close()
-            if self.isWindows:
-                message = message.replace("\r\n", "\n")
-            submitTemplate = message[:message.index(separatorLine)]
-            p4_write_pipe(['submit', '-i'], submitTemplate)
-
-            if self.preserveUser:
-                if p4User:
-                    # Get last changelist number. Cannot easily get it from
-                    # the submit command output as the output is
-                    # unmarshalled.
-                    changelist = self.lastP4Changelist()
-                    self.modifyChangelistUser(changelist, p4User)
-
-            # The rename/copy happened by applying a patch that created a
-            # new file.  This leaves it writable, which confuses p4.
-            for f in pureRenameCopy:
-                p4_sync(f, "-f")
+        submitted = False

-        else:
+        try:
+            if self.edit_template(fileName):
+                # read the edited message and submit
+                tmpFile = open(fileName, "rb")
+                message = tmpFile.read()
+                tmpFile.close()
+                if self.isWindows:
+                    message = message.replace("\r\n", "\n")
+                submitTemplate = message[:message.index(separatorLine)]
+                p4_write_pipe(['submit', '-i'], submitTemplate)
+
+                if self.preserveUser:
+                    if p4User:
+                        # Get last changelist number. Cannot easily get it from
+                        # the submit command output as the output is
+                        # unmarshalled.
+                        changelist = self.lastP4Changelist()
+                        self.modifyChangelistUser(changelist, p4User)
+
+                # The rename/copy happened by applying a patch that created a
+                # new file.  This leaves it writable, which confuses p4.
+                for f in pureRenameCopy:
+                    p4_sync(f, "-f")
+                submitted = True
+
+        finally:
             # skip this patch
-            ret = False
-            print "Submission cancelled, undoing p4 changes."
-            for f in editedFiles:
-                p4_revert(f)
-            for f in filesToAdd:
-                p4_revert(f)
-                os.remove(f)
-            for f in filesToDelete:
-                p4_revert(f)
+            if not submitted:
+                print "Submission cancelled, undoing p4 changes."
+                for f in editedFiles:
+                    p4_revert(f)
+                for f in filesToAdd:
+                    p4_revert(f)
+                    os.remove(f)
+                for f in filesToDelete:
+                    p4_revert(f)

         os.remove(fileName)
-        return ret
+        return submitted

     # Export git tags as p4 labels. Create a p4 label and then tag
     # with that.
-- 
1.9.1
