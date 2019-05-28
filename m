Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9594B1F609
	for <e@80x24.org>; Tue, 28 May 2019 01:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfE1BWP (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 21:22:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42844 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfE1BWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 21:22:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9295E1F462;
        Tue, 28 May 2019 01:22:14 +0000 (UTC)
Date:   Tue, 28 May 2019 01:22:14 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Chris Mayo <aklhfex@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] send-email: remove documented requirement for
 Net::SMTP::SSL
Message-ID: <20190528012214.p7t4kfthxia4y464@dcvr>
References: <20190526172242.13000-1-aklhfex@gmail.com>
 <20190527193517.GA22013@dcvr>
 <87imtvmy7f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imtvmy7f.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, May 27 2019, Eric Wong wrote:
> > Chris Mayo <aklhfex@gmail.com> wrote:
> >> git-send-email uses the TLS support in the Net::SMTP core module from
> >> recent versions of Perl. Documenting the minimum version is complex
> >> because of separate numbering for Perl (5.21.5~169), Net:SMTP (2.34)
> >> and libnet (3.01). Version numbers from commit:
> >> bfbfc9a953 ("send-email: Net::SMTP::starttls was introduced in v2.34",
> >> 2017-05-31)
> >
> > No disagreement for removing the doc requirement for Net::SMTP::SSL.
> >
> > But core modules can be split out by OS packagers.  For
> > Fedora/RH-based systems, the trend tends to be increasing
> > granularity and having more optional packages.
> >
> > So I think documenting Net::SMTP (and Net::Domain) as
> > requirements would still be good, perhaps with a note stating
> > they're typically installed with Perl.
> >
> > Fwiw, I recently ran into some issues where core modules such as
> > Devel::Peek, Encode, and autodie were separate packages on CentOS 7.
> 
> I've done enough git-send-email patching in anger for a year at least
> with what's sitting in "next" so I'm not working on this, but just my
> 0.02:
> 
> I wonder if we shouldn't just be much more aggressive about version
> requirements for something like git-send-email.
> 
> Do we really have git users who want a new git *and* have an old perl
> *and* aren't just getting it from an OS package where the module is
> dual-life, so the distributor can just package up the newer version if
> we were to require it?

I started writing this earlier, but dropped my connection.
And brian said the same thing I was going to say.

If OS packagers were to start making Net::SMTP/Net::Domain
optional (which I sorta expect...), we should make them
optional, too (and add descriptive error messages and manpage
updates).

I have no need for Net::SMTP with sendemail.smtpserver=/usr/bin/msmtp

> I.e. couldn't we just remove the fallback code added in 0ead000c3a
> ("send-email: Net::SMTP::SSL is obsolete, use only when necessary",
> 2017-03-24) and do away with this version detection (which b.t.w. should
> just do a $obj->can("starttls") check instead).

Too soon for the fallback code removal; maybe when CentOS 6 is
EOL.... However, the "->can" check is nicer, yes.

> For shipping a newer Net::SMTP we aren't talking about upgrading
> /usr/bin/perl, just that module, and anyone who's packaging git
> (e.g. Debian) who cares about minimal dependencies is likely splitting
> out git-send-email.perl anyway.
> 
> We could then just add some flag similar to NO_PERL_CPAN_FALLBACKS so
> we'd error out by default unless these modules were there when git was
> built, packagers could then still set some "no I can't be bothered with
> send-email at all" or "no I can't be bothered with its SSL support", in
> the latter case git-send-email would work except for the SSL parts.
> 
> That would take care of the communication about module dependencies via
> manpage problem since we'd error by default. When I package things I
> much prefer that error mode to "parts of package silently don't work
> because we check at runtime and I didn't religiously scour the
> docs/release notes".

I prefer we check options passed to the program and decide
which dependencies to require based on that.  The manpage and
--help could be listing the modules required for certain option
groups, even.

> I wouldn't say the same thing about git-add--interactive.perl due to
> more common its use is.

I wish to see git-send-email (and vendor-neutral messaging in
general) gain more traction.  IMHO, send-email should reach the
commonality of other parts of git.



(*) if/when I find the time, I'd make "git svn find-rev"
    work w/o SVN::Perl, too.
