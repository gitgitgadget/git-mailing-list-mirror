From: =?ISO-8859-1?Q?Kenneth_=D6lwing?= <kenneth@olwing.se>
Subject: Re: Collective wisdom about repos on NFS accessed by concurrent clients
 (== corruption!?)
Date: Sun, 07 Apr 2013 20:56:36 +0200
Message-ID: <5161C164.7020502@olwing.se>
References: <515419D0.7030107@olwing.se> <515EC51C.9070206@olwing.se><87li8xrt5f.fsf@linux-k42r.v.cablecom.net><515EE38D.2000502@olwing.se> <871uaorscq.fsf@linux-k42r.v.cablecom.net> <CB4C1FB3EB914D079EE0534228DE372D@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'Thomas Rast' <trast@inf.ethz.ch>, 'Git List' <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:57:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOumQ-0005k0-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934287Ab3DGS5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:57:17 -0400
Received: from hotelroom5.mainloop.net ([192.121.13.73]:36103 "EHLO
	hotelroom5.mainloop.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934283Ab3DGS5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:57:17 -0400
X-No-Relay: not in my network
X-No-Relay: not in my network
X-No-Relay: not in my network
Received: from [IPv6:::1] (unknown [82.214.25.167])
	by hotelroom5.mainloop.net (Postfix) with ESMTPSA id F053CF2822C;
	Sun,  7 Apr 2013 20:57:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CB4C1FB3EB914D079EE0534228DE372D@black>
X-Antivirus: AVG for E-mail 2013.0.2904 [2641/6230]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220359>

Thanks for suggestions,

>> I don't think there's any internal debugging that helps at this 
>> point. Usually errors pointing to corruption are caused by a chain of 
>> syscalls failing in some way, and the final error shows only the last 
>> one, so strace() output is very interesting. 

Right - a problem could be, in my understanding, that it will be quite 
hard to figure out which of the traces are actually interesting. First, 
just because of the intense concurrency, there will be a lot of false 
errors on the way, and as far as I can tell many of those errors are 
effectively indistinguishable from a real error; i.e. a clone can report 
wording to the effect of 'possibly the remote repo is broken', when it's 
just in transition by another process. So, a lot of retries eventually 
will work. Except when the repo actually is broken, but the retries are 
done until they're exhausted. I do keep all such logs anyway, and adding 
strace to the output should be fine - it's just a lot to go through. 
Which is the second thing - I noticed that I can get strace to put in 
timestamps in it's output which will likely be necessary to try to find 
where two or more processes interfere.

Oh, BTW - I'm also uncertain whether it is the actual regular ops (e.g. 
push) or perhaps auto-gc's that sometimes kick in that causes problems. 
While I can set gc.auto=0 to take those out of the equation, it's 
obviously not a solution in the long run. Hm, maybe I should go the 
other way, like doing gc --aggressive very often while doing pushes and 
see if that more quickly
provokes an error. Even Linus in my first link suggests 'avoiding 
concurrent gc --prune' (I know, not the same as aggressive), which is 
understandable, but since, again as I understand it, git will 
occasionally decide to do it on it's own, frankly I would expect this to 
work. Not optimally from any viewpoint of course, but still, I simply 
shouldn't be able to break a repo as long as I use regular git commands. 
Or is that an unreasonable expectation? Given that I'm probably way 
beyond any reasonable normal use, I guess it could be considered to 
chase ghosts...but then again, if there's even a tiny hole, it would be 
nice to close it.

Well, I'll just have to try to battle on with it. Is there a hint of 
docs anywhere that would describe the locking behavior git uses to 
battle concurrency, and/or some (preferably single) points in the source 
code that I could look at?

>>> The main issue I see is that I suspect it will generate so
>> much data
>>> that it'll overflow my disk ;-).
>> Well, assuming you have some automated way of detecting when
>> it fails, you can just overwrite the same strace output file
>> repeatedly; we're only interested in the last one (or all the
>> last ones if several gits fail concurrently).
> We use tmpwatch for this type of issue, especially with oracle traces. Set up a
> directory and tell tmpwatch to delete files older than X. This will keep the
> files at bay and when you detect a problem stop  the clean up script.
>
Thanks - as described above I do keep track of all tasks that eventually 
run out of steam and die from exhaustion (logs and the final copy of 
their clone), and can I get the strace in there things should be fine. 
It'll still be a lot of data since I as described I haven't yet figured 
out how to accurately detect the point where the real error actually 
occurs. I'll look into if I can have some checkpoints in my tasks where 
they all calm down so I can test the repo for correctness, so limiting 
the data and more quickly discovering the fail state.

ken1
