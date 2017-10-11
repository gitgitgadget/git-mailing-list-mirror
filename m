Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34F320372
	for <e@80x24.org>; Wed, 11 Oct 2017 08:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757430AbdJKIb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 04:31:58 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:49807 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757373AbdJKIbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 04:31:55 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:56408 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e2CQj-0003qz-VT; Wed, 11 Oct 2017 04:31:54 -0400
Date:   Wed, 11 Oct 2017 04:31:51 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Heiko Voigt <hvoigt@hvoigt.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <20171010115250.GA75189@book.hvoigt.net>
Message-ID: <alpine.LFD.2.21.1710110430020.10556@localhost.localdomain>
References: <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain> <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net> <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net> <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain> <1507412674.8322.4.camel@mad-scientist.net> <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain> <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain> <20171010115250.GA75189@book.hvoigt.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 10 Oct 2017, Heiko Voigt wrote:

> On Sun, Oct 08, 2017 at 07:56:20AM -0400, Robert P. J. Day wrote:
> >   but as i asked in my earlier post, if i wanted to remove *all* files
> > with names of "Makefile*", why can't i use:
> >
> >   $ git rm 'Makefile*'
> >
> > just as i used:
> >
> >   $ git rm '*.c'
> >
> > are those not both acceptable fileglobs? why does the former
> > clearly only match the top-level Makefile, and refuse to cross
> > directory boundaries?
>
> Maybe think about it this way: The only difference between git's
> globbing and the default shell globbing is that the '/' in a path
> has a special meaning. The shells expansion stops at a '/' but git
> does not.
>
> So with *.c the shell matches: blabla.c, blub.c, ...  but not
> subdir/bla.c, subdir/blub.c, ... since it only considers files in
> the current directory. A little different for Makefile* that will
> also match Makefile.bla, Makefile/bla or Makefile_bla/blub in shell
> but not subdir/Makefile or bla.Makefile. Basically anything directly
> in *this* directory that *starts* with 'Makefile'.
>
> Git on the other hand does not consider '/' to be special. So *.c
> matches all of the path above: bla.c, blub.c, subdir/bla.c,
> subdir/blub.c. Basically any file below the current directory with a
> path that ends in '.c'. With Makefile* it is the opposite: Every
> file below the current directory that *starts* with 'Makefile'. So
> Makefile.bla, Makefile/bla, ... but also not subdir/Makefile or
> bla.Makefile.

   ok, i believe i finally appreciate what is happening here, and
perhaps my first contribution will be a minor addition to the "git-rm"
man page to introduce a couple examples explaining these intricacies,
since they're not immediately obvious. i'll put something together and
submit it to the list. thank you all for your patience in explaining
this.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
