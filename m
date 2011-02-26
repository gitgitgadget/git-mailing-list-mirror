From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 2/3] git-p4: Allow filtering Perforce branches by user
Date: Sat, 26 Feb 2011 23:46:10 +0000
Message-ID: <1298763971-20556-3-git-send-email-vitor.hda@gmail.com>
References: <1298763971-20556-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 00:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtTqd-0000Rl-7z
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 00:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab1BZXqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 18:46:48 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab1BZXqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 18:46:46 -0500
Received: by mail-ww0-f44.google.com with SMTP id 22so1746968wwb.1
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=AFaexCdPaCXJW6QeUepC/NWDTmWnWCI9ICC7A5n+HgE=;
        b=X0aDBoxsUD2zTjEn5lD9RHZCfPaQ/JoBs58iL8QmsGrqU1qdrrTIQhmEX8TVQlg0Bs
         fLJ2QzBNV50JEgM6ZNe63ec6EthqQUutF6lruoaCZuhiBsXClsc3TC5oUlORf5YwOm/L
         sI71A9SJhqjkDOma9PDDzgmHQDPaYu3eex01o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FswsGhL3ev5hLG6yV7jZaR23groe4vQ7ohEBnJhjmwmgfBZHoqsaBHRfErGygksHdK
         4fcvorINYtPov0cZkxIZnPy8SCoYQbLQKsYAmxQkk49ZVTOdm2VHdzXLaQV/daI0CygC
         sjjkUo3bFscc52ekN1BA6OlnT6HjRy+mPSgMY=
Received: by 10.216.72.201 with SMTP id t51mr847414wed.6.1298764006294;
        Sat, 26 Feb 2011 15:46:46 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id n78sm1121697weq.27.2011.02.26.15.46.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 15:46:45 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298763971-20556-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168000>

All branches in the Perforce server are downloaded to allow branch detection. If
you have a centralized server on a remote location and there is a big number of
branches this operation can take some time.
This patch adds the configuration option git-p4.branchUser to allow filtering
the branch list by user. Although this limits the branch maintenance in Perforce
to be done by a single user, it might be an advantage when the number of
branches being used in a specific depot is very small when compared with the
branches available in the server.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4     |    8 +++++++-
 contrib/fast-import/git-p4.txt |    6 ++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index fad3371..646afc1 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1245,7 +1245,13 @@ class P4Sync(Command):
     def getBranchMapping(self):
         lostAndFoundBranches = set()
 
-        for info in p4CmdList("branches"):
+        user = gitConfig("git-p4.branchUser")
+        if len(user) > 0:
+            command = "branches -u %s" % user
+        else:
+            command = "branches"
+
+        for info in p4CmdList(command):
             details = p4Cmd("branch -o %s" % info["branch"])
             viewIdx = 0
             while details.has_key("View%s" % viewIdx):
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index e09da44..5b85081 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -196,6 +196,12 @@ able to find the relevant client.  This client spec will be used to
 both filter the files cloned by git and set the directory layout as
 specified in the client (this implies --keep-path style semantics).
 
+git-p4.branchUser
+
+Only use branch specifications defined by the selected username.
+
+  git config [--global] git-p4.branchUser username
+
 Implementation Details...
 =========================
 
-- 
1.7.4.1
