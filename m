From: Jeff King <peff@peff.net>
Subject: Re: Possible regression: overwriting untracked files in a fresh
 repo
Date: Mon, 24 Aug 2009 21:36:01 -0400
Message-ID: <20090825013601.GA3515@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
 <20090824190710.GB25168@coredump.intra.peff.net>
 <7vab1o3ikz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 03:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfkyn-0006QS-3n
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 03:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbZHYBgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 21:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZHYBgE
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 21:36:04 -0400
Received: from peff.net ([208.65.91.99]:44663 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778AbZHYBgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 21:36:03 -0400
Received: (qmail 12866 invoked by uid 107); 25 Aug 2009 01:36:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 Aug 2009 21:36:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2009 21:36:01 -0400
Content-Disposition: inline
In-Reply-To: <7vab1o3ikz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126986>

On Mon, Aug 24, 2009 at 04:20:12PM -0700, Junio C Hamano wrote:

> I do not think that this is the correct fix, but it should be a good start
> for other people to take a look at the issue.  With this change, any
> leftover work tree files will remain, but it has an interesting effect.
> 
>     $ git checkout maint
>     $ echo 'ref: refs/heads/nosuch' >.git/HEAD
>     $ git checkout -b foo master
> 
> You will notice that the index matches master (as expected), but the work
> tree mostly matches maint.  Knowing what these files are (i.e. "these are
> git.git source files that match 'maint' branch, and are vastly behind what
> are in 'master' branch we are switching to"), this result is utterly
> counterintuitive and feels wrong, but if you consider a case like what
> Dscho brought up originally in the thread of having a freshly initialized
> empty repository with some uncommitted files, totally unrelated to what
> you are checking out, I think you could argue that it is the right thing.

I don't think this is the right thing to do. We have _no_ current
branch, which means that everything in the working tree can be
considered untracked (and therefore precious). So I think the right
thing to do is barf and say "this untracked file would be overwritten".
The user can sort it out as appropriate, either deleting files that are
in the way, or using "-f" themselves (after they make the decision that
what they have can be overwritten).

Something like the patch below seems to work on the test case I posted
earlier, and passes the test suite (but other than that, I am very
unconfident, never having really looked at the checkout code before).

As an aside, if an unborn branch stops implying "-f", should we bother
even mentioning it? It seems superfluous now.

---
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 8a9a474..1f2f84d 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -402,7 +402,9 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir = ".gitignore";
-		tree = parse_tree_indirect(old->commit->object.sha1);
+		tree = parse_tree_indirect(old->commit ?
+					   old->commit->object.sha1 :
+					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		tree = parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
@@ -541,13 +543,8 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 		parse_commit(new->commit);
 	}
 
-	if (!old.commit && !opts->force) {
-		if (!opts->quiet) {
-			warning("You appear to be on a branch yet to be born.");
-			warning("Forcing checkout of %s.", new->name);
-		}
-		opts->force = 1;
-	}
+	if (!old.commit && !opts->force && !opts->quiet)
+		warning("You appear to be on a branch yet to be born.");
 
 	ret = merge_working_tree(opts, &old, new);
 	if (ret)
