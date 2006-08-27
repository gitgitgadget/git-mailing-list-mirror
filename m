From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problem with pack
Date: Sun, 27 Aug 2006 15:26:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608271513260.3683@localhost.localdomain>
References: <44F1DA25.3050403@arces.unibo.it>
 <Pine.LNX.4.64.0608271102450.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergio Callegari <scallegari@arces.unibo.it>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 21:27:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHQHb-0006Ff-Em
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 21:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWH0T0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 15:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWH0T0z
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 15:26:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58225 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932250AbWH0T0z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 15:26:55 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4O00BQR8OT62C0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 27 Aug 2006 15:26:54 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0608271102450.27779@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26108>

On Sun, 27 Aug 2006, Linus Torvalds wrote:

> Now, "git repack -a" is obviously special in that the "-a" will mean that 
> we will generally touch all of the old pack _anyway_, and thus verifying 
> the signature is no longer at all as unreasonable as it is under other 
> circumstances. And very arguably, if you _also_ do "-d", then since that 
> is a fairly dangerous operation with the potential for real data loss, you 
> could well argue that we should do it.

We definitely should do it with -d.

> However, since the data was _already_ corrupt in that situation, and since 
> a "git-fsck-objects --full" _will_ pick up the corruption in that case 
> both before and after, equally arguably it's also true that there's really 
> not a huge advantage to checking it in "git repack -a -d".

There really is an advantage.  Given that the absence of -d leaves old 
objects/packs around, there is a greater chance for still finding an 
early copy of the bad object.

> In other words, in your case, the reason you ended up with the corruption 
> spreading was _not_ that "git repack -a -d" might have silently not 
> noticed it, but really the fact that unison meant that the corruption 
> would spread from one archive to another in the first place.

But -d would definitely delete old packs that could have had a non 
corrupted copy of the desired object.

> Final note: a "git repack -a -d" normally actually _does_ do almost as 
> much checking as a "git-fsck-objects". It's literally just the "copy the 
> already packed object from an old pack to a new one" that it an 
> optimization that short-circuits all the normal git sanity checks. All the 
> other cases will effectively do a lot of integrity checking just by virtue 
> of unpacking the data in the object that is packed, before re-packing it.
> 
> So it might well be the case that we should simply add an extra integrity 
> check to the raw data copy in builtin-pack-objects.c: write_object().
> 
> Now, these days there is actually two cases of that: the pack-to-pack copy 
> (which has existed for a long while) and the new "!legacy_loose_object()" 
> case. They should perhaps both verify the integrity of what they copy.

I think that git-pack-object should grow another flag: --verify-src or 
something.  That flag would force the verification of the pack checksum 
for any pack used for the repack operation.  Then it should be used 
anytime -d is provided to git-repack.  When -d is not provided then we 
can skip that --verify-src security measure since nothing gets deleted 
and therefore no risk of loosing a good object over a corrupted one 
would happen.


Nicolas
