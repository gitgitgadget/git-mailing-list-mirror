From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH] improved delta support for git
Date: Wed, 18 May 2005 10:54:54 +0200
Message-ID: <d6evrk$jv2$1@sea.gmane.org>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> <d6dohe$dql$1@sea.gmane.org> <Pine.LNX.4.62.0505180005230.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 18 10:59:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYKO6-0004Sp-Rr
	for gcvg-git@gmane.org; Wed, 18 May 2005 10:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVERI66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 04:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVERI66
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 04:58:58 -0400
Received: from main.gmane.org ([80.91.229.2]:53633 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262133AbVERI6k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 04:58:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DYKLj-0004At-R8
	for git@vger.kernel.org; Wed, 18 May 2005 10:56:19 +0200
Received: from 217-211-177-12-o871.telia.com ([217.211.177.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 May 2005 10:56:19 +0200
Received: from holmsand by 217-211-177-12-o871.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 May 2005 10:56:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217-211-177-12-o871.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.62.0505180005230.20274@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre wrote:
> My goal is to provide the mechanism that can be used by a higher level 
> implementing the deltafication policy.  I only provided one script as an 
> example, but it turns out that you found a way to achieve better space 
> saving.  And I bet you that there is probably ways to do even better 
> with more exhaustive delta targets.  For example you could try all 
> possible combinations on an object list for each file (and let it run 
> overnight).

Well, any kind of deltafication of, say, the complete kernel history 
pretty much has to run overnight anyway :-)

> One thing I've been wondering about is whether gzipping small deltas is 
> actually a gain.  For very small files it seems that gzip is adding more 
> overhead making the compressed file actually larger.  Might be worth 
> storing some deltas uncompressed if the compressed version turns out to 
> be larger.

It's probably better to skip deltafication of very small files 
altogether. Big pain for small gain, and all that.

>>1) I limit the maximum size of any delta to 10% of the size of the new
>>version. That guarantees a big saving, as long as any delta is
>>produced.
> 
> 
> Well, any delta object smaller than its original object saves space, 
> even if it's 75% of the original size. But...

That's not true if you want to keep the delta chain length down (and 
thus performance up).

Then, the most efficient approach is to generate many deltas against the 
same base file (otherwise, you only get 50% delta files with a maximum 
delta depth of 1).

But in this case, the trick is to know when to stop deltafying against 
one base file, and start over with another. If you switch to a new 
keyframe too often, you obviously lose some potential savings. But if 
you don't switch often enough, you end up repeating the same data in too 
many delta files.

A maximum delta size of 10% turned out to be ideal for at least the "fs" 
  tree. 8% was significantly worse, as was 15%. (The ideal size depends 
on  how big the average change is: the smaller the average change, the 
smaller the max delta size should be).

> ... but then the ultimate solution is to try out all possible references 
> within a given list.  My git-deltafy-script already finds out the list 
> of objects belonging to the same file.  Maybe git-mkdelta should try 
> all combinations between them.  This way a deeper delta chain could be 
> allowed for maximum space saving.

Yeah. But then you lose the ability to do incremental deltafication, or 
deltafication on-the-fly. And it would be really, really nice to have 
git do deltas at commit time - that way you could keep the very cool 
"immutable objects" property of git, while still saving a lot of space.

> I will look at it and merge the good stuff.

Cool! Thanks!

/dan

