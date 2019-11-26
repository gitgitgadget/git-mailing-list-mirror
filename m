Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C3DC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF012073F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 16:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfKZQKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:10:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:32986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728118AbfKZQKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 11:10:55 -0500
Received: (qmail 2614 invoked by uid 109); 26 Nov 2019 16:10:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Nov 2019 16:10:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3187 invoked by uid 111); 26 Nov 2019 16:14:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Nov 2019 11:14:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Nov 2019 11:10:53 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: use skip_prefix() instead of starts_with()
Message-ID: <20191126161053.GE25729@sigill.intra.peff.net>
References: <8fa33928-3cbc-beba-524b-55bca143fd80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fa33928-3cbc-beba-524b-55bca143fd80@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 03:22:56PM +0100, René Scharfe wrote:

> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index a4615587fd..736f666f64 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -106,7 +106,7 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
>  	int i, len = strlen(line);
>  	struct origin_data *origin_data;
>  	char *src;
> -	const char *origin;
> +	const char *origin, *tag_name;
>  	struct src_data *src_data;
>  	struct string_list_item *item;
>  	int pulling_head = 0;
> @@ -162,14 +162,13 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
>  	if (pulling_head) {
>  		origin = src;
>  		src_data->head_status |= 1;
> -	} else if (starts_with(line, "branch ")) {
> +	} else if (skip_prefix(line, "branch ", &origin)) {
>  		origin_data->is_local_branch = 1;
> -		origin = line + 7;
>  		string_list_append(&src_data->branch, origin);
>  		src_data->head_status |= 2;
> -	} else if (starts_with(line, "tag ")) {
> +	} else if (skip_prefix(line, "tag ", &tag_name)) {
>  		origin = line;
> -		string_list_append(&src_data->tag, origin + 4);
> +		string_list_append(&src_data->tag, tag_name);
>  		src_data->head_status |= 2;

Looks good, as we're already mutating "origin" in the first one, and
"tag_name" is a new variable in the second one.

-Peff
