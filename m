Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3E01F404
	for <e@80x24.org>; Fri, 30 Mar 2018 14:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeC3OIn (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 10:08:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:48722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750794AbeC3OIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 10:08:43 -0400
Received: (qmail 11894 invoked by uid 109); 30 Mar 2018 14:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 14:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27895 invoked by uid 111); 30 Mar 2018 14:09:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 10:09:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 10:08:41 -0400
Date:   Fri, 30 Mar 2018 10:08:41 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 8/9] git_config_set: use do_config_from_file() directly
Message-ID: <20180330140840.GA5869@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de>
 <20180329213823.GH2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301500560.5026@qfpub.tvgsbejvaqbjf.bet>
 <20180330131456.GB29568@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301558360.5026@qfpub.tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803301558360.5026@qfpub.tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 04:01:56PM +0200, Johannes Schindelin wrote:

> You know what is *really* funny?
> 
> -- snip --
> static int git_config_from_stdin(config_fn_t fn, void *data)
> {
>         return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data, 0);
> }
> 
> int git_config_from_file(config_fn_t fn, const char *filename, void *data)
> {
>         int ret = -1;
>         FILE *f;
> 
>         f = fopen_or_warn(filename, "r");
>         if (f) {
>                 flockfile(f);
>                 ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data, 0);
>                 funlockfile(f);
>                 fclose(f);
>         }
>         return ret;
> }
> -- snap --
> 
> So the _stdin variant *goes out of its way not to flockfile()*...

*facepalm* That's probably my fault, since git_config_from_stdin()
existed already when I did the flockfile stuff.

Probably the flockfile should go into do_config_from_file(), where we
specify to use the unlocked variants.

> But I guess all this will become moot when I start handing down the config
> options. It does mean that I have to change the signatures in header
> files, oh well ;-)
> 
> But then I can drop this here patch and we can stop musing about
> flockfile()  ;-)

Yeah, I'll wait to see how your refactor turns out.

-Peff
