From: Nicolas Pitre <nico@cam.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 09:27:30 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801110913410.3054@xanadu.home>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
 <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net>
 <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org>
 <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
 <20080111094516.GD20141@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 15:28:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDKrc-0004G4-Je
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 15:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759383AbYAKO1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 09:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759369AbYAKO1h
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 09:27:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53763 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759065AbYAKO1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 09:27:36 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUH00KNCHHUIND0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 11 Jan 2008 09:27:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080111094516.GD20141@artemis.madism.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70163>

On Fri, 11 Jan 2008, Pierre Habouzit wrote:

> Okay the numbers are still not that impressive, but my patch doesn't
> touches _only_ deltas, but also log comments I said, so I've redone my
> tests with git log and *TADAAAA*:
> 
> vanilla git:
>     repeat 5 time git log >|/dev/null
>     git log >| /dev/null  2,54s user 0,12s system 99% cpu 2,660 total
>     git log >| /dev/null  2,52s user 0,12s system 99% cpu 2,653 total
>     git log >| /dev/null  2,57s user 0,07s system 99% cpu 2,637 total
>     git log >| /dev/null  2,56s user 0,09s system 99% cpu 2,659 total
>     git log >| /dev/null  2,54s user 0,10s system 99% cpu 2,660 total
> 
> with the 512 octets limit:
> 
>     $ repeat 5 time git log >|/dev/null
>     git log >| /dev/null  2,10s user 0,10s system 99% cpu 2,193 total
>     git log >| /dev/null  2,08s user 0,10s system 99% cpu 2,189 total
>     git log >| /dev/null  2,06s user 0,11s system 100% cpu 2,162 total
>     git log >| /dev/null  2,04s user 0,13s system 100% cpu 2,172 total
>     git log >| /dev/null  2,06s user 0,13s system 99% cpu 2,198 total
> 
>     That's already a 20% time reduction.

Well, sorry but that doesn't count to me.  The whole 'git log' taking 
around 2 seconds is already hell fast for what it does, and IMHO this is 
not worth increasing the repository storage size for this particular 
work load.

> with the 1024 octets limits:
>     $ repeat 5 time git log >|/dev/null
>     git log >| /dev/null  1,39s user 0,12s system 99% cpu 1,512 total
>     git log >| /dev/null  1,38s user 0,12s system 100% cpu 1,498 total
>     git log >| /dev/null  1,41s user 0,10s system 99% cpu 1,514 total
>     git log >| /dev/null  1,41s user 0,10s system 100% cpu 1,506 total
>     git log >| /dev/null  1,40s user 0,10s system 100% cpu 1,504 total
> 
>     Yes that's 43% time reduction !

If that was 43% reduction of a 10 second operation then sure I would 
agree, like the blame operation typically is.  But otherwise the 
significant storage size increase is not worth the reduction of less 
than a second in absolute time.

>   As a side note, repacking with the 1024 octets limits takes 4:06 here,
> and 4:26 without the limit at all, which is 8% less time. I know it
> doesn't matters a lot as repack is a once time operation, but still, it
> would speed up git gc --auto which is not something to neglect
> completely.

No, I doubt it would.  The bulk of 'git gc --auto' will reuse existing 
pack data which is way different from 'git repack -f'. 

> I say it's worth investigating a _lot_,

Well, I was initially entousiastic about this avenue, but the speed 
performance difference is far from impressive IMHO, given the tradeoff.


Nicolas
