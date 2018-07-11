Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B08E1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbeGKQlX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:41:23 -0400
Received: from gecko.sbs.de ([194.138.37.40]:55935 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbeGKQlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:41:23 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id w6BGZufc021066
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 18:35:56 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6BGZt3K010261;
        Wed, 11 Jul 2018 18:35:55 +0200
Date:   Wed, 11 Jul 2018 18:35:54 +0200
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
Message-ID: <20180711183554.308bee82@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180711143352.GA14600@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
        <20180711143352.GA14600@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Wed, 11 Jul 2018 10:33:52 -0400
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
> By the way, I think these gpgsm invocations need some redirection of
> their stderr. This isn't inside a test_expect block, so they spew to
> the terminal even in non-verbose mode.
> 
> Ideally they'd redirect to descriptor 4, which then respects "-v"
> properly (though the existing gpg invocations just go to 2).

Thanks for pointing that out. I decided to go for 2 as well, for
consistency with gpg and not having to change that.

Henning

> -Peff

