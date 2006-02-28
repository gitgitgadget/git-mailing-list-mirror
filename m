From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Tue, 28 Feb 2006 22:45:56 +0000
Message-ID: <b0943d9e0602281445w7160d915y@mail.gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	 <44037A5C.6080409@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6911_18125825.1141166756366"
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 23:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEDbe-00013X-CT
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 23:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWB1Wp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 17:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWB1Wp6
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 17:45:58 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:38744 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932450AbWB1Wp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 17:45:57 -0500
Received: by xproxy.gmail.com with SMTP id t11so812306wxc
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 14:45:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=VzcQkPegrVMUzF6vlh8FQ1sQ+alH9AXm/PnelRWn9N2zGsRYn7Y0Zk9SL6LuEQX6v/VG2UCfIksBd8nNNgUpIYn5vEmOP5rsRPGaVhDrc1X8qwWptDMPN7dbTpLdyV/eIrsYYSuYoxq734MsEXkzwHrGWYQtGladNHCp839VXj0=
Received: by 10.70.54.1 with SMTP id c1mr1215886wxa;
        Tue, 28 Feb 2006 14:45:56 -0800 (PST)
Received: by 10.70.31.16 with HTTP; Tue, 28 Feb 2006 14:45:56 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <44037A5C.6080409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16957>

------=_Part_6911_18125825.1141166756366
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 27/02/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> An idea (untested, I don't even know whether it's feasible) would be to
> check which patches were merged by reverse-applying them starting with
> the last. In this situation, all the merged patches should just revert
> their changes. You only need to do a git-diff between the bottom and the
> top of the patch and git-apply the output (maybe without even modifying
> the tree). If this operation succeeds, the patch was integrated and you
> don't even need to push it.

I attached another patch that should work properly. It also pushes
empty patches on the stack if they were merged upstream (a 'stg clean'
is required to remove them). This is useful for the push --undo
command if you are not happy with the result.

I'll try this patch for a bit more before pushing into the repository.

--
Catalin

------=_Part_6911_18125825.1141166756366
Content-Type: text/x-patch; name=merged-test.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek8t6ewq
Content-Disposition: attachment; filename="merged-test.diff"

Add a merged upstream test for pull and push

From: Catalin Marinas <catalin.marinas@gmail.com>

This patch adds the --merged option to both pull and push commands. With
this option, these commands will first try to check which patches were
merged upstream by reverse-applying them in reverse order. This should
solve the situation where several patches modify the same line in a file.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/common.py |   41 +++++++++++++++++++++++++++++++++++++++++
 stgit/commands/pull.py   |   15 +++++----------
 stgit/commands/push.py   |   28 ++++++----------------------
 stgit/git.py             |   12 +++++++++---
 stgit/stack.py           |   34 +++++++++++++++++++++++++++++++---
 5 files changed, 92 insertions(+), 38 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 2e1ba7a..2985379 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -132,6 +132,47 @@ def resolved_all(reset = None):
             resolved(filename, reset)
         os.remove(os.path.join(git.get_base_dir(), 'conflicts'))
 
+def push_patches(patches, check_merged = False):
+    """Push multiple patches onto the stack. This function is shared
+    between the push and pull commands
+    """
+    forwarded = crt_series.forward_patches(patches)
+    if forwarded > 1:
+        print 'Fast-forwarded patches "%s" - "%s"' % (patches[0],
+                                                      patches[forwarded - 1])
+    elif forwarded == 1:
+        print 'Fast-forwarded patch "%s"' % patches[0]
+
+    names = patches[forwarded:]
+
+    # check for patches merged upstream
+    if check_merged:
+        print 'Checking for patches merged upstream...',
+        sys.stdout.flush()
+
+        merged = crt_series.merged_patches(names)
+
+        print 'done (%d found)' % len(merged)
+    else:
+        merged = []
+
+    for p in names:
+        print 'Pushing patch "%s"...' % p,
+        sys.stdout.flush()
+
+        if p in merged:
+            crt_series.push_patch(p, empty = True)
+            print 'done (merged upstream)'
+        else:
+            modified = crt_series.push_patch(p)
+
+            if crt_series.empty_patch(p):
+                print 'done (empty patch)'
+            elif modified:
+                print 'done (modified)'
+            else:
+                print 'done'
+
 def name_email(address):
     """Return a tuple consisting of the name and email parsed from a
     standard 'name <email>' string
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 843b579..8f26f4d 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -39,6 +39,9 @@ format."""
 
 options = [make_option('-n', '--nopush',
                        help = 'do not push the patches back after pulling',
+                       action = 'store_true'),
+           make_option('-m', '--merged',
+                       help = 'check for patches merged upstream',
                        action = 'store_true')]
 
 def func(parser, options, args):
@@ -75,15 +78,7 @@ def func(parser, options, args):
     print 'done'
 
     # push the patches back
