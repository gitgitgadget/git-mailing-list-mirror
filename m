From: Nicolas Pitre <nico@cam.org>
Subject: Re: Recent and near future backward incompatibilities
Date: Sun, 15 Oct 2006 11:34:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610151133450.17085@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 17:34:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ80a-00031q-1j
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 17:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWJOPeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 11:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWJOPeW
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 11:34:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60009 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750987AbWJOPeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 11:34:21 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J76006K8OL89E70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 15 Oct 2006 11:34:21 -0400 (EDT)
In-reply-to: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28917>

On Sat, 14 Oct 2006, Junio C Hamano wrote:

> It was brought to my attention that the public git.git
> repository cannot be cloned with older versions of git.  More
> precisely, packs generated with post 16854571 (NOT contained in
> v1.4.2.3 but in the current "master" and more importantly in
> v1.4.3-rc3 which I tagged tonight) can contain deltas that are
> not compatible with the version of git before d60fc1c8, which
> means that v1.1.6 and older (v1.2.0 and later are Ok).

Ahhhhhh.  DAMN !

> One thing we can and should immediately do is to revert 16854571
> for now until we decide how to resolve this issue cleanly.
> 
> These are what needs to happen but one of them is quite tricky:
> 
>  - the reusing of delta is what makes pack-objects practical,
>    and it is expensive to look into existing delta to see if it
>    is version 2 or version 3 before deciding to reuse each delta
>    data, so even if we update pack-objects so that we can tell
>    it to generate a pack that contains only version 2 deltas, it
>    would be very expensive to do so and may not be practical.

Why not?  After all users of GIT versions that don't understand pack 
version 3 should be a very small minority by now.

>    am not sure how to resolve this issue efficiently right now;
>    we need a bit of thinking.

Actually it doesn't have to be that expensive to convert deltas v2 to 
deltas v3 on the fly.  They can be inflated, parsed, the copy ops that 
exceed 0x10000 converted into multiple ops of smaller copy blocks, then 
deflated.  This is certainly much less costly than rematching deltas 
from scratch.

Well I'd say you just revert pack v3 generation patch for now and 
release v1.4.3 without it.  Pack v3 generation can wait a bit longer 
until we implement the above or users of GIT that can read packs v2 only 
are so few that we shouldn't care anymore and tell them to use an 
intermediate version of GIT in order to clone the latest.  It is not 
like if that makes such a big difference on pack size anyway (much less 
than delta with offsets to base actually).

>  - we need to add .git/config item that tells pack-objects to
>    never generate version 3 delta for that particular
>    repository.  This is similar to the way we would need to
>    control the use of delta-base-offset representation currently
>    cooking in "next".

This is different. The delta-base-offset representation is decided at 
run time every time a pack is generated and regardless if delta data is 
being reused from another pack or regenerated afresh, and so with no 
cost.  So this is no issue for users of old GIT versions since the 
native GIT protocol already handle it in a backward compatible manner.

The only issue here concerns users that don't use the native GIT 
protocol.  But in this case they have two options: either they switch to 
the native protocol, or they upgrade to the latest GIT version which 
can always be pulled with the native GIT protocol.

> We may have a similar issue when enabling generation of loose
> objects with new style headers.  This is already controlled with
> the core.legacyheaders configuration item.

Sure, but those are never passed through the native GIT protocol which 
makes it a much less critical issue.

Not being able to upgrade to the latest GIT in order to actually cope 
with the new format because the primary GIT repository started to feed 
old GIT versions with that new format unconditionally really is a 
problem though.

I think we should not bend backward too much with repository 
compatibility issues as long as there is no interoperability issues at 
the protocol level.  But the GIT protocol must always remain 
interoperable with whatever GIT version still in use.


Nicolas
