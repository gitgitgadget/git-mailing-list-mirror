Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC821F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 15:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfJ1PVA convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 28 Oct 2019 11:21:00 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24527 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfJ1PVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 11:21:00 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x9SFKsaA088172
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Oct 2019 11:20:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
References: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com> <nycvar.QRO.7.76.6.1910281405000.46@tvgsbejvaqbjf.bet> <026401d58d9a$2bbe7600$833b6200$@nexbridge.com> <20191028145220.GU4348@szeder.dev>
In-Reply-To: <20191028145220.GU4348@szeder.dev>
Subject: RE: [BUG] git 2.24.0-rc1 t0500 on NonStop in Jenkins
Date:   Mon, 28 Oct 2019 11:20:48 -0400
Message-ID: <027301d58da3$4a4996a0$dedcc3e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHPNYlvTp8HvTWaccQRmuAfB7Lx7gHWySK8AblOW5QChv72x6dMHmGQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 28, 2019 10:52 AM, SZEDER Gábor wrote:
> On Mon, Oct 28, 2019 at 10:15:31AM -0400, Randall S. Becker wrote:
> > Here is the verbose output from subtest 2 that failed. Sorry it took
> > so long, we had to arrange a different Jenkins job to test this in isolation.
> > Format issue?
> >
> > Cheers,
> > Randall
> >
> > expecting success of 0500.2 'progress display with total':
> > 	cat >expect <<-\EOF &&
> > 	Working hard:  33% (1/3)<CR>
> > 	Working hard:  66% (2/3)<CR>
> > 	Working hard: 100% (3/3)<CR>
> > 	Working hard: 100% (3/3), done.
> > 	EOF
> >
> > 	cat >in <<-\EOF &&
> > 	progress 1
> > 	progress 2
> > 	progress 3
> > 	EOF
> > 	test-tool progress --total=3 "Working hard" <in 2>stderr &&
> >
> > 	show_cr <stderr >out &&
> > 	test_i18ncmp expect out
> >
> > + cat
> > + 1> expect 0< /tmp/sh1811939370.4
> 
> Wow :)
> 
> > + cat
> > + 1> in 0< /tmp/sh1811939370.5
> > + test-tool progress --total=3 Working hard 0< in 2> stderr show_cr 0<
> > + stderr 1> out
> 
> Another wow.
> 
> This is unrelated to the test failure, but makes me rather curious:
> you run the test script with '-x', that's why we see the trace of commands
> executed during the test.  Interestingly, though, we don't see any trace of
> commands executed within any shell function invoked in the test, i.e. from
> show_cr above and test_i18ncmp below.
> 
> What kind of shell is this?

The test output requested by Johannes was to use -i -v -x. We use ksh and have for years to test git. The command used was done within a Jenkins environment and was:

cd t && sh t0500-progress-display.sh -i -v -x

> 
> > + test_i18ncmp expect out
> > --- expect	2019-10-28 14:11:40 +0000
> > +++ out	2019-10-28 14:11:41 +0000
> > @@ -1,4 +1,2 @@
> > -Working hard:  33% (1/3)<CR>
> > -Working hard:  66% (2/3)<CR>
> > -Working hard: 100% (3/3)<CR>
> > -Working hard: 100% (3/3), done.
> > +Working hard:   0% (1/12884901888)<CR>
> > +Working hard:   0% (3/12884901888), done.
> 
> Weird, this looks exactly like the big-endian test failure that was fixed in
> 2b6f6ea1bd (test-progress: fix test failures on big-endian systems, 2019-10-
> 20), but that is already in 2.24.0-rc1 (but not yet in -rc0).
> 
> https://public-inbox.org/git/f1ce445e-6954-8e7b-2dca-
> 3a566ce689a5@physik.fu-berlin.de/
> 
> Is NonStop big or little-endian?  Does t0500 pass without 2b6f6ea1bd?

NonStop is big-endian. When t0500 is run from an interactive terminal, it passes. This failure seems to be a result of being in a disconnected terminal situation typical of Jenkins, not that the test result makes any sense with that being the only difference. t0500 did not exist in 2.23.0, our last build, so I can't easily get that answer. Our Jenkins is based off the master branch, so it's a hard to revert in our pipeline without a serious amount of work - that and without 2b6f6ea1bd, other things break if I remember from August.

Does the printf format use positional arguments (%digit$)? That has known issues on the platform.

FYI: int/long are 32 bits, long long is 64 bits. 12884901888 is 0x300000000, surprisingly.

> > error: last command exited with $?=1
> > not ok 2 - progress display with total
> > #
> > #		cat >expect <<-\EOF &&
> > #		Working hard:  33% (1/3)<CR>
> > #		Working hard:  66% (2/3)<CR>
> > #		Working hard: 100% (3/3)<CR>
> > #		Working hard: 100% (3/3), done.
> > #		EOF
> > #
> > #		cat >in <<-\EOF &&
> > #		progress 1
> > #		progress 2
> > #		progress 3
> > #		EOF
> > #		test-tool progress --total=3 "Working hard" <in 2>stderr &&
> > #
> > #		show_cr <stderr >out &&
> > #		test_i18ncmp expect out
> > #
> >

