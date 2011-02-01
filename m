From: Ian Wienand <ianw@vmware.com>
Subject: [PATCH] Support different branch layouts in git-p4
Date: Tue, 01 Feb 2011 14:59:52 -0800
Message-ID: <4D489068.2040704@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 23:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkPCY-0003jA-M4
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab1BAW7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 17:59:53 -0500
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:23928 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab1BAW7w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 17:59:52 -0500
Received: from mailhost4.vmware.com (mailhost4.vmware.com [10.16.67.124])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id 9096F1343A
	for <git@vger.kernel.org>; Tue,  1 Feb 2011 14:59:52 -0800 (PST)
Received: from [10.20.123.85] (coopers.eng.vmware.com [10.20.123.85])
	by mailhost4.vmware.com (Postfix) with ESMTP id 87CF0C9FCA
	for <git@vger.kernel.org>; Tue,  1 Feb 2011 14:59:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Iceowl/1.0b1 Icedove/3.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165875>

Hi,

I think the addition to the git-p4.txt in the diff explains the
reasoning behind the patch best.  In short, we have a repository
layout

//depot/foo/branch
//depot/moo/branch

where we require projects 'foo' and 'moo' to be alongside each other.
We can do this with p4 views, but currently have to have 'foo' and
'moo' in separate git repos.

This just munges the incoming paths to either put the branch as the
top level directory, or just remove it entirely if you don't need it.

I've tested it locally, but I don't really have a wide variety of p4
environments to expose it too.

-i

Signed-off-by: Ian Wienand <ianw@vmware.com>
---
 contrib/fast-import/git-p4     |   35 +++++++++++++++++++++++-
 contrib/fast-import/git-p4.txt |   58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..4bd40f8 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -848,6 +848,10 @@ class P4Sync(Command):
                 optparse.make_option("--max-changes", dest="maxChanges"),
                 optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
                                      help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
+                optparse.make_option("--branch-path", dest="branchPath", type='choice',
+                                     choices=('none', 'first'),
+                                     default=None,
+                                     help="Remove the branch dir (none) or move it above project dir (first)"),
                 optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
                                      help="Only sync files that are included in the Perforce Client Spec")
         ]
@@ -917,6 +921,20 @@ class P4Sync(Command):
             if path.startswith(p):
                 path = path[len(p):]
 
+        # reorg to move/remove branch from the output filename -- kind
+        # of like how you can set your view in your p4 client
+        if self.keepRepoPath and self.branchPath == 'first':
+            # move the second element first, so what was was
+            # "//depot/proj/branch/file" becomes "branch/proj/file".
+            path = re.sub("^([^/]+/)([^/]+/)", r'\2\1', path)
+        elif self.keepRepoPath and self.branchPath == 'none':
+            # remove the second element, so what was
+            # "//depot/proj/branch/file" becomes "proj/file"
+            path = re.sub("^([^/]+/)([^/]+/)", r'\2', path)
+        elif self.branchPath:
+            sys.stderr.write("branchPath without keepRepoPath?")
+            sys.exit(1)
+
         return path
 
     def splitFilesIntoBranches(self, commit):
@@ -940,7 +958,6 @@ class P4Sync(Command):
             relPath = self.stripRepoPath(path, self.depotPaths)
 
             for branch in self.knownBranches.keys():
-
                 # add a trailing slash so that a commit into qt/4.2foo doesn't end up in qt/4.2
                 if relPath.startswith(branch + "/"):
                     if branch not in branches:
@@ -1283,12 +1300,24 @@ class P4Sync(Command):
         if self.keepRepoPath:
             option_keys['keepRepoPath'] = 1
 
+        # since we're just saving the dict keys, append the branchPath
+        # option to the key
+        if self.branchPath:
+            option_keys['branchPath_%s' % self.branchPath] = 1
+
         d["options"] = ' '.join(sorted(option_keys.keys()))
 
     def readOptions(self, d):
         self.keepRepoPath = (d.has_key('options')
                              and ('keepRepoPath' in d['options']))
 
+        # restore the branchpath option; is one of "none" and "first"
+        if (d.has_key('options')):
+            if ('branchPath_none' in d['options']):
+                self.branchPath = 'none'
+            elif ('branchPath_first' in d['options']):
+                self.branchPath = 'first'
+
     def gitRefForBranch(self, branch):
         if branch == "main":
             return self.refPrefix + "master"
@@ -1775,6 +1804,10 @@ class P4Clone(P4Sync):
             sys.stderr.write("Must specify destination for --keep-path\n")
             sys.exit(1)
 
+        if self.branchPath and not self.keepRepoPath:
+            sys.stderr.write("Must specify --keep-path for --branch-path\n")
+            sys.exit(1)
+
         depotPaths = args
 
         if not self.cloneDestination and len(depotPaths) > 1:
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 49b3359..669c63c 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -191,6 +191,64 @@ git-p4.useclientspec
 
   git config [--global] git-p4.useclientspec false
 
+Dealing with different repository layouts
+=========================================
+
+Perforce clients can map views of projects and branches in different
+ways which your build system may rely on.  Say your code is organised
+as two projects "foo" and "moo" which have a common branch
+
+//depot/foo/branch/...
+//depot/moo/branch/...
+
+and you require both "foo" and "moo" projects in your git repository,
+there are several options.
+
+Firstly, you could simply clone each project as a completely separate
+git tree.  However, if the two projects are dependent on each other
+this can be annoying for both sync -- you must remember to sync both
+"foo" and "moo" to keep everything consistent -- and submit -- a
+change that should logically be a single changeset across "foo" and
+"moo" will have to be broken up (breaking bisection too).
+
+Another option is to simply specify multiple depots
+
+ git p4 sync //depot/foo/branch //depot/moo/branch
+
+which will import "foo" and "moo" into the same directory.
+
+To keep the projects separate, the --keep-path option used as
+
+ git p4 sync --keep-path --destination /tmp/boo/ //depot/foo/branch //depot/moo/branch
+
+will create a layout of
+
+ /tmp/boo/foo/branch/...
+ /tmp/boo/moo/branch/...
+
+However, some build systems may rely on p4's ability to specify
+destinations for views in your client.  The --branch-path flag, which
+requires the --keep-path flag, allows two additional layout options.
+
+ git p4 sync --keep-path --destination /tmp/boo --branch-path=none //depot/foo/branch //depot/moo/branch
+
+will remove the branch name entirely, leaving you with a directory
+that looks like
+
+ /tmp/boo/foo/...
+ /tmp/boo/moo/...
+
+and
+
+ git p4 sync --keep-path --destination /tmp/boo --branch-path=first //depot/foo/branch //depot/moo/branch
+
+will give you each of the projects under a directory named for their
+common branch
+
+ /tmp/boo/branch/foo/...
+ /tmp/boo/branch/moo/...
+
+
 Implementation Details...
 =========================
 
-- 
1.7.2.3
