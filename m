From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 20:36:32 +0200
Message-ID: <448B1130.8020005@dawes.za.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org> <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org> <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com> <87y7w5lowc.wl%cworth@cworth.org> <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org> <448A847C.20105@dawes.za.net> <Pine.LNX.4.64.0606101041490.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 20:36:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp8KH-00077g-5D
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 20:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWFJSgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 14:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWFJSgp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 14:36:45 -0400
Received: from sd-green-bigip-61.dreamhost.com ([208.97.132.61]:49357 "EHLO
	spunkymail-a3.dreamhost.com") by vger.kernel.org with ESMTP
	id S1030491AbWFJSgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 14:36:44 -0400
Received: from [192.168.201.67] (dsl-165-2-55.telkomadsl.co.za [165.165.2.55])
	by spunkymail-a3.dreamhost.com (Postfix) with ESMTP id 222C8111E2F;
	Sat, 10 Jun 2006 11:36:35 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606101041490.5498@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21614>

Linus Torvalds wrote:
> 
> On Sat, 10 Jun 2006, Rogan Dawes wrote:
>> Here's an idea. How about separating trees and commits from the actual blobs
>> (e.g. in separate packs)? My reasoning is that the commits and trees should
>> only be a small portion of the overall repository size, and should not be that
>> expensive to transfer. (Of course, this is only a guess, and needs some
>> numbers to back it up.)
> 
> The trees in particular are actually a pretty big part of the history. 
> 
> More importantly, the blobs compress horribly badly in the absense of 
> history - a _lot_ of the compression in git packing comes very much from 
> the fact that we do a good job at delta-compression.
> 
> So if you get all of the commit/tree history, but none of the blob 
> history, you're actually not going to win that much space. As already 
> discussed, the _whole_ history packed with git is usually not insanely 
> bigger than just the whole unpacked tree (with no history at all).
> 
> So you'd think that getting just the top version of the tree would be a 
> much bigger space-saving that it actually is. If you _also_ get all the 
> tree and commit objects, the space saving is even less.
> 

One possibility, given that the full commit and tree history is so
large, is simply to get the HEAD commit and the trees that the commit
depends directly on, rather than fetching them all up front.

> I actually suspect that the most realistic way to handle this is to use 
> the "fetch.c" logic (ie the incremental fetcher used by http), and add 
> some mode to the git daemon where you fetch literally one object at a time 
> (ie this would be totally _separate_ from the pack-file thing: you'd not 
> ask for "git-upload-pack", you'd ask for something like 
> "git-serve-objects" instead).
> 
> The fetch.c logic really does allow for on-demand object fetching, and is 
> thus much more suitable for incomplete repositories.
> 
> HOWEVER. The fetch.c logic - by necessity - works on a object-by-object 
> level. That means that you'd get no delta compression AT ALL, and I 
> suspect that the downside of that would be a factor of ten expansion or 
> more, which means that it would really not work that well in practice.

Would it be possible to add a mode where fetch.c is given a list of 
desired objects, and returns a list of pointers to those objects? Then 
callers that already have such a list could be modified to pass the 
whole list at once, allowing at least SOME compression, and optimisation 
of round trips, etc? There would be a tradeoff in memory use, though, I 
guess.

Rogan
