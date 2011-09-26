From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 19:37:10 +0100
Message-ID: <88a00eadcbb4a7946dbe8d70dd0e933d@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <201109251443.28243.mfick@codeaurora.org>
 <201109260915.29285.mfick@codeaurora.org>
 <201109261207.52736.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 20:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8G3N-0002Bz-SD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab1IZShN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 14:37:13 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:51801 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752533Ab1IZShN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 14:37:13 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id A30C8C0602;
	Mon, 26 Sep 2011 19:37:11 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 785DE36A824;
	Mon, 26 Sep 2011 19:37:11 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5GeZv5fUotU6; Mon, 26 Sep 2011 19:37:11 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C186636A76B;
	Mon, 26 Sep 2011 19:37:10 +0100 (BST)
In-Reply-To: <201109261207.52736.mfick@codeaurora.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182147>

On Mon, 26 Sep 2011 12:07:52 -0600, Martin Fick wrote:
-- snip --
> Ahh, I think I have some more clues.  So while this change
> does not speed things up for me normally, I found a case
> where it does!  I  set my .git/config to have
>
>   [core]
>         compression = 0
>
> and ran git-gc on my repo.  Now, with a modern git with this
> optimization in it (1.7.6, 1.7.7.rc0...), 'git branch' is
> almost instantaneous (.05s)!  But, if I revert c774aa it
> takes > ~15s.

I don't understand this.  I don't see why core.compression should have 
anything to do with refs ...

> So, it appears that this optimization is foiled by
> compression?  In the case when this optimization helps, it
> save about 15s, when it hurts (with compression), it seems
> to cost > 3mins.  I am not sure this optimization is worth
> it?  Would there be someway for it to adjust to the repo
> conditions?

Well, in the case I tried it was 1.2s vs 40s.  It would seem that you 
have managed to find some corner case.  It doesn't seem right to punish 
everyone who has large numbers of refs by making their commands take 
orders of magnitude longer to save one person 3m.  Much better to find, 
understand and fix the actual cause.

I really can't see what effect core.compression can have on loading the 
ref_list.  Certainly the sort doesn't load anything from the object 
database.  It would be really good to profile and find out what is 
taking all the time - I am assuming that the CPU is at 100% for the 3+ 
minutes?

Random thought.  What happens to the with compression case if you leave 
the commit in, but add a sleep(15) to the end of sort_refs_list?

-- 
Julian
