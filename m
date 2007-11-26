From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 15:55:43 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261529080.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
 <alpine.LFD.0.99999.0711261433210.9605@xanadu.home>
 <56b7f5510711261217h56214321xb7acd9851b677dd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwl0S-0002l2-Ea
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbXKZUzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbXKZUzp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:55:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17031 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbXKZUzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:55:44 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400J11SSVKTD0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 15:55:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <56b7f5510711261217h56214321xb7acd9851b677dd6@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66121>

On Mon, 26 Nov 2007, Dana How wrote:

> On Nov 26, 2007 11:52 AM, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 26 Nov 2007, Dana How wrote:
> > > Currently data can be quickly copied from pack to pack,
> > > but data cannot be quickly copied blob->pack or pack->blob
> > I don't see why you would need the pack->blob copy normally.
> True,  but that doesn't change the main point.

Sure, but let's not go overboard either.

> > > (there was an alternate blob format that supported this,
> > >  but it was deprecated).  Using the pack format for blobs
> > > would fix this.
> >
> > Then you can do just that for big enough blobs where "big enough" is
> > configurable: encapsulate them in a pack instead of a loose object.
> > Problem solved.  Sure you'll end up with a bunch of packs containing
> > only one blob object, but given that those blobs are so large to be a
> > problem in your work flow when written out as loose objects, then they
> > certainly must be few enough not to cause an explosion in the number of
> > packs.
> Are you suggesting that "git add" create a new pack containing
> one blob when the blob is big enough?

Exactly.

> Re-using (part of) the pack format
> in a blob (or maybe only some blobs) seems like less code change.

Don't know what you mean exactly here, but what I mean is to do 
something as simple as:

	pretend_sha1_file(...);
	add_object_entry(...);
	write_pack_file();

when the buffer to make a blob from is larger than a configured 
treshold.

> > > It would also mean blobs wouldn't need to
> > > be uncompressed to get the blob type or size I believe.
> >
> > They already don't.
> It looks like sha1_file.c:parse_sha1_header() works on a buffer
> filled in by sha1_file.c:unpack_sha1_header() by calling inflate(), right?
> 
> It is true you don't have to uncompress the *entire* blob.

Right.  Only the first 16 bytes or so need to be uncompressed.

> > > The equivalent operation in git would require the creation of
> > > the blob,  and then of a temporary pack to send to the server.
> > > This requires 3 calls to zlib for each blob,  which for very
> > > large files is not acceptable at my site.
> >
> > I currently count 2 calls to zlib, not 3.
> I count 3:
> 
> Call 1: git-add calls zlib to make the blob.
> 
> Call 2: builtin-pack-objects.c:write_one() calls sha1_file.c:read_sha1_file()
> calls :unpack_sha1_file() calls :unpack_sha1_{header,rest}() calls
> inflate() to get the data from the blob into a buffer.
> 
> Call 3: Then write_one() calls deflate to make the new buffer
> to write into the pack.  This is all under the "if (!to_reuse) {" path,
> which is active when packing a blob.

Oh, you're right.  Somehow I didn't count the needed decompression.

> Remember,  I'm comparing "p4 submit file" to
> "git add file"/"git commit"/"git push",  which is the comparison
> the users will be making.
> 
> On the other hand,  I'm looking at code from June;
> but I haven't noticed big changes since then on the list.
> 
> Calls 2 and 3 go away if the blob and pack formats were more similar.

... which my suggestion should provide with a minimum of changes, maybe 
less than 10 lines of code.


Nicolas
