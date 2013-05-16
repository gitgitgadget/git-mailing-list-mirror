From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Thu, 16 May 2013 03:36:46 -0500
Message-ID: <1368693407-21267-8-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctiM-0000iO-W5
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781Ab3EPIiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:55 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36578 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab3EPIir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:47 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so3135192obc.12
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=atBEHXV4nLOFK/+Lbe/j5XeDYKJjhOImzhX0JF5eqms=;
        b=eYgl+WIwrVU8Q/COJ8LMfaxUCdVhMXr4lb6vwYIerYn4Chy/aCzXMgyxtPF3QICcD/
         Syz/SB9nf7hUOkB19sTSoMVEZ8WNzjD8YN8M2KmC4Yr9uMxt8KJ0E13XiFdN1aZTkh0/
         0gT+pW7qa+kkEhH8eDF8pI2Z80QXTI4gIqE1C2ATzvWryL9qRLMDVKUCb+nuSBn1fdtw
         fFfT+iXKQlBe6cKH/8uKILe4fbIr69s0bOsDX65a39ozYOqdlRbQ9UHl5TRswWf/Y0Q9
         gYVfldwrR1rHJ+ffdHh+LBwRfxV7xySCWF2F55kzk6zjw22O7Zz3PZjZKIhbmjLkqOdF
         cPhQ==
X-Received: by 10.60.41.136 with SMTP id f8mr21159897oel.11.1368693527228;
        Thu, 16 May 2013 01:38:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm6893771obb.11.2013.05.16.01.38.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224508>

If the user specified a list of branches, we ignore what the remote
repository lists, and simply use the branches directly. Since some
remotes don't report the branches correctly, this is useful.

Otherwise either fetch the repo, or the branch.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 48 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index dd3d71c..434e613 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -794,7 +794,7 @@ def get_remote_branch(name):
 
     return branch
 
-def find_branches(repo, wanted):
+def find_branches(repo):
     transport = repo.user_transport
 
     for fn in transport.iter_files_recursive():
@@ -805,9 +805,6 @@ def find_branches(repo, wanted):
         name = name if name != '' else 'master'
         name = name.replace('/', '+')
 
-        if wanted and not name in wanted:
-            continue
-
         try:
             cur = transport.clone(subdir)
             branch = bzrlib.branch.Branch.open_from_transport(cur)
@@ -845,35 +842,32 @@ def get_repo(url, alias):
             except bzrlib.errors.NotBranchError:
                 pass
 
-    try:
-        repo = origin.open_repository()
-    except bzrlib.errors.NoRepositoryPresent:
-        # branch
-
-        name = 'master'
-        branch = origin.open_branch().base
+    wanted = get_config('remote-bzr.branches').rstrip().split(', ')
+    # stupid python
+    wanted = [e for e in wanted if e]
 
-        if not is_local:
-            peers[name] = branch
+    if not wanted:
+        try:
+            repo = origin.open_repository()
+        except bzrlib.errors.NoRepositoryPresent:
+            wanted = ['master']
 
-        branches[name] = branch
+    if wanted:
+        def list_wanted(url, wanted):
+            for name in wanted:
+                subdir = name if name != 'master' else ''
+                yield name, bzrlib.urlutils.join(url, subdir)
 
-        return origin
+        branch_list = list_wanted(url, wanted)
     else:
-        # repository
-
-        wanted = get_config('remote-bzr.branches').rstrip().split(', ')
-        # stupid python
-        wanted = [e for e in wanted if e]
-
-        for name, branch in find_branches(repo, wanted):
+        branch_list = find_branches(repo)
 
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
1.8.3.rc2.542.g24820ba
