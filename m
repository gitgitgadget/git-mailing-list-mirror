From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/20] remote-bzr: add support for bzr repos
Date: Thu, 25 Apr 2013 20:07:57 -0500
Message-ID: <1366938488-25425-10-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAg-0003jO-Np
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787Ab3DZBJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:52 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:34640 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730Ab3DZBJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:50 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so3527495oag.32
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=MmE6CEReNF4QHWviD5uF8NrwyoPVEss5bDC4zgwSQDI=;
        b=cA9UnErUnll6tWWTREZtO6aGoyzEv/4CHiJAzbczQedJ2xY/oJ7Pf43xZVG+pVpyzR
         lvUwe70jsGkzMexfBEfuR8UbwMFd92nrvSHtkPlXmKKKulOK3erBmhKng21l6EOcszWX
         rL3kgVFG7R9dY2DWnqYZuUnjLuVQqvk9zFSwiVgYyhE6s1ETDv+QcC8JdA7OydHzS51e
         kkqBxBTrco0B6MMFA4RKqWYklDHhvHuKExk19Yi1smbT1YFOP5r4Q9Qq1qUraKqqhP9t
         40AaZYIecSu0q5DmvGVEhEFaUnhFMbX6l9XdmfKh7rsmPM+kk2l7UpTBFZb5zBIZY2qK
         K73Q==
X-Received: by 10.182.78.41 with SMTP id y9mr20946611obw.69.1366938589176;
        Thu, 25 Apr 2013 18:09:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm5847433obb.14.2013.04.25.18.09.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222491>

In bazaar, a repository can contain multiple branches, and previously we
were supporting only one branch at a time. Now we fetch them all.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 158 ++++++++++++++++++++++------------
 1 file changed, 102 insertions(+), 56 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 0c67236..3b33061 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -27,6 +27,7 @@ import bzrlib.generate_ids
 import bzrlib.transport
 import bzrlib.errors
 import bzrlib.ui
+import bzrlib.urlutils
 
 import sys
 import os
@@ -250,12 +251,13 @@ def export_files(tree, files):
 
     return final
 
-def export_branch(branch, name):
+def export_branch(repo, name):
     global prefix
 
     ref = '%s/heads/%s' % (prefix, name)
     tip = marks.get_tip(name)
 
+    branch = branches[name]
     repo = branch.repository
 
     branch.lock_read()
@@ -323,7 +325,7 @@ def export_branch(branch, name):
 
         count += 1
         if (count % 100 == 0):
-            print "progress revision %s (%d/%d)" % (revid, count, len(revs))
+            print "progress revision %s '%s' (%d/%d)" % (revid, name, count, len(revs))
             print "#############################################################"
 
     branch.unlock()
@@ -348,7 +350,7 @@ def export_tag(repo, name):
 def do_import(parser):
     global dirname
 
-    branch = parser.repo
+    repo = parser.repo
     path = os.path.join(dirname, 'marks-git')
 
     print "feature done"
@@ -362,10 +364,10 @@ def do_import(parser):
         ref = parser[1]
         if ref.startswith('refs/heads/'):
             name = ref[len('refs/heads/'):]
-            export_branch(branch, name)
+            export_branch(repo, name)
         if ref.startswith('refs/tags/'):
             name = ref[len('refs/tags/'):]
-            export_tag(branch, name)
+            export_tag(repo, name)
         parser.next()
 
     print 'done'
@@ -551,8 +553,11 @@ def parse_commit(parser):
     ref = parser[1]
     parser.next()
 
-    if ref != 'refs/heads/master':
-        die("bzr doesn't support multiple branches; use 'master'")
+    if ref.startswith('refs/heads/'):
+        name = ref[len('refs/heads/'):]
+        branch = branches[name]
+    else:
+        die('unknown ref')
 
     commit_mark = parser.get_mark()
     parser.next()
@@ -588,8 +593,6 @@ def parse_commit(parser):
         path = c_style_unescape(path).decode('utf-8')
         files[path] = f
 
-    branch = parser.repo
-
     committer, date, tz = committer
     parents = [str(mark_to_rev(p)) for p in parents]
     revid = bzrlib.generate_ids.gen_revision_id(committer, date)
@@ -621,9 +624,6 @@ def parse_reset(parser):
     ref = parser[1]
     parser.next()
 
-    if ref != 'refs/heads/master':
-        die("bzr doesn't support multiple branches; use 'master'")
-
     # ugh
     if parser.check('commit'):
         parse_commit(parser)
@@ -636,7 +636,7 @@ def parse_reset(parser):
     parsed_refs[ref] = mark_to_rev(from_mark)
 
 def do_export(parser):
-    global parsed_refs, dirname, peer
+    global parsed_refs, dirname
 
     parser.next()
 
@@ -654,23 +654,24 @@ def do_export(parser):
         else:
             die('unhandled export command: %s' % line)
 
-    branch = parser.repo
-
     for ref, revid in parsed_refs.iteritems():
