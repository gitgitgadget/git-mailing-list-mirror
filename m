From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Add "stg id" support for "{public}" ref
Date: Fri, 29 May 2009 22:30:04 +0100
Message-ID: <20090529213003.8908.87850.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 29 23:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA9jh-0007VI-P3
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 23:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZE2VfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 17:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZE2VfV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 17:35:21 -0400
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:37564 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346AbZE2VfU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 17:35:20 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2009 17:35:20 EDT
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090529213006.SYGS6742.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Fri, 29 May 2009 22:30:06 +0100
Received: from localhost.localdomain ([86.9.126.106])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20090529213006.CUCZ21638.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 29 May 2009 22:30:06 +0100
User-Agent: StGit/0.14.3.340.ge799
X-Cloudmark-Analysis: v=1.0 c=1 a=Ij9IuO38S2sA:10 a=25HPCj9gIjAA:10 a=7CQSdrXTAAAA:8 a=ukHiMj6Zv7Cs_U4Zo6gA:9 a=cUBCQVrS-oA753eovd8A:7 a=tXpF7BduX_Q2QJU-d0Q_TX0JapkA:4 a=TRZ13oeOE2kA:10 a=ESTKKtUg-DoA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120319>

From: Catalin Marinas <catalin.marinas@arm.com>

The {public} ref refers to the public version of the branch as described
in the "publish" command.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 stgit/commands/common.py  |   16 +++++++++++++++-
 stgit/commands/diff.py    |    6 +-----
 stgit/commands/id.py      |   13 +++++++------
 stgit/commands/publish.py |    4 +---
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 4f53f91..dfd7e26 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -53,11 +53,20 @@ def git_id(crt_series, rev):
     repository = libstack.Repository.default()
     return git_commit(rev, repository, crt_series.get_name()).sha1
 
+def get_public_ref(branch_name):
+    """Return the public ref of the branch."""
+    public_ref = config.get('branch.%s.public' % branch_name)
+    if not public_ref:
+        public_ref = 'refs/heads/%s.public' % branch_name
+    return public_ref
+
 def git_commit(name, repository, branch_name = None):
     """Return the a Commit object if 'name' is a patch name or Git commit.
     The patch names allowed are in the form '<branch>:<patch>' and can
     be followed by standard symbols used by git rev-parse. If <patch>
-    is '{base}', it represents the bottom of the stack.
+    is '{base}', it represents the bottom of the stack. If <patch> is
+    {public}, it represents the public branch corresponding to the stack as
+    described in the 'publish' command.
     """
     # Try a [branch:]patch name first
     branch, patch = parse_rev(name)
@@ -69,6 +78,11 @@ def git_commit(name, repository, branch_name = None):
         base_id = repository.get_stack(branch).base.sha1
         return repository.rev_parse(base_id +
                                     strip_prefix('{base}', patch))
+    elif patch.startswith('{public}'):
+        public_ref = get_public_ref(branch)
+        return repository.rev_parse(public_ref +
+                                    strip_prefix('{public}', patch),
+                                    discard_stderr = True)
 
     # Other combination of branch and patch
     try:
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 7d2f719..568651c 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -32,11 +32,7 @@ description = """
 Show the diff (default) or diffstat between the current working copy
 or a tree-ish object and another tree-ish object (defaulting to HEAD).
 File names can also be given to restrict the diff output. The
-tree-ish object can be an StGIT patch, a standard git commit, tag or
-tree. In addition to these, the command also supports '{base}',
-representing the bottom of the current stack.
-
-rev = '[branch:](<patch>|{base}) | <tree-ish>'"""
+tree-ish object has the format accepted by the linkstg:id[] command."""
 
 args = [argparse.known_files, argparse.dirty_files]
 options = [
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 566edcc..654ff72 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -24,12 +24,13 @@ help = 'Print the git hash value of a StGit reference'
 kind = 'repo'
 usage = ['[options] [id]']
 description = """
-Print the SHA1 value of a Git id (defaulting to HEAD). In addition to
-the standard Git id's like heads and tags, this command also accepts
-'[<branch>:]<patch>' and '[<branch>:]{base}' showing the id of a patch
-or the base of the stack. If no branch is specified, it defaults to the
-current one. The bottom of a patch is accessible with the
-'[<branch>:]<patch>^' format."""
+Print the SHA1 value of a Git id (defaulting to HEAD). In addition to the
+standard Git id's like heads and tags, this command also accepts
+'[<branch>:]<patch>' for the id of a patch, '[<branch>:]\{base\}' for the base
+of the stack and '[<branch>:]\{public\}' for the public branch corresponding
+to the stack (see the 'publish' command for details). If no branch is
+specified, it defaults to the current one. The bottom of a patch is accessible
+with the '[<branch>:]<patch>^' format."""
 
 args = [argparse.applied_patches, argparse.unapplied_patches,
         argparse.hidden_patches]
diff --git a/stgit/commands/publish.py b/stgit/commands/publish.py
index e4b1a8d..401fbdf 100644
--- a/stgit/commands/publish.py
+++ b/stgit/commands/publish.py
@@ -82,9 +82,7 @@ def func(parser, options, args):
     stack = repository.get_stack(options.branch)
 
     if not args:
-        public_ref = config.get('branch.%s.public' % stack.name)
-        if not public_ref:
-            public_ref = 'refs/heads/%s.public' % stack.name
+        public_ref = common.get_public_ref(stack.name)
     elif len(args) == 1:
         public_ref = args[0]
     else:
