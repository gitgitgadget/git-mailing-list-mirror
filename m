From: Roy Liu <carsomyr@gmail.com>
Subject: [PATCH] Added the "contrib/hooks/repo_umask.py" script.
Date: Wed,  1 Dec 2010 17:06:19 -0500
Message-ID: <1291241179-10342-1-git-send-email-carsomyr@gmail.com>
Cc: Roy Liu <carsomyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 23:06:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNuoT-000508-UB
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625Ab0LAWGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:06:04 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:49912 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab0LAWGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 17:06:03 -0500
Received: by pxi15 with SMTP id 15so1155617pxi.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AlFtGBe4OO0vZ1WEicy6DgjwJvHgr+iV1k9jEtsLfbM=;
        b=uYEMyrJL4m1KSfpuHALlL6KwB757YPnacayHVvrr3+8hAViOoehRLPd5an+vDZIjmE
         byda/NMrX+yMgiItheXQZcJxieTd2cu9ZeW2Fg0DAkYi01jRWyikS1UGJQQG4vo2T2Ox
         wPdGQfIiz43xnCnLfIMRROPsehBNks+/IIaHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Q/6KZQ7vEOgjxfIkTsyBa257UrlCsjObqsL0usAT3Eu9D1s/o7WIn9xeLbWNCCptbB
         tw/GawlDNCP7S3M9ImKProDinAnRNp7IbJ7LFU4at7eaFmh6hPYG+xMeXvny2rkvToE+
         axELo3cuB3dgWcEgiZdq06Up4q4AyWScbrFRk=
Received: by 10.143.162.20 with SMTP id p20mr4637622wfo.179.1291241162052;
        Wed, 01 Dec 2010 14:06:02 -0800 (PST)
Received: from localhost.localdomain (hubris.ucsd.edu [137.110.161.58])
        by mx.google.com with ESMTPS id e14sm534110wfg.8.2010.12.01.14.06.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 14:06:00 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162621>

This patch adds a Git hook for versioning file permissions through the
gitattributes system. The hook works in a way similar to its predecessor
contrib/hooks/setgitperms.perl, with the notable difference being that
permissions are subtractively applied instead of tracked by a special metadata
file.

To restrict the permissions on certain paths, the user declares "umask"
attributes on said pathnames with values of the form [0-7][0-7][0-7], which
zero out undesirable group- and world- readable/writable/executable permission
bits. Thus, the net effect of applying the hook post-checkout and post-update
would be equivalent (on Unix systems) to applying a custom umask on top of the
user's umask to pathnames matched in .gitattributes files.

Detailed instructions for installing the hook script can be found in the Python
docstring below. Existing users of .gitignore, .gitconfig, and .gitattributes
files should find the permissions versioning system particularly easy to use.

Signed-off-by: Roy Liu <carsomyr@gmail.com>
---
 contrib/hooks/repo_umask.py |  173 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 173 insertions(+), 0 deletions(-)
 create mode 100755 contrib/hooks/repo_umask.py

