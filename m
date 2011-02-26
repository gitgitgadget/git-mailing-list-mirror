From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 3/3] git-p4: Allow branch definition with git config
Date: Sat, 26 Feb 2011 23:46:11 +0000
Message-ID: <1298763971-20556-4-git-send-email-vitor.hda@gmail.com>
References: <1298763971-20556-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 00:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtTqm-0000Vi-G7
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 00:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab1BZXqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 18:46:50 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1BZXqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 18:46:48 -0500
Received: by mail-ww0-f44.google.com with SMTP id 22so1746968wwb.1
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 15:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=LR89KnqZFYVXLz6lyN8nNywWcquhy3YgarsAAaLzFjs=;
        b=SGAdGVdmDJfOF1+Ab1vXWbnLqIfWtlQNiqkTDiD+xuH5RjlBwhXYJSFUahXmVaSAlu
         WSFX4UrCBclV1/QIYMPgktiugG8lV3jzSG6TH8et/e6Kvq/Q7U8NRjrPO9UoA9TzwlXy
         7l+XPMh3PvvH4Gg7+BXacmfJe+9oBDOZmcivI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lVNn5yc20dZXuVomEzEcvTxRmi95mY5IF64fpvRZ7IqO+nJ/bAXQ4nJ4vPn5CLQW8v
         +oIx0gh9xRRFlKsbiSNyWF8YvqdedyAshjm+NBrjtEKbXbPeLS24WWFGUfon5BPAoySI
         Rnv1BlDXp0kaF8T5Dx7DmIqqNLhKQ9cmXzhQI=
Received: by 10.216.254.89 with SMTP id g67mr845689wes.7.1298764007850;
        Sat, 26 Feb 2011 15:46:47 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id n78sm1121697weq.27.2011.02.26.15.46.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 15:46:47 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298763971-20556-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168001>

Perforce does not strictly require the usage of branch specifications to create
branches. In these cases the branch detection code of git-p4 will not be able to
import them.
This patch adds support for git-p4.branchList configuration option, allowing
branches to be defined in git config.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4     |   24 ++++++++++++++++++++++++
 contrib/fast-import/git-p4.txt |    7 +++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 646afc1..3ad9600 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -338,6 +338,11 @@ def gitConfig(key):
         _gitConfig[key] = read_pipe("git config %s" % key, ignore_error=True).strip()
     return _gitConfig[key]
 
+def gitConfigList(key):
+    if not _gitConfig.has_key(key):
+        _gitConfig[key] = read_pipe("git config --get-all %s" % key, ignore_error=True).strip().split(os.linesep)
+    return _gitConfig[key]
+
 def p4BranchesInGit(branchesAreInRemotes = True):
     branches = {}
 
@@ -1280,6 +1285,25 @@ class P4Sync(Command):
                     if source not in self.knownBranches:
                         lostAndFoundBranches.add(source)
 
+        # Perforce does not strictly require branches to be defined, so we also
+        # check git config for a branch list.
+        #
+        # Example of branch definition in git config file:
+        # [git-p4]
+        #   branchList=main:branchA
+        #   branchList=main:branchB
+        #   branchList=branchA:branchC
+        configBranches = gitConfigList("git-p4.branchList")
+        for branch in configBranches:
+            if branch:
+                (source, destination) = branch.split(":")
+                self.knownBranches[destination] = source
+
+                lostAndFoundBranches.discard(destination)
+
+                if source not in self.knownBranches:
+                    lostAndFoundBranches.add(source)
+
 
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 5b85081..3cc2309 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -202,6 +202,13 @@ Only use branch specifications defined by the selected username.
 
   git config [--global] git-p4.branchUser username
 
+git-p4.branchList
+
+List of branches to be imported when branch detection is enabled.
+
+  git config [--global] git-p4.branchList main:branchA
+  git config [--global] --add git-p4.branchList main:branchB
+
 Implementation Details...
 =========================
 
-- 
1.7.4.1
