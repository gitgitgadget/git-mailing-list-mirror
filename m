Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277E81F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbeB1Rcr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 28 Feb 2018 12:32:47 -0500
Received: from elephants.elehost.com ([216.66.27.132]:64704 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeB1Rcp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:32:45 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1SHWaas003500
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Feb 2018 12:32:36 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'demerphq'" <demerphq@gmail.com>
Cc:     "'Jeff King'" <peff@peff.net>, "'Eric Wong'" <e@80x24.org>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Git'" <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com> <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir> <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr> <20180228074918.GA32127@sigill.intra.peff.net> <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com> <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com> <CANgJU+WFKqou=ZXcdr8V_ST=opHSBm9ksEVowxRB7o7DDEmuvg@mail.gmail.com>
In-Reply-To: <CANgJU+WFKqou=ZXcdr8V_ST=opHSBm9ksEVowxRB7o7DDEmuvg@mail.gmail.com>
Subject: RE: [Problem] test_must_fail makes possibly questionable assumptions about exit_code.
Date:   Wed, 28 Feb 2018 12:32:30 -0500
Message-ID: <004801d3b0ba$1f2ffa80$5d8fef80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJEpadERfpX5LkwuayU7lmWnKekrgHW5ptIArDwK6kB6BkubwJEbisnAR6VsxoBc3aoQAIARwqYAgWVWn6iXcYH8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 28, 2018 12:19 PM, demerphq wrote:
> On 28 February 2018 at 18:10, Randall S. Becker <rsbecker@nexbridge.com>
> wrote:
> > On February 28, 2018 11:46 AM, demerphq wrote:
> >> On 28 February 2018 at 08:49, Jeff King <peff@peff.net> wrote:
> >> > On Wed, Feb 28, 2018 at 07:42:51AM +0000, Eric Wong wrote:
> >> >
> >> >> > > >  a) We could override the meaning of die() in Git.pm.  This feels
> >> >> > > >     ugly but if it works, it would be a very small patch.
> >> >> > >
> >> >> > > Unlikely to work since I think we use eval {} to trap
> >> >> > > exceptions from die.
> >> >> > >
> >> >> > > >  b) We could forbid use of die() and use some git_die() instead
> (but
> >> >> > > >     with a better name) for our own error handling.
> >> >> > >
> >> >> > > Call sites may be dual-use: "die" can either be caught by an
> >> >> > > eval or used to show an error message to the user.
> >> >>
> >> >> <snip>
> >> >>
> >> >> > > >  d) We could wrap each command in an eval {...} block to convert
> the
> >> >> > > >     result from die() to exit 128.
> >> >> > >
> >> >> > > I prefer option d)
> >> >> >
> >> >> > FWIW, I agree with all of that. You can do (d) without an
> >> >> > enclosing eval block by just hooking the __DIE__ handler, like:
> >> >> >
> >> >> > $SIG{__DIE__} = sub {
> >> >> >   print STDERR "fatal: @_\n";
> >> >> >   exit 128;
> >> >> > };
> >> >>
> >> >> Looks like it has the same problems I pointed out with a) and b).
> >> >
> >> > You're right. I cut down my example too much and dropped the
> >> > necessary eval magic. Try this:
> >> >
> >> > -- >8 --
> >> > SIG{__DIE__} = sub {
> >> >   CORE::die @_ if $^S || !defined($^S);
> >> >   print STDERR "fatal: @_";
> >> >   exit 128;
> >> > };
> >>
> >> FWIW, this doesn't need to use CORE::die like that unless you have
> >> code that overrides die() or CORE::GLOBAL::die, which would be pretty
> unusual.
> >>
> >> die() within $SIG{__DIE__} is special cased not to trigger
> >> $SIG{__DIE__} again.
> >>
> >> Of course it doesn't hurt, but it might make a perl hacker do a
> >> double take why you are doing it. Maybe add a comment like
> >>
> >> # using CORE::die to armor against overridden die()
> >
> > The problem is actually in git code in its test suite that uses perl inline, not in
> my test code itself. The difficulty I'm having is placing this appropriate so that
> the signal handler gets used throughout the test suite including in the perl -e
> invocations. This is more a lack of my own understanding of plumbing of git
> test framework rather than of using or coding perl.
> 
> Did you reply to the wrong mail?
> 
> Create a file like:
> 
> .../Git/DieTrap.pm
> 
> which would look like  this:
> 
> package Git::DieTrap;
> use strict;
> use warnings;
> 
> SIG{__DIE__} = sub {
>    CORE::die @_ if $^S || !defined($^S);
>    print STDERR "fatal: @_";
>    exit 128;
> };
> 
> 1;
> __END__
> 
> and then you would do:
> 
> export PERL5OPT=-MGit::DieTrap
> 
> before executing any tests. ANY use of perl from that point on will behave as
> though it has:
> 
> use Git::DieTrap;
> 
> at the top of the script, be it a -e, or any other way that Perl code is
> executed.

The context of this request, perhaps missing, what that I have been trying to move the platform to the standard git code base. It is not my issue specifically. Rather, if someone else wants to build and test git on the platform, they should not have to have any knowledge of putting in hacks to make it work. I can personally make this work. That's not the point. It is to allow others on platform to make it work without deep knowledge. Otherwise, I am not being productive with my efforts.

Cheers,
Randall

