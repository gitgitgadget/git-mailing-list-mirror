Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C10E1F576
	for <e@80x24.org>; Fri, 23 Feb 2018 06:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeBWGtz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 01:49:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:33692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750943AbeBWGty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 01:49:54 -0500
Received: (qmail 27124 invoked by uid 109); 23 Feb 2018 06:49:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Feb 2018 06:49:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11818 invoked by uid 111); 23 Feb 2018 06:50:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Feb 2018 01:50:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2018 01:49:52 -0500
Date:   Fri, 23 Feb 2018 01:49:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: factor out strbuf_read_file_or_whine()
Message-ID: <20180223064952.GB19791@sigill.intra.peff.net>
References: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 08:29:25PM +0100, René Scharfe wrote:

> Reduce code duplication by factoring out a function that reads an entire
> file into a strbuf, or reports errors on stderr if something goes wrong.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> The difference to using strbuf_read_file() is more detailed error
> messages for open(2) failures.  But I don't know if we need them -- or
> under which circumstances reading todo files could fail anyway.  When
> doing multiple rebases in parallel perhaps?

I'm fine with this patch, but FWIW I think reporting the result of
strbuf_read_file with error_errno() would actually be an improvement.
The errno values are generally sufficient to tell if the problem was in
opening or reading, and then we'd get more information in the case of a
failed read() call.

Thought note...

> diff --git a/sequencer.c b/sequencer.c
> index e9baaf59bd..e34334f0ef 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1869,22 +1869,31 @@ static int count_commands(struct todo_list *todo_list)
>  	return count;
>  }
>  
> +static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
> +{
> +	int fd;
> +	ssize_t len;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), path);
> +	len = strbuf_read(sb, fd, 0);
> +	close(fd);
> +	if (len < 0)
> +		return error(_("could not read '%s'."), path);
> +	return len;
> +}

If we were to use error_errno() in the second conditional here, we
should take care not to clobber errno during the close(). I think
strbuf_read_file() actually has the same problem, which might be worth
fixing.

-Peff
