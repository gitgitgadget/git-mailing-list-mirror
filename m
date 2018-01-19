Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3821F404
	for <e@80x24.org>; Fri, 19 Jan 2018 23:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756225AbeASXaR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 19 Jan 2018 18:30:17 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39172 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756107AbeASXaL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 18:30:11 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0JNU3Pd000964
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Jan 2018 18:30:03 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180119173406.13324-6-randall.s.becker@rogers.com> <20180119212716.GB10303@sigill.intra.peff.net> <000c01d39174$eacfff10$c06ffd30$@nexbridge.com>
In-Reply-To: <000c01d39174$eacfff10$c06ffd30$@nexbridge.com>
Subject: RE: [PATCH v2 4/6] Force test suite traps to be cleared for NonStop ksh
Date:   Fri, 19 Jan 2018 18:29:57 -0500
Message-ID: <001d01d3917d$6de77060$49b65120$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5ceUaUBDLnBuBgyHh9+OiHAZcgwIdqx1qAYnQeoICMa0kB6MBSzGQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 19, 2018 5:29 PM, I wrote:
> On January 19, 2018 4:27 PM, Jeff King wrote:
> > On Fri, Jan 19, 2018 at 12:34:04PM -0500, randall.s.becker@rogers.com
> wrote:
> >
> > > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> > >
> > > * t/lib-git-daemon.sh: fix incompatibilities with ksh traps not being
> > >   cleared automatically on platform. This caused tests to seem to fail
> > >   while actually succeeding.
> > >
> > > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > > ---
> > >  t/lib-git-daemon.sh | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh index
> > > 987d40680..955beecd9 100644
> > > --- a/t/lib-git-daemon.sh
> > > +++ b/t/lib-git-daemon.sh
> > > @@ -68,6 +68,7 @@ start_git_daemon() {
> > >  		test_skip_or_die $GIT_TEST_GIT_DAEMON \
> > >  			"git daemon failed to start"
> > >  	fi
> > > +	trap '' EXIT
> > >  }
> >
> > I don't think this can be right. The way these traps are supposed to work is:
> >
> >   - as soon as test-lib.sh is loaded, we "trap die EXIT" to catch an
> >     accidental death/exit from one of the scripts
> >
> >   - when test_done is called, we clear the trap (i.e., it is OK to exit
> >     now because the script has given us a positive indication that all
> >     tests have been run)
> >
> >   - while the child git-daemon is running, we'd want to clean up after
> >     ourselves. So during start_git_daemon() we add our cleanup (followed
> >     by the original "die", because shell traps don't push onto a stack).
> >     And then at stop_git_daemon(), we restore the original die trap.
> >
> > But this patch means that while git-daemon is running, we have no trap at
> all!
> > That means that a failed test which causes us to exit would leave a
> > child daemon running.
> >
> > Furthermore, both of these functions now drop the 'die' trap entirely,
> > meaning the script would fail to notice premature exit from one of the
> > test snippets.
> >
> > So while this may be papering over a problem on NonStop, I think it's
> > breaking the intent of the traps.
> >
> > I'm not sure what the root of the problem is, but it sounds like ksh
> > may be triggering EXIT traps when we don't expect (during function
> returns?
> > Subshell exits? Other?)
> 
> The "unexpected" EXIT traps are exactly the issue we found when working
> with the platform support team. There was some discussion about what the
> right expectation was, and I was not able to have a change made to ksh on
> the platform. The problem may have a similar (identical?) root cause to the
> Perl exit issues we are also experiencing that is in their hands. I'm currently
> retesting without this change (results in 36 hours ☹ ). Is there a preferred
> way you would like me to bypass this except on NonStop? I can add a check
> based on uname.

The option that may work, if the tests that are currenting running until Sunday (sadly) fail miserably, is to use:

if [ `uname` = "NONSTOP_KERNEL" ]; then trap '' EXIT; fi

or perhaps to add a descriptive function along those lines. We have had two major operating system upgrades since the original case relating to ksh traps, so perhaps things might improve. Our baseline is that there are currently 6 breaks (t1308#23, t1405#52, t9001#31/106/107/134), most of which have been traced back to perl completion codes.

Cheers,
Randall
P.S. I am happy to explain why the tests perform the at the rate they do on the development machines I have, if anyone is interested, although dissertations might be involved 😉

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



