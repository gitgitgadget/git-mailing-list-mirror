Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B0A1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 08:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeGFICU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 04:02:20 -0400
Received: from thoth.sbs.de ([192.35.17.2]:33259 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753428AbeGFICR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 04:02:17 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6681r1n019219
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 10:01:53 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6681qu3027904;
        Fri, 6 Jul 2018 10:01:52 +0200
Date:   Fri, 6 Jul 2018 10:01:52 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 8/8] gpg-interface t: extend the existing GPG tests with
 GPGSM
Message-ID: <20180706100152.317da7f7@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180706011447.GC7697@genre.crustytoothpaste.net>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <9ad3e4b6adb38440d5766e34e3a41b7f64281dca.1530616446.git.henning.schild@siemens.com>
 <20180706011447.GC7697@genre.crustytoothpaste.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fri, 6 Jul 2018 01:14:47 +0000
schrieb "brian m. carlson" <sandals@crustytoothpaste.net>:

> On Tue, Jul 03, 2018 at 02:38:20PM +0200, Henning Schild wrote:
> > Add test cases to cover the new X509/gpgsm support. Most of them
> > resemble existing ones. They just switch the format to X509 and set
> > the signingkey when creating signatures. Validation of signatures
> > does not need any configuration of git, it does need gpgsm to be
> > configured to trust the key(-chain).
> > We generate a self-signed key for committer@example.com and
> > configure gpgsm to trust it.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  t/lib-gpg.sh               |  9 ++++++-
> >  t/lib-gpg/gpgsm-gen-key.in |  6 +++++
> >  t/t4202-log.sh             | 66
> > ++++++++++++++++++++++++++++++++++++++++++++++
> > t/t5534-push-signed.sh     | 52
> > ++++++++++++++++++++++++++++++++++++ t/t7003-filter-branch.sh   |
> > 15 +++++++++++ t/t7030-verify-tag.sh      | 47
> > +++++++++++++++++++++++++++++++-- t/t7600-merge.sh           | 31
> > ++++++++++++++++++++++ 7 files changed, 223 insertions(+), 3
> > deletions(-) create mode 100644 t/lib-gpg/gpgsm-gen-key.in
> > 
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
> It looks like the GPGSM prerequisite will only be set if the GPG
> prerequisite is set as well.  Do we want to consider the case when the
> user might have gpgsm but not gpg?

Nice finding, i should have tried to hide that better ;).

I thought about it when writing the code. There might be distributions
where you can install one without the other. I also introduces a few
tests that rely on the implication, where GPGSM tests on top of GPG.
(i.e. t7030 "create signed tags x509")
The implication is really just there for the tests, not for end-users.
Dropping it would create more variations in testing (make it more
expensive).

I would say it is not worth it at the moment.

Implementing the gpg.format detection by actually calling the "other"
program to find which one knows the key, would shine another light on
that one. But i kind of doubt that idea is a good one.

Henning