-        if ref == 'refs/heads/master':
-            branch.generate_revision_history(revid, marks.get_tip('master'))
-            if peer:
-                try:
-                    branch.push(peer, stop_revision=revid)
-                except bzrlib.errors.DivergedBranches:
-                    print "error %s non-fast forward" % ref
-                    continue
+        name = ref[len('refs/heads/'):]
+        branch = branches[name]
+        branch.generate_revision_history(revid, marks.get_tip(name))
 
+        if name in peers:
+            peer = peers[name]
             try:
-                wt = branch.bzrdir.open_workingtree()
-                wt.update()
-            except bzrlib.errors.NoWorkingTree:
-                pass
+                peer.bzrdir.push_branch(branch, revision_id=revid)
+            except bzrlib.errors.DivergedBranches:
+                print "error %s non-fast forward" % ref
+                continue
+
+        try:
+            wt = branch.bzrdir.open_workingtree()
+            wt.update()
+        except bzrlib.errors.NoWorkingTree:
+            pass
 
         print "ok %s" % ref
 
@@ -697,9 +698,15 @@ def ref_is_valid(name):
 
 def do_list(parser):
     global tags
-    print "? refs/heads/%s" % 'master'
 
-    branch = parser.repo
+    master_branch = None
+
+    for name in branches:
+        if not master_branch:
+            master_branch = name
+        print "? refs/heads/%s" % name
+
+    branch = branches[master_branch]
     branch.lock_read()
     for tag, revid in branch.tags.get_tag_dict().items():
         try:
@@ -711,41 +718,77 @@ def do_list(parser):
         print "? refs/tags/%s" % tag
         tags[tag] = revid
     branch.unlock()
-    print "@refs/heads/%s HEAD" % 'master'
+
+    print "@refs/heads/%s HEAD" % master_branch
     print
 
+def get_remote_branch(origin, remote_branch, name):
+    global dirname, peers
+
+    branch_path = os.path.join(dirname, 'clone', name)
+    if os.path.exists(branch_path):
+        # pull
+        d = bzrlib.bzrdir.BzrDir.open(branch_path)
+        branch = d.open_branch()
+        try:
+            branch.pull(remote_branch, [], None, False)
+        except bzrlib.errors.DivergedBranches:
+            # use remote branch for now
+            return remote_branch
+    else:
+        # clone
+        d = origin.sprout(branch_path, None,
+                hardlink=True, create_tree_if_local=False,
+                force_new_repo=False,
+                source_branch=remote_branch)
+        branch = d.open_branch()
+
+    return branch
+
 def get_repo(url, alias):
-    global dirname, peer
+    global dirname, peer, branches
 
+    normal_url = bzrlib.urlutils.normalize_url(url)
     origin = bzrlib.bzrdir.BzrDir.open(url)
-    branch = origin.open_branch()
-
-    if not isinstance(origin.transport, bzrlib.transport.local.LocalTransport):
-        clone_path = os.path.join(dirname, 'clone')
-        remote_branch = branch
-        if os.path.exists(clone_path):
-            # pull
-            d = bzrlib.bzrdir.BzrDir.open(clone_path)
-            branch = d.open_branch()
-            try:
-                result = branch.pull(remote_branch, [], None, False)
-            except bzrlib.errors.DivergedBranches:
-                # use remote branch for now
-                peer = None
-                return remote_branch
+    is_local = isinstance(origin.transport, bzrlib.transport.local.LocalTransport)
+
+    clone_path = os.path.join(dirname, 'clone')
+
+    try:
+        repo = origin.open_repository()
+    except bzrlib.errors.NoRepositoryPresent:
+        # branch
+
+        name = 'master'
+        branch = origin.open_branch()
+
+        if not is_local:
+            if not os.path.exists(clone_path):
+                os.mkdir(clone_path)
+            peers[name] = branch
+            branches[name] = get_remote_branch(origin, branch, name)
         else:
-            # clone
-            d = origin.sprout(clone_path, None,
-                    hardlink=True, create_tree_if_local=False,
-                    source_branch=remote_branch)
-            branch = d.open_branch()
-            branch.bind(remote_branch)
-
-        peer = remote_branch
+            branches[name] = branch
+
+        return branch.repository
     else:
-        peer = None
+        # repository
 
-    return branch
+        if not is_local and not os.path.exists(clone_path):
+            clonedir = bzrlib.bzrdir.BzrDir.create(clone_path)
+
+        for branch in repo.find_branches():
+
+            name = repo.user_transport.relpath(branch.base)
+            name = name if name != '' else 'master'
+
+            if not is_local:
+                peers[name] = branch
+                branches[name] = get_remote_branch(origin, branch, name)
+            else:
+                branches[name] = branch
+
+        return repo
 
 def fix_path(alias, orig_url):
     url = urlparse.urlparse(orig_url, 'file')
@@ -762,6 +805,7 @@ def main(args):
     global parsed_refs
     global files_cache
     global is_tmp
+    global branches, peers
 
     alias = args[1]
     url = args[2]
@@ -772,6 +816,8 @@ def main(args):
     parsed_refs = {}
     files_cache = {}
     marks = None
+    branches = {}
+    peers = {}
 
     if alias[5:] == url:
         is_tmp = True
-- 
1.8.2.1.884.g3532a8d
