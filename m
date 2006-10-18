From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 09:02:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610180901210.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
 <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
 <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home>
 <7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610172209070.1971@xanadu.home>
 <7v64eii7hh.fsf@assigned-by-dhcp.cox.net>
 <7vu022gqji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 15:03:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaB4b-0002eD-Q4
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 15:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWJRNDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 09:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWJRNDA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 09:03:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24884 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030263AbWJRNC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 09:02:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00IJY1KL6040@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 09:02:45 -0400 (EDT)
In-reply-to: <7vu022gqji.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29229>

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Ah, I misread the code that uses union actually checks the type
> > in struct delta_entry (which embeds the union).  There won't be
> > any collision problem and you support both types at the same
> > time just fine.
> >
> > And your patch to compare only the first 20-bytes makes sense
> > (assuming ulong is always shorter than 20-bytes which I think is
> > safe to assume).
> 
> Does this sound fair (the code is yours, just asking about the
> log message)?
> 
> If we really wanted to be purist, we could run comparison with
> the union and obj->type as two keys, but I do not think it is
> worth it.
> 
> -- >8 --
> From: Nicolas Pitre <nico@cam.org>
> Date: Tue, 17 Oct 2006 16:23:26 -0400
> Subject: [PATCH] index-pack: compare the first 20-bytes of the key.
> 
> The "union delta_base" is a strange beast.  It is a 20-byte
> binary blob key to search a binary searchable deltas[] array,
> each element of which uses it to represent its base object with
> either a full 20-byte SHA-1 or an offset in the pack.  Which
> representation is used is determined by another field of the
> deltas[] array element, obj->type, so there is no room for
> confusion, as long as we make sure we compare the keys for the
> same type only with appropriate length.  The code compared the
> full union with memcmp().
> 
> When storing the in-pack offset, the union was first cleared
> before storing an unsigned long, so comparison worked fine.
> 
> On 64-bit architectures, however, the union typically is 24-byte
> long; the code did not clear the remaining 4-byte alignment
> padding when storing a full 20-byte SHA-1 representation.  Using
> memcmp() to compare the whole union was wrong.
> 
> This fixes the comparison to look at the first 20-bytes of the
> union, regardless of the architecture.  As long as ulong is
> smaller than 20-bytes this works fine.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Signed-off-by: Nicolas Pitre <nico@cam.org>
