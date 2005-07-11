From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Mon, 11 Jul 2005 17:53:50 +0200
Message-ID: <42D2960E.3050008@gmail.com>
References: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>	<42D17D89.9080808@innehallsbolaget.se> <7v4qb2ni73.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 18:21:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds11t-0002xA-54
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 18:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVGKP7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 11:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVGKP5L
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 11:57:11 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:22030 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262064AbVGKPyU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 11:54:20 -0400
Received: by wproxy.gmail.com with SMTP id i3so189075wra
        for <git@vger.kernel.org>; Mon, 11 Jul 2005 08:54:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Sld5U4QibkdgbK26XH717VepcF6UX6c3qbvvJt2u/d6L70+bMHSvmKUaOTx3Tz4ee4+1pLBtpo7+FtIAbIfAserhyayUD5QNUJJK/UfhmbYBqTnuRh1JHAhKcfSzYIjkIf6uaUc0FGYyB+oNU8lWpLR8DqDAg553Ybob+r/NVO0=
Received: by 10.54.27.57 with SMTP id a57mr3920681wra;
        Mon, 11 Jul 2005 08:53:54 -0700 (PDT)
Received: from ?192.168.0.35? ([217.211.115.65])
        by mx.gmail.com with ESMTP id 12sm8237908wrl.2005.07.11.08.53.52;
        Mon, 11 Jul 2005 08:53:53 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qb2ni73.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> One very minor problem I have with Holmsand approach [*1*] is
> that the original Barkalow puller allowed a really dumb http
> server by not requiring directory index at all.  For somebody
> like me with a cheap ISP account [*2*], it was great that I did
> not have to update 256 index.html files for objects/??/
> directories.  Admittedly, it would be just one directory
> object/pack/, but still...

I totally agree that you shouldn't have to do any special kind of 
prepping to serve a repository thru http. Which was why I thought it was 
a good thing to use the default directory listing of the web-server, 
assuming that this feature would be available on most servers... 
Apparently not yours, though :-(

And Cogito already relies on directory listings (to find tags to download).

But if git-repack-script generates a "pack index file" automagically, 
then of course everything is fine.

> On the other hand, picking an optimum set of packs from
> overlapping set of packs is indeed a very interesting (and hard
> combinatorial) problem to solve.  I am hoping that in practice
> people would not force clients to do it with "interesting" set
> of packs.  I would hope them to have just a full pack and
> incrementals, never having ovelaps, like Linus plans to do on
> his kernel repo.
> 
> On the other hand, for somebody like Jeff Garzik with 50 heads,
> it might make some sense to have a handful different overlapping
> packs, optimized for different sets of people wanting to pull
> some but not all of his heads.

Well, it is an interresting problem... But I don't think that the 
solution is to create more pack files. In fact, you'd want as few pack 
files as possible, for maximum overall efficiency.

I did a little experiment. I cloned Linus' current tree, and git 
repacked everything (that's 63M + 3.3M worth of pack files). Then I got 
something like 25 or so of Jeff's branches. That's 6.9M of object files, 
and 1.4M packed. Total size: 70M for the entire .git/objects/pack directory.

Repacking all of that to a single pack file gives, somewhat 
surprisingly, a pack size of 62M (+ 1.3M index). In other words, the 
cost of getting all those branches, and all of the new stuff from Linus, 
turns out to be *negative* (probably due to some strange deltification 
coincidence).

I think that this shows that (at least in this case), having many 
branches isn't particularly wasteful (1.4M in this case with one 
incremental pack).

And that fewer packs beats many packs quite handily.

The big problem, however, comes when Jeff (or anyone else) decides to 
repack. Then, if you fetch both his repo and Linus', you might end up 
with several really big pack files, that mostly overlap. That could 
easily mean storing most objects many times, if you don't do some smart 
selective un/repacking when fetching.

/dan
