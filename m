From: =?UTF-8?B?S2VubmV0aCDDlmx3aW5n?= <kenneth@olwing.se>
Subject: Re: Collective wisdom about repos on NFS accessed by concurrent clients
 (== corruption!?)
Date: Fri, 05 Apr 2013 16:45:33 +0200
Message-ID: <515EE38D.2000502@olwing.se>
References: <515419D0.7030107@olwing.se> <515EC51C.9070206@olwing.se> <87li8xrt5f.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWIz-0002u6-5S
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161848Ab3DEOqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 10:46:14 -0400
Received: from hotelroom5.mainloop.net ([192.121.13.73]:47673 "EHLO
	hotelroom5.mainloop.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161562Ab3DEOqO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 10:46:14 -0400
X-No-Relay: not in my network
X-No-Relay: not in my network
Received: from [IPv6:::1] (unknown [82.214.25.167])
	by hotelroom5.mainloop.net (Postfix) with ESMTPSA id 9090170FA0;
	Fri,  5 Apr 2013 16:46:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <87li8xrt5f.fsf@linux-k42r.v.cablecom.net>
X-Antivirus: AVG for E-mail 2013.0.2904 [2641/6225]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220184>

On 2013-04-05 15:42, Thomas Rast wrote:
> Can you run the same tests under strace or similar, and gather the 
> relevant outputs? Otherwise it's probably very hard to say what is 
> going wrong. In particular we've had some reports on lustre that 
> boiled down to "impossible" returns from libc functions, not git 
> issues. It's hard to say without some evidence. 
Thomas, thanks for your reply.

I'm assuming I should strace the git commands as they're issued? I'm 
already collecting regular stdout/err output in a log as I go. Is there 
any debugging things I can turn on to make the calls issue internal 
tracing of some sort?

The main issue I see is that I suspect it will generate so much data 
that it'll overflow my disk ;-). Consider that my hammer consists of a 
Perl script that forks a number of tasks (e.g. 15) that each loops doing 
clone/commit/push/pull, with retrying on a few levels as errors occur 
(usually expected ones due to the concurrency, i.e. someone else pushed 
so a pull is necessary first, but occasionally the central repo is 
broken enough that it can't be cloned from, or at least not checked out 
master from...sometimes with printed errors that still give me a zero 
exit code...). That is then also run on several machines to the same 
repo to hopefully cause a breakage by sheer pounding...it's going to 
generate huge collections of strace output I expect...

I have some variations of this (e.g. all tasks are working on different 
branches, improving concurrency in some respects, but effects there have 
been that at the end I was missing a branch or so...). The likelihood of 
problems seems to increase when I actually use ssh in my ultimate setup, 
so a loadbalancer roundrobins each call to any of several hosts. In that 
case I must admit I don't know how to get in on the action since I guess 
I would need to strace the git-upload/receive-pack processes on the 
server side...?

Lastly, I don't know how much this will impact timings etc, or load. To 
get a broken result I have sometimes needed to run for many hours, 
others fairly quickly.

Well...I will try, it'll probably be a blast :-)

BTW, this is mostly done on Centos 6.3 and 6.4, locally built git-1.8.2.

ken1
