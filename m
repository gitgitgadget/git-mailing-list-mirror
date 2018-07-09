Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D054C1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeGITQK (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:16:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:52402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932813AbeGITQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:16:09 -0400
Received: (qmail 792 invoked by uid 109); 9 Jul 2018 19:16:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Jul 2018 19:16:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14633 invoked by uid 111); 9 Jul 2018 19:16:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 15:16:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 15:16:07 -0400
Date:   Mon, 9 Jul 2018 15:16:07 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git cherry-pick does not complain about unknown options
Message-ID: <20180709191607.GA9852@sigill.intra.peff.net>
References: <33d3e45b-1245-9e2f-42ea-a654a593bf10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33d3e45b-1245-9e2f-42ea-a654a593bf10@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 04:16:16PM +0200, Andrei Rybak wrote:

> I was trying to cherry pick commits, while simultaneously changing the
> author.  Unfortunately, cherry-pick doesn't have the same --author
> option as git-commit.  However, instead of complaining about unknown
> option:

Yeah, its "--author" option is interpreted by revision.c similar to "log
--author" (because we just pass all unknown options to the traversal
machinery). So you could say:

  git cherry-pick --author=peff v1.0..v2.0

to pick all of my commits between the two versions. I'm not sure if that
would ever be _useful_, but that's how it has behaved since 7e2bfd3f99
(revert: allow cherry-picking more than one commit, 2010-06-02), I
think.

I agree that having something similar to commit's "--author" (or even
just "--reset-author") would be useful. When I've had to do this before,
I usually just cherry-pick and then follow-up with "commit --amend
--author" (or use "rebase -i" if there are several commits). You can
also do "cherry-pick -n $commit" followed by "commit -c $commit".

> All commits in tests existed in repository:
> 
>     $ git cherry-pick --author='TEST' <one-commit> # case 1
>     error: BUG: expected exactly one commit from walk
>     fatal: cherry-pick failed
>     $ echo $?
>     128

I think it's reasonable for this to issue an error. But a BUG is
definitely wrong. The error is more like "empty commit set passed",
which is what we get for something like:

  $ git cherry-pick HEAD..HEAD
  error: empty commit set passed
  fatal: cherry-pick failed

that triggers the revision walker but has no positive commits. But we
don't trigger that code because the single-rev case has some magic to
allow a cherry-pick during another sequencer operation.

So I think that BUG message needs to be softened.

>     $ git cherry-pick --author='TEST' <commit1> <commit2>  # case 2
>     $ echo $?
>     0

And here we come up with an empty set, but we don't flag it as an error
at all. I could even accept that philosophically as "empty input,
nothing to do", but we clearly do flag it as an error in the case I
showed above.

I think the problem is that we catch the error in
sequencer.c:prepare_revs(), after prepare_revision_walk() returns no
commits. But we _do_ have a starting commit for this case, and it's not
culled until we actually ask get_revisions() to start walking.

I think we'd want something like this:

diff --git a/sequencer.c b/sequencer.c
index 4034c0461b..b978157399 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1860,8 +1860,6 @@ static int prepare_revs(struct replay_opts *opts)
 	if (prepare_revision_walk(opts->revs))
 		return error(_("revision walk setup failed"));
 
-	if (!opts->revs->commits)
-		return error(_("empty commit set passed"));
 	return 0;
 }
 
@@ -2314,6 +2312,10 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 			short_commit_name(commit), subject_len, subject);
 		unuse_commit_buffer(commit, commit_buffer);
 	}
+
+	if (!todo_list->nr)
+		return error(_("empty commit set passed"));
+
 	return 0;
 }
 

-Peff
