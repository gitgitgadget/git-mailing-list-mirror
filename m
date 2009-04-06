From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 11:14:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904061042300.6741@xanadu.home>
References: <20090404220743.GA869@curie-int> <20090405070412.GB869@curie-int>
 <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
 <7vab6ue520.fsf@gitster.siamese.dyndns.org>
 <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com>
 <alpine.LFD.2.00.0904060959250.6741@xanadu.home>
 <9e4733910904060737k3d1c082fk785cd98cdeb6d73d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Mpzm7CBkR1Ek2cKgDLTbaw)"
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 17:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqqZ2-0003c1-4c
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 17:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbZDFPPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 11:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZDFPPM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 11:15:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18782 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZDFPPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 11:15:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHO00419QCYUHH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 11:14:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910904060737k3d1c082fk785cd98cdeb6d73d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115845>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Mpzm7CBkR1Ek2cKgDLTbaw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Mon, 6 Apr 2009, Jon Smirl wrote:

> On Mon, Apr 6, 2009 at 10:19 AM, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 6 Apr 2009, Jon Smirl wrote:
> >
> >> First thing an initial clone does is copy all of the pack files from
> >> the server to the client without even looking at them.
> >
> > This is a no go for reasons already stated many times.  There are
> > security implications (those packs might contain stuff that you didn't
> > intend to be publically accessible) and there might be efficiency
> > reasons as well (you might have a shared object store with lots of stuff
> > unrelated to the particular clone).
> 
> How do you deal with dense history packs? These packs take many hours
> to make (on a server class machine) and can be half the size of a
> regular pack. Shouldn't there be a way to copy these packs intact on
> an initial clone? It's ok if these packs are specially marked as being
> ok to copy.

[sigh]

Let me explain it all again.

There is basically two ways to create a new pack: the intelligent way, 
and the bruteforce way.

When creating a new pack the intelligent way, what we do is to enumerate 
all the needed object and look them up in the object store.  When a 
particular object is found, we create a record for that object and note 
in which pack it is located, at what offset in that pack, how much space 
it occupies in its compressed form within that pack, , and if whether it 
is a delta or not.  When that object is indeed a delta (the majority of 
objects usually are) then we also keep a pointer on the record for the 
base object for that delta.

Next, for all objects in delta form which base object is also part of 
the object enumeration and obviously part of the same pack, we simply 
flag those objects as directly reusable without any further processing.  
This means that, when those objects are about to be stored in the new 
pack, their raw data is simply copied straight from the original pack 
using the offset and size noted above.  In other words, those objects 
are simply never redeltified nor redeflated at all, and all the work 
that was previously done to find the best delta match is preserved with 
no extra cost.

Of course, when your repository is tightly packed into a single pack, 
then all enumerated objects fall into the reusable category and 
therefore a copy of the original pack is indeed sent over the wire.  
One exception is with older git clients which don't support the delta 
base offset encoding, in which case the delta reference encoding is 
substituted on the fly with almost no cost (this is btw another reason 
why a dumb copy of existing pack may not work universally either).  But 
in the common case, you might see the above as just the same as if git 
did copy the pack file because it really only reads some data from a 
pack and immediately writes that data out.

The bruteforce repacking is different because it simply doesn't concern 
itself with existing deltas at all.  It instead start everything from 
scratch and perform the whole delta search all over for all objects.  
This is what takes lots of resources and CPU cycles, and as you may 
guess, is never used for fetch/clone requests.


Nicolas

--Boundary_(ID_Mpzm7CBkR1Ek2cKgDLTbaw)--
