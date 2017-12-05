Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775B520C11
	for <e@80x24.org>; Tue,  5 Dec 2017 06:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbdLEGxc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 01:53:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:48290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751255AbdLEGxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 01:53:32 -0500
Received: (qmail 29622 invoked by uid 109); 5 Dec 2017 06:53:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Dec 2017 06:53:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29790 invoked by uid 111); 5 Dec 2017 06:53:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 05 Dec 2017 01:53:52 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Dec 2017 01:53:29 -0500
Date:   Tue, 5 Dec 2017 01:53:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 1/4] Makefile: don't error out under DC_SHA1_EXTERNAL if
 DC_SHA1_SUBMODULE=auto
Message-ID: <20171205065329.GA4788@sigill.intra.peff.net>
References: <20171128213214.12477-1-avarab@gmail.com>
 <20171128213214.12477-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171128213214.12477-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 28, 2017 at 09:32:11PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Fix a logic error in the initial introduction of DC_SHA1_EXTERNAL. If
> git.git has a sha1collisiondetection submodule checked out the logic
> to set DC_SHA1_SUBMODULE=auto would interact badly with the check for
> whether DC_SHA1_SUBMODULE was set.
> 
> It would error out, meaning that there's no way to build git with
> DC_SHA1_EXTERNAL=YesPlease without deinit-ing the submodule.
> 
> Instead, adjust the logic to only fire if the variable is to something
> else than "auto" which would mean it's a mistake on the part of
> whoever's building git, not just the Makefile tripping over its own
> logic.

This all makes sense, and I agree your patch is an improvement.

One minor whitespace nit:

> diff --git a/Makefile b/Makefile
> index e53750ca01..8fe8278126 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1497,7 +1497,9 @@ else
>  	LIB_OBJS += sha1dc_git.o
>  ifdef DC_SHA1_EXTERNAL
>  	ifdef DC_SHA1_SUBMODULE
> +ifneq ($(DC_SHA1_SUBMODULE),auto)
>  $(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
> +endif
>  	endif

The indentation here is funky. Unfortunately I think $(error) can't be
tab-indented, so it has to either stay at the left-most side, or we have
to use spaces.

But the ifneq/endif pair can be indented. Ordinarily I'd say it's fine
to keep it at the outermost (because of the weird error indent), but
note that we're _inside_ an already-indented ifdef/endif pair. We should
either stay inside there, or we should put the outer one to the left for
consistency.

-Peff
