From: Nicolas Pitre <nico@cam.org>
Subject: Re: git gc expanding packed data?
Date: Wed, 05 Aug 2009 18:39:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908042203380.16073@xanadu.home>
References: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:40:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYp9c-0001XL-RJ
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbZHEWkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbZHEWkC
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:40:02 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52846 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZHEWkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:40:00 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KNX00M7FDMJN740@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Aug 2009 18:39:56 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125012>

On Tue, 4 Aug 2009, Hin-Tak Leung wrote:

> I cloned gcc's git about a week ago to work on some problems I have
> with gcc on minor platforms, just plain 'git clone
> git://gcc.gnu.org/git/gcc.git gcc' .and ran gcc fetch about daily, and
> 'git rebase origin' from time to time. I don't have local changes,
> just following and monitoring what's going on in gcc. So after a week,
> I thought I'd do a git gc . Then it goes very bizarre.
> 
> Before I start 'git gc', .The whole of .git was about 700MB and
> git/objects/pack was a bit under 600MB, with a few other directories
> under .git/objects at 10's of K's and a few 30000-40000K's, and the
> checkout was, well, the size of gcc source code. But after I started
> git gc, the message stays in the 'counting objects' at about 900,000
> for a long time, while a lot of directories under .git/objects/ gets a
> bit large, and .git blows up to at least 7GB with a lot of small files
> under .git/objects/*/, before seeing as I will run out of disk space,
> I kill the whole lot and ran git clone again, since I don't have any
> local change and there is nothing to lose.
> 
> I am running git version 1.6.2.5 (fedora 11). Is there any reason why
> 'git gc' does that?

There is probably a reason, although a bad one for sure.

Well... OK.

It appears that the git installation serving clone requests for 
git://gcc.gnu.org/git/gcc.git generates lots of unreferenced objects. I 
just cloned it and the pack I was sent contains 1383356 objects (can be 
determined with 'git show-index < .git/objects/pack/*.idx | wc -l').  
However, there are only 978501 actually referenced objects in that 
cloned repository ( 'git rev-list --all --objects | wc -l').  That makes 
for 404855 useless objects in the cloned repository.

Now git has a safety mechanism to _not_ delete unreferenced objects 
right away when running 'git gc'.  By default unreferenced objects are 
kept around for a period of 2 weeks.  This is to make it easy for you to 
recover accidentally deleted branches or commits, or to avoid a race 
where a just-created object in the process of being but not yet 
referenced could be deleted by a 'git gc' process running in parallel.

So to give that grace period to packed but unreferenced objects, the 
repack process pushes those unreferenced objects out of the pack into 
their loose form so they can be aged and eventually pruned.  Objects 
becoming unreferenced are usually not that many though.  Having 404855 
unreferenced objects is quite a lot, and being sent those objects in the 
first place via a clone is stupid and a complete waste of network 
bandwidth.

Anyone has an idea of the git version running on gcc.gnu.org?  It is 
certainly buggy and needs fixing.

Anyway... To solve your problem, you simply need to run 'git gc' with 
the --prune=now argument to disable that grace period and get rid of 
those unreferenced objects right away (safe only if no other git 
activities are taking place at the same time which should be easy to 
ensure on a workstation).  The resulting .git/objects directory size 
will shrink to about 441 MB.  If the gcc.gnu.org git server was doing 
its job properly, the size of the clone transfer would also be 
significantly smaller, meaning around 414 MB instead of the current 600+ 
MB.

And BTW, using 'git gc --aggressive' with a later git version (or
'git repack -a -f -d --window=250 --depth=250') gives me a .git/objects 
directory size of 310 MB, meaning that the actual repository with all 
the trunk history is _smaller_ than the actual source checkout.  If that 
repository was properly repacked on the server, the clone data transfer 
would be 283 MB.  This is less than half the current clone transfer 
size.


Nicolas
