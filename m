Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176C720954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbdLGVUw (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:20:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:51456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752453AbdLGVUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:20:32 -0500
Received: (qmail 31441 invoked by uid 109); 7 Dec 2017 21:20:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 21:20:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26519 invoked by uid 111); 7 Dec 2017 21:20:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 07 Dec 2017 16:20:54 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Dec 2017 16:20:30 -0500
Date:   Thu, 7 Dec 2017 16:20:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: release strbuf after use in split_mail_mbox()
Message-ID: <20171207212030.GC12850@sigill.intra.peff.net>
References: <ad0af192-1bd4-eee2-d6e8-2f1776e87428@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad0af192-1bd4-eee2-d6e8-2f1776e87428@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 09:20:19PM +0100, René Scharfe wrote:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/am.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 02853b3e05..1ac044da2e 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -708,6 +708,7 @@ static int split_mail_mbox(struct am_state *state, const char **paths,
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	struct strbuf last = STRBUF_INIT;
> +	int ret;
>  
>  	cp.git_cmd = 1;
>  	argv_array_push(&cp.args, "mailsplit");
> @@ -721,13 +722,16 @@ static int split_mail_mbox(struct am_state *state, const char **paths,
>  	argv_array_push(&cp.args, "--");
>  	argv_array_pushv(&cp.args, paths);
>  
> -	if (capture_command(&cp, &last, 8))
> -		return -1;
> +	ret = capture_command(&cp, &last, 8);
> +	if (ret)
> +		goto exit;

Looks good to me.

Coupled with your third patch, it made me wonder if capture_command()
should free the strbuf when it sees an error. But probably not. Some
callers would want to see the output even from a failing command (and
doubly for pipe_command(), which may capture stderr).

(And anyway, it wouldn't make this case any simpler; we were leaking in
the success code path, too!)

-Peff
