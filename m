From: Nicolas Pitre <nico@cam.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 20:43:58 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806102026430.23110@xanadu.home>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
 <m3abhtp42o.fsf@localhost.localdomain>
 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
 <200806102159.02875.jnareb@gmail.com>
 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
 <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
 <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org>
 <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
 <alpine.LFD.1.10.0806101518590.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 02:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ESR-0002DY-GM
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 02:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbYFKAoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 20:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874AbYFKAoE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 20:44:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14011 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbYFKAoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 20:44:03 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2900386WPAH4R0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Jun 2008 20:43:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0806101518590.3101@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84566>

On Tue, 10 Jun 2008, Linus Torvalds wrote:

> Anyway, I'll think about sane ways to add a "safe" mode without making it 
> _too_ painful. In the meantime, here's a trial patch that you should 
> probably use. It does slow things down, but hopefully not too much.
> 
> (I really don't much like it - but I think this is a good change, and I 
> just need to come up with a better way to do the fsync() than to be 
> totally synchronous about it.)
> 
> It's going to make big "git add" calls *much* slower, so I'm not very 
> happy about it (especially since we don't actually care that deeply about 
> the files really being there until much later, so doing something 
> asynchronous would be perfectly acceptable), but for you this is 
> definitely worth-while.

I don't like it at all.

I think this only gives a false sense of security with a huge 
performance cost.  If the machine crashes at the right moment, the 
object will still be half written/fsync'd and you'll be in the same 
situation again.

And because we don't overwrite existing objects (again for performance 
reasons), then a corrupted blob object will remain corrupted even if you 
reattempt the commit later.  So doing the fsync only when the commit 
object is written isn't a good solution either.

I wonder if supporting crashy systems is worth that cost.  If Denis' 
laptop is the odd case then a sync in the commit hook might be plenty 
sufficient.  Personally I'd simply replace the OS or the machine for 
something more reliable.


Nicolas
