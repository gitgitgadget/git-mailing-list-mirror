Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0930E1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935186AbeB1WDN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:03:13 -0500
Received: from elephants.elehost.com ([216.66.27.132]:38235 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935105AbeB1WDM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:03:12 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1SM35uR014300
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Feb 2018 17:03:06 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     "'demerphq'" <demerphq@gmail.com>, "'Jeff King'" <peff@peff.net>,
        "'Eric Wong'" <e@80x24.org>, "'Git'" <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com> <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir> <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr> <20180228074918.GA32127@sigill.intra.peff.net> <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com> <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com> <20180228174402.GC251290@aiede.svl.corp.google.com> <005901d3b0c0$f5acd370$e1067a50$@nexbridge.com> <20180228185152.GE251290@aiede.svl.corp.google.com> <006901d3b0cf$4a3f7d30$debe7790$@nexbridge.com>
In-Reply-To: <006901d3b0cf$4a3f7d30$debe7790$@nexbridge.com>
Subject: RE: [Problem] test_must_fail makes possibly questionable assumptions about exit_code.
Date:   Wed, 28 Feb 2018 17:02:59 -0500
Message-ID: <007001d3b0df$e8b9c280$ba2d4780$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJEpadERfpX5LkwuayU7lmWnKekrgHW5ptIArDwK6kB6BkubwJEbisnAR6VsxoBc3aoQAIARwqYArfRsxIBum2kDQI9KHGRAkksBwyiJneLMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 28, 2018 3:04 PM, Jonathan Nieder wrote:
> On February 28, 2018 1:52 PM, Jonathan Nieder wrote:
> > Randall S. Becker wrote:
> > > On February 28, 2018 12:44 PM, Jonathan Nieder wrote:
> > >> Randall S. Becker wrote:
> >
> > >>> The problem is actually in git code in its test suite that uses
> > >>> perl inline, not in my test code itself.
> > [...]
> > >> Can you elaborate with an example?  My understanding was that
> > >> test_must_fail is only for running git.
> > [...]
> > > Have a look at a recent t1404 as a sample. Line 615 is the one
> > > causing the platform grief, because it triggers a 'die'. However,
> > > the particular test case #54, had no difference on platform with
> > > test_must_fail or !, which has the same underlying EBADF completion
> after
> > digging and digging.
> >
> > Sorry to be dense: what I see on that line is
> >
> > 	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
> 
> My bad, I think. I'm going to go looking through my notes and get back on
> which line in the test was the issue. I assumed from your response that it
> might have been the test_must_fail, which is throughout the git test
suite.
> Obviously it isn't the line failing in this case. Stay tuned.

The original thread below has details of what the original issue was and
why. It hit three tests specifically on this platform where die was invoked
(at least on one of them). Perl was invoked under the covers and the
completion code of 169 propagated back through git to the test framework.
https://public-inbox.org/git/499fb29f-ca34-8d28-256d-896107c29a3e@kdbg.org/T
/#m0b30f0857feae2044f38e04dc6b8565b68b7d52b

While removing test_must_fail is laudable, it won't seemingly solve the
underlying cause that I am trying to work through, which is inserting the
$SIGdie reporting 169 on platform and inserting:

 SIG{__DIE__} = sub {
   CORE::die @_ if $^S || !defined($^S);
   print STDERR "fatal: @_";
   exit 128;
 };

I just don't know the framework well enough (or perl for that matter) to
know the exact spot to place this so that it would work properly and be
acceptable to the committers (you know who you are :-) ). 

I hope that provides info on what is going on and why I am motivated to fix
this by (nearly) whatever means necessary.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



