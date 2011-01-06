From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Concurrent pushes updating the same ref
Date: Thu, 06 Jan 2011 16:51:53 -0500
Message-ID: <4D263979.1080403@xiplink.com>
References: <4D25E3DE.7050801@xiplink.com> <20110106163035.GA7812@sigill.intra.peff.net> <7v1v4pbz6y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 22:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paxkk-0006bs-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab1AFVwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:52:09 -0500
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:44027 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab1AFVwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:52:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp43.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id C60BD2D0622;
	Thu,  6 Jan 2011 16:52:07 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp43.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 835662D06D6;
	Thu,  6 Jan 2011 16:52:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <7v1v4pbz6y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164681>

On 11-01-06 02:37 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Jan 06, 2011 at 10:46:38AM -0500, Marc Branchaud wrote:
>>
>>> fatal: Unable to create
>>> '/usr/xiplink/git/public/Main.git/refs/builds/3.3.0-3.lock': File exists.
>>> If no other git process is currently running, this probably means a
>>> git process crashed in this repository earlier. Make sure no other git
>>> process is running and remove the file manually to continue.
>>> fatal: The remote end hung up unexpectedly
>>>
>>> I think the cause is pretty obvious, and in a normal interactive situation
>>> the solution would be to simply try again.  But in a script trying again
>>> isn't so straightforward.
>>>
>>> So I'm wondering if there's any sense or desire to make git a little more
>>> flexible here.  Maybe teach it to wait and try again once or twice when it
>>> sees a lock file.  I presume that normally a ref lock file should disappear
>>> pretty quickly, so there shouldn't be a need to wait very long.
>>
>> Yeah, we probably should try again. The simplest possible (and untested)
>> patch is below. However, a few caveats:
>>
>>   1. This patch unconditionally retries for all lock files. Do all
>>      callers want that?
> 
> I actually have to say that _no_ caller should want this.  If somebody
> earlier crashed, we would want to know about it (and how).  If somebody
> else alive is actively holding a lock, why not make it the responsibility
> of a calling script to decide if it wants to retry itself or perhaps
> decide to do something else?

I'm not sure I follow this.

How would retrying a few times prevent us from finding out about an earlier
crash?  It's not like we're overriding the lock by retrying.  Nobody's going
to be able to remove a lock created by a crashed process, right?

And if someone active doesn't release the lock and the low-level code retried
a few times, the caller can still decide what to do.  I don't see how it
would even impact that decision -- if the caller wants to try again, the
system can still retry a few times underneath the caller's one retry.  It
seems fine to me.

		M.
