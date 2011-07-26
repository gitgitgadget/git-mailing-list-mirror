From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Tue, 26 Jul 2011 17:46:54 +0600
Message-ID: <CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
	<CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 13:47:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlg6P-0006Gz-Og
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 13:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab1GZLrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 07:47:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62562 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab1GZLqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 07:46:55 -0400
Received: by qwk3 with SMTP id 3so154167qwk.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NYn1edVYU7xmFsFkgPCLzfLmeCjmdDts+FTBHzANddo=;
        b=erKCMP4X8jg7YfOCStpW9q+gwFD9MvVvr1++600VUO/6ftcDEQCZe3MJZ3GBotxZDX
         kkP2fqnEVK/Ey1PmFFXVzav85/A2cmCEyQ05AEGGw+bSxpZtFNJGiOQzzKluFyuYH9z0
         Qk9A55KeVArx/32j7sUcUcSVispAwWZ6iWJwI=
Received: by 10.229.101.143 with SMTP id c15mr4344301qco.36.1311680814893;
 Tue, 26 Jul 2011 04:46:54 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Tue, 26 Jul 2011 04:46:54 -0700 (PDT)
In-Reply-To: <CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177860>

Hi,

I've found where the bug comes from, but not yet understand the delta
logic in fast-import.c enough to fix it properly or to create a small testcase.
The problem is with delta coding a tree change, e->versions[0].sha1 and
e->tree->..->versions[0].sha1 diverge, the former corresponds to an older
state. When doing delta coding  we call mktree(t, 0, oldtree) that reads from
our in-memory e->tree structure, get the correct delta with the produced, the
data sha1 is also correct, but e->versions[0].sha1 is written to the packfile
as a delta base and it is wrong. When this object is unpacked by git delta
is applied to wrong base and hence the sha1 mismatch.

1) Do we need to delta code trees?
2) Was it supposed to work, or only blob deltas were meant to work?
3) Is this breakage specific to tags/v1.7.3-rc0~75^2 "Teach
fast-import to import subtrees named by tree id" 30 Jun 2010 (allowing
M 040000 <tree id> pathname)?

The simple fix is not to delta-code tree in store_tree():

diff --git a/fast-import.c b/fast-import.c
index 9e8d186..129f1c7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1425,8 +1425,6 @@ static void store_tree(struct tree_entry *root)
 {
        struct tree_content *t = root->tree;
        unsigned int i, j, del;
-       struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
-       struct object_entry *le;

        if (!is_null_sha1(root->versions[1].sha1))
                return;
@@ -1436,18 +1434,10 @@ static void store_tree(struct tree_entry *root)
                        store_tree(t->entries[i]);
        }

-       le = find_object(root->versions[0].sha1);
-       if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
-               mktree(t, 0, &old_tree);
-               lo.data = old_tree;
-               lo.offset = le->idx.offset;
-               lo.depth = t->delta_depth;
-       }
-
        mktree(t, 1, &new_tree);
-       store_object(OBJ_TREE, &new_tree, &lo, root->versions[1].sha1, 0);
+       store_object(OBJ_TREE, &new_tree, NULL, root->versions[1].sha1, 0);

-       t->delta_depth = lo.depth;
+       t->delta_depth = 0;
        for (i = 0, j = 0, del = 0; i < t->entry_count; i++) {
                struct tree_entry *e = t->entries[i];
                if (e->versions[1].mode) {

The harder fix is to try to keep e->versions[0].sha1 for trees correct.
That looks like that it should match mktree(v=0), and it uses
versions[0].sha1 of child entries. Once a version[0].sha1 changes all
parents should clear their versions[0].sha1 (is it right?). And also in
load_tree(), child entries versions[0].sha1 should be set (its it right?)
from parent base object. No patch for this case.

Assuming that trees delta coding breaks only when we do
M 040000 sha1 some/path
and only that tree's data gets invalid, we can do this patch:

diff --git a/fast-import.c b/fast-import.c
index 9e8d186..85c711c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1514,6 +1514,9 @@ static int tree_content_set(
                                if (e->tree)
                                        release_tree_content_recursive(e->tree);
                                e->tree = subtree;
+                               if (S_ISDIR(mode)) {
+                                       hashclr(e->versions[0].sha1);
+                               }
                                hashclr(root->versions[1].sha1);
                                return 1;
                        }

Both patches seem to fix the bug, at least on one large testcase I'm testing it.
But first of all a small test is needed, it looks very likely that
there exists one.
And then, of course, a proper fix is needed.

I'll leave a short description of the setup for a reference.

> So, how do I currently reproduce it.
> Import gcc svn repository with svn-fe up to r15507 - fine. (1.9G
> fast-import stream, 3min to import, 1min to fsck)
> Import up to r15508 - fine, but fsck finds a sha1 mismatch in a tree object.
> Strip r15508 to a three commands:
>
> ..commit header..
> ls :14842 branches/gcc3/gcc/config
> M 040000 fbc83f80e9516c831918dff149058cba38a2e5f1 tags/egcs_ss_970917/gcc/config
> ls :15459 trunk/gcc/config/alpha
> M 040000 9ffe84c346eec93b523d95ce642b54d54d23109c
> tags/egcs_ss_970917/gcc/config/alpha
> ls "tags/egcs_ss_970917/gcc/config/alpha"
> D tags/egcs_ss_970917/gcc/config/alpha/vms-tramp.asm
>
> So here we set a directory with one old tree, then set it's child with
> another old tree, and then delete a file in the child. The broken tree
> is the resulting tree for that child. sha1 written to the pack matches
> the intent (the second M + D) while the content is wrong (matches the
> first M/subdir + D) - the second M command is partially lost.
