From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH] improved delta support for git
Date: Wed, 18 May 2005 21:32:06 +0200
Message-ID: <d6g569$hln$1@sea.gmane.org>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> <d6dohe$dql$1@sea.gmane.org> <Pine.LNX.4.62.0505180005230.20274@localhost.localdomain> <d6evrk$jv2$1@sea.gmane.org> <Pine.LNX.4.62.0505181428170.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 18 21:37:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYUKH-0002IF-Vi
	for gcvg-git@gmane.org; Wed, 18 May 2005 21:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVERTgC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 15:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVERTgC
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 15:36:02 -0400
Received: from main.gmane.org ([80.91.229.2]:26346 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262303AbVERTfU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 15:35:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DYUI5-00021T-J9
	for git@vger.kernel.org; Wed, 18 May 2005 21:33:13 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 May 2005 21:33:13 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 May 2005 21:33:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.62.0505181428170.20274@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre wrote:
> On Wed, 18 May 2005, Dan Holmsand wrote:
>>Nicolas Pitre wrote:
>>It's probably better to skip deltafication of very small files altogether. Big
>>pain for small gain, and all that.
> 
> No, that's not what I mean.
> 
> Suppose a large source file that may change only one line between two 
> versions.  The delta may therefore end up being only a few bytes long.  
> Compressing a few bytes with zlib creates a _larger_ file than the 
> original few bytes.

Oh, I see. You're right, of course. I doubt, however, that there are 
really large gains to be made, measured in bytes; since small files tend 
to be small :-) It might nevertheless be worthwhile to skip processing 
of really small files, though, as there's basically no hope of gaining 
anything by deltafication.

Anyway, I've also noticed that deltas compress a lot worse than regular 
blobs. In particular, "complex deltas" (i.e. small changes on lines 
1,3,5,9,12, etc.), compress poorly. That might explain why my simplistic 
"depth-one-deltas-against-a-common-keyframe" method works comparatively 
well, as that should tend to cleaner deltas from time to time (i.e. 
chunk on lines 1-12 got replaced by new stuff), that ought to be easier 
to compress.

>>>Well, any delta object smaller than its original object saves space, even if
>>>it's 75% of the original size. But...
>>
>>That's not true if you want to keep the delta chain length down (and thus
>>performance up).
> 
> Sure.  That's why I added the -d switch to mkdelta.  But if you can fit 
> a delta which is 75% the size of its original object size then you still 
> save 25% of the space, regardless of the delta chain length.

Ok, I guess we're talking about slightly different things here. I was 
talking about my simple-and-fast method of processing one new version of 
an object at a time, deltafying each new version against the first 
previous non-deltafied one. If you, in that scenario, allow use of up to 
75% sized deltas, on average delta size will probably be something like 37%.

> In fact it seems that deltas might be significantly harder to compress.  
> Therefore a test on the resulting file should probably be done as well 
> to make sure we don't end up with a delta larger than the original 
> object.

Yeah (see above). That's just one of the things I cheated my way out of, 
by limiting delta size to 10% (I trusting that compression doesn't 
increase size by 90%).

>>>... but then the ultimate solution is to try out all possible references
>>>within a given list.  My git-deltafy-script already finds out the list of
>>>objects belonging to the same file.  Maybe git-mkdelta should try all
>>>combinations between them.  This way a deeper delta chain could be allowed
>>>for maximum space saving.
>>
>>Yeah. But then you lose the ability to do incremental deltafication, or
>>deltafication on-the-fly.
> 
> 
> Not at all.  Nothing prevents you from making the latest revision of a 
> file be the reference object and the previous revision turned into a 
> delta against that latest revision, even if it was itself a reference 
> object before.  The only thing that must be avoided is a delta loop and 
> current mkdelta code takes care of that already.

Sure. But there's some downside to modifying already existing objects. 
In particular, downloads using the existing methods (both http and 
rsync) won't get your new, smaller objects. If someone is pulling from a 
deltafied repository often enough, and the objects of the top-most 
commit are always non-deltafied, they will never see any deltas. Object 
immutability is a really good thing.

And there might be some performance issues involved, if you'd like to do 
deltafying at commit-time (not that I've actually tried this, or 
anything)...

Thanks for your comments!

/dan

