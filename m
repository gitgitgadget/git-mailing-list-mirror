From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2] remote-bzr: reuse bzrlib transports when possible
Date: Sun,  8 Sep 2013 01:47:49 -0400
Message-ID: <1378619269-21991-1-git-send-email-rhansen@bbn.com>
References: <522C0B66.1080707@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com, felipe.contreras@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 08 07:48:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIXrY-0006xi-Ho
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 07:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab3IHFs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 01:48:28 -0400
Received: from smtp.bbn.com ([128.33.1.81]:18763 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab3IHFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 01:48:28 -0400
Received: from socket.bbn.com ([192.1.120.102]:42474)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VIXrE-000PSo-ID; Sun, 08 Sep 2013 01:48:24 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id CB6D63FF85
X-Mailer: git-send-email 1.8.4
In-Reply-To: <522C0B66.1080707@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234187>

Pass a list of open bzrlib.transport.Transport objects to each bzrlib
function that might create a transport.  This enables bzrlib to reuse
existing transports when possible, avoiding multiple concurrent
connections to the same remote server.

If the remote server is accessed via ssh, this fixes a couple of
problems:
  * If the user does not have keys loaded into an ssh agent, the user
    may be prompted for a password multiple times.
  * If the user is using OpenSSH and the ControlMaster setting is set
    to auto, git-remote-bzr might hang.  This is because bzrlib closes
    the multiple ssh sessions in an undefined order and might try to
    close the master ssh session before the other sessions.  The
    master ssh process will not exit until the other sessions have
    exited, causing a deadlock.  (The ssh sessions are closed in an
    undefined order because bzrlib relies on the Python garbage
    collector to trigger ssh session termination.)

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
Changes from v1:
  * add Signed-off-by line

 contrib/remote-helpers/git-remote-bzr | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index c3a3cac..1e0044b 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -674,7 +674,7 @@ def parse_reset(parser):
     parsed_refs[ref] = mark_to_rev(from_mark)
 
 def do_export(parser):
-    global parsed_refs, dirname
+    global parsed_refs, dirname, transports
 
     parser.next()
 
@@ -699,7 +699,8 @@ def do_export(parser):
             branch.generate_revision_history(revid, marks.get_tip(name))
 
             if name in peers:
-                peer = bzrlib.branch.Branch.open(peers[name])
+                peer = bzrlib.branch.Branch.open(peers[name],
+                                                 possible_transports=transports)
                 try:
                     peer.bzrdir.push_branch(branch, revision_id=revid)
                 except bzrlib.errors.DivergedBranches:
@@ -769,25 +770,28 @@ def do_list(parser):
     print
 
 def clone(path, remote_branch):
+    global transports
     try:
-        bdir = bzrlib.bzrdir.BzrDir.create(path)
+        bdir = bzrlib.bzrdir.BzrDir.create(path, possible_transports=transports)
     except bzrlib.errors.AlreadyControlDirError:
-        bdir = bzrlib.bzrdir.BzrDir.open(path)
+        bdir = bzrlib.bzrdir.BzrDir.open(path, possible_transports=transports)
     repo = bdir.find_repository()
     repo.fetch(remote_branch.repository)
     return remote_branch.sprout(bdir, repository=repo)
 
 def get_remote_branch(name):
-    global dirname, branches
+    global dirname, branches, transports
 
-    remote_branch = bzrlib.branch.Branch.open(branches[name])
+    remote_branch = bzrlib.branch.Branch.open(branches[name],
+                                              possible_transports=transports)
     if isinstance(remote_branch.user_transport, bzrlib.transport.local.LocalTransport):
         return remote_branch
 
     branch_path = os.path.join(dirname, 'clone', name)
 
     try:
-        branch = bzrlib.branch.Branch.open(branch_path)
+        branch = bzrlib.branch.Branch.open(branch_path,
+                                           possible_transports=transports)
     except bzrlib.errors.NotBranchError:
         # clone
         branch = clone(branch_path, remote_branch)
@@ -821,17 +825,19 @@ def find_branches(repo):
             yield name, branch.base
 
 def get_repo(url, alias):
-    global dirname, peer, branches
+    global dirname, peer, branches, transports
 
     normal_url = bzrlib.urlutils.normalize_url(url)
-    origin = bzrlib.bzrdir.BzrDir.open(url)
+    origin = bzrlib.bzrdir.BzrDir.open(url, possible_transports=transports)
     is_local = isinstance(origin.transport, bzrlib.transport.local.LocalTransport)
 
     shared_path = os.path.join(gitdir, 'bzr')
     try:
-        shared_dir = bzrlib.bzrdir.BzrDir.open(shared_path)
+        shared_dir = bzrlib.bzrdir.BzrDir.open(shared_path,
+                                               possible_transports=transports)
     except bzrlib.errors.NotBranchError:
-        shared_dir = bzrlib.bzrdir.BzrDir.create(shared_path)
+        shared_dir = bzrlib.bzrdir.BzrDir.create(shared_path,
+                                                 possible_transports=transports)
     try:
         shared_repo = shared_dir.open_repository()
     except bzrlib.errors.NoRepositoryPresent:
@@ -844,7 +850,8 @@ def get_repo(url, alias):
         else:
             # check and remove old organization
             try:
-                bdir = bzrlib.bzrdir.BzrDir.open(clone_path)
+                bdir = bzrlib.bzrdir.BzrDir.open(clone_path,
+                                                 possible_transports=transports)
                 bdir.destroy_repository()
             except bzrlib.errors.NotBranchError:
                 pass
@@ -897,6 +904,7 @@ def main(args):
     global files_cache
     global is_tmp
     global branches, peers
+    global transports
 
     alias = args[1]
     url = args[2]
@@ -909,6 +917,7 @@ def main(args):
     marks = None
     branches = {}
     peers = {}
+    transports = []
 
     if alias[5:] == url:
         is_tmp = True
-- 
1.8.4
