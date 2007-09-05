From: Steven Grimm <koreth@midwinter.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 01:50:04 -0700
Message-ID: <46DE6DBC.30704@midwinter.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqaP-0005Xp-V6
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbXIEIuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756055AbXIEIuF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:50:05 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:60409 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756019AbXIEIuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:50:03 -0400
Received: (qmail 23074 invoked from network); 5 Sep 2007 08:50:02 -0000
Received: from c-76-21-16-80.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.16.80)
  by tater.midwinter.com with SMTP; 5 Sep 2007 08:50:02 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20070905074206.GA31750@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57690>

Pierre Habouzit wrote:
>   Well independently from the fact that one could suppose that users
> should use gc on their own, the big nasty problem with repacking is that
> it's really slow. And I just can't imagine git that I use to commit
> blazingly fast, will then be unavailable for a very long time (repacks
> on my projects -- that are not as big as the kernel but still -- usually
> take more than 10 to 20 seconds each).
>   

What about kicking off a repack in the background at the ends of certain 
commands? With an option to disable, of course. It could run at a low 
priority and could even sleep a lot to avoid saturating the system's 
disks -- since it'd be running asynchronously there should be no problem 
if it takes longer to run.

Alternately, if it's possible to break the repack work up into chunks 
that can be executed a bit at a time, you could do a small amount of 
repacking very frequently (possibly still in the background) rather than 
the whole thing at once. I suspect the nature of a repack, where you 
presumably want everything loaded at once, would make that a challenge, 
but it might not be impossible.

On the more general question...

IMO expecting end users to regularly perform what are essentially 
database administration tasks (running git-gc is akin to rebuilding 
indexes or packing tables on a DBMS) is naive. Heck, even database 
administrators don't like to run database administration commands; 
PostgreSQL added the "autovacuum" feature precisely because manual 
periodic repacking (and the associated monitoring to figure out when to 
do it) was too annoying for developers and DBAs. But you don't have to 
look that far; anyone who has worked in IT can tell you horror stories 
of users, including developers, whose computers have slowed to a crawl 
because the users never bothered to defrag their hard disks. And that 
affects *everything* the users do, not just version control operations!

It'll get worse as better UIs and tool integration become available and 
git gains large numbers of users who are neither software developers nor 
system administrators, and wouldn't know a packfile from a hole in the 
ground. I'm talking web designers, graphic artists, mechanical 
engineers, even managers and secretaries -- all of those people are in 
git's ultimate target audience, even if it's not ready for them today. 
None of them is going to be interested in doing random housekeeping 
operations by hand, but they'll all appreciate a fast environment.

The fact that git sometimes stores your files individually in the .git 
directory and sometimes bundles them together into big archives should 
be an implementation detail that end-users don't have to worry about day 
to day; git should do the right thing to remain fast under typical usage 
scenarios, while leaving the plumbing exposed so people with atypical 
usage can get their stuff done too.

-Steve
