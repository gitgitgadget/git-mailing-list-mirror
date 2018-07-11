Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53F51F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 08:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeGKIus (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 04:50:48 -0400
Received: from goliath.siemens.de ([192.35.17.28]:39196 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeGKIus (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 04:50:48 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w6B8lJ8Y007577
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 10:47:19 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6B8lJX5030521;
        Wed, 11 Jul 2018 10:47:19 +0200
Date:   Wed, 11 Jul 2018 10:47:19 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/9] t/t7510: check the validation of the new config
 gpg.format
Message-ID: <20180711104719.1bf5d835@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqr2kb81zw.fsf@gitster-ct.c.googlers.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <cover.1531208187.git.henning.schild@siemens.com>
        <b02154496033220897f6f773e1149a98b21ccba7.1531208187.git.henning.schild@siemens.com>
        <xmqqr2kb81zw.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 10 Jul 2018 09:54:59 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > Test setting gpg.format to both invalid and valid values.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  t/t7510-signed-commit.sh | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
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
> 
> Please don't.  .git/config has stuff that are more important than
> just collection of random configuration these days, and we can even
> expect that future versions of Git may not store its config in a
> flat file .git/config but in a different mechanism "git config"
> command knows how to access.  A low-level test for "git config"
> command's operation may have to be implemented by inspecting the
> resulting .git/config, but as this test is not about "git config"'s
> inner workins but is about one feature "git commit" command has,
> we prefer not to depend too much on the internal implementation
> detail such as "local config is stored in .git/config file".
> 
> Let's hear why you want to remove this file; what things that have
> previously been placed in the file do you want not to see, before
> performing the following actions?  Once we know that, we can suggest
> a way to do so better than removing the entire file.

That was a leftover of parsing the result and expecting the malformed
value in a certain line. Now i do not look at result anymore. If the
first two do succeed and the third fails it is probably fair enough to
assume that the format "malformed" triggerd the config validation path.

That rm is gone from what will be v3.

Henning

> > +	test_config gpg.format openpgp &&
> > +	git commit -S --amend -m "success" &&
> > +	test_config gpg.format OpEnPgP &&
> > +	git commit -S --amend -m "success" &&
> > +	test_config gpg.format malformed &&
> > +	test_must_fail git commit -S --amend -m "fail" 2>result
> > +'
> > +
> >  test_done  

