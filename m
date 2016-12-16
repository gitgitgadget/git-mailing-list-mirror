Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233261FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756929AbcLPVo3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:44:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:57798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755661AbcLPVo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:44:28 -0500
Received: (qmail 10947 invoked by uid 109); 16 Dec 2016 21:44:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 21:44:28 +0000
Received: (qmail 14939 invoked by uid 111); 16 Dec 2016 21:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 16:45:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 16:44:25 -0500
Date:   Fri, 16 Dec 2016 16:44:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
Message-ID: <20161216214424.o3x4xqttrao3i73v@sigill.intra.peff.net>
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
 <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
 <xmqqlgvfso16.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgvfso16.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 10:54:13AM -0800, Junio C Hamano wrote:

> I am tempted to suggest an intermediate step that comes before
> b1ef400eec ("setup_git_env: avoid blind fall-back to ".git"",
> 2016-10-20), which is the attached, and publish that as part of an
> official release.  That way, we'll see what is broken without
> hurting people too much (unless they or their scripts care about
> extra message given to the standard error stream).  I suspect that
> released Git has a slightly larger user base than what is cooked on
> 'next'.
> 
>  environment.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/environment.c b/environment.c
> index 0935ec696e..88f857331e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -167,8 +167,11 @@ static void setup_git_env(void)
>  	const char *replace_ref_base;
>  
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
> -	if (!git_dir)
> +	if (!git_dir) {
> +		if (!startup_info->have_repository)
> +			warning("BUG: please report this at git@vger.kernel.org");
>  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> +	}

Yes, I think this is a nice way to ease into the change. I wish I had
thought of it when doing the original series, and we could have shipped
it in v2.11. :)

-Peff
