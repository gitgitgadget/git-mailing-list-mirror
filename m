From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Wed, 11 Jan 2006 01:06:42 +0100
Message-ID: <43C44C12.3050609@op5.se>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>	 <1136849810.11717.518.camel@brick.watson.ibm.com>	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>	 <1136910406.11717.579.camel@brick.watson.ibm.com> <43C4075E.4070407@op5.se>	 <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net> <1136924980.11717.603.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 01:07:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwTVp-0002Ii-U8
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 01:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030699AbWAKAGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 19:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030702AbWAKAGr
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 19:06:47 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:14229 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030699AbWAKAGq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 19:06:46 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C40656BD03; Wed, 11 Jan 2006 01:06:43 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1136924980.11717.603.camel@brick.watson.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14466>

Michal Ostrowski wrote:
> On Tue, 2006-01-10 at 11:47 -0800, Junio C Hamano wrote:
> 
>>
>>>Good point. Perhaps we should only prepend to path when the directory
>>>isn't already in $PATH, or append rather than prepend.
>>
>>I think appending not prepending would stop letting me say
>>
>> $ GIT_EXEC_PATH=/usr/libexec/git-core/0.99.9k git foo
>>
>>to try out older version, if I have more recent git in my PATH.
>>But I agree with Michal it is not nice to affect invocations of
>>"diff" (and things spawned from hooks, which would inherit PATH
>>from receive-pack).
>>

So how about prepending only when the directory isn't already in the 
PATH? That can be done with a two-line patch to git.c only.

It will break the "diff in another dir" scenario in the highly unlikely 
event that the other diff is located in the same dir as the git suite, 
isn't supposed to be used, and the directory in question isn't in $PATH 
already. People who have such a setup will be too ashamed to admit it, 
so we're not likely to be blamed for it either. ;)

>>
> 
> 
> How about searching for executables in the following places, and in this
> order:
> 
> 1. --exec-path setting, if any
> 2. GIT_EXEC_PATH env var, if set
> 3. PATH (never modified)
> 4. Value of ${bindir} at build time
> 

This is more or less what's done today, with the exception that $PATH 
isn't searched and it throws an error immediately no matter where 
exec_path (the git.c variable) came from.

Adding $PATH to the search-pattern would be a simple matter of falling 
back to execvp() if execve(), but then we could end up with running 
programs from a different release while the user thinks he/she's 
specifically running 1.0.3... Tricky problem, really.

> 
> Secondly, the shell scripts as is cannot utilize this search order as
> long as they don't religiously use the git potty internally.  If we were
> to "sed -e 's/git-/git /g' -i git*.sh" (grotesquely simplified of
> course) then they would. 
> 

I think this has been done, but as it happened to be convenient. I'd 
prefer if the git potty could keep prepending the GIT_EXEC_PATH to the 
path, really. We're bound to run into setup-related problems otherwise, 
such as;

Alice writes a script that works fine for her and her friends, so she 
shares it freely with Bob and whoever else might be listening. Bob's 
git-tools aren't in the $PATH but he keeps the potty handy at all times. 
He can't always run it through the potty because in some code-paths 
Alice's script uses git-tools without going through the potty. Bob 
thinks Alice puts entropy in her programs on purpose, so Alice flees, 
sobbing and shaking in anger and betrayed trust. The two never speak again.

Luckily, Bruce Schneier shows up and saves the day.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
