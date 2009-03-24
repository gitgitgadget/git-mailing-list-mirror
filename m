From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Tue, 24 Mar 2009 15:40:10 +0000
Message-ID: <b0943d9e0903240840m3f22b702qd48293caad4187e3@mail.gmail.com>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com>
	 <20090323084507.GA6447@diana.vm.bytemark.co.uk>
	 <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com>
	 <20090324131640.GB4040@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 16:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm8lx-0006XP-SS
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 16:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757579AbZCXPkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 11:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbZCXPkQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 11:40:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:30893 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbZCXPkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 11:40:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1038300fkq.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QolTaPdGp1qh4VZRV9pUB/nU5/mHmucRShRJRRzC3HY=;
        b=hojGv3x3HAhVITbWe6znr+2s1PQruJSUs2KrpmfWbieVYnWIVqo+RB5arTrJcBjzhP
         FDaxfb+w7Vn9j89EDW8X3LvWiBo/jUr9dDknTYb2wzZpC7Cr5cMN4yqeJPNhbXMvua1M
         YzXZL1PbD0jZmaCw5KUQUQrEziDA5aROCUlT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DbxwzaYyk+8svYwdEuH1uZlvmP8LF7DtSNcbhqP2W/ZPGxYTABQCBo35vbr9XNkRhV
         RJl22b0dP0haKsBzlJUkOjPjSlG51Nn4U0ecrOaszvQO8mlQLXw9SyFd6wV89gLWGfvx
         hgZTyStZsJjBzYwi2MvNlTYkI1KdMXntTdA9Q=
Received: by 10.204.58.9 with SMTP id e9mr2966238bkh.23.1237909210390; Tue, 24 
	Mar 2009 08:40:10 -0700 (PDT)
In-Reply-To: <20090324131640.GB4040@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114467>

2009/3/24 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-23 16:33:04 +0000, Catalin Marinas wrote:
>> Now I understand it better :-). Reading my explanation above, it
>> seems that only the T1..T2 case matters and it can be taken care of
>> in the check_merged() function. Checking whether the tree returned
>> by merge() is different than "ours" should be enough for all the
>> above cases.
>
> Hmm. If the tip of the branch is T1, and we reverse-apply the patch
> T1..T2, we get the merge (base T2, ours T1, theirs T1) ... yeah, I se=
e
> what you mean. The problem isn't that we give T1 as the result of thi=
s
> merge -- that's actually the right thing to do -- the problem is that
> you don't actually want a merge. What you want is patch application.
> Maybe the apply_treediff method would do?

Yes, see below for an updated patch.

>> I had the impression that an Index object would hold some state and
>> didn't want to break it. It seems OK to use as long as I don't touch
>> self.temp_index_tree. See below for an updated patch:
>
> Yes, an Index object owns a git index file.
>
> And no, not quite. temp_index_tree is set to the tree we know is
> stored in temp_index right now (or None if we don't know). The idea i=
s
> that we'll often want to read a tree into the index that's already
> there, and by keeping track of this we'll get better performance.
> (This works very well in practice.) Apologies if there aren't comment=
s
> explaining this ... the merge method has some docs on the subject.

I figured this out eventually. Anyway, with apply_treedif() there is
no need for the temp_index_tree. In the updated patch below, I don't
even call write_tree() as it isn't needed (to my understanding).
Whatever is in the index after the check_merged() function doesn't
correspond to any tree so it would need to be re-read.

BTW, I implemented push and pop and it now passes all the "push
--merged" tests. I had to correct the "already_merged" case in
Transaction.push_patch() to generate an empty patch.

    Add the --merged option to goto

    This patch adds support for checking which patches were already mer=
ged
    upstream. This checking is done by trying to reverse-apply the patc=
hes
    in the index before pushing them onto the stack.

    Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

diff --git a/stgit/argparse.py b/stgit/argparse.py
index 85ee6e3..765579c 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -225,6 +225,10 @@ def keep_option():
                 short =3D 'Keep the local changes',
                 default =3D config.get('stgit.autokeep') =3D=3D 'yes')=
]

