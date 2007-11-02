From: Chris Pettitt <cpettitt@gmail.com>
Subject: [PATCH] git-p4: Detect changes to executable bit and include them in p4 submit.
Date: Thu,  1 Nov 2007 20:43:14 -0700
Message-ID: <1193974994-19211-2-git-send-email-cpettitt@gmail.com>
References: <1193974994-19211-1-git-send-email-cpettitt@gmail.com>
Cc: Chris Pettitt <cpettitt@gmail.com>
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 04:43:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnRr-0000Ey-R2
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXKBDnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXKBDnY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:43:24 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:60425 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbXKBDnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:43:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so805091wah
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 20:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4FbKkfiMnYGIlWMDNudpF07MmVSr9l9soIs5zpKZWYk=;
        b=tUT9VB5zTLAGYFF9qE2cavMgEXhbSDM9SfhKG/JwtgeHPcZhUEDtCCPPCItrXoh7oS7c7Gcfmgb3Mn0Q/UFeY/So7er7goYsKV8Pu65XuulWFi7vATt5d8QtHPJp7Hwige7WtlGzmwixeOE91sedenTz2eyB6Fnqvq9BKNuEp2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P7o5n8ZZ0FOKfJIlI8zH+i3+Feby2i85rK5WXlUTqOg/ut41pXAA6OBN3ddMN7KYpEr/Uz7YbiVOAyjqkJrR156f+25wAtCYKRnS7yARqipIE1vwtMv18R/qWI3es+RdnB/3qj3V+ZNxRQr7My0X/Yn9Ah2gCclUf/jkv2kff3A=
Received: by 10.115.58.1 with SMTP id l1mr1376481wak.1193975003446;
        Thu, 01 Nov 2007 20:43:23 -0700 (PDT)
Received: from localhost ( [76.236.71.63])
        by mx.google.com with ESMTPS id n30sm3416476wag.2007.11.01.20.43.20
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 20:43:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.498.g9c514
In-Reply-To: <1193974994-19211-1-git-send-email-cpettitt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63056>

This changeset takes advantage of the new parseDiffTreeEntry(...) function to
detect changes to the execute bit in the git repository.  During submit, git-p4
now looks for changes to the executable bit and if it finds them it "reopens"
the file in perforce, which allows it to change the file type.

The logic for adding the executable bit in perforce is straightforward: the +x
modifier can be used. Removing the executable bit in perforce requires that the
entire filetype be redefined (there is no way to join remove the bit with a -x
modifier, for example). This changeset includes logic to remove the executable
bit from the full file type while preserving the base file type and other
modifiers.

Signed-off-by: Chris Pettitt <cpettitt@gmail.com>
---
 contrib/fast-import/git-p4 |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c7fc564..c148b5a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -71,6 +71,31 @@ def isP4Exec(kind):
     a plus sign, it is also executable"""
     return (re.search(r"(^[cku]?x)|\+.*x", kind) != None)
 
+def setP4ExecBit(file, mode):
+    # Reopens an already open file and changes the execute bit to match
+    # the execute bit setting in the passed in mode.
+
+    p4Type = "+x"
+
+    if not isModeExec(mode):
+        p4Type = getP4OpenedType(file)
+        p4Type = re.sub('^([cku]?)x(.*)', '\\1\\2', p4Type)
+        p4Type = re.sub('(.*?\+.*?)x(.*?)', '\\1\\2', p4Type)
+        if p4Type[-1] == "+":
+            p4Type = p4Type[0:-1]
+
+    system("p4 reopen -t %s %s" % (p4Type, file))
+
+def getP4OpenedType(file):
+    # Returns the perforce file type for the given file.
+
+    result = read_pipe("p4 opened %s" % file)
+    match = re.match(".*\((.+)\)$", result)
+    if match:
+        return match.group(1)
+    else:
+        die("Could not determine file type for %s" % file)
+
 def diffTreePattern():
     # This is a simple generator for the diff tree regex pattern. This could be
     # a class variable if this and parseDiffTreeEntry were a part of a class.
@@ -111,6 +136,14 @@ def parseDiffTreeEntry(entry):
         }
     return None
 
+def isModeExec(mode):
+    # Returns True if the given git mode represents an executable file,
+    # otherwise False.
+    return mode[-3:] == "755"
+
+def isModeExecChanged(src_mode, dst_mode):
+    return isModeExec(src_mode) != isModeExec(dst_mode)
+
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
     cmd = "p4 -G %s" % cmd
     if verbose:
@@ -538,15 +571,19 @@ class P4Submit(Command):
         filesToAdd = set()
         filesToDelete = set()
         editedFiles = set()
+        filesToChangeExecBit = {}
         for line in diff:
             diff = parseDiffTreeEntry(line)
             modifier = diff['status']
             path = diff['src']
             if modifier == "M":
                 system("p4 edit \"%s\"" % path)
+                if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
+                    filesToChangeExecBit[path] = diff['dst_mode']
                 editedFiles.add(path)
             elif modifier == "A":
                 filesToAdd.add(path)
+                filesToChangeExecBit[path] = diff['dst_mode']
                 if path in filesToDelete:
                     filesToDelete.remove(path)
             elif modifier == "D":
@@ -557,6 +594,8 @@ class P4Submit(Command):
                 src, dest = diff['src'], diff['dst']
                 system("p4 integrate -Dt \"%s\" \"%s\"" % (src, dest))
                 system("p4 edit \"%s\"" % (dest))
+                if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
+                    filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
                 editedFiles.add(dest)
                 filesToDelete.add(src)
@@ -609,6 +648,11 @@ class P4Submit(Command):
             system("p4 revert \"%s\"" % f)
             system("p4 delete \"%s\"" % f)
 
+        # Set/clear executable bits
+        for f in filesToChangeExecBit.keys():
+            mode = filesToChangeExecBit[f]
+            setP4ExecBit(f, mode)
+
         logMessage = ""
         if not self.directSubmit:
             logMessage = extractLogMessageFromGitCommit(id)
-- 
1.5.3.4.498.g9c514
