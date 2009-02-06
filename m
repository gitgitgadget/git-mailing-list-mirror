From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Fri, 6 Feb 2009 14:46:19 +0000
Message-ID: <b0943d9e0902060646hd779681x821e74d9a155d97b@mail.gmail.com>
References: <20090128231305.16133.29214.stgit@localhost.localdomain>
	 <20090129034512.GD24344@diana.vm.bytemark.co.uk>
	 <b0943d9e0901300601j27ab6ebdq4b38a9f7c0cbe261@mail.gmail.com>
	 <20090130152649.GA22044@diana.vm.bytemark.co.uk>
	 <b0943d9e0901300936t4a6e0a37x1968a6949fb7bdda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:47:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRzi-0003zs-Db
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZBFOqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbZBFOqX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:46:23 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:64139 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZBFOqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:46:22 -0500
Received: by fxm13 with SMTP id 13so1220285fxm.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 06:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ax0dG6VK4aRwKYJurQJ6saeY+70wFKk9VcZ+3ENmjQQ=;
        b=diy67tmY9473CMW1p/llC0vEod9W629pOlwilOl0oUq5hIw5mt/fhq6ibj6Lon6M9l
         8yoDBedjL2UVpXwH3vKcBkEnPGS0aVBZbu/cIVXBXwGO1evLCkMaVpnQBRDPsuwsJ2Nb
         AzUgPPZnno/JKYa7wFHgJ7jFBuc1o5q6C7f8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XAxKo2qnLZSK62yGvGu9MnAmpQuJX2BMXLdsazv+oJHGCVp+INpEABmRz0NaNPWvLv
         r/UuoOIDX7KNmFSgFIDhn5pBOyrFqHeHkoSOi5et8tUNzQSxEJBVXKZc4rNw6OTiFbB4
         d8T+SHzpNdTml6b8WRk6feKjNykoILeeXh4Xc=
Received: by 10.223.107.9 with SMTP id z9mr1526811fao.1.1233931579918; Fri, 06 
	Feb 2009 06:46:19 -0800 (PST)
In-Reply-To: <b0943d9e0901300936t4a6e0a37x1968a6949fb7bdda@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108720>

2009/1/30 Catalin Marinas <catalin.marinas@gmail.com>:
> Now, should we add the check_clean argument to Transaction.__init__()
> rather than run() as we do for the allow_bad_head case?

It looks like this may be a better option. The previous patch fails if
"goto" pushes a patch with standard git-apply followed by another
patch with a three-way merge. When Transaction.run() is called, even
if the patch pushing succeeded, the function complains about local
changes because of the "iw.index.is_clean(self.stack.head)" check.

It is also a bit weird to push/pop patches and only complain at the
end of local changes. Below is an updated patch which does the
checking in Transaction.__init__ (only the relevant parts of the
patch):

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index e2b4266..07079b8 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -706,9 +706,11 @@ class Index(RunWithEnv):
                     ).output_one_line())
         except run.RunException:
             raise MergeException('Conflicting merge')
-    def is_clean(self):
+    def is_clean(self, tree):
+        """Check whether the index is clean relative to the given treeish."""
         try:
-            self.run(['git', 'update-index', '--refresh']).discard_output()
+            self.run(['git', 'diff-index', '--quiet', '--cached', tree.sha1]
+                    ).discard_output()
         except run.RunException:
             return False
         else:
@@ -858,6 +860,14 @@ class IndexAndWorktree(RunWithEnvCwd):
         cmd = ['git', 'update-index', '--remove']
         self.run(cmd + ['-z', '--stdin']
                  ).input_nulterm(paths).discard_output()
+    def worktree_clean(self):
+        """Check whether the worktree is clean relative to index."""
+        try:
+            self.run(['git', 'update-index', '--refresh']).discard_output()
+        except run.RunException:
+            return False
+        else:
+            return True

 class Branch(object):
     """Represents a Git branch."""
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 54de127..e1bd38d 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -75,7 +75,8 @@ class StackTransaction(object):
       your refs and index+worktree, or fail without having done
       anything."""
     def __init__(self, stack, msg, discard_changes = False,
-                 allow_conflicts = False, allow_bad_head = False):
+                 allow_conflicts = False, allow_bad_head = False,
+                 check_clean = False):
         """Create a new L{StackTransaction}.

         @param discard_changes: Discard any changes in index+worktree
@@ -102,6 +103,8 @@ class StackTransaction(object):
         self.__temp_index = self.temp_index_tree = None
         if not allow_bad_head:
             self.__assert_head_top_equal()
+        if check_clean:
+            self.__assert_index_worktree_clean()
     stack = property(lambda self: self.__stack)
     patches = property(lambda self: self.__patches)
     def __set_applied(self, val):
@@ -147,6 +150,12 @@ class StackTransaction(object):
                 'This can happen if you modify a branch with git.',
                 '"stg repair --help" explains more about what to do next.')
             self.__abort()
+    def __assert_index_worktree_clean(self):
+        iw = self.__stack.repository.default_iw
+        if not iw.worktree_clean() or \
+           not iw.index.is_clean(self.stack.head):
+            self.__halt('Repository not clean. Use "refresh" or '
+                        '"status --reset"')
     def __checkout(self, tree, iw, allow_bad_head):
         if not allow_bad_head:
             self.__assert_head_top_equal()


-- 
Catalin
