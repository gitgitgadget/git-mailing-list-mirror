Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A6A1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbcHCVgc (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:36:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:54243 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932518AbcHCVgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:36:31 -0400
Received: (qmail 17891 invoked by uid 102); 3 Aug 2016 21:09:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:09:50 -0400
Received: (qmail 5934 invoked by uid 107); 3 Aug 2016 21:10:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:10:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 17:09:46 -0400
Date:	Wed, 3 Aug 2016 17:09:46 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
Message-ID: <20160803210946.pjclbkz3qlsi2ezb@sigill.intra.peff.net>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
 <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 01:57:09PM -0700, Junio C Hamano wrote:

> All bugs are from my original, I think.  Here is a proposed squash.
> 
>  * This shouldn't make much difference for @@PAGER_ENV@@, but not
>    quoting the default assignment, i.e.
> 
>    	: "${VAR=VAL}" && export VAR
> 
>    is bad manners.  cf. 01247e02 (sh-setup: enclose setting of
>    ${VAR=default} in double-quotes, 2016-06-19)
> 
>  * Again, this shouldn't make much difference for PAGER_ENV, but
>    let's follow the "reset per iteration, release at the end"
>    pattern to avoid repeated allocation.
> 
>  * Let's avoid a hand-rolled "skip blanks" loop and let strspn() do
>    it.

Sounds good.

> diff --git a/pager.c b/pager.c
> index cd1ac54..7199c31 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -66,25 +66,22 @@ const char *git_pager(int stdout_is_tty)
>  static void setup_pager_env(struct argv_array *env)
>  {
>  	const char *pager_env = PAGER_ENV;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	while (*pager_env) {
> -		struct strbuf buf = STRBUF_INIT;
>  		const char *cp = strchrnul(pager_env, '=');
>  
>  		if (!*cp)
>  			die("malformed build-time PAGER_ENV");
>  		strbuf_add(&buf, pager_env, cp - pager_env);

I thought you'd need a strbuf_reset() here, but I guess it is handled by
the one at the end of the loop. That's OK because there are no other
loop exits, though IMHO putting it at the top makes the reusable-strbuf
idiom easier to understand.

-Peff
