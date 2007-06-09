From: Johan Herland <johan@herland.net>
Subject: Re: Refactoring the tag object; Introducing soft references
 (softrefs); Git 'notes' (take 2)
Date: Sun, 10 Jun 2007 01:16:45 +0200
Message-ID: <200706100116.46062.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <466B305A.5080802@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 01:17:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxAB4-0005Gf-Tc
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 01:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579AbXFIXRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbXFIXRA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 19:17:00 -0400
Received: from smtp.getmail.no ([84.208.20.33]:53234 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388AbXFIXQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 19:16:59 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00J1B60AUP00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 01:16:58 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00JO85ZYII50@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 01:16:46 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE0090S5ZYPLA0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 01:16:46 +0200 (CEST)
In-reply-to: <466B305A.5080802@midwinter.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49638>

On Sunday 10 June 2007, Steven Grimm wrote:
> Being able to specify relationships between commits after the fact seems 
> like a very useful facility.
> 
> Does it make sense to have type information to record what the 
> relationship between two objects means? Without that, it seems like 
> it'll be hard to build much of a tool set on top of this feature, since 
> no two tools that made use of it could unambiguously query just their 
> own softrefs.

Actually MadCoder/Pierre had a similar idea on IRC. He wanted to separate 
softrefs into namespaces, so that softrefs for tags could live in a 
different place than softrefs associated with his "gits" bug tracker.

I haven't thought very much about this, but it's certainly possible to do 
something like this. What do the rest of y'all think?

> A few use cases for relationships-after-the-fact come to mind in 
> addition to the one the patch itself mentions:
> 
> A facility like this could replace the info/grafts file, or at least 
> provide another way to turn a regular commit into a merge commit. Just 
> put a "manually specified merge parent" ref between the target revision 
> and the one you want git to think you've merged from. That would scale a 
> lot better than info/grafts does, I suspect, if only by virtue of being 
> O(log n) searchable thanks to the sorting.

Yes, I _knew_ this was similar to grafts in some way :) While working on 
this, I tried to see if I could leverage grafts somewhere in my design, but 
I found them to be too commit-bound and specific. But when you look at it 
the other way it seems to make more sense.

> One could easily imagine recording a "cherry picked" softref, which 
> could, e.g., be the rebase machinery to skip over an already-applied 
> revision. IMO the lack of any tool-readable history about cherry picking 
> -- which is, after all, a sort of merge, at least conceptually -- is a 
> shortcoming in present-day git. (Not a huge one, but if nothing else 
> it'd be great to see cherry picking represented in, e.g., the gitk 
> history display.)
> 
> It might be possible to annotate rebases to make pulling from rebased 
> branches less troublesome. If you have
> 
> A--B--C--D
>     \
>      -E--F--G
> 
> and you rebase E onto D, a "rebased from" softref could be recorded 
> between E and E':
> 
> A--B--C--D
>     \     \
>      -E....E'--F'--G'
> 
> Then a pulling client could potentially use that information to cleanly 
> replay the rebase operation to keep its history straight. Perhaps if you 
> could record historical rebases like that, you could do away with the 
> current gotchas involving rebasing shared repositories. One negative 
> side effect would be that you'd end up needing to keep E around where 
> before you'd have been able to throw it away, but it should delta 
> compress well, and you can, I think, still prune revisions F and G in 
> the above picture. Or maybe it's enough to just keep E's SHA1 around 
> without actually retaining its contents.

Whoa. I hadn't even imagined this, but I guess you're right. I actually 
thought about solving the same problem (using a much worse method) way back 
in May [1], but I'd since totally forgotten about it. 

> But in any event, this seems like the start of a useful new set of 
> capabilities for git.

Thanks a lot for sharing your ideas. :)


Have fun!

...Johan

[1] http://article.gmane.org/gmane.comp.version-control.git/46137

-- 
Johan Herland, <johan@herland.net>
www.herland.net
