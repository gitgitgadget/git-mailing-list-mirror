From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/8] remote-bzr: simplify get_remote_branch()
Date: Thu, 16 May 2013 03:36:42 -0500
Message-ID: <1368693407-21267-4-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucti8-0000W1-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787Ab3EPIij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:39 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:36240 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab3EPIig (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:36 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so3433529oag.31
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hQQyrUKlv/Np8aadio2lRXR3K6+AYawGCTgpUDBSBS4=;
        b=C863ADpMvTo8MaS4HuKTEKkBrOM4ZyCkmKAME+6iuMP4rdyazC32a2946cHoOub1j4
         loBFbHC4icl5jY+C8oL/wuf16nn8MUuxdT0gNskJH3QEa8EP0abcwhRXb7CfARAC2JqM
         yn/5nQ9yByb5g8de3GNeYfIt8uAoyK3GuHvrOMG/FPirp+4W14Gm7HigvxXy8bC/q678
         YHMmVHqWQFggU0Z+/18+6rdj9WEkmzM+JxZwScJb3Q4paC7E6fszR3CgM03sveNVJHGF
         K143OwBuHlWZGciz9Lah8HnNDhN+s8ae8YWsRTy58FYhRhOLQUsRDyusrxnLZbl2PrGm
         DMhg==
X-Received: by 10.60.121.106 with SMTP id lj10mr19265366oeb.128.1368693514543;
        Thu, 16 May 2013 01:38:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm7113093oes.6.2013.05.16.01.38.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224507>

No need for 'origin', it's only needed for the bzrdir 'sprout' method,
which can be greatly simplified.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index b849336..b7656df 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -764,25 +764,26 @@ def do_list(parser):
     print "@refs/heads/%s HEAD" % master_branch
     print
 
-def get_remote_branch(origin, remote_branch, name):
+def clone(path, remote_branch):
+    bdir = bzrlib.bzrdir.BzrDir.create(path)
+    repo = bdir.find_repository()
+    repo.fetch(remote_branch.repository)
+    return remote_branch.sprout(bdir, repository=repo)
+
+def get_remote_branch(remote_branch, name):
     global dirname, peers
 
     branch_path = os.path.join(dirname, 'clone', name)
 
     try:
-        d = bzrlib.bzrdir.BzrDir.open(branch_path)
-        branch = d.open_branch()
+        branch = bzrlib.branch.Branch.open(branch_path)
     except bzrlib.errors.NotBranchError:
         # clone
-        d = origin.sprout(branch_path, None,
-                hardlink=True, create_tree_if_local=False,
-                force_new_repo=False,
-                source_branch=remote_branch)
-        branch = d.open_branch()
+        branch = clone(branch_path, remote_branch)
     else:
         # pull
         try:
-            branch.pull(remote_branch, [], None, False)
+            branch.pull(remote_branch, overwrite=True)
         except bzrlib.errors.DivergedBranches:
             # use remote branch for now
             return remote_branch
@@ -850,7 +851,7 @@ def get_repo(url, alias):
 
         if not is_local:
             peers[name] = remote_branch.base
-            branch = get_remote_branch(origin, remote_branch, name)
+            branch = get_remote_branch(remote_branch, name)
         else:
             branch = remote_branch
 
@@ -868,7 +869,7 @@ def get_repo(url, alias):
 
             if not is_local:
                 peers[name] = remote_branch.base
-                branch = get_remote_branch(origin, remote_branch, name)
+                branch = get_remote_branch(remote_branch, name)
             else:
                 branch = remote_branch
 
-- 
1.8.3.rc2.542.g24820ba
