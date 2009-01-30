From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Fri, 30 Jan 2009 14:01:20 +0000
Message-ID: <b0943d9e0901300601j27ab6ebdq4b38a9f7c0cbe261@mail.gmail.com>
References: <20090128231305.16133.29214.stgit@localhost.localdomain>
	 <20090129034512.GD24344@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSu4B-0006vE-Ck
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZA3OIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 09:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbZA3OIa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:08:30 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:58192 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZA3OI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 09:08:29 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jan 2009 09:08:28 EST
Received: by bwz5 with SMTP id 5so42599bwz.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W1/QzNTMf5w3nGB+4x8hVo37DkqjQ/cm76wqqIkbDAU=;
        b=pBfE8Q2+MI68m/Dfoz+8MMHaJRtEDuhlER2UppoyuGdUo16ctmer7iDOWJFlZKeez4
         2cpOQRQxLRQSW5GkjPXSheee40RObR53lDtnKwrgakF/CkLykYgx648XBjM+SVLVeX4o
         btObt3bTJqUt7DjbFsVHefyOyAVh1/TqfMPZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HiTk6k0nFQw7+h0gJzGY31oPv5rgb8ZZ2RTdwf18Vbq3fyGQiSB/jplzBjdBAUKEnO
         G+OPS9jNKSrWJ8WQgX8xW+n30SL8uSZUmfihI/jkaFsjNpVOvDTx80byQtXmAZCAcpiR
         xY6Fzw2D2gSk8lClBd6CGBaR+YVr39a5+zrY0=
Received: by 10.223.111.211 with SMTP id t19mr345642fap.64.1233324080531; Fri, 
	30 Jan 2009 06:01:20 -0800 (PST)
In-Reply-To: <20090129034512.GD24344@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107822>

2009/1/29 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-01-28 23:13:05 +0000, Catalin Marinas wrote:
>> +        # Check for not clean index
>> +        if check_clean and iw and not iw.index.is_clean():
>> +            self.__halt('Repository not clean. Use "refresh" or '
>> +                        '"status --reset"')
>
> ... this, which doesn't do what I think you think it does.
>
> Index.is_clean() calls "git update-index --refresh", which checks for
> changes in the worktree relative to the index. It's bad design to hav=
e
> it in Index rather than IndexAndWorktree, but that's my fault, not
> yours. ;-) But the point that breaks your patch is that it doesn't
> check for changes between index and HEAD -- try it and see.
>
> The fix I'd suggest is to move the existing is_clean() method to
> IndexAndWorktree, and call it maybe worktree_clean(). And create a
> method in Index() called is_clean(tree) that checks whether the index
> is clean with respect to the given Tree (I think this method should
> just call "git diff-index --quiet --cached <tree>".). Then call both
> of these methods.

What about this (only pasting the relevant hunks, though they may be
wrapped by the web interface):

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index e2b4266..7e1b9dd 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -706,9 +706,15 @@ class Index(RunWithEnv):
                     ).output_one_line())
         except run.RunException:
             raise MergeException('Conflicting merge')
-    def is_clean(self):
+    def is_clean(self, tree =3D None):
+        """Check whether the index is clean relative to the given tree=
=2E"""
+        if tree:
+            sha1 =3D tree.sha1
+        else:
+            sha1 =3D 'HEAD'
         try:
-            self.run(['git', 'update-index', '--refresh']).discard_out=
put()
+            self.run(['git', 'diff-index', '--quiet', '--cached', sha1=
]
+                    ).discard_output()
         except run.RunException:
             return False
         else:
@@ -858,6 +864,15 @@ class IndexAndWorktree(RunWithEnvCwd):
         cmd =3D ['git', 'update-index', '--remove']
         self.run(cmd + ['-z', '--stdin']
                  ).input_nulterm(paths).discard_output()
+    def worktree_clean(self):
+        """Check whether the worktree is clean relative and no updates=
 or
+        merges are needed."""
+        try:
+            self.run(['git', 'update-index', '--refresh']).discard_out=
put()
+        except run.RunException:
+            return False
+        else:
+            return True

 class Branch(object):
     """Represents a Git branch."""
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 54de127..8abf296 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -183,13 +183,22 @@ class StackTransaction(object):
             self.__checkout(self.__stack.head.data.tree, iw,
                             allow_bad_head =3D True)
     def run(self, iw =3D None, set_head =3D True, allow_bad_head =3D F=
alse,
-            print_current_patch =3D True):
+            print_current_patch =3D True, check_clean =3D False):
         """Execute the transaction. Will either succeed, or fail (with=
 an
         exception) and do nothing."""
         self.__check_consistency()
         log.log_external_mods(self.__stack)
         new_head =3D self.head

+        # Check for not clean index and worktree
+        if check_clean and iw:
+            if not iw.worktree_clean():
+                self.__halt('Repository not clean. Use "refresh" or '
+                            '"status --reset"')
+            elif not iw.index.is_clean()):
+                self.__halt('Index and HEAD different. Use "repair" to=
 '
+                            'recover additional commits')
+
         # Set branch head.
         if set_head:
             if iw:


Thanks.

--=20
Catalin
