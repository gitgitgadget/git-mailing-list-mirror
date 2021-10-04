Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E13C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B4261222
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJDJZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 05:25:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:60280 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhJDJZe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 05:25:34 -0400
Received: (qmail 8863 invoked by uid 109); 4 Oct 2021 09:23:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 09:23:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12535 invoked by uid 111); 4 Oct 2021 09:23:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 05:23:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 05:23:44 -0400
From:   Jeff King <peff@peff.net>
To:     some-java-user-99206970363698485155@vodafonemail.de
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Bug: Failed checkout causes index to be in incorrect state
Message-ID: <YVrIIBSG7BF1Pyy5@coredump.intra.peff.net>
References: <07ae9b61a42346a0b49744586d4496bd@vodafonemail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07ae9b61a42346a0b49744586d4496bd@vodafonemail.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 02, 2021 at 10:41:32PM +0200, some-java-user-99206970363698485155@vodafonemail.de wrote:

> ## Description
> When Git fails to check out files (during `git clone`) the index seems to be in an incomplete state afterwards.
> The files which could not be checked out are erroneously staged as "deleted", and files which were checked out
> successfully are marked as untracked. This renders the suggested `git restore --source=HEAD :/` command to retry
> the checkout ineffective.

Hmm. I guess I'm not too surprised that we might leave things in an
inconsistent state, but I'm having trouble getting the same outcome on
Linux.

If I clone a repo with a very long file name, I do indeed get a failure.
But there is no index written at all, nor any files checked out. So all
file are marked as to-be-deleted in the index (compared to the HEAD
commit), but nothing is untracked, nor are there differences between the
index and working tree.

My reproduction is:

	git init repo
	cd repo

	echo before >0
	echo after >2
	git add .
	git update-index --index-info <<-EOF
	100644 $(git rev-parse :0)	1-$(perl -e 'print "a" x 5000')
	EOF
	git commit -qm whatever

	git clone --no-local . foo.git
	cd foo.git
	git status | cut -c -60

where the final status yields (note the intentional truncation on the
filename):

  On branch main
  Your branch is up to date with 'origin/main'.
  
  Changes to be committed:
  	deleted:    0
  	deleted:    1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  	deleted:    2

One interesting thing is that my error during clone is:

  error: cannot stat '1-aaaaaaaaaaa...

which happens before we even start putting things into the filesystem.
Whereas in the sample output you linked, Dscho had:

  error: unable to create file...

followed by more "Unpacking objects".

So there seems to be some difference in how the checkout occurs. The
backtrace for my error is:

  #0  error_errno (fmt=0x5555558bcf02 "cannot stat '%s'") at usage.c:220
  #1  0x0000555555804950 in verify_absent_1 (ce=0x7ffff7390098, error_type=ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, 
      o=0x7fffffffdba0) at unpack-trees.c:2249
  #2  0x0000555555804a56 in verify_absent (ce=0x7ffff7390098, error_type=ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, 
      o=0x7fffffffdba0) at unpack-trees.c:2268
  #3  0x0000555555804af8 in merged_entry (ce=0x5555559a8ae0, old=0x0, o=0x7fffffffdba0) at unpack-trees.c:2301
  #4  0x0000555555805a50 in oneway_merge (src=0x7fffffffd450, o=0x7fffffffdba0) at unpack-trees.c:2701
  #5  0x0000555555800896 in call_unpack_fn (src=0x7fffffffd450, o=0x7fffffffdba0) at unpack-trees.c:582
  #6  0x0000555555801f04 in unpack_single_entry (n=1, mask=1, dirmask=0, src=0x7fffffffd450, names=0x7fffffffd790, 
      info=0x7fffffffd9e0) at unpack-trees.c:1132
  #7  0x00005555558028c0 in unpack_callback (n=1, mask=1, dirmask=0, names=0x7fffffffd790, info=0x7fffffffd9e0)
      at unpack-trees.c:1404
  #8  0x00005555557fd0d5 in traverse_trees (istate=0x55555596f0e0 <the_index>, n=1, t=0x7fffffffdb50, 
      info=0x7fffffffd9e0) at tree-walk.c:532
  #9  0x0000555555803654 in unpack_trees (len=1, t=0x7fffffffdb50, o=0x7fffffffdba0) at unpack-trees.c:1784
  #10 0x0000555555599a7e in checkout (submodule_progress=1) at builtin/clone.c:699
  #11 0x000055555559b56a in cmd_clone (argc=2, argv=0x7fffffffe4f0, prefix=0x0) at builtin/clone.c:1299

I wonder why we get further than that on Windows. If I hack
verify_absent_1() to treat this as success, I do get "unable to create"
message later, along with some checked-out files. My status output is:

  On branch main
  Your branch is up to date with 'origin/main'.
  
  Changes to be committed:
  	deleted:    0
  	deleted:    1-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  	deleted:    2
  
  Untracked files:
  	0
  	2

We did not create the index at all, so comparing to HEAD, _every_ file
appears to be deleted. And likewise comparing to the working tree,
anything we did create is untracked.

I think it would probably be nicer if we wrote out the index in this
case, if there were no problems creating the index itself, and just in
the actual file-checkout stage. unpack_trees() tries to make this
distinction, but we don't pay any attention. So perhaps something like:

diff --git a/builtin/clone.c b/builtin/clone.c
index ff1d3d447a..84dca96dad 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -696,14 +696,27 @@ static int checkout(int submodule_progress)
 	tree = parse_tree_indirect(&oid);
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
-	if (unpack_trees(1, &t, &opts) < 0)
-		die(_("unable to checkout working tree"));
+	switch (unpack_trees(1, &t, &opts)) {
+	case 0: break;
+	case -2:
+		/*
+		 * failed to checkout; install index so that tools like
+		 * git-status give sensible results, but die below.
+		 */
+		err = -1;
+		break;
+	default:
+		die(_("unable to create index"));
+	}
 
 	free(head);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
+	if (err)
+		die(_("unable to checkout working tree"));
+
 	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
 			   oid_to_hex(&oid), "1", NULL);
 

would help. But the outcome from git-status is weird. Because the long
name chokes stat(), it doesn't report it as a change, even though the
file is missing! This seems like a bug on the reading side.

I'm also still puzzled at the fact that on Linux we barf in
verify_absent(), but somehow don't on Windows.

-Peff
