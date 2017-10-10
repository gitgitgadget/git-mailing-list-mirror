Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1661FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 11:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755948AbdJJLw6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 07:52:58 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.100]:60443 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755888AbdJJLw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 07:52:57 -0400
Received: from [84.141.117.173] (helo=book.hvoigt.net)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e1t5g-0005eb-BG; Tue, 10 Oct 2017 13:52:52 +0200
Date:   Tue, 10 Oct 2017 13:52:50 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171010115250.GA75189@book.hvoigt.net>
References: <20171007190402.GH3382@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net>
 <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 07:56:20AM -0400, Robert P. J. Day wrote:
>   but as i asked in my earlier post, if i wanted to remove *all* files
> with names of "Makefile*", why can't i use:
> 
>   $ git rm 'Makefile*'
> 
> just as i used:
> 
>   $ git rm '*.c'
> 
> are those not both acceptable fileglobs? why does the former clearly
> only match the top-level Makefile, and refuse to cross directory
> boundaries?

Maybe think about it this way: The only difference between git's
globbing and the default shell globbing is that the '/' in a path has a
special meaning. The shells expansion stops at a '/' but git does not.

So with *.c the shell matches: blabla.c, blub.c, ...  but not
subdir/bla.c, subdir/blub.c, ... since it only considers files in the
current directory. A little different for Makefile* that will also match
Makefile.bla, Makefile/bla or Makefile_bla/blub in shell but not
subdir/Makefile or bla.Makefile. Basically anything directly in *this*
directory that *starts* with 'Makefile'.

Git on the other hand does not consider '/' to be special. So *.c
matches all of the path above: bla.c, blub.c, subdir/bla.c,
subdir/blub.c. Basically any file below the current directory with a
path that ends in '.c'. With Makefile* it is the opposite: Every file
below the current directory that *starts* with 'Makefile'. So
Makefile.bla, Makefile/bla, ... but also not subdir/Makefile or
bla.Makefile.

Maybe that helps...

Cheers Heiko

