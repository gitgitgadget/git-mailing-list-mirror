Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB991F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfFDOWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:22:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:45870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727378AbfFDOWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:22:35 -0400
Received: (qmail 22406 invoked by uid 109); 4 Jun 2019 14:22:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 14:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14347 invoked by uid 111); 4 Jun 2019 14:23:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 10:23:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 10:22:33 -0400
Date:   Tue, 4 Jun 2019 10:22:33 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/5] t5801 (remote-helpers): add test to fetch tags
Message-ID: <20190604142233.GB10598@sigill.intra.peff.net>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
 <20190604021330.16130-3-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604021330.16130-3-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 09:13:27PM -0500, Felipe Contreras wrote:

> This used to work, but commit e198b3a740 broke it.
> 
>   e198b3a740 (fetch: replace string-list used as a look-up table with a hashmap)
> 
> Probably all remote helpers that use the import method are affected, but
> we didn't catch the issue.

Thanks for beefing up the tests. It's rather unfortunate that we missed
such a severe regression.

> +test_expect_failure 'fetch tag' '
> +	(cd server &&
> +	 git tag v1.0
> +	) &&
> +	(cd local &&
> +	 git fetch
> +	) &&
> +	compare_refs local v1.0 server v1.0
> +'

This single-commands might be more readable using "git -C", but this
matches the existing style in the test script, so I'm OK with it either
way.

> diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
> index f2b551dfaf..6b9f0b5dc7 100755
> --- a/t/t5801/git-remote-testgit
> +++ b/t/t5801/git-remote-testgit
> @@ -12,9 +12,14 @@ url=$2
>  
>  dir="$GIT_DIR/testgit/$alias"
>  
> -refspec="refs/heads/*:refs/testgit/$alias/heads/*"
> +h_refspec="refs/heads/*:refs/testgit/$alias/heads/*"
> +t_refspec="refs/tags/*:refs/testgit/$alias/tags/*"
>  
> -test -n "$GIT_REMOTE_TESTGIT_NOREFSPEC" && refspec=""
> +if test -n "$GIT_REMOTE_TESTGIT_NOREFSPEC"
> +then
> +	h_refspec=""
> +	t_refspec=""
> +fi

And the simplification from the prior step pays off. Looks good.

The rest of it seems pretty sensible (modulo the caveat that I don't know
remote-testgit well enough to detect anything subtle).

-Peff
