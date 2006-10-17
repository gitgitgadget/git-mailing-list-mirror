From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 14:47:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:47:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZtyO-0008OO-M3
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWJQSrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWJQSrS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:47:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63621 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750995AbWJQSrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:47:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7A0010EMUSWR90@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 14:47:16 -0400 (EDT)
In-reply-to: <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29102>

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Could you instrument the code at the end of 
> > index-pack.c:parse_pack_objects() to display how many deltas were 
> > actually resolved and how many were not?  IOW is it a case of all or 
> > nothing, or is there an isolated case of corruption lurking somewhere?
> 
> fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has
> 18915 unresolved ref-deltas and 0 ofs-deltas among 21205

Hmmm....  Interesting.

Is it possible that sizeof(union delta_base) might not be equal to 20 
for you?

> By the way, "Gaaaah".  Is this find_delta() called from
> find_delta_children() doing the right thing?  I wonder if this
> is open to accidental collisions?. If you have an object name
> whose last 12-bytes are all NUL and you have a pack offset whose
> bytes happens to be a good prefix for an object, what happens?

It is filtered out later thusly:

	...
	for (j = ref_first; j <= ref_last; j++)
		if (deltas[j].obj->type == OBJ_REF_DELTA)
			resolve_delta(&deltas[j], data, ...);

So if a collision happens the object won't be of the right type and it 
is simply skipped.


Nicolas
