Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B89B1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754467AbeGII1p (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 04:27:45 -0400
Received: from thoth.sbs.de ([192.35.17.2]:58853 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754446AbeGII1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 04:27:43 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w698RRbM023875
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 10:27:27 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w698RQX2009035;
        Mon, 9 Jul 2018 10:27:26 +0200
Date:   Mon, 9 Jul 2018 10:27:26 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/8] t/t7510: check the validation of the new config
 gpg.format
Message-ID: <20180709102726.754c37cf@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqfu0wjetl.fsf@gitster-ct.c.googlers.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <9fd9d0d2ee3ae549baf8e9a710dfffbc118e66f7.1530616446.git.henning.schild@siemens.com>
        <xmqqfu0wjetl.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fri, 6 Jul 2018 13:21:10 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > Valid values are already covered by all tests that use GPG, now also
> > test what happens if we go for an invalid one.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  t/t7510-signed-commit.sh | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> > index 6e2015ed9..cb523513f 100755
> > --- a/t/t7510-signed-commit.sh
> > +++ b/t/t7510-signed-commit.sh
> > @@ -227,4 +227,14 @@ test_expect_success GPG 'log.showsignature
> > behaves like --show-signature' ' grep "gpg: Good signature" actual
> >  '
> >  
> > +test_expect_success GPG 'check gpg config for malformed values' '
> > +	mv .git/config .git/config.old &&
> > +	test_when_finished "mv .git/config.old .git/config" &&  
> 
> Hmmmmm.  
> 
> Is the damage caused by throwing a bad value at gpg.format designed
> to be so severe that "test_when_finished test_unconfig ..." cannot
> recover from?  This test script is not about how "git config" is
> implemented and works, so it would be a good idea for it to be even
> oblivious to the fact that .git/config is the file being mucked with
> when we do "git config".
> 
> I have a suspicion that you can just use test_config (which would
> arrange "test_when_finished test_unconfig ..." for free).
> 
> > +	git config gpg.format malformed &&
> > +	test_expect_code 128 git commit -S --amend -m "fail"
> > 2>result &&  
> 
> Is this 128 something we document and have users rely on?  Or should
> we rather say
> 
> 	test_must_fail git commit ...
> 
> here instead?

This is basically an adopted copy of t1308 'check line errors for
malformed values'.

I will have a look at test_config.

Henning

> > +	test_i18ngrep "malformed value for gpg.format: malformed"
> > result &&
> > +	test_i18ngrep "fatal: .*\.git/config" result &&
> > +	test_i18ngrep "fatal: .*line 2" result
> > +'
> > +
> >  test_done  

