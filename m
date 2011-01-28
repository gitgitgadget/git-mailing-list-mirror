From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 16:09:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_WSjNyqDHg6FxPYaeTsbDQg)"
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 28 22:09:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PivZa-0000nm-AJ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 22:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1A1VJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 16:09:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26039 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1A1VJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 16:09:31 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFR002Z943I5KG0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Jan 2011 16:09:18 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1101281523430.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165641>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_WSjNyqDHg6FxPYaeTsbDQg)
Content-id: <alpine.LFD.2.00.1101281523431.8580@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Fri, 28 Jan 2011, Shawn Pearce wrote:

> On Fri, Jan 28, 2011 at 10:46, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 28 Jan 2011, Shawn Pearce wrote:
> >
> >> This started because I was looking for a way to speed up clones coming
> >> from a JGit server.  Cloning the linux-2.6 repository is painful,
> ...
> >> Later I realized, we can get rid of that cached list of objects and
> >> just use the pack itself.
> ...
> > Playing my old record again... I know.  But pack v4 should solve a big
> > part of this enumeration cost.
> 
> I've said the same thing for years myself.  As much as it would be
> nice to fix some of the decompression costs with pack v2/v3, v2/v3 is
> very common in the wild, and a new pack encoding is going to be a
> fairly complex thing to get added to C Git.  And pack v4 doesn't
> eliminate the enumeration, it just makes it faster.

Well, you don't necessarily need pack v4 to be widely deployed for 
people to benefit from it.  If it is available on servers such as 
git.kernel.org then everybody will see their clone requests go faster.  
Same principle as for the cache packs.

And yes it doesn't eliminate the enumeration, but you can't eliminate it 
entirely either as many other operations do require object enumeration 
too, and those would be sped up as well.

But this is in fact orthogonal to the cache pack concept indeed.

> That's what I also liked about my --create-cache flag.  Its keeping
> the same data we already have, in the same format we already have it
> in.  We're just making a more explicit statement that everything in
> some pack is about as tightly compressed as it ever would be for a
> client, and it isn't going to change anytime soon.  Thus we might as
> well tag it with .keep to prevent repack of mucking with it, and we
> can take advantage of this to serve the pack to clients very fast.

I do agree on that point.   And I like it too.  However I'd prefer if 
the whole thing wasn't created "automatically".  It's probably best if 
the repository administrator decides explicitly what should go in such 
cached packs according to actual purpose and usage for good commit 
thresholds and branches.  Only a human can make that decision.

I'd also recommend _not_ using the ref namespace for that.  Let's not 
mix up branching/tagging with what is effectively a storage 
implementation issue. Linking the ref namespace with the actual packs 
they refer to would be highly inelegant if the SHA1 of the pack has to 
be part of the ref name.  Instead, I'd suggest simply listing all the 
commit tips a cache pack contains in the .keep file directly instead.  
That would make it much easier to use with the object alternates too as 
the alternate mechanism points to the object store of a foreign repo and 
not to its refs.

> Over breakfast this morning I made the point to Junio that with the
> cached pack and a slight network protocol change (enabled by a
> capability of course) we could stop using pkt-line framing when
> sending the cached pack part of the stream, and just send the pack
> directly down the socket.  That changes the clone of a 400 MB project
> like linux-2.6 from being a lot of user space stuff, to just being a
> sendfile() call for the bulk of the content.  I think we can just hand
> off the major streaming to the kernel. 

While this might look like a good idea in theory, did you actually 
profile it to see if that would make a noticeable difference?  The 
pkt-line framing allows for asynchronous messages to be sent over a 
sideband, which you wouldn't be able to do anymore until the full 400 MB 
is received by the remote side.  Without concrete performance numbers 
I'm not convinced it is worth the maintenance cost for creating a 
deviation in the protocol like this.

> (Part of the protocol change
> is we would need to use multiple SHA-1 checksums in the stream, so we
> don't have to re-checksum the existing cached pack.)

?? I don't follow you here.

> I love the idea of some of the concepts in pack v4.  I really do.  But
> this sounds a lot simpler to implement, and it lets us completely
> eliminate a massive amount of server processing (even under pack v4
> you still have object enumeration), in exchange for what might be a
> few extra MBs on the wire to the client due to slightly less good
> deltas and the use of REF_DELTA in the thin pack used for the most
> recent objects.

I agree.  And what I personally like the most is the fact that this can 
be made transparent to clients using the existing network protocol 
unchanged.

> Plus we can safely do byte range requests for resumable clone within
> the cached pack part of the stream.

That part I'm not sure of.  We are still facing the same old issues 
here, as some mirrors might have the same commit edges for a cache pack 
but not necessarily the same packing result, etc.  So I'd keep that out 
of the picture for now.  The idea of being able to resume the transfer 
of a cache pack is good, however I'd make it into a totally separate 
service outside git-upload-pack where the issue of validating and 
updating content on both sides can be done efficiently without impacting 
the upload-pack protocol.  There would be more than just the cache pack 
in play during a typical clone.

> And when pack v4 comes along, we
> can use this same strategy for an equally large pack v4 pack.

Absolutely.


Nicolas

--Boundary_(ID_WSjNyqDHg6FxPYaeTsbDQg)--
