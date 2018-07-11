Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA781F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 08:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeGKIFe (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 04:05:34 -0400
Received: from david.siemens.de ([192.35.17.14]:33079 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeGKIFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 04:05:34 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w6B82Acw016406
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 10:02:10 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6B829kH002862;
        Wed, 11 Jul 2018 10:02:09 +0200
Date:   Wed, 11 Jul 2018 10:02:08 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Jeff King <peff@peff.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/9] t/t7510: check the validation of the new config
 gpg.format
Message-ID: <20180711100208.34387665@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180710155536.GB23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <b02154496033220897f6f773e1149a98b21ccba7.1531208187.git.henning.schild@siemens.com>
        <20180710155536.GB23624@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 10 Jul 2018 11:55:36 -0400
schrieb Jeff King <peff@peff.net>:

> On Tue, Jul 10, 2018 at 10:52:26AM +0200, Henning Schild wrote:
> 
> > diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> > index 6e2015ed9..7e1e9caf4 100755
> > --- a/t/t7510-signed-commit.sh
> > +++ b/t/t7510-signed-commit.sh
> > @@ -227,4 +227,14 @@ test_expect_success GPG 'log.showsignature
> > behaves like --show-signature' ' grep "gpg: Good signature" actual
> >  '
> >  
> > +test_expect_success GPG 'check config gpg.format values' '
> > +	rm .git/config &&
> > +	test_config gpg.format openpgp &&
> > +	git commit -S --amend -m "success" &&  
> 
> You shouldn't need this "rm" here. test_config will add your config,
> and then delete it after the test finishes.

Right, got rid of it.

> I know you probably saw that in t1300 or nearby tests, but IMHO they
> are wrong to do so. It's a historical wart that should be cleaned up.
> 
> > +	test_config gpg.format OpEnPgP &&
> > +	git commit -S --amend -m "success" &&  
> 
> A bit of a funny side effect is that we'll unset gpg.format three
> times at the end of the test, since each test_config doesn't know
> that the earlier invocations touched the same variable.
> 
> It's probably not worth addressing, but we could do it with an
> explicit:

I think it is not worth addressing. Manual unsetting would mess with
test_config and both alternatives would just bloat the code. The
additional two unsets do not hurt, imho.

>   test_when_finished "test_unconfig gpg.format" &&
>   git config gpg.format openpgp &&
>   ...
>   git config gpg.format OpEnPgP &&
> 
> Or alternatively, this could be three independent tests, which would
> give the opportunity to describe each.
> 
> > +	test_config gpg.format malformed &&
> > +	test_must_fail git commit -S --amend -m "fail" 2>result
> > +'  
> 
> If you're not going to look at the saved "result", we are better to
> just leave stderr un-redirected. It will go to /dev/null by default,
> or to the user-visible output of the test is run in verbose mode.

Right, dropped the redirect.

Henning
 
> -Peff

