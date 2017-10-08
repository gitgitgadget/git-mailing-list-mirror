Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711E820372
	for <e@80x24.org>; Sun,  8 Oct 2017 11:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbdJHLhe (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 07:37:34 -0400
Received: from ikke.info ([178.21.113.177]:59274 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdJHLhe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 07:37:34 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A1974440397; Sun,  8 Oct 2017 13:37:32 +0200 (CEST)
Date:   Sun, 8 Oct 2017 13:37:32 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171008113732.GA8251@alpha.vpn.ikke.info>
References: <20171007190402.GH3382@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net>
 <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710080502050.19600@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710080502050.19600@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 05:07:12AM -0400, Robert P. J. Day wrote:
> On Sun, 8 Oct 2017, Junio C Hamano wrote:
> 
> > "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
> >
> > > ... so if, in the kernel source
> > > tree, i ran:
> > >
> > >   $ git rm \*.c
> > >
> > > i would end up removing *all* 25,569 "*.c" files in the kernel source
> > > repository.
> >
> > Yes, as that is exactly what the command line asks Git to do.
> 
>   so if i wanted git to remove, say, all files named "Makefile*" from
> everywhere in the linux kernel source tree, the (dry run) command
> would be:
> 
>   $ git rm -n Makefile\*
> 
> is that it? let's try that:
> 
>   $ git rm -n Makefile\*
>   rm 'Makefile'
>   $
> 
> oops.
> 
> rday
> 

So your question is not su much  about the recursive option (delete
mentioned directories, including their contents), but globbing
(expanding the * to any files matching the pattern).

The explanation of <files> mentions this:

   Files to remove. Fileglobs (e.g.  *.c) can be given to remove all
   matching files.

This indicates that git itself (not your shell alone) does file
globbing.

I think the confusing part is that most people have no clear idea of the
separation between what the shell sees and interprets, and what the
program actually gets.

When you execute:

    $ git rm Makefile\*

What git actually sees is this:

    Makefile*

The shell intepreted the \* to mean just '*' and not interpret it
itself, and provide that to the executed program. Git, in its turn,
would start matching any file to that pattern to see which files
matches.


If you would execute:

    $ git rm 'Makefile\*'

Git would see:

    Makefile\*

Which does the thing you intended. So you have to deal with 2 levels of
programs interpreting the arguments, not just one.

Whether '*.c' should match just all .c files in the current dir, or all
files ending with .c depends on whether the path seperator is matched by
* or not and is a separate discussion.

GITGLOSSARY(7) under pathspec mentions this:

    glob    Git treats the pattern as a shell glob suitable for consumption
            by fnmatch(3) with the FNM_PATHNAME flag: wildcards in the
            pattern will not match a / in the pathname.

So that seems to indicate '*.c' should only match .c files in the
current dir. I'm not sure why that's not the case.

I hope this clears up what's happening a bit, and perhaps can lead to
improvements to the documentation so that it's not so surprising.

Kind regards, Kevin.
