From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem with pack
Date: Fri, 25 Aug 2006 12:20:12 +0200
Message-ID: <44EECEDC.7090608@op5.se>
References: <44EECBE2.7090801@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 12:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGYnV-0005EN-SS
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 12:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWHYKUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 06:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWHYKUS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 06:20:18 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:20954 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751020AbWHYKUQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 06:20:16 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 3CE656BD39; Fri, 25 Aug 2006 12:20:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E53736BD30; Fri, 25 Aug 2006 12:20:12 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Sergio Callegari <scallegari@arces.unibo.it>
In-Reply-To: <44EECBE2.7090801@arces.unibo.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25995>

Sergio Callegari wrote:
>>
>> > git verify-pack -v pack-ebcdfbbda07e5a3e4136aa1f499990b35685bab4.idx
>> > fatal: failed to read delta-pack base object 
>> 2849bd2bd8a76bbca37df2a4c8e8b990811d01a7
>>
>> Eeeh! Not good.
>>
>> > 1) I am working on both a pc and a notebook, syncing the two 
>> everytime I move
>> > from one to the other.
>>
>> So, you still have one "good" version? Please make a backup 
>> immediately. (If only to reproduce the problem.)
>>   
> I have a good working tree, but unfortunately I realized that there was 
> a problem with the pack only _after_ the sync:
> I was not expecting this kind of problem, so I silly did a repack as the 
> last thing, I went home, I attached the laptop to the net, I run unison, 
> I started to work and I realized that there was a problem when I 
> attempted a new repack which failed complaining about the corrupted pack...
> 
> So actually, I do not even know where the corruption came from (an hd 
> error, the sync tool, ...)
> 
> I only have the corrupted pack and its index and a good last working tree.
> 
> BTW, it would be nice to have some "security measure" in git reset... 
> e.g. an option to trigger the following behavior:
> 
> - saving all current changes in a temporary commit
> - checking that the current HEAD can be re-checked out before the reset
> 

The recommended way is to do a throw-away branch to commit your 
temporary commit to (or the 'master' so long as you remember to use 
reset). The current HEAD can always, barring object database errors, be 
checked out if 'git status' reports no changes in the working tree. 
Unfortunately, the object database is often enormous, so doing a full 
fsck-objects before each change to the branch you're on (which is 
basically what a reset is), would take far too long to be viable.

>> Since unpack-objects does not use the index, it cannot extract 
>> anything after the first error. We _could_ enhance unpack-objects to 
>> be nice and optionally take a pack-index to try to reconstruct as many 
>> objects as possible.
>>   
> That would be very useful...
> Btw, even without that, if I understand correctly, git packs are 
> collections of compressed objects, each of which has its own header 
> stating how long is the compressed object itself. In my case, the error 
> is in inflating one object (git unpack-objects says inflate returns 
> -3)... so shouldn't there be a way to try to skip to the next object 
> even in this case?

It should be possible, assuming the pack index is still intact. The pack 
index is where the headers are stored, afaik.


>> BTW I'd recommend not syncing with unison, but with the git 
>> transports: If your PC and Laptop are connected, you could do 
>> something like
>>
>>     git pull laptop:my_project/.git
>>   
> Actually, the project, including the git archive gets syncronized as a 
> part of a syncronization process including all my Documents directory 
> (the project is in fact a LaTeX manual with somehow complex LaTeX 
> packages and classes). Syncronizing in this way actually worked very 
> well so far, because at once I was getting in sync all my working trees 
> and all my repos...
> 

The largest benefit of using git's synchronization methods is that you 
immediately get a pack-file verification, and also that you never risk 
overwriting anything in either repo if you've forgotten to sync between 
the two (say you've made changes on your laptop, forgot to send them to 
your workstation, then made changes on your workstation and then you try 
to sync them). It's possible to recover from such a situation using the 
lost-found tool, but it can be cumbersome, and uncommitted changes, as 
well as changes to the working tree, are lost forever.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
