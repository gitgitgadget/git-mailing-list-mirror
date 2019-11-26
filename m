Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC63CC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE68E2071E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfKZP4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:56:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:32924 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727758AbfKZP4s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 10:56:48 -0500
Received: (qmail 2487 invoked by uid 109); 26 Nov 2019 15:56:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Nov 2019 15:56:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2915 invoked by uid 111); 26 Nov 2019 16:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Nov 2019 11:00:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Nov 2019 10:56:47 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell: use skip_prefix() instead of starts_with()
Message-ID: <20191126155647.GA25729@sigill.intra.peff.net>
References: <0a4dfbcc-9eb5-6b39-6b93-0014f5c475de@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a4dfbcc-9eb5-6b39-6b93-0014f5c475de@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 04:00:43PM +0100, René Scharfe wrote:

> Get rid of a magic number by using skip_prefix() instead of
> starts_with().
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  shell.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/shell.c b/shell.c
> index 40084a3013..54cca7439d 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -16,10 +16,10 @@ static int do_generic_cmd(const char *me, char *arg)
>  	setup_path();
>  	if (!arg || !(arg = sq_dequote(arg)) || *arg == '-')
>  		die("bad argument");
> -	if (!starts_with(me, "git-"))
> +	if (!skip_prefix(me, "git-", &me))
>  		die("bad command");
> 
> -	my_argv[0] = me + 4;
> +	my_argv[0] = me;
>  	my_argv[1] = arg;
>  	my_argv[2] = NULL;

The context makes this look obviously correct, but one thing to watch
out for in these skip_prefix() conversions is that the value of "me" is
now mutated.  This one is fine, because nobody else looks at "me" after
this (knowing you, I am pretty sure you checked that already, but I am
making a mental note to myself and others as we review these).

-Peff
