From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 23:01:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610182234070.1971@xanadu.home>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
 <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
 <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home>
 <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
 <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181910440.1971@xanadu.home>
 <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 05:02:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaOAQ-0008RA-26
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 05:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423224AbWJSDBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 23:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWJSDBy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 23:01:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58209 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030293AbWJSDBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 23:01:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7D00CAX4F4D6K3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 23:01:53 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29314>

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> 
> 
> On Wed, 18 Oct 2006, Nicolas Pitre wrote:
> > 
> > If you use builtin-unpack-objects.c from next, you'll be able to 
> > generate the pack index pretty easily as well, as all the needed info is 
> > stored in the obj_list array.  Just need to append objects remaining on 
> > the delta_list array to the end of the pack, sort the obj_list by sha1 
> > and write the index.
> 
> Actually, I've hit an impasse.
> 
> The index isn't the problem. The problem is actually writing the resultant 
> pack-file itself in one go.
> 
> The silly thing is, the pack-file contains the number of entries in the 
> header. That's a silly problem, because the _natural_ way to turn a thin 
> pack into a normal pack would be to just add the missing objects from the 
> local store into the resulting pack. But we don't _know_ how many such 
> missing objects there are, until we've gone through the whole source pack. 
> 
> So you can't easily do a streaming "write the result as you go along" 
> version using that approach.

Hmmm.... unpack-objects receives a (possibly thin) pack over its stdin.  
That part has to be streamed.  But its output is currently always 
written to multiple files as separate objects.  So, while the input 
comes from a stream, the output doesn't have to.

In that case, why not just write the input directly to a temporary file, 
append the missing objects, seek back to adjust the object number, and 
finally run a SHA1_Update() on the whole thing?  This forces you to 
write everything and then read everything back, but this should not be 
too bad especially that the written data is likely to still be cached.  
Once its final sha1sum is written then it just need to be moved with the 
appropriate name.

> So there's _another_ way of fixing a thin pack: it's to expand the objects 
> without a base into non-delta objects, and keeping the number of objects 
> in the pack the same. But _again_, we don't actually know which ones to 
> expand until it's too late.
> 
> The end result? I can expand them all (I have a patch that does that). Or 
> I could leave as deltas the ones I have already seen the base for in the 
> pack-file (I don't have that yet, but that should be a SMOP). But I'm not 
> very happy with even the latter choice, because it really potentially 
> expands things that didn't _need_ expansion, they just got expanded 
> because we hadn't seen the base object yet.

Most base objects, well all of them nowadays, are written before their 
deltas.  So in practice the only objects that will get expanded are the 
deltas with missing base.   Still it is unfortunate.

> So I'll happily send my patches to anybody who wants to try (I don't write 
> the index file yet, but it should be easy to add), but I'm getting the 
> feeling that "builtin-unpack-objects.c" is the wrong tool to use for this, 
> because it's very much designed for streaming.
> 
> It would probably be better to start from "index-pack.c" instead, which is 
> already a multi-pass thing, and wouldn't have had any of the problems I 
> hit. 

But index-pack is totally incompatible with any streaming.  It mmap() 
the whole pack and happily perform random accesses.  So you'd need to 
write the entire thin pack to disk anyway before it could work on it.  
This is not really better than the unpack-objects option.  At least 
unpack-objects is structured to perform work on the fly as data is 
received.

> Gaah.
> 
> > Pretty trivial indeed.
> 
> So it's conceptually totally trivial to rewrite a pack-file as another 
> pack-file, but at least so far, it's turned out to be less trivial in 
> practice (or at least in a single pass, without holding everything in 
> memory, which I definitely do _not_ want to do).
> 
> So I'm leaving this for today, and perhaps coming back to it tomorrow with 
> a fresh eye.

I'll have a look at your patches tomorrow as well.  I have many ideas 
brewing, including randering index-pack obsolete since actually 
unpack-objects could do it all already (both tools have many concepts in 
common).


Nicolas
