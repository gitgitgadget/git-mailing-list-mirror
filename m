From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Concurrent pushes updating the same ref
Date: Thu, 06 Jan 2011 12:12:47 -0500
Message-ID: <4D25F80F.3050604@xiplink.com>
References: <4D25E3DE.7050801@xiplink.com> <20110106163035.GA7812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 18:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PatOn-0003rb-Sm
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab1AFRNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 12:13:01 -0500
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:53729 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab1AFRNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 12:13:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp42.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 9D0A31488B3;
	Thu,  6 Jan 2011 12:12:59 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp42.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 74AFF148417;
	Thu,  6 Jan 2011 12:12:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110106163035.GA7812@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164644>

On 11-01-06 11:30 AM, Jeff King wrote:
> On Thu, Jan 06, 2011 at 10:46:38AM -0500, Marc Branchaud wrote:
> 
>> fatal: Unable to create
>> '/usr/xiplink/git/public/Main.git/refs/builds/3.3.0-3.lock': File exists.
>> If no other git process is currently running, this probably means a
>> git process crashed in this repository earlier. Make sure no other git
>> process is running and remove the file manually to continue.
>> fatal: The remote end hung up unexpectedly
>>
>> I think the cause is pretty obvious, and in a normal interactive situation
>> the solution would be to simply try again.  But in a script trying again
>> isn't so straightforward.
>>
>> So I'm wondering if there's any sense or desire to make git a little more
>> flexible here.  Maybe teach it to wait and try again once or twice when it
>> sees a lock file.  I presume that normally a ref lock file should disappear
>> pretty quickly, so there shouldn't be a need to wait very long.
> 
> Yeah, we probably should try again. The simplest possible (and untested)
> patch is below. However, a few caveats:
> 
>   1. This patch unconditionally retries for all lock files. Do all
>      callers want that? I wonder if there are any exploratory lock
>      acquisitions that would rather return immediately than have some
>      delay.
> 
>   2. The number of tries and sleep time are pulled out of a hat.
> 
>   3. Even with retries, I don't know if you will get the behavior you
>      want. The lock procedure for refs is:
> 
>         1. get the lock
>         2. check and remember the sha1
>         3. release the lock
>         4. do some long-running work (like the actual push)
>         5. get the lock
>         6. check that the sha1 is the same as the remembered one
>         7. update the sha1
>         8. release the lock
> 
>      Right now you are getting contention on the lock itself. But may
>      you not also run afoul of step (6) above? That is, one push updates
>      the ref from A to B, then the other one in attempting to go from A
>      to B sees that it has already changed to B under our feet and
>      complains?

Could not anything run afoul of step (6)?  Who knows what might happen in
step (4)...

However, in my particular case I'm using a "force" refspec:

	git push origin +HEAD:refs/builds/${TAG}

so (as Shawn says) step (6) shouldn't matter, right?  Plus, all the
concurrent pushes are setting the ref to the same value anyway.

This is fairly degenerate behaviour though.

>      I can certainly think of a rule around that special case (if we are
>      going to B, and it already changed to B, silently leave it alone
>      and pretend we wrote it), but I don't know how often that would be
>      useful in the real world.

Yes -- useful in my case, but otherwise...  Still, I think it would be
more-correct to do that.

		M.
