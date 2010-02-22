From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
Date: Mon, 22 Feb 2010 00:50:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002220034540.1946@xanadu.home>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
 <7v635p4z26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:17:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjRBZ-0000Fl-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 06:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab0BVFuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 00:50:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49902 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab0BVFuU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 00:50:20 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY80019XAVUS820@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Feb 2010 00:50:19 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v635p4z26.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140616>

On Sun, 21 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > The whole point is to detect data incoherencyes.
> 
> Yes.  We want to make sure that the SHA-1 we compute is over what we fed
> deflate().
> 
> > So current sequence of events is as follows:
> >
> > T0	write_sha1_file_prepare() is called
> > T1	start initial SHA1 computation on data buffer
> > T2	in the middle of initial SHA1 computation
> > T3	end of initial SHA1 computation -> object name is determined
> > T4	write_loose_object() is called
> > ...	enter the write loop
> > T5+n	deflate() called on buffer n
> > T6+n	git_SHA1_Update(() called on the same buffer n
> > T7+n	deflated data written out
> > ...
> > Tend	abort if result of T6+n doesn't match object name from T3
> >
> > So... what can happen:
> >
> > 1) Data is externally modified before T5+n: deflated data and its CRC32 
> >    will be coherent with the SHA1 computed in T6+n, but incoherent with 
> >    the SHA1 used for the object name. Wrong data is written to the 
> >    object even if it will inflate OK. We really want to prevent that 
> >    from happening. The test in Tend will fail.
> >
> > 2) Data is externally modified between T5+n and T6+n: the deflated data 
> >    and CRC32 will be coherent with the object name but incoherent with 
> >    the parano_sha1.  Although written data will be OK, this is way too 
> >    close from being wrong, and the test in Tend will fail.  If there is 
> >    more than one round into the loop and the external modifications are 
> >    large enough then this becomes the same as case 1 above.
> >
> > 3) Data is externally modified in T2: again the test in Tend will fail.
> >
> > So in all possible cases I can think of, the write will abort.
> 
> There is one pathological case.
> 
> Immediately before T5+n (or between T5+n and T6+n), the external process
> changes the data deflate() is working on, but before T6+n, the external
> process changes the data back.  Two SHA-1's computed may match, but it is
> not a hash over what was deflated(); you won't be able to abort.

And what real life case would trigger this?  Given the size of the 
window for this to happen, what are your chances?

Of course the odds for me to be struck by lightning also exist.  And if 
I work really really hard at it then I might be able to trigger that 
pathological case above even before the next thunderstorm.  But in 
practice I'm hardly concerned by either of those possibilities.


Nicolas
