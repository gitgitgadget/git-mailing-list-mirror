Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE9C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272142086A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHDAN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:13:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53112 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgHDAN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:13:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7DD5E1F5AE;
        Tue,  4 Aug 2020 00:13:27 +0000 (UTC)
Date:   Tue, 4 Aug 2020 00:13:26 +0000
From:   Eric Wong <e@80x24.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] git-cvsexportcommit: port to SHA-256
Message-ID: <20200804001315.GA4899@dcvr>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-15-sandals@crustytoothpaste.net>
 <87zh7bo9so.fsf@igel.home>
 <20200803235007.GN6540@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803235007.GN6540@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On 2020-08-03 at 18:37:27, Andreas Schwab wrote:
> > On Jun 22 2020, brian m. carlson wrote:
> > 
> > > diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> > > index fc00d5946a..6483d792d3 100755
> > > --- a/git-cvsexportcommit.perl
> > > +++ b/git-cvsexportcommit.perl
> > > @@ -22,6 +22,10 @@
> > >  my $repo = Git->repository();
> > >  $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
> > >  
> > > +my $tmpdir = File::Temp->newdir;
> > 
> > File::Temp in perl 5.10 doesn't have the newdir method.
> 
> That method was added in File::Temp 0.19, which was added in 2007.  Does

5.10.0 doesn't have ->newdir, but 5.10.1 does.  I figure nobody
used 5.10.0 anymore since 5.10.1 exists and (IIRC) fixed many
things wrong in 5.10.0.

>   my $tmpdir = File::Temp::tempdir(CLEANUP => 1);
> 
> do the right thing on your Perl 5.10?  I no longer use CentOS 6 at work
> and it won't run in Docker on modern Debian, so I can't test.  If so,
> I'll send a patch.

I haven't touched CentOS 6 in several years, either.  I've been
testing public-inbox against 5.10.1 built using patches from
Devel::PatchPerl (libdevel-patchperl-perl in Debian)

> For the record, I plan to propose that we drop support for Perl versions
> earlier than 5.14 on December 2, since CentOS 6 will be dead at that
> point.  I think a ten-year lifespan for an OS is quite generous and
> we're still considering Perl 5.8.8, which nobody is publicly supporting
> anymore.

That's probably fine.  I haven't looked at 5.12 and 5.14 changes
enough to comment, but just moving rom 5.8 to 5.10.1 last year
made my life considerably better (e.g. `//', `//=')

In any case, it's probably a good idea to put use "v5.$SOMETHING"
with Perl 7 on the way (and Perl 8 will probably break v5 code :<)
