Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62772208D0
	for <e@80x24.org>; Wed, 16 Aug 2017 16:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdHPQgA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 12:36:00 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:14029 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbdHPQf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 12:35:59 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1di1IS-0002v4-8c; Wed, 16 Aug 2017 18:35:56 +0200
Date:   Wed, 16 Aug 2017 18:35:54 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
Message-ID: <20170816163554.GA4683@book.hvoigt.net>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com>
 <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kag+U94tzJ14mB4VZjSZ2MtUJ4vu4MXKLKkpkLw=2K_NA@mail.gmail.com>
 <xmqqd17wpe14.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZAkdiKHUweQK6U4dqAakfzReDMfiHKDmzsKGuAH3BgyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZAkdiKHUweQK6U4dqAakfzReDMfiHKDmzsKGuAH3BgyA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

was about to write that we are maybe overly cautious here. Because the
current way a submodule ends up in the list to be pushed is through:

    find_unpushed_submodules()

that itself collects all changed submodules when submodule_needs_pushing() is
true. In there we have this:

    if (!submodule_has_commits(path, commits))
        /*
         * NOTE: We do consider it safe to return "no" here. The
         * correct answer would be "We do not know" instead of
         * "No push needed", but it is quite hard to change
         * the submodule pointer without having the submodule
         * around. If a user did however change the submodules
         * without having the submodule around, this indicates
         * an expert who knows what they are doing or a
         * maintainer integrating work from other people. In
         * both cases it should be safe to skip this check.
         */
        return 0;

So if the check, whether a submodule has commits, fails for any reason it will
not end up in the list to be pushed.

As a side note: inside submodule_has_commits() there is an add_submodule_odb()
followed by a process to really make sure that the commits are in the
submodule.

So IMO at this point we can be sure that the *database* exists and this extra
check could be dropped if we said that a caller to push_submodule() should make
sure that the submodule exists. The current ones are doing it already (if I did
not miss anything).

On Tue, Aug 15, 2017 at 06:05:25PM -0700, Stefan Beller wrote:
> On Tue, Aug 15, 2017 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Stefan Beller <sbeller@google.com> writes:
> >
> >>> Is "is it populated" a good thing to check here, though?  IIRC,
> >>> add-submodule-odb allows you to add the object database of an
> >>> inactivated submodule, so this seems to change the behaviour.  I do
> >>> not know if the behaviour change is a good thing (i.e. bugfix) or
> >>> not (i.e. regression) offhand, though.
> >>
> >> Good point, we should be able to push non-populated, even inactive(?)
> >> submodules. For that we strictly need add_submodule_odb here
> >> (or the repo object of the submodule, eventually).
> >>
> >> So let's retract this patch for now.
> >
> > Not so fast.
> 
> Ok, I took another look at the code.
> 
> While we may desire that un-populated submodules can be pushed
> (due to checking out another revision where the submodule
> doesn't exist, before pushing), this is not supported currently, because
> the call to run the push in the submodule assumes there is a
> "<path>/.git" on which the child process can operate.
> So for now we HAVE to have the submodule populated.

That is a good point though. In the current form of push_submodule() we need to
have a populated submodule. So IMO to check whether the submodule is actually
*populated* instead of adding the odb is correct and a possible bug fix.

Cheers Heiko
