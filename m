From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression: overwriting untracked files in a fresh repo
Date: Mon, 24 Aug 2009 16:20:12 -0700
Message-ID: <7vab1o3ikz.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
 <20090824190710.GB25168@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 01:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfiq5-0003Bf-B7
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 01:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbZHXXU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 19:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZHXXU1
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 19:20:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbZHXXU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 19:20:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76D8F36EDD;
	Mon, 24 Aug 2009 19:20:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ElwRTVCvz15qkFugt4UgkdW8kvQ=; b=Luv1Nw
	OSsyTYLtF/l+a2MfN61ctbF74Q+YWVEkZTEJosJ1eWbiK1RHO7b+3/YeUeBG+ceT
	Yj0l8wkti5DeBUrRRCng0HAjELCiVxRpVh+BOsElTOBn1c42rkS5optxfRLzWf0W
	j8VwCr6uLXWboVTI0Dpepm8Y8eym1o0Ve1IB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uV5bzG3rjWRjZiSLp//iJ5qVFM3daEyh
	FNaAftOmcU7gLCARwYTIMgLhQq0miTvlAJBrYqqaoCG8XUHlTj8K1Y1newrXyNaI
	1aZoXaTdcX9LGujTvHMwuw95I5/NetWVKcZkNtDIBVzbPGfI6WGEbOEusB9aEiKj
	XnBWh7HSARM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CACB36EDC;
	Mon, 24 Aug 2009 19:20:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B54B636EDB; Mon, 24 Aug 2009
 19:20:13 -0400 (EDT)
In-Reply-To: <20090824190710.GB25168@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 24 Aug 2009 15\:07\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B05F89FA-9104-11DE-9821-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126981>

reset_tree() is used from two places in checkout.

 (1) When --force is given, to reset potentially unmerged state away and
     forcibly switch to the destination branch.  We do an equivalent of
     "reset --hard";

 (2) When switching from a dirty work tree using --merge, we first write
     out the current index + any local changes in the work tree as a tree
     object (thus ensuring that the index is merged at this point), and
     then switch forcibly to the new branch by calling the function.

     After switching to the new branch, we merge the difference between
     the old commit and the tree that represents the dirty work tree,
     but then reset the index to the new branch.

The "checking out a real branch from an unborn branch" codepath was
reusing codepath for (1), essentially doing "reset --hard new".  This of
course allows any work tree cruft that gets in the way removed.

The patch changes it not to force, but adds another call style for the
reset_tree() function that does not do the hard reset, and uses it when
you are switching from an unborn branch (or a broken one).

I do not think that this is the correct fix, but it should be a good start
for other people to take a look at the issue.  With this change, any
leftover work tree files will remain, but it has an interesting effect.

    $ git checkout maint
    $ echo 'ref: refs/heads/nosuch' >.git/HEAD
    $ git checkout -b foo master

You will notice that the index matches master (as expected), but the work
tree mostly matches maint.  Knowing what these files are (i.e. "these are
git.git source files that match 'maint' branch, and are vastly behind what
are in 'master' branch we are switching to"), this result is utterly
counterintuitive and feels wrong, but if you consider a case like what
Dscho brought up originally in the thread of having a freshly initialized
empty repository with some uncommitted files, totally unrelated to what
you are checking out, I think you could argue that it is the right thing.

I dunno.

 builtin-checkout.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 8a9a474..2930bd6 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -309,16 +309,17 @@ static void describe_detached_head(char *msg, struct commit *commit)
 	strbuf_release(&sb);
 }
 
-static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
+static int reset_tree(struct tree *tree, struct checkout_opts *o, int flags)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
+	int worktree = !!(flags & 01);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.update = worktree;
 	opts.skip_unmerged = !worktree;
-	opts.reset = 1;
+	opts.reset = !(flags & 02);
 	opts.merge = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = !o->quiet;
@@ -373,6 +374,10 @@ static int merge_working_tree(struct checkout_opts *opts,
 		ret = reset_tree(new->commit->tree, opts, 1);
 		if (ret)
 			return ret;
+	} else if (!old->commit) {
+		ret = reset_tree(new->commit->tree, opts, 2);
+		if (ret)
+			return ret;
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -542,11 +547,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	}
 
 	if (!old.commit && !opts->force) {
-		if (!opts->quiet) {
+		if (!opts->quiet)
 			warning("You appear to be on a branch yet to be born.");
-			warning("Forcing checkout of %s.", new->name);
-		}
-		opts->force = 1;
 	}
 
 	ret = merge_working_tree(opts, &old, new);
