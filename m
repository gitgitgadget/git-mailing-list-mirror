From: Jeff King <peff@peff.net>
Subject: Re: Possible regression: overwriting untracked files in a fresh
 repo
Date: Mon, 24 Aug 2009 23:03:16 -0400
Message-ID: <20090825030316.GA8098@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0908241829510.11375@intel-tinevez-2-302>
 <20090824190710.GB25168@coredump.intra.peff.net>
 <7vab1o3ikz.fsf@alter.siamese.dyndns.org>
 <20090825013601.GA3515@coredump.intra.peff.net>
 <7vk50sve00.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 05:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfmJh-0006wC-L3
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 05:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbZHYDDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 23:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbZHYDDQ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 23:03:16 -0400
Received: from peff.net ([208.65.91.99]:51650 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286AbZHYDDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 23:03:16 -0400
Received: (qmail 13386 invoked by uid 107); 25 Aug 2009 03:03:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 Aug 2009 23:03:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2009 23:03:16 -0400
Content-Disposition: inline
In-Reply-To: <7vk50sve00.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126993>

On Mon, Aug 24, 2009 at 07:11:43PM -0700, Junio C Hamano wrote:

> This looks a lot saner; I like it.  Care to wrap it up with the usual
> supporting material?

Patch is below. I did a little digging to see the origin of the
current behavior. It looks like invoking "force" was probably the
easiest way to make the shell version work, and then the behavior just
got ported to C (see below for details).

> I think the "You appear to be" can just go, but I do not feel very
> strongly either way.

I don't feel strongly, either. I couldn't think of a reason a user would
care, and it is potentially confusing to new users (though most will
simply clone and never see it), so I ripped it out.

And now you can try your new scissors patch. ;)

-- >8 --
Subject: [PATCH] checkout: do not imply "-f" on unborn branches

When checkout sees that HEAD points to a non-existent ref,
it currently acts as if "-f" was given; this behavior dates
back to 5a03e7f, which enabled checkout from unborn branches
in the shell version of "git-checkout". The reasoning given
is to avoid the code path which tries to merge the tree
contents. When checkout was converted to C, this code
remained intact.

The unfortunate side effect of this strategy is that the
"force" code path will overwrite working tree and index
state that may be precious to the user. Instead of enabling
"force", this patch uses the normal "merge" codepath for an
unborn branch, but substitutes the empty tree for the "old"
commit.

This means that in the absence of an index, any files in the
working tree will be treated as untracked files, and a
checkout which would overwrite them is aborted. Similarly,
any paths in the index will be merged with an empty entry
as the base, meaning that unless the new branch's content is
identical to what's in the index, there will be a conflict
and the checkout will be aborted.

The user is then free to correct the situation or proceed
with "-f" as appropriate.

This patch also removes the "warning: you are on a branch
yet to be born" message. Its function was to warn the user
that we were enabling the "-f" option. Since we are no
longer doing that, there is no reason for the user to care
whether we are switching away from an unborn branch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-checkout.c         |   12 +++---------
 t/t2015-checkout-unborn.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 9 deletions(-)
 create mode 100755 t/t2015-checkout-unborn.sh

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 8a9a474..c6d6ac9 100644
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
@@ -541,14 +543,6 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 		parse_commit(new->commit);
 	}
 
-	if (!old.commit && !opts->force) {
-		if (!opts->quiet) {
-			warning("You appear to be on a branch yet to be born.");
-			warning("Forcing checkout of %s.", new->name);
-		}
-		opts->force = 1;
-	}
-
 	ret = merge_working_tree(opts, &old, new);
 	if (ret)
 		return ret;
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
new file mode 100755
index 0000000..c551d39
--- /dev/null
+++ b/t/t2015-checkout-unborn.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='checkout from unborn branch protects contents'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir parent &&
+	(cd parent &&
+	 git init &&
+	 echo content >file &&
+	 git add file &&
+	 git commit -m base
+	) &&
+	git fetch parent master:origin
+'
+
+test_expect_success 'checkout from unborn preserves untracked files' '
+	echo precious >expect &&
+	echo precious >file &&
+	test_must_fail git checkout -b new origin &&
+	test_cmp expect file
+'
+
+test_expect_success 'checkout from unborn preserves index contents' '
+	echo precious >expect &&
+	echo precious >file &&
+	git add file &&
+	test_must_fail git checkout -b new origin &&
+	test_cmp expect file &&
+	git show :file >file &&
+	test_cmp expect file
+'
+
+test_expect_success 'checkout from unborn merges identical index contents' '
+	echo content >file &&
+	git add file &&
+	git checkout -b new origin
+'
+
+test_done
-- 
1.6.4.1.330.g14cea.dirty
