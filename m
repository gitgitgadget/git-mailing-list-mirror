From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Tue, 12 Jul 2005 19:21:40 +0200
Message-ID: <42D3FC24.7010509@gmail.com>
References: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>	<42D17D89.9080808@innehallsbolaget.se>	<7v4qb2ni73.fsf@assigned-by-dhcp.cox.net> <42D2960E.3050008@gmail.com> <7vu0j0ncnr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 19:24:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsOUq-0006yY-6V
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 19:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVGLRX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 13:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVGLRVx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 13:21:53 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:2196 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261764AbVGLRVr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 13:21:47 -0400
Received: by zproxy.gmail.com with SMTP id 16so597nzp
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 10:21:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=juO7hWxkjNoJubD/eDtu+bLuGnQ/k29pGP7Rz27WAOlrJCeaCwOeEN7iMdRyUj0/u2jaHx69TOwYajdaYNZN2cYKa2Qqe1vcDgQwoIwTMXcHK+wh1hHEv0QkH+Gvecza4tnIiQY1reSDyXsR3M97ZH7uG9TkTlWr0XmKmb9z5eM=
Received: by 10.36.33.19 with SMTP id g19mr29162nzg;
        Tue, 12 Jul 2005 10:21:44 -0700 (PDT)
Received: from ?192.168.0.35? ([217.211.115.65])
        by mx.gmail.com with ESMTP id 19sm2926851nzp.2005.07.12.10.21.43;
        Tue, 12 Jul 2005 10:21:44 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0j0ncnr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Dan Holmsand <holmsand@gmail.com> writes:
>>Repacking all of that to a single pack file gives, somewhat
>>surprisingly, a pack size of 62M (+ 1.3M index). In other words, the
>>cost of getting all those branches, and all of the new stuff from
>>Linus, turns out to be *negative* (probably due to some strange
>>deltification coincidence).
> 
> 
> We do _not_ want to optimize for initial slurps into empty
> repositories.  Quite the opposite.  We want to optimize for
> allowing quick updates of reasonably up-to-date developer repos.
> If initial slurps are _also_ efficient then that is an added
> bonus; that is something the baseline big pack (60M Linus pack)
> would give us already.  So repacking everything into a single
> pack nightly is _not_ what we want to do, even though that would
> give the maximum compression ;-).  I know you understand this,
> but just stating the second of the above paragraphs would give
> casual readers a wrong impression.

I agree, to a point: I think the bonus is quite nice to have... As it 
is, it's actually faster on my machine to clone a fresh tree of Linus' 
than it is to "git clone" a local tree (without doing the hardlinking 
"cheating", that is). And it's kind of nice to have the option to start 
completely fresh.

Anyway, my point is this: to make pulling efficient, we should ideally 
have (1) as few object files to pull as possible, especially when using 
http, and (2) have as few packs as possible, to gain some compression 
for those who pull more seldom. Point 1 is obviously the most important one.

To make this happen, relatively frequent repacking and re-repacking 
(even if only on parts of the repository) would be necessary. Or at 
least nice to have...

Which was why I wanted the "dumb fetch" thingies to at least do some 
"relatively smart un/repacking" to avoid duplication. And, ideally, that 
they would avoid downloading entire packs that we just want the 
beginning of. That would lessen the cost of repacking, which I happen to 
think is a good thing.

Also, it's kind of strange when the ssh/local fetching *always* unpacks 
everything, and rsync/http *never* does this...

> You are correct.  For somebody like Jeff, having the Linus
> baseline pack with one pack of all of his head (incremental that
> excludes what is already in the Linus baseline pack) would help
> pullers.

That would work, of course. It, however, means that Linus becomes the 
"official repository maintainer" in a way that doesn't feel very 
distributed. Perhaps then Linus' packs should be marked "official" in 
some way?

>>The big problem, however, comes when Jeff (or anyone else) decides to
>>repack. Then, if you fetch both his repo and Linus', you might end up
>>with several really big pack files, that mostly overlap. That could
>>easily mean storing most objects many times, if you don't do some
>>smart selective un/repacking when fetching.
> 
> 
> Indeed.  Overlapping packs is a possibility, but my gut feeling
> is that it would not be too bad, if things are arranged so that
> packs are expanded-and-then-repacked _very_ rarely if ever.
> Instead, at least for your public repository, if you only repack
> incrementally I think you would be OK.

To be exact, you're ok (in the meaning of avoiding duplicates) as long 
as you always rsync in the "official packs", and coordinate with others 
you're merging with, before you do any repacking of your own. Sure, this 
works. It just feels a bit "un-distributed" for my personal taste...

/dan