-    if options.nopush:
-        applied = []
-    for p in applied:
-        print 'Pushing patch "%s"...' % p,
-        sys.stdout.flush()
-        crt_series.push_patch(p)
-        if crt_series.empty_patch(p):
-            print 'done (empty patch)'
-        else:
-            print 'done'
+    if not options.nopush:
+        push_patches(applied, options.merged)
 
     print_crt_patch()
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 9924a78..90777c1 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -49,6 +49,9 @@ options = [make_option('-a', '--all',
            make_option('--reverse',
                        help = 'push the patches in reverse order',
                        action = 'store_true'),
+           make_option('-m', '--merged',
+                       help = 'check for patches merged upstream',
+                       action = 'store_true'),
            make_option('--undo',
                        help = 'undo the last push operation',
                        action = 'store_true')]
@@ -58,9 +61,9 @@ def is_patch_appliable(p):
     """See if patch exists, or is already applied.
     """
     if p in applied:
-        raise CmdException, 'Patch "%s" is already applied.' % p
+        raise CmdException, 'Patch "%s" is already applied' % p
     if p not in unapplied:
-        raise CmdException, 'Patch "%s" does not exist.' % p
+        raise CmdException, 'Patch "%s" does not exist' % p
 
 def func(parser, options, args):
     """Pushes the given patch or all onto the series
@@ -127,25 +130,6 @@ def func(parser, options, args):
     if options.reverse:
         patches.reverse()
 
-    forwarded = crt_series.forward_patches(patches)
-    if forwarded > 1:
-        print 'Fast-forwarded patches "%s" - "%s"' % (patches[0],
-                                                      patches[forwarded - 1])
-    elif forwarded == 1:
-        print 'Fast-forwarded patch "%s"' % patches[0]
-
-    for p in patches[forwarded:]:
-        is_patch_appliable(p)
-
-        print 'Pushing patch "%s"...' % p,
-        sys.stdout.flush()
+    push_patches(patches, options.merged)
 
-        modified = crt_series.push_patch(p)
-
-        if crt_series.empty_patch(p):
-            print 'done (empty patch)'
-        elif modified:
-            print 'done (modified)'
-        else:
-            print 'done'
     print_crt_patch()
diff --git a/stgit/git.py b/stgit/git.py
index a3488ff..40d54ef 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -465,14 +465,20 @@ def commit(message, files = None, parent
 
     return commit_id
 
-def apply_diff(rev1, rev2):
+def apply_diff(rev1, rev2, check_index = True):
     """Apply the diff between rev1 and rev2 onto the current
     index. This function doesn't need to raise an exception since it
     is only used for fast-pushing a patch. If this operation fails,
     the pushing would fall back to the three-way merge.
     """
-    return os.system('git-diff-tree -p %s %s | git-apply --index 2> /dev/null'
-                     % (rev1, rev2)) == 0
+    if check_index:
+        index_opt = '--index'
+    else:
+        index_opt = ''
+    cmd = 'git-diff-tree -p %s %s | git-apply %s 2> /dev/null' \
+          % (rev1, rev2, index_opt)
+
+    return os.system(cmd) == 0
 
 def merge(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
diff --git a/stgit/stack.py b/stgit/stack.py
index e1c55f0..165b5a7 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -780,7 +780,27 @@ class Series:
 
         return forwarded
 
-    def push_patch(self, name):
+    def merged_patches(self, names):
+        """Test which patches were merged upstream by reverse-applying
+        them in reverse order. The function returns the list of
+        patches detected to have been applied. The state of the tree
+        is restored to the original one
+        """
+        patches = [Patch(name, self.__patch_dir, self.__refs_dir)
+                   for name in names]
+        patches.reverse()
+
+        merged = []
+        for p in patches:
+            if git.apply_diff(p.get_top(), p.get_bottom(), False):
+                merged.append(p.get_name())
+        merged.reverse()
+
+        git.reset()
+
+        return merged
+
+    def push_patch(self, name, empty = False):
         """Pushes a patch on the stack
         """
         unapplied = self.get_unapplied()
@@ -798,7 +818,15 @@ class Series:
         modified = False
 
         # top != bottom always since we have a commit for each patch
-        if head == bottom:
+        if empty:
+            # just make an empty patch (top = bottom = HEAD). This
+            # option is useful to allow undoing already merged
+            # patches. The top is updated by refresh_patch since we
+            # need an empty commit
+            patch.set_bottom(head, backup = True)
+            patch.set_top(head, backup = True)
+            modified = True
+        elif head == bottom:
             # reset the backup information
             patch.set_bottom(bottom, backup = True)
             patch.set_top(top, backup = True)
@@ -835,7 +863,7 @@ class Series:
         self.__set_current(name)
 
         # head == bottom case doesn't need to refresh the patch
-        if head != bottom:
+        if empty or head != bottom:
             if not ex:
                 # if the merge was OK and no conflicts, just refresh the patch
                 # The GIT cache was already updated by the merge operation

------=_Part_6911_18125825.1141166756366--
