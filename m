From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded in
 the pack
Date: Sat, 29 Oct 2011 00:48:03 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110290031540.30467@xanadu.home>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
 <CAJo=hJt-YZcdxw+D=1S4haPmY-8-LLjXD=MvDGeWbdJ88_VOGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_GRTHt6+vG2FkKOiwslw8GQ)"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 29 00:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJvDf-0000pg-10
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 00:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933639Ab1J1WsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 18:48:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21057 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932752Ab1J1WsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 18:48:05 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LTS00EG9SE5JDA0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Oct 2011 18:42:05 -0400 (EDT)
In-reply-to: <CAJo=hJt-YZcdxw+D=1S4haPmY-8-LLjXD=MvDGeWbdJ88_VOGw@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184436>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_GRTHt6+vG2FkKOiwslw8GQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 28 Oct 2011, Shawn Pearce wrote:

> On Thu, Oct 27, 2011 at 23:04, Junio C Hamano <gitster@pobox.com> wrote:
> > In addition to four basic types (commit, tree, blob and tag), the pack
> > stream can encode a few other "representation" types, such as REF_DELTA
> > and OFS_DELTA. As we allocate 3 bits in the first byte for this purpose,
> > we do not have much room to add new representation types in place, but we
> > do have one value reserved for future expansion.
> 
> We have 2 values reserved, 0 and 5.
> 
> > When bit 4-6 encodes type 5, the first byte is used this way:
> >
> >  - Bit 0-3 denotes the real "extended" representation type. Because types
> >   0-7 can already be encoded without using the extended format, we can
> >   offset the type by 8 (i.e. if bit 0-3 says 3, it means representation
> >   type 11 = 3 + 8);
> >
> >  - Bit 4-6 has the value "5";
> >
> >  - Bit 7 is used to signal if the _third_ byte needs to be read for larger
> >   size that cannot be represented with 8-bit.
> 
> This is very complicated. We don't need more complex logic in the pack
> encoding. We _especially_ do not need yet another variant of how to
> store a variable length integer in the pack file. I'm sorry, but we
> already have two different variants and this just adds a third. It is
> beyond crazy.
> 
> Last time (this is now years ago but whatever) Nico and I discussed
> adding a new type to packs it was for the alternate tree encoding in
> "pack v4". Trees happen so often that type code 5 is a good value to
> use for these. Later you talked about using the extended type to store
> a cattree blob thing, which would not appear nearly as often as a
> normal directory listing type tree that was encoded using the pack v4
> style encoding... I think saving type 5 for a small frequently
> occurring type is a good thing.
> 
> > As it is unlikely for us to pack things that do not need to record any
> > size, the second byte is always used in full to encode the low 8-bit of
> > the size.
> >
> > I haven't started using type=8 and upwards for anything yet, but because
> > we have only one "future expansion" value left, I want us to be extremely
> > careful in order to avoid painting us into a corner that we cannot get out
> > of, so I am sending this out early for a preliminary review.
> 
> I would have said something more like:
> 
> When bit 4-6 encodes "0", then:
> 
> - Bit 0-3 and bit 7 are used normally to encode a variable length
> "size" integer. These may be 0 indicating no size information.
> 
> - 2nd-nth bytes store remaining "size" information, if bit 7 was set.
> 
> - The immediate next byte encodes the extended type. This type is
> stored using the OFS_DELTA offset varint encoding, and thus may be
> larger than 256 if we ever need it to be.

I'd say it is just a byte.  No encoding needed.  Let's not be silly 
about it.  If we really have more than 255 object types one day (and I 
really hope this will never happen) then the value 0 in that byte could 
indicate yet another extended object type encoding.  But I truly hope 
we'll have pack v9 or v10 by then and that we'll have obsoleted the 
current 3-bit encoding completely at that point anyway.

For the record, I spent around 20 hours working on pack v4 while in the 
Caribbeans for a week last winter as I said I would.  Maybe I'll repeat 
the operation this year.


Nicolas

--Boundary_(ID_GRTHt6+vG2FkKOiwslw8GQ)--
