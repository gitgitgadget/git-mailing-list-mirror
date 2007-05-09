From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 09 May 2007 11:27:28 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705091048120.24220@xanadu.home>
References: <4640FBDE.1000609@gmail.com>
 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
 <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
 <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 17:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlo50-00030M-A6
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbXEIP1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbXEIP1q
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:27:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40615 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbXEIP1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:27:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHS00NYV5LU4530@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 May 2007 11:27:30 -0400 (EDT)
In-reply-to: <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46728>

On Wed, 9 May 2007, Dana How wrote:

> OK,  I got really confused here, so I looked over the code,
> and figured out 2 causes for my confusion.
> (1) core.legacyheaders controls use_legacy_headers, which defaults to 1.
> So currently all loose objects are in legacy format and the code block
> I spoke of doesn't trigger [without a config setting].  I didn't realize
> legacy headers were still being produced (mislead by the name!).
> (2) I read your "setting core.legacyheaders" as followed by TRUE,
> but you meant FALSE, which is not the default.
> 
> I also read that 1 year after 1.4.2, the default for core.legacyheaders is
> going
> to change to FALSE.  I think our discussion should assume this has
> happened.

<tangential comment>

Now that we encourage and actively preserve objects in a packed form 
more agressively than we did at the time core.legacyheaders was 
introduced, I really wonder if this option is still worth it.  Because 
the packing of loose objects has to go through the delta match loop 
anyway, and since most of them should end up being deltified in most 
cases, there is really little advantage to have this parallel loose 
object format as the CPU savings it might provide is rather lost in the 
noise in the end.  

So I suggest that we get rid of core.legacyheaders, preserve the legacy 
format as the only writable loose object format and deprecate the other 
one to keep things simpler.  Thoughts?

</tangential comment>

> So let's assume FALSE in the following.  The point of that is that 
> such a FALSE setting can't be assumed to have any special intent; it 
> will be the default.
> 
> [Everything I write here boils down to only one question,
> which I repeat at the end.]
> 
> Data gets into a pack in these ways:
> 1. Loose object copied in;
> 2. Loose object newly deltified;
> 3. Packed object to be copied;
> 4. Packed object to be newly deltified;
> 5. Packed deltified object we can't re-use;
> 6. Packed deltified object we can re-use.
> ["copied" includes recompressed.]

I think you forgets "packed undeltified objects we can reuse".

> In (2), (4), and (5), pack.compression will always be newly used.
> If pack.compression doesn't change,  this means (6)
> will be using pack.compression since it comes from (2) or (4).
> So if I "guarantee" that (1) uses pack.compression,
> (3) will as well, meaning everything in the pack will be
> at pack.compression.
> 
> Thus if pack.compression != core.loosecompression takes precedence
> over core.legacyheaders = false,  then for pack.compression constant
> we get all 6 cases at level pack.compression.  If core.legacyheaders =
> false takes precedence as you suggest,  then all undeltified objects
> (20%?) will be stuck at core.loosecompression [since I see no way
> to sensibly re-apply compression to something copied pack-to-pack].
> 
> I think this is inconsistent with what a pack.compression !=
> core.loosecompression setting is telling us.

OK I see that I missed the fact that git-repack -f (or git-pack-objects 
--no-reuse-delta) does not recompress undeltified objects.  Note this is 
a problem in the case where you change pack.compression to a different 
value or override it on the command line as well: reused undeltified 
objects won't get recompressed with the new level.  My rant on 
core.legacyheaders and its removal would address the first case.  Your 
test for a difference between loose and packed compression levels is 
flawed because the value of core.compression does not necessarily 
represent the compression level that was used for the loose objects to 
pack (core.compression might have been modified since then), but it 
only addresses the first case too.  And this is a problem even now.

What we need instead is a --no-reuse-object that would force 
recompression of everything when you really want to enforce a specific 
compression level across the whole pack(s).


Nicolas
