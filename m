From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Fri, 24 May 2013 21:24:25 -0500
Message-ID: <1369448666-17515-8-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Bk-0006XS-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab3EYC01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:27 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34812 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3EYC00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:26 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so6961467oag.37
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mRMTH1ghW6D7WA/HstIL2R/lMzLqOSq0VAnlxAMvuLI=;
        b=Em+yyUedMMoQzvBLuuTCVmUyKbaSPOIBcmBm5n2DKfzy2CMjRQ0wRZAxXqyGlaNvrE
         4Xxe4ueMqybQn/xhvt+dItj1/0eQQCLDvgjt9pj3NL7xIEaOFaPDXuqbIsBNxhYPFHuh
         qaQ65tgVj8Pp4Gv9bZZfu/tlX+0eOIfLzyRVxSylLQDjvQk0Totp/poBFXZjKXyzKU30
         DfNrpUANfAkGPGRL4jqkmjyvkPNUnUCW3MA4wxv/qh+bOchbq3zBGtmZhfBKE7/jl+Et
         R1rE7j1O8b0qS+mh8asStBSi0qgdkhw9AMP3lghG9jyap9UH1Xahsv2Zrg39UcjB5Zj0
         7plg==
X-Received: by 10.60.46.70 with SMTP id t6mr13661219oem.121.1369448785508;
        Fri, 24 May 2013 19:26:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm20011523obb.11.2013.05.24.19.26.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225411>

If the user specified a list of branches, we ignore what the remote
repository lists, and simply use the branches directly. Since some
remotes don't report the branches correctly, this is useful.

Otherwise either fetch the repo, or the branch.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 58 ++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 34025c3..3248586 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -795,7 +795,7 @@ def get_remote_branch(name):
 
     return branch
 
-def find_branches(repo, wanted):
+def find_branches(repo):
     transport = repo.bzrdir.root_transport
 
     for fn in transport.iter_files_recursive():
@@ -806,9 +806,6 @@ def find_branches(repo, wanted):
         name = name if name != '' else 'master'
         name = name.replace('/', '+')
 
-        if wanted and not name in wanted:
-            continue
-
         try:
             cur = transport.clone(subdir)
             branch = bzrlib.branch.Branch.open_from_transport(cur)
@@ -848,38 +845,35 @@ def get_repo(url, alias):
             except bzrlib.errors.NoRepositoryPresent:
                 pass
 
-    try:
-        repo = origin.open_repository()
-        if not repo.user_transport.listable():
-            # this repository is not usable for us
-            raise bzrlib.errors.NoRepositoryPresent(repo.bzrdir)
-    except bzrlib.errors.NoRepositoryPresent:
-        # branch
-
-        name = 'master'
-        branch = origin.open_branch().base
-
-        if not is_local:
-            peers[name] = branch
+    wanted = get_config('remote-bzr.branches').rstrip().split(', ')
+    # stupid python
+    wanted = [e for e in wanted if e]
 
-        branches[name] = branch
-
-        return origin
+    if not wanted:
+        try:
+            repo = origin.open_repository()
+            if not repo.user_transport.listable():
+                # this repository is not usable for us
+                raise bzrlib.errors.NoRepositoryPresent(repo.bzrdir)
+        except bzrlib.errors.NoRepositoryPresent:
+            wanted = ['master']
+
+    if wanted:
+        def list_wanted(url, wanted):
+            for name in wanted:
+                subdir = name if name != 'master' else ''
+                yield name, bzrlib.urlutils.join(url, subdir)
+
+        branch_list = list_wanted(url, wanted)
     else:
-        # repository
-
-        wanted = get_config('remote-bzr.branches').rstrip().split(', ')
-        # stupid python
-        wanted = [e for e in wanted if e]
+        branch_list = find_branches(repo)
 
-        for name, branch in find_branches(repo, wanted):
-
-            if not is_local:
-                peers[name] = branch
-
-            branches[name] = branch
+    for name, url in branch_list:
+        if not is_local:
+            peers[name] = url
+        branches[name] = url
 
-        return origin
+    return origin
 
 def fix_path(alias, orig_url):
     url = urlparse.urlparse(orig_url, 'file')
-- 
1.8.3.rc3.312.g47657de
