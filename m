From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 21:28:53 +0100
Message-ID: <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <201109261207.52736.mfick@codeaurora.org>
 <88a00eadcbb4a7946dbe8d70dd0e933d@quantumfyre.co.uk>
 <201109261401.38624.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 22:29:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8HnT-0008Oh-P9
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 22:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1IZU26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 16:28:58 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:44477 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753075Ab1IZU25 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 16:28:57 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id C2925C0602;
	Mon, 26 Sep 2011 21:28:56 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 7335636A824;
	Mon, 26 Sep 2011 21:28:54 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WrsfdegFS0iK; Mon, 26 Sep 2011 21:28:53 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id D02FC36A4A4;
	Mon, 26 Sep 2011 21:28:53 +0100 (BST)
In-Reply-To: <201109261401.38624.mfick@codeaurora.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182161>

On Mon, 26 Sep 2011 14:01:38 -0600, Martin Fick wrote:
-- snip --
> So, maybe you are correct, maybe my repo is the corner case?
> Is a repo which needs to be gced considered a corner case?
> Should git be able to detect that the repo is so in
> desperate need of gcing?  Is it normal for git to need to gc
> right after a clone and then fetching ~100K refs?

Were you 100k refs packed before the gc?  If not, perhaps your refs are 
causing a lot of trouble for the merge sort?  They will be written out 
sorted to the packed-refs file, so the merge sort won't have to do any 
real work when loading them after that...

> I am not sure what is right here, if this patch makes a repo
> which needs gcing degrade 5 to 10 times worse than the
> benefit of this patch, it still seems questionable to me.

Well - it does this _for your repo_, that doesn't automatically mean 
that it does generally, or frequently.  For instance, none of my normal 
repos that have a lot of refs are Gerrit ones, and I wouldn't be 
surprised if they benefitted from the merge sort (assuming that I am 
right that the merge sort is taking a long time on your gerrit refs).

Besides, you would be better off running gc, and thus getting the 
benefit too.

>> Random thought.  What happens to the with compression
>> case if you leave the commit in, but add a sleep(15) to
>> the end of sort_refs_list?
>
> Why, what are you thinking?  Hmm, I am trying this on the
> non gced repo and it doesn't seem to be completing (no cpu
> usage)!  It appears that perhaps it is being called many
> times (the sleeping would explain no cpu usage)?!?  This
> could be a real problem, this should only get called once
> right?

I was just wondering if the time taken to get the refs was changing the 
interaction with something else.  Not very likely, but ...

I added a print statement, and it was called four times when I had 
unpacked refs, and once with packed.  So, maybe you are hitting some 
nasty case with unpacked refs.  If you use a print statement instead of 
a sleep, how many times does sort_refs_lists get called in your unpacked 
case?  It may well also be worth calculating the time taken to do the 
sort.

-- 
Julian
