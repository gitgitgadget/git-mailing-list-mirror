Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D759DC3F2D2
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA14020870
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 13:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCBNsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:48:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:58878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726300AbgCBNsn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 08:48:43 -0500
Received: (qmail 30168 invoked by uid 109); 2 Mar 2020 13:48:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Mar 2020 13:48:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3199 invoked by uid 111); 2 Mar 2020 13:57:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2020 08:57:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Mar 2020 08:48:42 -0500
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] remote.c: fix handling of push:remote_ref
Message-ID: <20200302134842.GB1176622@coredump.intra.peff.net>
References: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
 <20200228182349.GA1408759@coredump.intra.peff.net>
 <20200301220531.iuokzzdb5gruslrn@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200301220531.iuokzzdb5gruslrn@doriath>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 01, 2020 at 11:05:31PM +0100, Damien Robert wrote:

> So it remains the problem of handling the 'upstream' case.
> The ideal solution would be to not duplicate branch_get_push_1.

Yeah, that would be nice (though at least if it's all contained in
remote.c, we can live with some duplication). There's already some
duplication in the way remote_ref_for_branch() applies remote refspecs.

And I think all of this may be duplicated with git-push itself (which
would also be nice to get rid of, but last time I looked into it was
hard to refactor it to do so).

> In most of the case, this function finds `dst` which is exactly the
> push:remoteref we are looking for.
> 
> Then branch_get_push_1 uses
> 		ret = tracking_for_push_dest(remote, dst, err);
> which simply calls
> 	ret = apply_refspecs(&remote->fetch, dst);

Right, there we already have the remote name, and are applying the fetch
refspecs to know what our tracking branch would be. So in
remote_ref_for_branch(), we'd just not apply those.

> The only different case is
> 	case PUSH_DEFAULT_UPSTREAM:
> 		return branch_get_upstream(branch, err);
> which returns
> 	branch->merge[0]->dst

We also have PUSH_DEFAULT_NOTHING, for which obviously we'd return
nothing (NULL or an empty string).

Likewise for SIMPLE, we probably need to check that the upstream has a
matching name (and return nothing if not).

> So we could almost write an auxiliary function that returns push:remoteref
> and use it both in remote_ref_for_branch and branch_get_push_1 (via a
> further call to tracking_for_push_dest) except for the 'upstream' case
> which is subtly different.

Yes, that makes sense.

> In the 'upstream' case, the auxiliary function would return
> branch->merge_name[0]. So the question is: can
> tracking_for_push_dest(branch->merge_name[0]) be different from
> branch->merge[0]->dst?

Those will both return tracking refs. I think you just want
merge[0]->src for the upstream case.

And yes, the two can be different. It's the same case as when the
upstream branch has a different name than the current branch.

> Another solution could be as follow: we already store `push` in
> `branch->push_tracking_ref`. So the question is: can we always easily convert
> something like refs/remotes/origin/branch_name to refs/heads/branch_name
> (ie essentially reverse ètracking_for_push_dest`), or are there corner cases?

This would basically be reverse-applying the fetch refspec. In theory
it should be possible, but there are cases where somebody has
overlapping refspecs. But at any rate, I think it's better to just get
the pre-mapped values (i.e., avoid calling tracking_for_push_dest() in
the first place).

> Otherwise a simple but not elegant solution would be to copy paste the
> code of branch_get_push_1 to remote_ref_for_branch, simply removing the
> calls to `tracking_for_push_dest` and using remote->branch_name[0] rather
> than remote->branch[0]->dst for the upstream case.

Yeah, I think that's going to be the easiest. It would be nice to avoid
repeating that switch(), but frankly I think the boilerplate you'll end
up with trying to handle the two cases may be worse than just repeating
it. It may be worth adding a comment to each function to mention the
other, and that any changes need to match.

-Peff
