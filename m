Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C36C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 05:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKDFgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 01:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDFgH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 01:36:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F74205F2
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 22:36:05 -0700 (PDT)
Received: (qmail 17422 invoked by uid 109); 4 Nov 2022 05:36:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 05:36:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26191 invoked by uid 111); 4 Nov 2022 05:36:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 01:36:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 01:36:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Martin von Zweigbergk <martinvonz@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] branch: gracefully handle '-d' on orphan HEAD
Message-ID: <Y2SkxJAnjOtwKX6o@coredump.intra.peff.net>
References: <Y2F9lkCWf/2rjT2E@nand.local>
 <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>
 <Y2H/1S3G+KeeEN/l@coredump.intra.peff.net>
 <f21bf37f-4efe-326c-0090-d13ed54696b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f21bf37f-4efe-326c-0090-d13ed54696b9@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 02:26:00AM +0100, Rubén Justo wrote:

> > So instead, we'll teach the local branch_merged() helper to treat a NULL
> > as "not merged". This would be a little more elegant in in_merge_bases()
> > itself, but that function is called in a lot of places, and it's not
> > clear that quietly returning "not merged" is the right thing everywhere
> > (I'd expect in many cases, feeding a NULL is a sign of a bug).
> > 
> > There are four tests here:
> > ...
> I've reviewed the change and looks fine to me.  Fixes the issue with the
> deletion and avoids the segfault you discovered.

Just to make things clear, the segfault doesn't exist before my patch.
It's only once we remove the die() call that we need to make sure the
downstream code does the right thing with the resulting NULL, and does
not segfault.

> But the last paragraph in your message, before describing the tests, makes me
> scratch my head.
> 
> Certainly there are a few dozen places where we have direct calls to
> in_merge_bases.  I haven't found any (beyond the modified in this patch) where
> a NULL commit can be used in the call.  All I have reviewed have a
> check_for_null protection before calling, mainly to show an error message.  And
> this makes me think about, what almost happened here, leaving that uncovered
> left us open to a change where the error condition (NULL commit) doesn't matter
> (just the not_merged), and/or does not have a proper test with generation
> numbers.

I didn't find any instances, either, but I also didn't look. My
reasoning was mostly that by making the change to this code in
isolation, we could be sure not to have accidental effects in other
code. Now it _could_ be useful to handle NULL in those other call-sites,
but I didn't want making a judgement on that to hold up this fix.

> The segfault possibility was introduced in 6cc017431 (commit-reach: use
> can_all_from_reach, 2018-07-20).  Before that, NULL was tolerated by
> is_descendant_of (and indirectly by in_merge_bases) and returned, still today
> (as you described in your message) as 1.  So IMHO we can safely put a check for
> NULL there and return 1, as a fix (or protection) for this segfault.  Something
> like:

Yes, the segfault possibility was introduced there. But that doesn't
mean the code intended to handle a NULL commit in that case. I think it
ends up doing the right thing, but the behavior is a little
questionable. It actually sees an error from repo_parse_commit(), and
then aborts the whole in_merge_bases_many() operation (not even looking
at the other entries in the "reference" array, although in this caller
it will always be the only element of the array).

So I find it too hard to blame 6cc017431 here; I don't think
is_descendant_of() ever intended to handle NULL, and it was just luck
that it did before then.

So a fix there might be OK, but...

> diff --git a/commit-reach.c b/commit-reach.c
> index c226ee3da4..246eaf093d 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -445,7 +445,7 @@ int repo_is_descendant_of(struct repository *r,
>                           struct commit *commit,
>                           struct commit_list *with_commit)
>  {
> -       if (!with_commit)
> +       if (!with_commit || !commit)
>                 return 1;
>  
>         if (generation_numbers_enabled(the_repository)) {
> 
> and leave the checks for NULL in branch.c, as optimizations.

I don't think that does the right thing. We are asking if "commit" is a
descendant of any element in "with_commit". If "with_commit" is empty,
we say "yes" by returning 1.  But if there is no "commit", is the answer
also "yes"? It seems like it should be "no", returning 0.

TBH, I find the existing "return 1" questionable. It comes originally
from 694a577519 (git-branch --contains=commit, 2007-11-07). Back then
the function was used only for checking --contains, where a NULL list
meant "the user did not ask to constrain the list at all".

I think it may be luck that no other caller has relied on that in the
intervening years.

> This patch also /fixes/ the error message when:
> 
> 	$ git init -b initial
> 	$ git branch -d initial
> 	fatal: Couldn't look up commit object for HEAD
> 
> Now we get the much clear:
> 
> 	error: Cannot delete branch 'initial' checked out at ...

OK, good. That surprised me at first, because the check in
branch_checked_out() doesn't use the same head_rev variable. But it is
just the case that the die() I removed was aborting much earlier, and
now we get far enough to do the right message. The distinction is
relevant because it means that I didn't miss a spot where I should have
checked the behavior of NULL head_rev; the head_rev value is not used
directly here.

-Peff
