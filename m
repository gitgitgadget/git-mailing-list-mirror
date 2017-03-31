Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D5A1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbdCaRsb (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:48:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:55015 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933205AbdCaRsa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:48:30 -0400
Received: (qmail 10521 invoked by uid 109); 31 Mar 2017 17:48:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 17:48:29 +0000
Received: (qmail 11845 invoked by uid 111); 31 Mar 2017 17:48:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 13:48:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Mar 2017 13:48:27 -0400
Date:   Fri, 31 Mar 2017 13:48:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
Message-ID: <20170331174827.zheqstwtlsqtxa6e@sigill.intra.peff.net>
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
 <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
 <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 01:45:15PM -0400, Jeff King wrote:

> I suspect this may improve things, but I haven't dug deeper to see if
> there are unwanted side effects, or if there are other spots that need
> similar treatment.
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 43990dec7..38411f90b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2952,7 +2952,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	if (status && oi->typep)
>  		*oi->typep = status;
>  	strbuf_release(&hdrbuf);
> -	return 0;
> +	return status;
>  }
>  
>  int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)

Er, no, that's totally wrong. "status' may be holding the type. It
should really be:

  return status < 0 ? status : 0;

-Peff
