Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789BC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 15:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbiFIPDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbiFIPDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 11:03:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC596442
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 08:03:39 -0700 (PDT)
Received: (qmail 11196 invoked by uid 109); 9 Jun 2022 15:03:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jun 2022 15:03:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 9 Jun 2022 11:03:37 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Tassilo Horn <tsdh@gnu.org>, Tao Klerks <tao@klerks.biz>,
        git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
Message-ID: <YqILyX97zKg5ViUS@coredump.intra.peff.net>
References: <87h750q1b9.fsf@gnu.org>
 <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
 <87y1yb2xc8.fsf@gnu.org>
 <YqEyh5opAaJxph2+@coredump.intra.peff.net>
 <87sfoe7hio.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sfoe7hio.fsf@kyleam.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 08, 2022 at 09:27:43PM -0400, Kyle Meyer wrote:

> > I think the code could be written to realize that none of those features
> > are in use, and disable the diff entirely in favor of checking whether
> > the two trees has the same object id. That would yield _mostly_ the same
> > behavior, though there are probably corner cases (e.g., a tree with an
> > odd mode entry, say, may get parsed so as to produce an empty diff, even
> > though it's not byte for byte identical). That may be an acceptable
> > tradeoff. But I think the code would be a bit brittle (it needs to know
> > about all the cases where a diff might matter, and we may add more
> > later).
> 
> Do you think it'd be safe to make --no-patch imply --diff-merges=off, as
> Tao suggested elsewhere in this thread?
> 
>   https://lore.kernel.org/git/CAPMMpog-7eDOrgSU9GjV4G9rk5RkL-PJhaUAO3_0p2YxfRf=LA@mail.gmail.com

I'm not sure. If I do:

diff --git a/diff-merges.c b/diff-merges.c
index 7f64156b8b..f05a585dfb 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -164,6 +164,9 @@ void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
 
 void diff_merges_setup_revs(struct rev_info *revs)
 {
+	if (revs->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT &&
+	    !revs->explicit_diff_merges)
+		diff_merges_suppress(revs);
 	if (revs->combine_merges == 0)
 		revs->dense_combined_merges = 0;
 	if (revs->separate_merges == 0)

then the test suite passes, but that may just be because we are not
invoking the right corner case. It does change the output with something
like:

  git show --diff-filter=D -s a6434bc6f7a1

Without the patch above, it always shows the commit. With it, it shows
nothing. That's a bit far-fetched, but it is a regression, and I'm also
not sure if it's just the tip of the iceberg.

It also doesn't solve problem completely. Regular commits can have
expensive diffs, too.

I think you'd do better to have a mode specific to git-show that skips
the diff if we're not showing it, but makes sure to always show the
commit anyway. Perhaps something like the hunk above, but put into
cmd_show(), and then setting revs->always_show_header. But it would
require somebody verifying that this does the right thing in all cases.

-Peff
