Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BECD1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJXRnh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:43:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:52630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726256AbeJXRnh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:43:37 -0400
Received: (qmail 13929 invoked by uid 109); 24 Oct 2018 09:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 09:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3925 invoked by uid 111); 24 Oct 2018 09:15:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 05:15:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 05:16:18 -0400
Date:   Wed, 24 Oct 2018 05:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] run-command: mark path lookup errors with ENOENT
Message-ID: <20181024091617.GA25118@sigill.intra.peff.net>
References: <20181024073637.GA31069@sigill.intra.peff.net>
 <20181024073800.GB31202@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1810241054110.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810241054110.4546@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 11:01:54AM +0200, Johannes Schindelin wrote:

> > @@ -910,6 +921,7 @@ int start_command(struct child_process *cmd)
> >  }
> >  #endif
> >  
> > +end_of_spawn:
> 
> Sadly, this fails to build on Windows:
> 
> 	run-command.c: In function 'start_command':
> 	run-command.c:924:1: error: label 'end_of_spawn' defined but not used [-Werror=unused-label]
> 	 end_of_spawn:
> 	 ^~~~~~~~~~~~

Doh. I didn't think of that.

> How about squashing in this diff:
> 
> -- snip --
> diff --git a/run-command.c b/run-command.c
> index 639ea5ac3366..3f03795a5995 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -918,6 +918,8 @@ int start_command(struct child_process *cmd)
>  		close(fhout);
>  	if (fherr != 2)
>  		close(fherr);
> +
> +	goto end_of_spawn;
>  }
>  #endif
>  
> -- snap --
> 
> I can confirm that the result compiles and passes t0061.

That leaves the Windows side of the #else with a funny, useless goto
(and without even a matching useless one on the Unix side).  Let's put
it instead inside the half of the #if that actually uses it. Like so
(actually courtesy of Jonathan Nieder):

diff --git a/run-command.c b/run-command.c
index 639ea5ac33..d679cc267c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -868,6 +868,8 @@ int start_command(struct child_process *cmd)
 	argv_array_clear(&argv);
 	free(childenv);
 }
+end_of_spawn:
+
 #else
 {
 	int fhin = 0, fhout = 1, fherr = 2;
@@ -921,7 +923,6 @@ int start_command(struct child_process *cmd)
 }
 #endif
 
-end_of_spawn:
 	if (cmd->pid < 0) {
 		if (need_in)
 			close_pair(fdin);

Thanks for your review!

-Peff
