Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC4DC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75121246AC
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1SXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:23:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:57316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725730AbgB1SXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 13:23:51 -0500
Received: (qmail 4527 invoked by uid 109); 28 Feb 2020 18:23:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Feb 2020 18:23:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18075 invoked by uid 111); 28 Feb 2020 18:32:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Feb 2020 13:32:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Feb 2020 13:23:49 -0500
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     J Wyman <jwyman@microsoft.com>, git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH 1/1] remote.c: fix handling of push:remote_ref
Message-ID: <20200228182349.GA1408759@coredump.intra.peff.net>
References: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 06:24:55PM +0100, Damien Robert wrote:

> To get the meaning of push:remoteref, ref-filter.c calls
> remote_ref_for_branch.
> 
> However remote_ref_for_branch only handles the case of a specified refspec.
> The other cases treated by branch_get_push_1 are the mirror case,
> PUSH_DEFAULT_{NOTHING,MATCHING,CURRENT,UPSTREAM,UNSPECIFIED,SIMPLE}.

Just to back up a minute to the user-visible problem, it's that:

  git config push.default matching
  git for-each-ref --format='%(push)'
  git for-each-ref --format='%(push:remoteref)'

prints a useful tracking ref for the first for-each-ref, but an empty
string for the second. That feature (and remote_ref_for_branch) come
from 9700fae5ee (for-each-ref: let upstream/push report the remote ref
name, 2017-11-07). Author cc'd for guidance.

I wonder if %(upstream:remoteref) has similar problems, but I suppose
not (it doesn't have this implicit config, so we'd always either have a
remote ref or we'd have no upstream at all).

> In all these cases, either there is no push remote, or the remote_ref is
> branch->refname. So we can handle all these cases by returning
> branch->refname, provided that remote is not empty.

In the case of "upstream", the names could be different, couldn't they?

If I do this:

  git init parent
  git -C parent commit --allow-empty -m foo
  
  git clone parent child
  cd child
  git branch --track mybranch origin/master
  git config push.default upstream
  git for-each-ref \
    --format='push=%(push), remoteref=%(push:remoteref)' \
    refs/heads/mybranch

the current code gives no remoteref value, which seems wrong. But with
your patch I'd get "refs/heads/mybranch", which is also wrong.

I think you're right that all of the other cases would always use the
same refname on the remote.

>  remote.c | 5 +++++
>  1 file changed, 5 insertions(+)

We'd want some test coverage to make sure this doesn't regress. There
are already some tests covering this feature in t6300. And indeed, your
patch causes them to fail when checking a "simple" push case (but I
think I'd argue the current expected value there is wrong). That should
be expanded to cover the "upstream" case, too, once we figure out how to
get it right.

> diff --git a/remote.c b/remote.c
> index 593ce297ed..75e42b1e36 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -538,6 +538,11 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
>  					*explicit = 1;
>  				return dst;
>  			}
> +			else if (remote) {
> +				if (explicit)
> +					*explicit = 1;
> +				return branch->refname;
> +			}

Saying "*explicit = 1" here seems weird. Isn't the whole point that
these modes _aren't_ explicit?

It looks like our only caller will ignore our return value unless we say
"explicit", though. I have to wonder what the point of that flag is,
versus just returning NULL when we don't have anything to return.

-Peff
