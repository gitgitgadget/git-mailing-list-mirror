Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F14020372
	for <e@80x24.org>; Sun,  8 Oct 2017 11:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbdJHL4Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 07:56:24 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:41989 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdJHL4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 07:56:23 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38166 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e1ABy-0003zk-FL; Sun, 08 Oct 2017 07:56:22 -0400
Date:   Sun, 8 Oct 2017 07:56:20 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain> <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain> <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain> <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net> <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain> <1507412674.8322.4.camel@mad-scientist.net> <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
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

On Sun, 8 Oct 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> > ... so if, in the kernel source
> > tree, i ran:
> >
> >   $ git rm \*.c
> >
> > i would end up removing *all* 25,569 "*.c" files in the kernel
> > source repository.
>
> Yes, as that is exactly what the command line asks Git to do.

  ok, i truly want to understand this, so let me dig through this
carefully. i can now see (from the man page and the recent
explanations) that "git rm" will accept *escaped* fileglobs to remove
and that, further, "File globbing matches across directory
boundaries." which is why, in the linux kernel source tree, if i run
one of:

  $ git rm \*.c
  $ git rm '*.c'

the "git rm" command will internally process the fileglob and apply it
across directory boundaries. and that's why, when i try a dry run, i
can see the effect it would have on the kernel source:

  $ git rm -n '*.c' | wc -l
  25569
  $

> If you said
>
>     $ git rm *.c
>
> then the shell expands the glob and all Git sees is that you want to
> remove a.c b.c d.c ...; if you said "git rm -r *.c", unless b.c is
> not a directory, these and only these files are removed.

  right, that's just regular shell fileglob processing, no surprise
there. (let's stick to just file removal for now.)

> >   however, let's say i wanted to remove, recursively, all files with a
> > *precise* (non-globbed) name, such as "Makefile". so i, naively, run:
> >
> >   $ git rm Makefile
> >
> > guess what ... the lack of globbing means i remove only the single
> > Makefile at the top of the working directory.
>
> Again, that is exactly what you asked Git to do.

  yes, now i get it -- a lack of fileglob arguments disallows
traversing directory boundaries, so one gets the "normal" behaviour.

>     $ git rm $(find . -name Makefile -print)
>
> would of course one way to remove all Makefiles.  If you let POSIX
> shell glob, i.e.
>
>     $ git rm */Makefile
>
> the asterisk would not expand nothing but a single level, so it may
> remove fs/Makefile, but not fs/ext4/Makefile (some shells allow
> "wildmatch" expansion so "git rm **/Makefile" may catch the latter
> with such a shell).

  sure, all regular shell fileglob processing.

> By letting Git see the glob, i.e.
>
>     $ git rm Makefile \*/Makefile
>
> you would let Git to go over the paths it knows/cares about to find
> ones that match the pathspec pattern and remove them (but not
> recursively, even if you had a directory whose name is Makefile; for
> that, you would use "-r").

  right ... i can now see that '*/Makefile' would pick up all
Makefiles *below* the current directory, so you need that initial
reference to 'Makefile' to catch the top one. this just seems ...
awkward.

  but as i asked in my earlier post, if i wanted to remove *all* files
with names of "Makefile*", why can't i use:

  $ git rm 'Makefile*'

just as i used:

  $ git rm '*.c'

are those not both acceptable fileglobs? why does the former clearly
only match the top-level Makefile, and refuse to cross directory
boundaries?

  $ git rm -n 'Makefile*'
  rm 'Makefile'
  $

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
