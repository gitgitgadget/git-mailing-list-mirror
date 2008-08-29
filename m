From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] improve reliability of fixup_pack_header_footer()
Date: Fri, 29 Aug 2008 07:30:23 -0700
Message-ID: <20080829143023.GA7403@spearce.org>
References: <alpine.LFD.1.10.0808282142490.1624@xanadu.home> <1219975624-7653-1-git-send-email-nico@cam.org> <20080829044459.GA28492@spearce.org> <alpine.LFD.1.10.0808290844200.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 16:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ51D-0000f4-RV
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 16:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882AbYH2Oa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 10:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757892AbYH2Oa0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 10:30:26 -0400
Received: from george.spearce.org ([209.20.77.23]:56870 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756613AbYH2Oa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 10:30:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 509D038375; Fri, 29 Aug 2008 14:30:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808290844200.1624@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94288>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 28 Aug 2008, Shawn O. Pearce wrote:
> > 
> > I found your implementation in fixup_pack_header to be very
> > contorted.  Did you read the JGit patch I posted?
> 
> Well, actually, I don't find the JGit implementation easier to follow at 
> all.  Of course I wrote the C version while you wrote the Java version.  
> Maybe without our respective bias then things are just fine in both 
> cases.

I probably should have gone and edited my eariler comments after I
reached the end of the patch and the light dawned about why you are
summing the tail.  Most of what I found to be complex in your code
was just to handle that boundary condition at partial_pack_offset
and restart the checksum for the tail.  But I honestly cannot see
an easier way to write that, so what you have is just fine.
 
> > >  void fixup_pack_header_footer(int pack_fd,
> > ...
> > > +	if (partial_pack_sha1 && !partial_pack_offset) {
> > > +		partial_pack_offset = lseek(pack_fd, 0, SEEK_CUR);
> > > +		if (partial_pack_offset == (off_t)-1)
> > 
> > Eh?
> > 
> > I find this to be nonsense.
> 
> This is not for thin packs but for split packs in repack-objects. And 
> yeah, the caller has the offset information already in that case too, so 
> this could be removed.  It just felt more generic that way originally.

Oh, yea, that makes sense.  It still seems like playing with fire.

I'd rather the caller pass in the proper offset than rely on it
being the current position of the fd.  Especially if the caller
does actually have it available.

If you change anything, I'd like to see this lseek(SEEK_CUR) go away.
 
> And another thing I had in store (but for which you _again_ beat me to :-) )
> is to realign data reads onto filesystem blocks.

That _really_ made the JGit code ugly.  But I think its worth it.

I also want to try and buffer the whole object appending we do
during fixThinPack(), as right now we write the object header in
one write and then compressed data bursts in the others.  Moving it
to at least write a full 4k at a time should remove about 2 write
calls per object.
 
> > That's freaking brilliant.  And something I missed in JGit.
> > The way its implemented is downright difficult to follow though.
> > I'll admit it took me a good 10 minutes to understand what you were
> > doing here, and why.
> 
> Again maybe that's just because you're just too biased by your own 
> implementation.  I don't consider this code particularly obscur.

My own code in JGit got "obscure" when I added this check too.
I take back the remark above.

-- 
Shawn.
