Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD91B1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 14:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeB1Ozg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 28 Feb 2018 09:55:36 -0500
Received: from elephants.elehost.com ([216.66.27.132]:12679 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeB1Oze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 09:55:34 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1SEtNqM096377
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Feb 2018 09:55:24 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Eric Wong'" <e@80x24.org>
Cc:     "'Jonathan Nieder'" <jrnieder@gmail.com>, <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com> <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir> <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr> <20180228074918.GA32127@sigill.intra.peff.net>
In-Reply-To: <20180228074918.GA32127@sigill.intra.peff.net>
Subject: RE: [Problem] test_must_fail makes possibly questionable assumptions about exit_code.
Date:   Wed, 28 Feb 2018 09:55:17 -0500
Message-ID: <000501d3b0a4$29162a80$7b427f80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJEpadERfpX5LkwuayU7lmWnKekrgHW5ptIArDwK6kB6BkubwJEbisnAR6VsxqiiVrogA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 28, 2018 2:49 AM, Peff wrote:
> On Wed, Feb 28, 2018 at 07:42:51AM +0000, Eric Wong wrote:
> 
> > > > >  a) We could override the meaning of die() in Git.pm.  This feels
> > > > >     ugly but if it works, it would be a very small patch.
> > > >
> > > > Unlikely to work since I think we use eval {} to trap exceptions
> > > > from die.
> > > >
> > > > >  b) We could forbid use of die() and use some git_die() instead (but
> > > > >     with a better name) for our own error handling.
> > > >
> > > > Call sites may be dual-use: "die" can either be caught by an eval
> > > > or used to show an error message to the user.
> >
> > <snip>
> >
> > > > >  d) We could wrap each command in an eval {...} block to convert the
> > > > >     result from die() to exit 128.
> > > >
> > > > I prefer option d)
> > >
> > > FWIW, I agree with all of that. You can do (d) without an enclosing
> > > eval block by just hooking the __DIE__ handler, like:
> > >
> > > $SIG{__DIE__} = sub {
> > >   print STDERR "fatal: @_\n";
> > >   exit 128;
> > > };
> >
> > Looks like it has the same problems I pointed out with a) and b).
> 
> You're right. I cut down my example too much and dropped the necessary
> eval magic. Try this:
> 
> -- >8 --
> SIG{__DIE__} = sub {
>   CORE::die @_ if $^S || !defined($^S);
>   print STDERR "fatal: @_";
>   exit 128;
> };
> 
> eval {
>   die "inside eval";
> };
> print "eval status: $@" if $@;
> 
> die "outside eval";
> -- 8< --
> 
> Running that should produce:
> 
> $ perl foo.pl; echo $?
> eval status: inside eval at foo.pl line 8.
> fatal: outside eval at foo.pl line 12.
> 128
> 
> It may be getting a little too black-magic, though. Embedding in an eval is at
> least straightforward, if a bit more invasive.

I like this solution. The $64K question for me is how (a.k.a. where) to instrument this broadly instead of in each perl fragment in the test suite.  The code:

$SIG{__DIE__} = sub {
  CORE::die @_ if $^S || !defined($^S);
  print STDERR "fatal: @_";
  exit 128;
};

eval {
  die "inside eval";
};

print "eval status: $@" if $@;

die "outside eval";

as tested above, in NonStop results in an exit code of 128 whether run from a script or from stdin (a good thing). I'm happy to do the heavy lifting on this, but  a bit more direction as to the implementation would help.

Cheers,
Randall

