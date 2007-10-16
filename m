From: Chris Pettitt <cpettitt@gmail.com>
Subject: [PATCH] git-p4 support for perforce renames.
Date: Mon, 15 Oct 2007 21:37:03 -0700
Message-ID: <1192509423-21368-1-git-send-email-cpettitt@gmail.com>
Cc: Chris Pettitt <cpettitt@gmail.com>
To: Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 06:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IheBT-0005ky-HG
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 06:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbXJPEhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 00:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbXJPEhZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 00:37:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:38291 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbXJPEhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 00:37:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2239770wah
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 21:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=cuJp6ECkFsgdB+7tLQprJlBWaFUEzj2TO6ELDDb2ifw=;
        b=YyYLseVIe8109XrxTQ099iVooYMpYai+b/xeoGdaA+/rST8nHJZJiFeZ92/OrWlQZsSjzzsoPV7KwlAQk2RU8KVZqLw7ntprhqp3IBmR/3CusD8ZS2KiiCKsk/UN/4KPLoxgDJhlgOU/8XRsWgMjRAl3SJ9bJeEOzGUn9mghU2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=ZR3tmT8LQiAzAValNXqFtlFvUIiwgjyh1JRYlhSrk0ScXIS410s7/CLXaDWWNpzONOsPWsVUB6SszZniYgVqEp47ggSJLzg4hdWIc6uIlT7lr4YiMHUO4KOcQpBk7SlEslgXVa3DgqElXttgOea/aqz/Y0pi/Scj03PMoq7T53Y=
Received: by 10.115.90.1 with SMTP id s1mr7919709wal.1192509443548;
        Mon, 15 Oct 2007 21:37:23 -0700 (PDT)
Received: from localhost ( [76.236.71.63])
        by mx.google.com with ESMTPS id z20sm6402885pod.2007.10.15.21.37.19
        (version=SSLv3 cipher=OTHER);
        Mon, 15 Oct 2007 21:37:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.206.g58ba4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61075>

The current git-p4 implementation does support file renames. However, because
it does not use the "p4 integrate" command, the history for the renamed file is
not linked to the new file.

This changeset adds support for perforce renames with the integrate command.
Currently this feature is only enabled when calling git-p4 submit with the -M
option. This is intended to look and behave similar to the "detect renames"
feature of other git commands.

The following sequence is used for renamed files:

    p4 integrate -Dt x x'
    p4 edit x'
    rm x'
    git apply
    p4 delete x

By default, perforce will not allow an integration with a target file that has
been deleted. That is, if x' in the example above is the name of a previously
deleted file then perforce will fail the integrate. The -Dt option tells
perforce to allow the target of integrate to be a previously deleted file.

Signed-off-by: Chris Pettitt <cpettitt@gmail.com>
---
 contrib/fast-import/git-p4 |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 557649a..f9a8871 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -399,6 +399,7 @@ class P4Submit(Command):
                 optparse.make_option("--dry-run", action="store_true"),
                 optparse.make_option("--direct", dest="directSubmit", action="store_true"),
                 optparse.make_option("--trust-me-like-a-fool", dest="trustMeLikeAFool", action="store_true"),
+                optparse.make_option("-M", dest="detectRename", action="store_true"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -411,6 +412,7 @@ class P4Submit(Command):
         self.origin = ""
         self.directSubmit = False
         self.trustMeLikeAFool = False
+        self.detectRename = False
         self.verbose = False
         self.isWindows = (platform.system() == "Windows")
 
@@ -491,7 +493,8 @@ class P4Submit(Command):
             diff = self.diffStatus
         else:
             print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
-            diff = read_pipe_lines("git diff-tree -r --name-status \"%s^\" \"%s\"" % (id, id))
+            diffOpts = ("", "-M")[self.detectRename]
+            diff = read_pipe_lines("git diff-tree -r --name-status %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
         editedFiles = set()
@@ -509,6 +512,13 @@ class P4Submit(Command):
                 filesToDelete.add(path)
                 if path in filesToAdd:
                     filesToAdd.remove(path)
+            elif modifier == "R":
+                src, dest = line.strip().split("\t")[1:3]
+                system("p4 integrate -Dt \"%s\" \"%s\"" % (src, dest))
+                system("p4 edit \"%s\"" % (dest))
+                system("rm \"%s\"" % dest)
+                editedFiles.add(dest)
+                filesToDelete.add(src)
             else:
                 die("unknown modifier %s for %s" % (modifier, path))
 
-- 
1.5.3.4.206.g58ba4
