From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] improve reliability of fixup_pack_header_footer()
Date: Fri, 29 Aug 2008 09:08:48 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808290844200.1624@xanadu.home>
References: <alpine.LFD.1.10.0808282142490.1624@xanadu.home>
 <1219975624-7653-1-git-send-email-nico@cam.org>
 <20080829044459.GA28492@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 15:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ3jj-0001Cd-Mz
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 15:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYH2NIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 09:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbYH2NIz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 09:08:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40468 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbYH2NIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 09:08:54 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D0009E5UOUV80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 09:08:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080829044459.GA28492@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Aug 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > Currently, this function has the potential to read corrupted pack data
> > from disk and give it a valid SHA1 checksum.  Let's add the ability to
> > validate SHA1 checksum of existing data along the way, including before
> > and after any arbitrary point in the pack.
> 
> I found your implementation in fixup_pack_header to be very
> contorted.  Did you read the JGit patch I posted?  I think its
> implementation is more elegant and easier to follow.  Oh, and its
> BSD licensed... so easy for a GPLv2 project to borrow.  ;-)

Well, actually, I don't find the JGit implementation easier to follow at 
all.  Of course I wrote the C version while you wrote the Java version.  
Maybe without our respective bias then things are just fine in both 
cases.

> >  void fixup_pack_header_footer(int pack_fd,
> ...
> > +	if (partial_pack_sha1 && !partial_pack_offset) {
> > +		partial_pack_offset = lseek(pack_fd, 0, SEEK_CUR);
> > +		if (partial_pack_offset == (off_t)-1)
> 
> Eh?
> 
> I find this to be nonsense.  If the caller gave us a SHA-1 but
> wants us to do fixup then they have increased the size of the pack.
> Which means they must pass us the original length.  Computing it
> here is relying on the caller leaving the file pointer positioned
> at the old end.  Who the heck does that after fixing a thin pack?

This is not for thin packs but for split packs in repack-objects. And 
yeah, the caller has the offset information already in that case too, so 
this could be removed.  It just felt more generic that way originally.

> >  	buf = xmalloc(buf_sz);
> >  	for (;;) {
> > -		ssize_t n = xread(pack_fd, buf, buf_sz);
> > +		ssize_t m, n;
> > +		m = (partial_pack_sha1 && partial_pack_offset < buf_sz) ?
> > +			partial_pack_offset : buf_sz;
> > +		n = xread(pack_fd, buf, m);
> 
> Why not read the full buf_sz per round and then use only part of
> the buffer in SHA1_Update(&old_sha1_ctx)?  It took me a while to
> figure out what the heck you were trying to measure here.  It also
> would be a few less CPU instructions if you always just read buf_sz
> and leave the min test to after the "if (!partial_pack_sha1)" below.

I doubt it.  That would only move the offset test from before the read 
to after it, and actually complicate things for restarting the 
checksumming after the special offset was crossed.  And we're talking 
about a comparison with a conditional move instructions only.

And another thing I had in store (but for which you _again_ beat me to :-) )
is to realign data reads onto filesystem blocks.

> > +		if (!partial_pack_sha1)
> > +			continue;
> > +
> > +		SHA1_Update(&old_sha1_ctx, buf, n);
> > +		partial_pack_offset -= n;
> > +		if (partial_pack_offset == 0) {
> > +			unsigned char sha1[20];
> > +			SHA1_Final(sha1, &old_sha1_ctx);
> > +			if (hashcmp(sha1, partial_pack_sha1) != 0)
> > +				die("Unexpected checksum for %s "
> > +				    "(disk corruption?)", pack_name);
> > +			/*
> > +			 * Now let's compute the SHA1 of the remainder of the
> > +			 * pack, which also means making partial_pack_offset
> > +			 * big enough not to matter anymore.
> > +			 */
> > +			SHA1_Init(&old_sha1_ctx);
> > +			partial_pack_offset = ~partial_pack_offset;
> > +			partial_pack_offset -= MSB(partial_pack_offset, 1);
> 
> That's freaking brilliant.  And something I missed in JGit.
> 
> The way its implemented is downright difficult to follow though.
> I'll admit it took me a good 10 minutes to understand what you were
> doing here, and why.

Again maybe that's just because you're just too biased by your own 
implementation.  I don't consider this code particularly obscur.


Nicolas
