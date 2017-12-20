Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA4E1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbdLTQ0k (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 11:26:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:44210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755121AbdLTQ0j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 11:26:39 -0500
Received: (qmail 22649 invoked by uid 109); 20 Dec 2017 16:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 16:26:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14269 invoked by uid 111); 20 Dec 2017 16:27:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 11:27:04 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 11:26:37 -0500
Date:   Wed, 20 Dec 2017 11:26:37 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/4] status: update short status to use --no-ahead-behind
Message-ID: <20171220162637.GC31149@sigill.intra.peff.net>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-4-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220144245.39401-4-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 02:42:44PM +0000, Jeff Hostetler wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach "git status --short --branch" to use "--no-ahead-behind"
> flag to skip computing ahead/behind counts for the branch and
> its upstream and just report '[different]'.

How come "--short" and "--long" get this smaller bit of data, but
"--porcelain=v2" just omits the line entirely?

I don't have a real preference for or against the "[different]" message
myself, but if we can get the information cheaply, it seems odd not to
provide it in all cases.

> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 6ce8cf8..ea029ad 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -117,6 +117,9 @@ configuration variable documented in linkgit:git-config[1].
>  	expensive computation on extremely large repositories.
>  +
>  	In porcelain V2 format, the 'branch.ab' line will not be present.
> ++
> +	In short format with --branch, '[different]' will printed rather
> +	than detailed ahead/behind counts.

s/will/will be/ ?

> diff --git a/remote.c b/remote.c
> index a38b42e..0a63ac1 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1978,9 +1978,12 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
>  
>  /*
>   * Compare a branch with its upstream, and save their differences (number
> - * of commits) in *num_ours and *num_theirs. The name of the upstream branch
> - * (or NULL if no upstream is defined) is returned via *upstream_name, if it
> - * is not itself NULL.
> + * of commits) in *num_ours and *num_theirs.  If either num_ours or num_theirs
> + * are NULL, we skip counting the commits and just return whether they are
> + * different.

OK, this makes sense. I wondered in the last one why the caller could
not simply check "num_ours != num_theirs" themselves. And this is why:
we want to be able to signal to stat_tracking_info() that we want the
"cheap" version.

> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 8f17fd9..0190220 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -147,6 +147,19 @@ test_expect_success 'status -s -b (diverged from upstream)' '
>  '
>  
>  cat >expect <<\EOF
> +## b1...origin/master [different]
> +EOF
> +
> +test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '

This patch will affect "git status --porcelain", too. That's not
supposed to change in incompatible ways. I guess it's up for debate
whether callers are meant to handle any arbitrary string inside the []
(we already show "[gone]" for some cases), since AFAICT the format of
the tracking info is left completely vague in the documentation.

(I'd also hope that everybody is using --porcelain=v2 if they can, but
we should still avoid breaking v1).

-Peff
