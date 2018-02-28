Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726B71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbeB1SVp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:21:45 -0500
Received: from elephants.elehost.com ([216.66.27.132]:37321 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeB1SVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:21:44 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1SILWiC005016
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Feb 2018 13:21:33 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     "'demerphq'" <demerphq@gmail.com>, "'Jeff King'" <peff@peff.net>,
        "'Eric Wong'" <e@80x24.org>, "'Git'" <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com> <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir> <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr> <20180228074918.GA32127@sigill.intra.peff.net> <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com> <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com> <20180228174402.GC251290@aiede.svl.corp.google.com>
In-Reply-To: <20180228174402.GC251290@aiede.svl.corp.google.com>
Subject: RE: [Problem] test_must_fail makes possibly questionable assumptions about exit_code.
Date:   Wed, 28 Feb 2018 13:21:27 -0500
Message-ID: <005901d3b0c0$f5acd370$e1067a50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJEpadERfpX5LkwuayU7lmWnKekrgHW5ptIArDwK6kB6BkubwJEbisnAR6VsxoBc3aoQAIARwqYArfRsxKiWDxbEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 28, 2018 12:44 PM, Jonathan Nieder wrote:
> Randall S. Becker wrote:
> 
> > The problem is actually in git code in its test suite that uses perl
> > inline, not in my test code itself. The difficulty I'm having is
> > placing this appropriate so that the signal handler gets used
> > throughout the test suite including in the perl -e invocations. This
> > is more a lack of my own understanding of plumbing of git test
> > framework rather than of using or coding perl.
> 
> Can you elaborate with an example?  My understanding was that
> test_must_fail is only for running git.  If a test is running perl and
wants to
> check its exit code, the test is supposed to use !, not test_must_fail.
> 
> t/README backs me up:
> 
>  - use '! git cmd' when you want to make sure the git command exits
>    with failure in a controlled way by calling "die()".  Instead,
>    use 'test_must_fail git cmd'.  This will signal a failure if git
>    dies in an unexpected way (e.g. segfault).
> 
>    On the other hand, don't use test_must_fail for running regular
>    platform commands; just use '! cmd'.  We are not in the business
>    of verifying that the world given to us sanely works.
> 
> So I don't consider the initial issue you raised a test issue at all!
> It's a bug in the git commands, and a fix for it should not be specific to
the
> test suite.
> 
> And now it sounds like there is a second issue: the test suite is
overusing
> test_must_fail in some context and that needs to be fixed as well.

Have a look at a recent t1404 as a sample. Line 615 is the one causing the
platform grief, because it triggers a 'die'. However, the particular test
case #54, had no difference on platform with test_must_fail or !, which has
the same underlying EBADF completion after digging and digging.

not ok 52 - delete fails cleanly if packed-refs file is locked
#
#               prefix=refs/locked-packed-refs &&
#               # Set up a reference with differing loose and packed
versions:
#               git update-ref $prefix/foo $C &&
#               git pack-refs --all &&
#               git update-ref $prefix/foo $D &&
#               git for-each-ref $prefix >unchanged &&
#               # Now try to delete it while the `packed-refs` lock is held:
#               : >.git/packed-refs.lock &&
#               test_when_finished "rm -f .git/packed-refs.lock" &&
#               ! git update-ref -d $prefix/foo >out 2>err &&
#               git for-each-ref $prefix >actual &&
#               test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File
exists" err &&
#               test_cmp unchanged actual
#

