Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D7CC7EE37
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjFLD4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjFLD4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:56:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55192114
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:55:59 -0700 (PDT)
Received: (qmail 24258 invoked by uid 109); 12 Jun 2023 03:55:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11801 invoked by uid 111); 12 Jun 2023 03:56:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:56:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:55:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 08/11] branch: fix a leak in check_tracking_branch
Message-ID: <20230612035557.GH306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <98c68cb4-abbe-0b86-0052-517f47711271@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98c68cb4-abbe-0b86-0052-517f47711271@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:50:27PM +0200, Rubén Justo wrote:

> diff --git a/branch.c b/branch.c
> index 19d606d360..09b9563ae7 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -480,9 +480,12 @@ static int check_tracking_branch(struct remote *remote, void *cb_data)
>  {
>  	char *tracking_branch = cb_data;
>  	struct refspec_item query;
> +	int res;
>  	memset(&query, 0, sizeof(struct refspec_item));
>  	query.dst = tracking_branch;
> -	return !remote_find_tracking(remote, &query);
> +	res = !remote_find_tracking(remote, &query);
> +	free(query.src);
> +	return res;
>  }

OK, so we expect remote_find_tracking() to fill in the "src" field, but
we don't actually care about the value here (we are just validating). It
probably doesn't fill in the value for some error cases, but then we'd
be left with a NULL, which is OK to feed to free(). Makes sense. I
double-checked that it always allocates "src" when it is assigned to, so
I think this fix is good.

-Peff
