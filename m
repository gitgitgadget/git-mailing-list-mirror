Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE84C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9446120A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 11:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhKEL4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 07:56:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:53810 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231852AbhKEL4T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 07:56:19 -0400
Received: (qmail 11515 invoked by uid 109); 5 Nov 2021 11:53:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 11:53:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17994 invoked by uid 111); 5 Nov 2021 11:53:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 07:53:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 07:53:38 -0400
From:   Jeff King <peff@peff.net>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v2] fetch: Protect branches checked out in all worktrees
Message-ID: <YYUbQqyYQDD5QEAz@coredump.intra.peff.net>
References: <9dfca5ec-4426-d3d4-988e-b81ebb087584@mit.edu>
 <alpine.DEB.2.21.999.2111041709080.94135@tardis-on-the-dome.mit.edu>
 <YYTtdZblnHYgDgBq@coredump.intra.peff.net>
 <991240f7-2a3e-8ae7-ae25-a1d9d96d55d4@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <991240f7-2a3e-8ae7-ae25-a1d9d96d55d4@mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 03:01:39AM -0700, Anders Kaseorg wrote:

> On 11/5/21 01:38, Jeff King wrote:
> > If we get the non-default worktree here, it might be nice to tell the
> > user which worktree has it checked out. Otherwise it may lead to
> > head-scratching as they peek at their current HEAD.
> 
> I’d agree if this case were reachable, but as per below, it seems not to be.
> So I didn’t bother figuring out how to shoehorn such a message into the
> arguments expected by format_display().

I was thinking of just:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a6549c2ab6..61c8fc9983 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -855,6 +855,7 @@ static int update_local_ref(struct ref *ref,
 			    int summary_width)
 {
 	struct commit *current = NULL, *updated;
+	const struct worktree *wt;
 	const char *pretty_ref = prettify_refname(ref->name);
 	int fast_forward = 0;
 
@@ -869,14 +870,16 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (!update_head_ok &&
-	    find_shared_symref("HEAD", ref->name) &&
+	    (wt = find_shared_symref("HEAD", ref->name)) &&
 	    !is_null_oid(&ref->old_oid)) {
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
 		format_display(display, '!', _("[rejected]"),
-			       _("can't fetch in current branch"),
+			       wt->is_current ?
+			       _("can't fetch in current branch") :
+			       _("branch checked out in worktree"),
 			       remote, pretty_ref, summary_width);
 		return 1;
 	}

though of course that does not mention the working tree we found. We'd
probably have to format the string into an extra strbuf for that. But I
agree, that if we don't think this is reachable, it may not be worth
worrying about. But see below, where I get off on a bit of tangent.

> > So if the earlier hunk covered this case, then what is this hunk for? :)
> 
> Yeah, that duplication confused me too. The relevant call paths seem to be:
> 
> 1. do_fetch calls check_not_current_branch (later hunk);
> 2. do_fetch calls fetch_and_consume_refs → store_updated_refs →
> update_local_ref (earlier hunk);
> 3. do_fetch calls backfill_tags → fetch_and_consume_refs →
> store_updated_refs → update_local_ref (earlier hunk);
> 
> in that order. That suggests there should be no way to trip the earlier
> hunk’s check without first tripping the latter hunk’s check.

That matches what I found. I think that the check in update_local_ref()
became obsolete when we added check_not_current_branch() in 8ee5d73137
(Fix fetch/pull when run without --update-head-ok, 2008-10-13). That
commit confused me at first, because there's no mention of the existing
mechanism at all in the commit message nor the mailing list thread.

But it was indeed broken back then, and I think is even broken now! The
problem is that it was comparing against current_branch->name, which is
not the full refname, and thus would never match. The check added in
8ee5d73137 gets this right.

Your patch also ends up fixing this as a side effect, because it
switches to using find_shared_symref(), which eliminates the buggy code.

