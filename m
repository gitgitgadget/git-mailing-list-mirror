Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70D11F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 10:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeGKKm0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 06:42:26 -0400
Received: from thoth.sbs.de ([192.35.17.2]:44297 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeGKKm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 06:42:26 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6BAcPfh000455
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 12:38:26 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6BAcPJ6006484;
        Wed, 11 Jul 2018 12:38:25 +0200
Date:   Wed, 11 Jul 2018 12:38:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Jeff King <peff@peff.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests
 with GPGSM
Message-ID: <20180711123824.7e0be91a@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180710170901.GH23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
 <20180710170901.GH23624@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 10 Jul 2018 13:09:01 -0400
schrieb Jeff King <peff@peff.net>:

> On Tue, Jul 10, 2018 at 10:52:31AM +0200, Henning Schild wrote:
> 
> > diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> > index a5d3b2cba..9dcb4e990 100755
> > --- a/t/lib-gpg.sh
> > +++ b/t/lib-gpg.sh
> > @@ -38,7 +38,14 @@ then
> >  			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
> >  		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null
> > 2>&1 \ --sign -u committer@example.com &&
> > -		test_set_prereq GPG
> > +		test_set_prereq GPG &&
> > +		echo | gpgsm --homedir "${GNUPGHOME}" -o
> > "$TEST_DIRECTORY"/lib-gpg/gpgsm.crt.user --passphrase-fd 0
> > --pinentry-mode loopback --generate-key --batch
> > "$TEST_DIRECTORY"/lib-gpg/gpgsm-gen-key.in &&  
> 
> Is this --generate-key going to require high-quality entropy? That
> could slow the test suite down (and maybe even stall it quite a bit
> on servers doing automated CI).

Yes, i also saw that getting "stuck" on one machine. But i blamed an
experimental kernel.

> Can we save a dummy generated key and just import it? That's what we
> do for the regular gpg case.

I will look into storing a binary and leaving notes how it was
generated, just like regular gpg does. The reason i did not do that in
the first place is that x509 certs have a validity and we introduce
time into the picture. But i will see if i can generate epoch->infinity
to get the host clock or just the future out of the picture.

> > +		gpgsm --homedir "${GNUPGHOME}" --import
> > "$TEST_DIRECTORY"/lib-gpg/gpgsm.crt.user &&
> > +		gpgsm --homedir "${GNUPGHOME}" -K | grep
> > fingerprint: | cut -d" " -f4 | tr -d '\n' >
> > ${GNUPGHOME}/trustlist.txt &&
> > +		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
> > +		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> > +		echo hello | gpgsm --homedir "${GNUPGHOME}" -u
> > committer@example.com -o /dev/null --sign - 2>&1 &&
> > +		test_set_prereq GPGSM  
> 
> This &&-chain means we can't have GPGSM without GPG. In theory the two
> could be tested independently. I don't know if it's worth the trouble
> to make that work, though. I wouldn't be surprised if there are some
> subtle dependencies within the test scripts, and I'm not sure how
> common it is for somebody to have gpgsm and not gpg. So it may make
> sense to just punt on it until such a person appears.

As you found later, i already commented on that and do not think it is
worth the effort. Users will be able to just have gpgsm, testers will
need gpg to test gpgsm.
 
> >  test_expect_success GPG 'log --graph --show-signature' '
> >  	git log --graph --show-signature -n1 signed >actual &&
> >  	grep "^| gpg: Signature made" actual &&
> >  	grep "^| gpg: Good signature" actual
> >  '
> >  
> > +test_expect_success GPGSM 'log --graph --show-signature x509' '
> > +	git log --graph --show-signature -n1 signed-x509 >actual &&
> > +	grep "^| gpgsm: Signature made" actual &&
> > +	grep "^| gpgsm: Good signature" actual
> > +'  
> 
> We're going to have a lot of duplicated tests here. That's a
> maintenance burden when one of them needs fixes later. And when new
> tests are added, we won't automatically get them tested under each
> format.
> 
> Can we move the battery of tests into a function that takes a few
> parameters (prereq name, branch to look at, etc) and then call it for
> both the gpg/gpgsm cases?

I guess this is part of the earlier "allow GPGSM without GPG" and i
can ignore it if we agree that this is not needed?

Henning
 
> -Peff

