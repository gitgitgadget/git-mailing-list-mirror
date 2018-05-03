Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C013200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeECQuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:50:14 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:13861 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeECQuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:50:11 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2018 12:50:08 EDT
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fEHJM-0000rV-3K; Thu, 03 May 2018 18:42:28 +0200
Date:   Thu, 3 May 2018 18:42:26 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
Cc:     "sbeller@google.com" <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: git merge banch w/ different submodule revision
Message-ID: <20180503164226.GB23564@book.hvoigt.net>
References: <1524739599.20251.17.camel@klsmartin.com>
 <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
 <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
 <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
 <20180430170229.GA775@book.hvoigt.net>
 <1525246025.2176.12.camel@klsmartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525246025.2176.12.camel@klsmartin.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, May 02, 2018 at 07:30:25AM +0000, Middelschulte, Leif wrote:
> Am Montag, den 30.04.2018, 19:02 +0200 schrieb Heiko Voigt:
> > On Thu, Apr 26, 2018 at 03:19:36PM -0700, Stefan Beller wrote:
> > > Stefan wrote:
> > > > See https://github.com/git/git/commit/68d03e4a6e448aa557f52adef92595ac4d6cd4bd
> > > > (68d03e4a6e (Implement automatic fast-forward merge for submodules, 2010-07-07)
> > > > to explain the situation you encounter. (specifically merge_submodule
> > > > at the end of the diff)
> > > 
> > > +cc Heiko, author of that commit.
> > 
> > In that commit we tried to be very careful about. I do not understand
> > the situation in which the current strategy would be wrong by default.
> > 
> > We only merge if the following applies:
> > 
> >  * The changes in the superproject on both sides point forward in the
> >    submodule.
> > 
> >  * One side is contained in the other. Contained from the submodule
> >    perspective. Sides from the superproject merge perspective.
> > 
> > So in case of the mentioned rewind of a submodule: Only one side of the
> > 3-way merge would point forward and the merge would fail.
> > 
> > I can imagine, that in case of a temporary revert of a commit in the
> > submodule that you would not want that merged into some other branch.
> > But that would be the same without submodules. If you merge a temporary
> > revert from another branch you will not get any conflict.
> > 
> > So maybe someone can explain the use case in which one would get the
> > results that seem wrong?
> In an ideal world, where there are no regressions between revisions, a
> fast-forward is appropriate. However, we might have regressions within
> submodules.
> 
> So the usecase is the following:
> 
> Environment:
> - We have a base library L that is developed by some team (Team B).
> - Another team (Team A) developes a product P based on those libraries using git-flow.
> 
> Case:
> The problem occurs, when a developer (D) of Team A tries to have a feature
> that he developed on a branch accepted by a core developer of P:
> If a core developer of P advanced the reference of L within P (linear history), he might
> deem the work D insufficient. Not because of the actual work by D, but regressions
> that snuck into L. The core developer will not be informed about the missmatching
> revisions of L.
> 
> So it would be nice if there was some kind of switch or at least some trigger.

I still do not understand how the current behaviour is mismatching with
users expectations. Let's assume that you directly tracked the files of
L in your product repository P, without any submodule boundary. How
would the behavior be different? Would it be? If D started on an older
revision and gets merged into a newer revision, there can always be
regressions even without submodules.

Why would the core developer need to be informed about mismatching
revisions if he himself advanced the submodule?

It seems to me that you do not want to mix integration testing and
testing of the feature itself. How about just testing/reviewing on the
branch then? You would still get the submodule revision D was working on
and then in a later stage check if integration with everything else
works.

Cheers Heiko
