Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA351F667
	for <e@80x24.org>; Fri, 18 Aug 2017 06:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdHRG3d (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 02:29:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:42414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750709AbdHRG3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 02:29:32 -0400
Received: (qmail 21298 invoked by uid 109); 18 Aug 2017 06:29:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 06:29:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32655 invoked by uid 111); 18 Aug 2017 06:29:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 02:29:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 02:29:30 -0400
Date:   Fri, 18 Aug 2017 02:29:30 -0400
From:   Jeff King <peff@peff.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/4] commit: replace the raw buffer with strbuf in
 read_graft_line
Message-ID: <20170818062929.f4zitbtaeii4xiko@sigill.intra.peff.net>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <65f84c5eb94e8b6f5cbce31f56810fdb71a58bf9.1503020338.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65f84c5eb94e8b6f5cbce31f56810fdb71a58bf9.1503020338.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 03:59:36AM +0200, Patryk Obara wrote:

> diff --git a/commit.c b/commit.c
> index 8b28415..019e733 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -134,17 +134,18 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>  	return 0;
>  }
>  
> -struct commit_graft *read_graft_line(char *buf, int len)
> +struct commit_graft *read_graft_line(struct strbuf *line)
>  {
>  	/* The format is just "Commit Parent1 Parent2 ...\n" */
> -	int i;
> +	int i, len;
> +	char *buf = line->buf;

Copying a pointer to a strbuf's buffer is a dangerous habit. The strbuf
is free to re-allocate the buffer under the hood during any operation it
likes, potentially leaving you pointing to freed memory.

In this case it's OK because the only function you call is
strbuf_rtrim(), which never reallocates. But I feel like this is setting
up a maintenance trap for the next person to touch the function.

AFAICT this is only here to avoid having to s/buf/line->buf/ in the rest
of the function. But I think we should just make that change (you
already did in some of the spots). And IMHO we should do the same for
line->len. When there are two names for the same value, it increases the
chances of a bug where the two end up diverging.

> -	while (len && isspace(buf[len-1]))
> -		buf[--len] = '\0';
> -	if (buf[0] == '#' || buf[0] == '\0')
> +	strbuf_rtrim(line);
> +	if (line->buf[0] == '#' || line->len == 0)
>  		return NULL;

I find it funny to look at line->buf[0] before line->len, because it
means we're reading pas the end of the buffer. It's OK here because we
know there's a NUL terminator, but I think short-circuiting like:

  if (!line->len || line->buf[0] == '#')

is better (I also think "!" instead of "== 0" is our usual style, but
that's much less important).

-Peff