+def merged_option():
+    return [opt('-m', '--merged', action =3D 'store_true',
+                short =3D 'Check for patches merged upstream')]
+
 class CompgenBase(object):
     def actions(self, var): return set()
     def words(self, var): return set()
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 66f49df..839b75c 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -28,7 +28,7 @@ Push/pop patches to/from the stack until the one
given on the command
 line becomes current."""

 args =3D [argparse.other_applied_patches, argparse.unapplied_patches]
-options =3D argparse.keep_option()
+options =3D argparse.keep_option() + argparse.merged_option()

 directory =3D common.DirectoryHasRepositoryLib()

@@ -47,8 +47,14 @@ def func(parser, options, args):
         assert not trans.pop_patches(lambda pn: pn in to_pop)
     elif patch in trans.unapplied:
         try:
-            for pn in trans.unapplied[:trans.unapplied.index(patch)+1]=
:
-                trans.push_patch(pn, iw, allow_interactive =3D True)
+            to_push =3D trans.unapplied[:trans.unapplied.index(patch)+=
1]
+            if options.merged:
+                merged =3D set(trans.check_merged(to_push))
+            else:
+                merged =3D set()
+            for pn in to_push:
+                trans.push_patch(pn, iw, allow_interactive =3D True,
+                                 already_merged =3D pn in merged)
         except transaction.TransactionHalted:
             pass
     elif patch in trans.hidden:
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index b146648..e2d9b78 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -297,7 +297,8 @@ class StackTransaction(object):
                     out.info('Deleted %s%s' % (pn, s))
         return popped

-    def push_patch(self, pn, iw =3D None, allow_interactive =3D False)=
:
+    def push_patch(self, pn, iw =3D None, allow_interactive =3D False,
+                   already_merged =3D False):
         """Attempt to push the named patch. If this results in conflic=
ts,
         halts the transaction. If index+worktree are given, spill any
         conflicts to them."""
@@ -305,11 +306,15 @@ class StackTransaction(object):
         cd =3D orig_cd.set_committer(None)
         oldparent =3D cd.parent
         cd =3D cd.set_parent(self.top)
-        base =3D oldparent.data.tree
-        ours =3D cd.parent.data.tree
-        theirs =3D cd.tree
-        tree, self.temp_index_tree =3D self.temp_index.merge(
-            base, ours, theirs, self.temp_index_tree)
+        if already_merged:
+            # the resulting patch is empty
+            tree =3D cd.parent.data.tree
+        else:
+            base =3D oldparent.data.tree
+            ours =3D cd.parent.data.tree
+            theirs =3D cd.tree
+            tree, self.temp_index_tree =3D self.temp_index.merge(
+                base, ours, theirs, self.temp_index_tree)
         s =3D ''
         merge_conflict =3D False
         if not tree:
@@ -341,7 +346,9 @@ class StackTransaction(object):
         else:
             comm =3D None
             s =3D ' (unmodified)'
-        if not merge_conflict and cd.is_nochange():
+        if already_merged:
+            s =3D ' (merged)'
+        elif not merge_conflict and cd.is_nochange():
             s =3D ' (empty)'
         out.info('Pushed %s%s' % (pn, s))
         def update():
@@ -379,3 +386,23 @@ class StackTransaction(object):
         assert set(self.unapplied + self.hidden) =3D=3D set(unapplied =
+ hidden)
         self.unapplied =3D unapplied
         self.hidden =3D hidden
+
+    def check_merged(self, patches):
+        """Return a subset of patches already merged."""
+        merged =3D []
+        self.temp_index.read_tree(self.stack.head.data.tree)
+        # The self.temp_index is modified by apply_treediff() so force
+        # read_tree() the next time merge() is used.
+        self.temp_index_tree =3D None
+        for pn in reversed(patches):
+            # check whether patch changes can be reversed in the curre=
nt index
+            cd =3D self.patches[pn].data
+            if cd.is_nochange():
+                continue
+            try:
+                self.temp_index.apply_treediff(cd.tree, cd.parent.data=
=2Etree,
+                                               quiet =3D True)
+                merged.append(pn)
+            except git.MergeException:
+                pass
+        return merged



Thanks.

--=20
Catalin
