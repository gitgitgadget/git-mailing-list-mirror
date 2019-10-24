Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248EB1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfJXXee (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:34:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:57722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727446AbfJXXee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:34:34 -0400
Received: (qmail 26925 invoked by uid 109); 24 Oct 2019 23:34:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 23:34:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6477 invoked by uid 111); 24 Oct 2019 23:37:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 19:37:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 19:34:33 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [git-for-windows] Git for Windows v2.24.0-rc0, was Re:
 [ANNOUNCE] Git v2.24.0-rc0
Message-ID: <20191024233432.GB32602@sigill.intra.peff.net>
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet>
 <74f50326-e613-8545-2c69-65cd29dd3cfb@iee.email>
 <nycvar.QRO.7.76.6.1910250052350.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910250052350.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 25, 2019 at 01:08:16AM +0200, Johannes Schindelin wrote:

> diff --git a/config.c b/config.c
> index e7052b39773..8e2f4748c49 100644
> --- a/config.c
> +++ b/config.c
> @@ -1658,8 +1658,10 @@ static int git_config_from_blob_ref(config_fn_t fn,
>  const char *git_etc_gitconfig(void)
>  {
>  	static const char *system_wide;
> -	if (!system_wide)
> +	if (!system_wide) {
>  		system_wide = system_path(ETC_GITCONFIG);
> +		normalize_path_copy((char *)system_wide, system_wide);
> +	}
>  	return system_wide;

This cast made me wonder why it was OK to write to system_wide. The
answer is that system_path() hands ownership of the memory to us, since
59362e560d (system_path(): always return free'able memory to the caller,
2014-11-24). So I think the better solution than the cast is to drop the
"const" from its declaration to better indicate our ownership within the
function.

I also wondered how we know that system_wide is a large enough buffer,
but I guess normalizing always makes things smaller. It would be nice if
normalize_path_copy() said so in its docstring, but that is certainly
not new to your patch. :)

-Peff
