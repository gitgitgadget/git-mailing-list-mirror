Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A330A1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfFDOQV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:16:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:45856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727287AbfFDOQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:16:21 -0400
Received: (qmail 22368 invoked by uid 109); 4 Jun 2019 14:16:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 14:16:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14218 invoked by uid 111); 4 Jun 2019 14:17:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 10:17:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 10:16:19 -0400
Date:   Tue, 4 Jun 2019 10:16:19 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/5] t5801 (remote-helpers): cleanup refspec stuff
Message-ID: <20190604141619.GA10598@sigill.intra.peff.net>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
 <20190604021330.16130-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604021330.16130-2-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 09:13:26PM -0500, Felipe Contreras wrote:

> diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
> index 752c763eb6..f2b551dfaf 100755
> --- a/t/t5801/git-remote-testgit
> +++ b/t/t5801/git-remote-testgit
> @@ -11,13 +11,10 @@ fi
>  url=$2
>  
>  dir="$GIT_DIR/testgit/$alias"
> -prefix="refs/testgit/$alias"
>  
> -default_refspec="refs/heads/*:${prefix}/heads/*"
> +refspec="refs/heads/*:refs/testgit/$alias/heads/*"
>  
> -refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
> -
> -test -z "$refspec" && prefix="refs"
> +test -n "$GIT_REMOTE_TESTGIT_NOREFSPEC" && refspec=""

So this simplifies the feature by just allowing two refspecs: the
default one, or none at all. And that works because all of the existing
callers wanted or the other. Makes sense.

> @@ -81,10 +78,10 @@ do
>  
>  		echo "feature done"
>  		git fast-export \
> +			${refspec:+"--refspec=$refspec"} \
>  			${testgitmarks:+"--import-marks=$testgitmarks"} \
>  			${testgitmarks:+"--export-marks=$testgitmarks"} \
> -			$refs |
> -		sed -e "s#refs/heads/#${prefix}/heads/#g"
> +			$refs

This second hunk puzzled me for a minute. By using --refspec, we can
avoid doing the mapping with sed here, which is simpler and more robust.
Good.

One caveat for anybody else testing this: when I initially applied this
patch, some tests failed! The problem turned out to be a leftover
git-remote-testgit in my build dir from prior to 5afb2ce4cd
(remote-testgit: move it into the support directory for t5801,
2019-04-12).

So the problem isn't related to this patch (it's only noticeable here
because this is the first change to remote-testgit since it moved). I
wonder if we could make the test script more robust here. I think it's
tricky because the build dir is added to the $PATH internally by Git
itself (since it's the exec-path), so nothing do in the test script can
override that. Perhaps it's worth just renaming the script as part of
the move. +cc Dscho

-Peff
