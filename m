From: Nicolas Pitre <nico@cam.org>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 00:08:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703182355570.18328@xanadu.home>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org>
 <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org>
 <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org>
 <20070319032130.GF11371@thunk.org> <20070319035351.GI20658@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 05:09:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT9BA-0000AU-1I
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 05:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbXCSEIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 00:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbXCSEIt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 00:08:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54564 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbXCSEIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 00:08:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF400LKPU6NI490@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 00:08:47 -0400 (EDT)
In-reply-to: <20070319035351.GI20658@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42582>

On Sun, 18 Mar 2007, Shawn O. Pearce wrote:

> Theodore Tso <tytso@mit.edu> wrote:
> > So I dug a little more deeply, and the problem is that the reflog for
> > master was getting updated, but not the reflog for HEAD, and that's
> > what "git reflog" was showing --- hence my confusion.
> > 
> > What are the rules for when HEAD's reflog should get updated, and is
> > this documented anywhere in the man pages?
> 
> It is buried down in write_ref_sha1 (in refs.c).  The rule is if the
> name of the ref given to us for update does not match the actual
> ref we are about to change, we log to both the original ref name
> given and the actual ref name.
> 
> This handles the case of HEAD being a symref to some actual branch;
> we update the HEAD reflog and the actual branch reflog whenever
> someone updates HEAD.  Which is what we are usually doing from
> tools like git-checkout.
> 
> receive-pack isn't updating the HEAD reflog as its updating the
> actual branch, not HEAD.  If you pushed instead to HEAD you should
> see the HEAD reflog entry too.

This is indeed a corner case.  And it was never considered before as 
great care was made at the time to be sure pushes wouldn't create any 
reflogs on the remote side, which is effectively done by not 
automatically enabling reflogs on bare repos.

> Its a little ugly here as I'm not sure we should always update
> HEAD's reflog if HEAD points at a branch we are actually updating.
> Maybe we should though in receive-pack ?

If the meaning of HEAD changed (although indirectly) because HEAD 
happens to point to the branch that just got updated then logically the 
HEAD reflog should be updated too.  On the other hand the HEAD reflog 
should reflect operations performed on HEAD.  Since the push updates the 
branch directly it is not exactly performing some operation on HEAD 
since HEAD could point anywhere and that wouldn't change the push at 
all.

Meaning that for the discussion of pushing to a non-bare repository with 
a dirty working tree... If the branch being pushed into is not pointed 
to by HEAD then no consideration what so ever about the working tree 
should be made, and no update to the HEAD reflog made of course.


Nicolas