But all of that means we could actually drop check_not_current_branch()
in favor of the update_local_ref() check. Doing this:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..c52c44684a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -869,7 +869,7 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (current_branch &&
-	    !strcmp(ref->name, current_branch->name) &&
+	    !strcmp(ref->name, current_branch->refname) &&
 	    !(update_head_ok || is_bare_repository()) &&
 	    !is_null_oid(&ref->old_oid)) {
 		/*
@@ -1385,20 +1385,6 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
 	return result;
 }
 
-static void check_not_current_branch(struct ref *ref_map)
-{
-	struct branch *current_branch = branch_get(NULL);
-
-	if (is_bare_repository() || !current_branch)
-		return;
-
-	for (; ref_map; ref_map = ref_map->next)
-		if (ref_map->peer_ref && !strcmp(current_branch->refname,
-					ref_map->peer_ref->name))
-			die(_("Refusing to fetch into current branch %s "
-			    "of non-bare repository"), current_branch->refname);
-}
-
 static int truncate_fetch_head(void)
 {
 	const char *filename = git_path_fetch_head(the_repository);
@@ -1587,8 +1573,6 @@ static int do_fetch(struct transport *transport,
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
-	if (!update_head_ok)
-		check_not_current_branch(ref_map);
 
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");

passes the entire test suite except for one test which expects:

  git fetch . side:main

to fail. But that is only because "side" and "main" point to the same
commit, and thus the fetch is a noop. The code in update_local_ref()
covers that case before checking the HEAD case (which I would argue is
a completely reasonable outcome).

The reason I bring this up is that I think doing the check in
update_local_ref() makes much more sense. We don't abort the whole
fetch, but just treat it as a normal per-ref failure. That gives us the
usual status-table output (I thought it might also avoid wasting some
work of actually fetching objects, but I think the current check kicks
in before we actually fetch anything).

On the other hand, this is a rare-ish error, and nobody has cared much
about the distinction in the last 13 years. So it probably doesn't
really matter.

Now getting back to your patch and the message produced in the
update_local_ref() check. I am content to say: this code path is not
really reachable, but cleaning it up is out of scope, so let's leave it
for another day. But if we do eventually want to keep just the check in
update_local_ref(), then we might want to improve the message now while
we're thinking about it.

> > It's technically correct, but perhaps it would be nicer to keep the old
> > message if the worktree we found is the current one.
> 
> I note that this new message is more consistent with
> 
> $ git branch -d main
> error: Cannot delete branch 'main' checked out at '/home/anders/tmp'

Yeah, that may be a reason to keep things consistent. My main worry is
just that somebody who is not using worktrees but has a long repo
pathname may find the message a bit more overwhelming. But if we want to
deal with that, we should probably do so everywhere.

> While looking for other related messages, I noticed another bug:
> receive-pack doesn’t stop you from updating or deleting a branch checked out
> in a worktree for a bare repository.
> 
> $ git init
> $ git commit --allow-empty -qm foo
> $ git clone --bare . bare.git
> $ git -C bare.git worktree add wt
> $ git -C bare.git/wt push .. :wt
> 
> To ..
> 
>  - [deleted]         wt
> 
> 
> This is_bare_repository() check in update() in builtin/receive-pack.c seems
> wrong:
> 
> const struct worktree *worktree = is_bare_repository() ? NULL :
> find_shared_symref("HEAD", name);

Hmm. That is the same check that is on the fetch side, isn't it? In a
bare repository, we will not do any of these current-branch checks. What
is weird in your example is that you are adding a worktree to a bare
repository. Is that a supported workflow? Should that make it non-bare?

I notice that there is a worktree->is_bare flag, and that
find_shared_symref() would not report such a bare entry to us. But I'm
really unclear how any of that is supposed to work (how do you have a
bare worktree, and what does it mean?).

I think that's all orthogonal to the main purpose of your patch here.
You may want to post about it separately with a different subject to get
the attention of folks who work on worktrees.

-Peff
