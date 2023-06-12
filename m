Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081F7C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjFLD0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLD0R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:26:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3139E
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:26:16 -0700 (PDT)
Received: (qmail 22471 invoked by uid 109); 12 Jun 2023 03:26:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:26:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11666 invoked by uid 111); 12 Jun 2023 03:26:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:26:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:26:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 05/11] branch: fix a leak in setup_tracking
Message-ID: <20230612032615.GE306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <49a4339b-d736-2c30-0c57-194ab33f377c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49a4339b-d736-2c30-0c57-194ab33f377c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:49:51PM +0200, Rubén Justo wrote:

> The return introduced in bdaf1dfae7 was to avoid setting up the
> tracking, but even in that case it is still necessary to do the
> clean-up.  Let's do it.

That may be a sign that the return introduced by that commit is in the
wrong spot (i.e., could we be checking it earlier and returning before
doing the work that led to the allocations?).

But I didn't look too carefully, and I think for the purposes of your
series it is OK to simply fix the leak without digging too far.

I'll cc the author (and quote the patch below) though, as sometimes in
cases like these they may be interested in looking deeper themselves.

-Peff

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/branch.c b/branch.c
> index a7333a4c32..ff81c2266a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -333,7 +333,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  		if (!skip_prefix(tracking.srcs->items[0].string,
>  				 "refs/heads/", &tracked_branch) ||
>  		    strcmp(tracked_branch, new_ref))
> -			return;
> +			goto cleanup;
>  	}
>  
>  	if (tracking.srcs->nr < 1)
> -- 
> 2.40.1
