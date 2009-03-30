From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Mon, 30 Mar 2009 17:01:12 +0100
Message-ID: <b0943d9e0903300901i469bd899v3518b43c331bd9df@mail.gmail.com>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com>
	 <20090323084507.GA6447@diana.vm.bytemark.co.uk>
	 <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com>
	 <20090324131640.GB4040@diana.vm.bytemark.co.uk>
	 <b0943d9e0903240840m3f22b702qd48293caad4187e3@mail.gmail.com>
	 <20090325090541.GA24889@diana.vm.bytemark.co.uk>
	 <b0943d9e0903250324j9ed0ed9k2d97cbacba6a7801@mail.gmail.com>
	 <20090326111554.GA19337@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:06:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJwm-0006af-Ga
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbZC3QBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbZC3QBQ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 12:01:16 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:42268 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZC3QBP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 12:01:15 -0400
Received: by bwz17 with SMTP id 17so1983687bwz.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PcOClyWFjadu2zjwnUzXVG48qyn7c8Gfy6CHb0n+riI=;
        b=khxezPmeihx4VxxruCRSENk5yw4UZcyD/Or9VvcwT9C2wWni4x4pYf9IVUaxtMoS83
         WWqoAJQa/SifCrkRBCa0GZaBQ7M5h1GjBlkcZT4X85yx6Efs4F879eZLfQWbvBpVsg4+
         +MKlYvWO09UyHWiKC60lWDXF9N00IeB+HvxEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WCDw5iKRWcCv4tEkenxXGdaxZ9bQk497IGVC8FTjDDBUHQuqWw3jnX2GHGriYw01pM
         a4F0LbHpM+9TMzqRWdEODfKKJzPxGKrg9T1fcZ64SdpHMy5DT7TeeNLsuDuhU4QNfNgx
         EkFDHxhzv0AmTbpzpzXjtQHqyf4KmDFaa6Vi4=
Received: by 10.204.62.135 with SMTP id x7mr2009107bkh.124.1238428872702; Mon, 
	30 Mar 2009 09:01:12 -0700 (PDT)
In-Reply-To: <20090326111554.GA19337@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115169>

2009/3/26 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-25 10:24:13 +0000, Catalin Marinas wrote:
>
>> BTW, why don't we keep the tree information directly in the Index
>> object? Since this object is modified only via its own interface, it
>> can do all the checks and avoid the managing of temp_index_tree in
>> the Transaction object.
>
> I guess that might be a good idea -- it should be doable without any
> extra overhead for users that don't want it.

I tried but gave up quickly. The IndexAndWorktree class also dirties
the Index with the merge operations, so it is not worth the hassle.

That's the updated patch:

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
index b146648..4148ff3 100644
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
@@ -379,3 +386,25 @@ class StackTransaction(object):
         assert set(self.unapplied + self.hidden) =3D=3D set(unapplied =
+ hidden)
         self.unapplied =3D unapplied
         self.hidden =3D hidden
+
+    def check_merged(self, patches):
+        """Return a subset of patches already merged."""
+        merged =3D []
+        if self.temp_index_tree !=3D self.stack.head.data.tree:
+            self.temp_index.read_tree(self.stack.head.data.tree)
+            self.temp_index_tree =3D self.stack.head.data.tree
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
+                # The self.temp_index was modified by apply_treediff()=
 so
+                # force read_tree() the next time merge() is used.
+                self.temp_index_tree =3D None
+            except git.MergeException:
+                pass
+        return merged


--=20
Catalin
