Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9005F1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 03:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdBHDK6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 22:10:58 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:54632 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdBHDK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 22:10:57 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1cbIBW-0003yH-GK; Wed, 08 Feb 2017 11:40:42 +0900
Date:   Wed, 8 Feb 2017 11:40:42 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
Message-ID: <20170208024042.trmkjm4jnxidcflg@glandium.org>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1702071739060.17609@i7.lan>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 05:48:26PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 7 Feb 2017, Linus Torvalds wrote:
> > 
> > [ Clarification from original message, since Junio asked: I didn't
> >   actually want the semantics of '.' at all, since in a subdirectory it
> >   limits to the current subdirectory. So I'd suggest that in the absence
> >   of any positive pattern, there is simply no filtering at all, so
> >   whenever I say '.' as a pattern, I really meant ":(top)." which is
> >   even more of a cumbersom syntax that the current model really
> >   encourages. Crazy. Since I tend to always work in the top directory,
> >   the two are the same for me ]
> 
> So here's an RFC patch, and I'm quoting the above part of my thinking 
> because it's what the patch does, but it turns out that it's probably not 
> what we want, and I suspect the "." behavior (as opposed to "no filtering 
> at all") is actually better.
> 
> Now _I_ don't much care, since I only work from the top level, but without 
> the "." behavior, you get into an odd situation that the negative match 
> will be relative to the current directory, but then the positive matches 
> will be everywhere else. 
> 
> Obviously, a negative match that has "top" set would change that logic. So 
> this patch is purely a request for further discussion.
> 
> When I wrote the patch, I actually also removed the now stale entries from 
> the 'po' files, but I'm not including that part here because it just 
> distracts from the meat of it all. So this diff was actually generated 
> with the new syntax:
> 
> 	git diff -p --stat -- :^po/
> 
> and the only thing even remotely subtle here is that it changes our ctype 
> array to make '^' be both a regex and a pathspec magic character.
> 
> Everything else should be pretty darn obvious.
> 
> The code *could* just track all the 'relative to top or not' bits in the 
> exclusion pattern, and then use whatever top-ness the exclusion patterns 
> have (and maybe fall back to the old warning if it had a mixture of 
> exclusionary patterns). I'll happily change it to act that way if people 
> think that makes sense.
> 
> Comments?

It seems to me that `git diff` and `git diff -- :^stuff` should have the
same output if there aren't changes in stuff, and `git diff` does the
same as `git diff -- :/` if you are in a subdirectory, not the same as
`git diff .`.

As such, the default positive match should be ':/' (which is shorter and
less cumbersome than ':(top)', btw)

Mike
