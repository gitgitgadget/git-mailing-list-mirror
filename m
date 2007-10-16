From: Chris Pettitt <cpettitt@gmail.com>
Subject: [PATCH] git-p4 support for perforce renames.
Date: Mon, 15 Oct 2007 22:15:06 -0700
Message-ID: <1192511706-21929-1-git-send-email-cpettitt@gmail.com>
References: <de47e4420710152214k1e74bf5eh5ecbf48d0507322@mail.gmail.com>
Cc: Chris Pettitt <cpettitt@gmail.com>
To: Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 07:15:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhemK-0002Su-SJ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 07:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779AbXJPFPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 01:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759970AbXJPFPX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 01:15:23 -0400
Received: from hu-out-0506.google.com ([72.14.214.228]:12678 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378AbXJPFPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 01:15:21 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1546128hue
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 22:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0h1TJqEboYkgjtPu6Y+BEllDrJjX8CE2DjqPSxKI1Ws=;
        b=ApSmMvRE40wG6nbT+BzxEt/ckps0fD3BJRFn+gefAuGVKR8xFuFHqlH6mS5MF2vk9FGwx1PngVRHE+SSlfHwCvLt719SdP2TyMpgU3PLg0r5zrVwsbXZ6xzqAZL9aRcdWwXOI2ykLBLLbs/Gd3psk8BNEC9bKaOU3FQYSXD77DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rU3KDlxs/C7JcHFLqSfxQR/zXwJlJPxaK2uHb7gz2YAK54q9kJmRkEm0mTum1I9/LWC7bqPXJDTqiU90XgKrsUDOvnVBJVQ/kXm/zjvLPuvvwUApl8aFNJwHE5GbzEEzmziwx6wYe//U0Lokbtc+UhJL9egLs4YF6LCRF+s4QRM=
Received: by 10.114.127.1 with SMTP id z1mr7965718wac.1192511718352;
        Mon, 15 Oct 2007 22:15:18 -0700 (PDT)
Received: from localhost ( [76.236.71.63])
        by mx.google.com with ESMTPS id k23sm9839801waf.2007.10.15.22.15.16
        (version=SSLv3 cipher=OTHER);
        Mon, 15 Oct 2007 22:15:17 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.206.g58ba4
In-Reply-To: <de47e4420710152214k1e74bf5eh5ecbf48d0507322@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61077>

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
index 557649a..90945b7 100755
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
+                os.unlink(dest)
+                editedFiles.add(dest)
+                filesToDelete.add(src)
             else:
                 die("unknown modifier %s for %s" % (modifier, path))
 
-- 
1.5.3.4.206.g58ba4
