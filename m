From: Nicolas Pitre <nico@cam.org>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 16:28:49 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
References: <1134404990.5928.4.camel@localhost.localdomain>
 <7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
 <7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:32:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElvEU-0006kn-2z
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 22:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVLLV2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 16:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVLLV2v
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 16:28:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:5118 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932137AbVLLV2u
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 16:28:50 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IRE0021UMC1GJ10@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Dec 2005 16:28:49 -0500 (EST)
In-reply-to: <7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13542>

On Mon, 12 Dec 2005, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Darrin Thompson <darrint@progeny.com> writes:
> >
> >> Could someone confirm that this exists on more recent git heads and fix
> >> if needed?
> >
> > (1) Yup.  I can reproduce it.
> > (2) Will look into it when able.
> 
> This is not just "diff".  Our deltify code is half-broken, and
> in the worst case this can corrupt our packs if an empty blob is
> involved.

I would say involving an empty blob with deltas _is_ the bug in the 
first place.  Please don't let that happen.

Especially with pack files, an empty blob can be represented with a 
_single_ byte.  A delta must always be against something else and simply 
storing the reference for the object the delta is against will always 
use at least 20 bytes even for empty ones.

> The problem is if from_size or to_size is empty, it does not
> produce any.
> 
>         if (!from_size || !to_size || delta_prepare(from_buf, from_size, &bdf))
>                 return NULL;
> 	
> 
> I think either we need to make the users more careful or fix
> deltifier to produce trivial delta.  I'd vote for the latter;
> let me rig up something.

If my opinion is still of any weight I'd strongly vote for the former.  
A delta against an empty object, or a delta that produces an empty 
object simply makes no sense since it is always suboptimal compared to
storing the non deltified object (or finding another object to deltify 
against).  Allowing empty deltas only paper over another more 
fundamental bug IMHO.


Nicolas
