From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 01:56:19 +0200
Message-ID: <2F8F3BF2-66F9-473C-BE82-8F784E1FF9A4@ai.rug.nl>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <m3od85qxcl.fsf@localhost.localdomain> <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org> <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl> <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 01:57:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnMvi-00036w-1t
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 01:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbYDSX42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 19:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYDSX42
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 19:56:28 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:24481 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbYDSX42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 19:56:28 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6108.orange.nl (SMTP Server) with ESMTP id ADA317000085;
	Sun, 20 Apr 2008 01:56:26 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6108.orange.nl (SMTP Server) with ESMTP id 6E4BA7000084;
	Sun, 20 Apr 2008 01:56:20 +0200 (CEST)
X-ME-UUID: 20080419235624451.6E4BA7000084@mwinf6108.orange.nl
In-Reply-To: <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79937>


On 20 apr 2008, at 01:26, Linus Torvalds wrote:
>
> It may be that the problem with OS X is a sucky pathname cache  
> mechanism.
>
> The trivial patch cut down the number of stat() calls by a fair  
> amount,
> but the calls that got removed were all of the "do two 'lstat()'  
> calls on
> the exact same pathname consecutively" type.
>
> Maybe OS X has some very limited pathname caching that catches that,  
> or
> even if not, it just ends up being very nice in the D$, so it's not  
> a big
> deal. And then the real suckiness happens only with bigger workloads.
>

Yes, I just tested this.

	for (int i = 0; i < 50000; i++) {
		sprintf(s, "/Users/pieter/test/perf/%i", i);
		int ret = lstat(s, a);
	}

This loop needs about 3 seconds to  run. Replacing the i with 10 in  
the sprintf reduces it to 0.24seconds.

>> Command                                            Mean     Std
>> git status .                                       13.970  1.298
>> /Users/pieter/projects/External/git/git-status .   13.759  0.321
>
> This is the WebKit archive, right?
>
> For me, doing a "time git status ." on the WebKit thing I just  
> cloned from
> git://git.webkit.org/WebKit.git is much faster: 1.264s (and it goes  
> down
> by maybe 5-10% with my lstat-avoidance patch).
>
> Is there any system-level profiler for OS X to get a clue where that  
> cost
> is, in case it's not the lstat() at all?

Yes, that was the webkit repo (the test above was in a dir with 50k  
files).

Alas, I tried to create a nice profiling for the "git status .". In  
the Instruments application I can create a sampler, but I see no way  
to export it. The option to export the script as a dtrace script is  
greyed out in the menu.

 From the sampler, it appears that the lstat calls still account for  
most of the time. I have uploaded a screenshot to http://ss.frim.nl/==759.png 
. It actually shows quite nicely when the lstats are being done --  
it's when the CPU is idle. Next to the lstats, the read_tree_recursive  
is also called often.

- Pieter