diff --git a/contrib/hooks/repo_umask.py b/contrib/hooks/repo_umask.py
new file mode 100755
index 0000000..1507b57
--- /dev/null
+++ b/contrib/hooks/repo_umask.py
@@ -0,0 +1,173 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+# 
+# Copyright (C) 2010 Roy Liu
+# All rights reserved.
+# 
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions are met:
+# 
+#   * Redistributions of source code must retain the above copyright notice,
+#     this list of conditions and the following disclaimer.
+#   * Redistributions in binary form must reproduce the above copyright notice,
+#     this list of conditions and the following disclaimer in the documentation
+#     and/or other materials provided with the distribution.
+#   * Neither the name of the author nor the names of any contributors may be
+#     used to endorse or promote products derived from this software without
+#     specific prior written permission.
+# 
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+# POSSIBILITY OF SUCH DAMAGE.
+
+"""A script for applying "umask" attribute values to designated pathnames in a Git repository, effectively restricting
+access permissions on them. It is similar in flavor to the contrib/hooks/setgitperms.perl script, with the notable
+difference being that permissions are overwritten (if incorrect) instead of tracked. To use:
+
+  - Create ".gitattributes" files with the "umask" attribute set on some pathnames like so:
+
+        $GIT_WORK_TREE/a/b/.gitattributes
+            /some_file  umask=077 some_other_attribute=some_value
+            /some_dir/  umask=022
+            *.txt       umask=026
+
+    The above settings have the following effects:
+
+      - $GIT_WORK_TREE/a/b/some_file will only be accessible by the owner, and the preceding slash removes the
+        possibility of matching files like $GIT_WORK_TREE/a/b/c/some_file.
+      - $GIT_WORK_TREE/a/b/some_dir is group- and world- readable. Note that directories are specified with a trailing
+        slash.
+      - All files with the ".txt" extension in any subdirectory of $GIT_WORK_TREE/a/b are group-, but not world-,
+        readable.
+
+  - The hooks $GIT_DIR/hooks/{post-checkout, post-merge, pre-commit} should all read:
+
+        #!/bin/sh
+        "$GIT_DIR"/hooks/repo_umask.py -v
+
+    Don't forget to turn on their execute bits.
+
+  - Any kind of checkout or commit will now cause "umask" attribute values to be applied throughout your working tree.
+
+Chances are that you also wish to lock down permissions on $GIT_DIR and all objects/packs created thereafter:
+
+    git config --replace-all core.sharedrepository 0xxx
+"""
+
+from optparse import OptionParser
+from subprocess import Popen
+import os
+import re
+import stat
+import subprocess
+import sys
+import threading
+
+lsfilespattern = re.compile("^(?P<permissions>[0-9]{6}) [0-9a-f]{40} [0-3]\t(?P<filename>.*)$")
+umaskattributepattern = re.compile("^.*: umask: (?P<umask>[0-7]{3})$")
+
+def main():
+    """The main method body.
+    """
+
+    parser = OptionParser()
+    parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=None,
+                      help="be verbose")
+
+    options, _ = parser.parse_args()
+
+    # Change to the Git working tree root.
+    cdup = Popen(["git", "rev-parse", "--show-cdup"], stdout=subprocess.PIPE).stdout.read().decode().rstrip()
+    os.chdir("./%s" % cdup)
+
+    if options.verbose and cdup != "":
+        print("Changing to the Git working tree root at '%s' to perform changes." % os.getcwd())
+
+    # List tracked files.
+    p = Popen(["git", "ls-files", "-sz"], stdout=subprocess.PIPE)
+
+    lines = p.stdout.read().decode().split("\0")
+
+    if len(lines) > 0:
+        lines.pop()
+
+    filetuples = [(filename, permissions) for filename, permissions
+                  in [(m.group("filename"), int(m.group("permissions"), 8) & 0x1FF) for m
+                      in [lsfilespattern.search(line) for line in lines]]
+                  if permissions != 0]
+
+    # Determine the file creation umask.
+    umask = os.umask(0)
+    os.umask(umask)
+
+    dirpermissions = ~umask & 0x1FF
+
+    pathtuples = set()
+
+    # We can infer paths from files tracked by Git.
+    for filename, _ in filetuples:
+
+        headpathname = filename
+
+        while True:
+
+            headpathname, _ = os.path.split(headpathname)
+            pathtuple = ("%s/" % headpathname, dirpermissions)
+
+            if headpathname == "" or pathtuple in pathtuples:
+                break
+
+            pathtuples.add(pathtuple)
+
+    # Aggregate all pathnames for files and directories.
+    pathtuples = list(sorted(pathtuples.union(filetuples), key=lambda x: x[0]))
+
+    # Determine which pathnames have the "umask" attribute set.
+    p = Popen(["git", "check-attr", "--stdin", "-z", "umask"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
+
+    def run():
+        for pathname, _ in pathtuples:
+            p.stdin.write(("%s\0" % pathname).encode())
+        p.stdin.close()
+
+    # Remember to spawn a thread to avoid deadlock.
+    t = threading.Thread(target=run)
+    t.start()
+
+    lines = [line.decode().rstrip() for line in p.stdout.readlines()]
+
+    t.join()
+
+    for i in range(len(lines)):
+
+        m = umaskattributepattern.search(lines[i])
+        pathname, permissions = pathtuples[i]
+
+        # Calculate restricted permissions if the "umask" attribute is present and well-formed.
+        if m:
+            newpermissions = permissions & (~int(m.group("umask"), 8) & 0x1FF)
+        else:
+            newpermissions = permissions
+
+        oldpermissions = stat.S_IMODE(os.stat(pathname).st_mode)
+
+        if oldpermissions != newpermissions:
+
+            os.chmod(pathname, newpermissions)
+
+            if options.verbose:
+                print("Changed permissions on '%s' from %s to %s."
+                      % (pathname, oct(oldpermissions), oct(newpermissions)))
+
+#
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
1.7.3.2
