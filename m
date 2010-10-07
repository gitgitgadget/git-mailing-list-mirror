From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] contrib/svn-fe: Fast script to remap svn history
Date: Thu,  7 Oct 2010 17:06:01 +1100
Message-ID: <1286431561-24126-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 08:07:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3jdO-0007jh-4a
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 08:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829Ab0JGGGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 02:06:52 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:63132
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752560Ab0JGGGv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 02:06:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id E20DBC067;
	Thu,  7 Oct 2010 17:06:53 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RH3j0Hn+EqjS; Thu,  7 Oct 2010 17:06:51 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id 019C9C065;
	Thu,  7 Oct 2010 17:06:50 +1100 (EST)
X-Mailer: git-send-email 1.7.3.4.g45608.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158375>

This python script walks the commit sequence imported by svn-fe.
For each commit, it tries to identify the branch that was changed.
Commits are rewritten to be rooted according to the standard layout.
A basic heuristic of matching trees is used to find parents for the
first commit in a branch and for tags.

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 contrib/svn-fe/svn-filter-root.py |  107 +++++++++++++++++++++++++++++++++++++
 fast-import.c                     |    9 +++
 2 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100755 contrib/svn-fe/svn-filter-root.py

diff --git a/contrib/svn-fe/svn-filter-root.py b/contrib/svn-fe/svn-filter-root.py
new file mode 100755
index 0000000..72d248f
--- /dev/null
+++ b/contrib/svn-fe/svn-filter-root.py
@@ -0,0 +1,107 @@
+#!/usr/bin/python
+from subprocess import *
+import re
+import os
+
+subroot_re = re.compile("^trunk|^branches/[^/]*|^tags/[^/]*") 
+
+tree_re = re.compile("^tree ([0-9a-f]{40})", flags=re.MULTILINE)
+parent_re = re.compile("^parent ([0-9a-f]{40})", flags=re.MULTILINE)
+author_re = re.compile("^author (.*)$", flags=re.MULTILINE)
+committer_re = re.compile("^committer (.*)$", flags=re.MULTILINE)
+
+git_svn_id_re = re.compile("^git-svn-id[^@]*", flags=re.MULTILINE)
+
+ref_commit = {}
+tree_commit = {}
+count = 1
+
+# Open a cat-file process for subtree lookups
+subtree_process = Popen(["git","cat-file","--batch-check"], stdin=PIPE, stdout=PIPE)
+
+# Iterate over commits from subversion imported with svn-fe
+revlist = Popen(["git","rev-list","--reverse","--topo-order","--default","HEAD"], stdout=PIPE)
+cat_file = Popen(["git","cat-file","--batch"], stdin=revlist.stdout, stdout=PIPE)
+object_header = cat_file.stdout.readline().strip().split(" ");
+while len(object_header) == 3:
+    object_body = cat_file.stdout.read(int(object_header[2]))
+    cat_file.stdout.read(1)
+    git_commit = object_header[0]
+    (commit_header, blank_line, commit_message) = object_body.partition("\n\n")
+    object_header = cat_file.stdout.readline().strip().split(" ");
+
+    author = author_re.search(commit_header).group()
+    committer = committer_re.search(commit_header).group()
+
+    # Diff against the empty tree if no parent
+    match = parent_re.search(commit_header)
+    if match:
+        parent = match.group(1)
+    else:
+        parent = "4b825dc642cb6eb9a060e54bf8d69288fbee4904"
+
+    # Find a common path prefix in the changes for the revision
+    subroot = ""
+    changes = Popen(["git","diff","--name-only",parent,git_commit], stdout=PIPE)
+    for path in changes.stdout:
+        match = subroot_re.match(path)
+        if match:
+            subroot = match.group()
+            changes.terminate()
+            break
+
+    # Attempt to rewrite the commit on top of the matching branch
+    if subroot == "":
+        print "progress Weird commit - no subroot."
+    else:
+        # Rewrite git-svn-id in the log to point to the subtree
+        commit_message = git_svn_id_re.sub('\g<0>/'+subroot, commit_message)
+        subtree_process.stdin.write(git_commit+":"+subroot+"\n")
+        subtree_process.stdin.flush()
+        subtree_line = subtree_process.stdout.readline()
+        if re.match("^.*missing$", subtree_line):
+            print "progress Weird commit - invalid subroot"
+            continue
+        subtree = subtree_line[0:40]
+        # Map the svn tag/branch name to a git-friendly one
+	ref = "refs/heads/" + re.sub(" ", "%20", subroot)
+        # Choose a parent for the rewritten commit
+        if ref in ref_commit:
+            parent = ref_commit[ref]
+        elif subtree in tree_commit:
+            parent = tree_commit[subtree]
+        else:
+	    parent = ""
+        # Update tags if necessary
+        if re.match("^refs/heads/tags/", ref):
+            if parent == "":
+                print "progress Weird tag - no matching commit."
+            else:
+                tagname = ref[16:]
+                print "tag "+tagname
+                print "from "+parent
+                print "tagger "+committer[10:]
+                print "data "+str(len(commit_message))
+                print commit_message
+        else:
+            # Default to trunk if the branch is new
+            if parent == "" and "refs/heads/trunk" in ref_commit:
+                parent = ref_commit["refs/heads/trunk"]
+            print "commit "+ref
+            print "mark :"+str(count)
+            print author
+            print committer
+            print "data "+str(len(commit_message))
+            print commit_message
+            if parent != "":
+                print "from "+parent
+            print "M 040000 "+subtree+" \"\""
+            commit = ":"+str(count)
+            # Advance the matching branch
+            ref_commit[ref] = commit
+            # Update latest commit by tree to drive parent matching
+            tree_commit[subtree] = commit
+    print "progress " + str(count)
+    count = count + 1
+
+subtree_process.terminate()
diff --git a/fast-import.c b/fast-import.c
index 2317b0f..8f68a89 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1454,6 +1454,15 @@ static int tree_content_set(
 		n = slash1 - p;
 	else
 		n = strlen(p);
+	if (!slash1 && !n) {
+		if (!S_ISDIR(mode))
+			die("Root cannot be a non-directory");
+		hashcpy(root->versions[1].sha1, sha1);
+		if (root->tree)
+			release_tree_content_recursive(root->tree);
+		root->tree = subtree;
+		return 1;
+	}
 	if (!n)
 		die("Empty path component found in input");
 	if (!slash1 && !S_ISDIR(mode) && subtree)
-- 
1.7.3.4.g45608.dirty
