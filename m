From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
Date: Sun, 21 Feb 2010 20:35:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 03:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjNGg-0002oQ-Fr
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 02:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab0BVBjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 20:39:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15116 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab0BVBjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 20:39:18 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY70077TZ3OYX70@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 21 Feb 2010 20:35:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140534>

On Sun, 21 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >  	/* Then the data itself.. */
> >  	stream.next_in = buf;
> >  	stream.avail_in = len;
> >  	do {
> > +		unsigned char *in0 = stream.next_in;
> >  		ret = deflate(&stream, Z_FINISH);
> > +		git_SHA1_Update(&c, in0, stream.next_in - in0);
> 
> Actually, I have to take my earlier comment back.  This is not "paranoia".
> 
> I do not see anything that protects the memory area between in0 and
> stream.next_in from getting modified while deflate() nor SHA1_Update() run
> from the outside.

So what?

> Unless you copy the data away to somewhere stable at
> the beginning of each iteration of this loop and run deflate() and
> SHA1_Update(), you cannot have "paranoia".

No.

The whole point is to detect data incoherencyes.

So current sequence of events is as follows:

T0	write_sha1_file_prepare() is called
T1	start initial SHA1 computation on data buffer
T2	in the middle of initial SHA1 computation
T3	end of initial SHA1 computation -> object name is determined
T4	write_loose_object() is called
...	enter the write loop
T5+n	deflate() called on buffer n
T6+n	git_SHA1_Update(() called on the same buffer n
T7+n	deflated data written out
...
Tend	abort if result of T6+n doesn't match object name from T3

So... what can happen:

1) Data is externally modified before T5+n: deflated data and its CRC32 
   will be coherent with the SHA1 computed in T6+n, but incoherent with 
   the SHA1 used for the object name. Wrong data is written to the 
   object even if it will inflate OK. We really want to prevent that 
   from happening. The test in Tend will fail.

2) Data is externally modified between T5+n and T6+n: the deflated data 
   and CRC32 will be coherent with the object name but incoherent with 
   the parano_sha1.  Although written data will be OK, this is way too 
   close from being wrong, and the test in Tend will fail.  If there is 
   more than one round into the loop and the external modifications are 
   large enough then this becomes the same as case 1 above.

3) Data is externally modified in T2: again the test in Tend will fail.

So in all possible cases I can think of, the write will abort.  No copy 
buffer needed, no filesystem mtime required, etc.  If the whole data is 
not stable between T1 and Tend then the object is not added to the 
repository.  Of course it is possible that the data be modified at the 
beginning of the file while the loop in T[5-7] is passed that point.  
But still, there is no data inconsistency at that point.

> My comment about "trickier" is about determining the size of that buffer
> used as "somewhere stable".

We don't care about such buffer.


Nicolas
