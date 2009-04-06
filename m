From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 10:19:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904060959250.6741@xanadu.home>
References: <20090404220743.GA869@curie-int>
 <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
 <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
 <7vab6ue520.fsf@gitster.siamese.dyndns.org>
 <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_X7HI39R1C/7upqtVz3YHJw)"
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqph7-00007o-2q
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbZDFOT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbZDFOT3
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:19:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58956 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbZDFOT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:19:28 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHO001QFNQILE20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 10:18:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.0904061015220.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115835>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_X7HI39R1C/7upqtVz3YHJw)
Content-id: <alpine.LFD.2.00.0904061015221.6741@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Mon, 6 Apr 2009, Jon Smirl wrote:

> On Mon, Apr 6, 2009 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Nicolas Pitre <nico@cam.org> writes:
> >
> >> What git-pack-objects does in this case is not a full repack.  It
> >> instead _reuse_ as much of the existing packs as possible, and only does
> >> the heavy packing processing for loose objects and/or inter pack
> >> boundaryes when gluing everything together for streaming over the net.
> >> If for example you have a single pack because your repo is already fully
> >> packed, then the "packing operation" involved during a clone should
> >> merely copy the existing pack over with no further attempt at delta
> >> compression.
> >
> > One possibile scenario that you still need to spend memory and cycle is if
> > the cloned repository was packed to an excessive depth to cause many of
> > its objects to be in deltified form on insanely deep chains, while cloning
> > send-pack uses a depth that is more reasonable.  Then pack-objects invoked
> > by send-pack is not allowed to reuse most of the objects and would end up
> > redoing the delta on them.
> 
> That seems broken. You went through all of the trouble to make the
> pack file smaller to reduce transmission time, and then clone undoes
> the work.

And as I already explained, this is indeed not what happens.

> What about making a very simple special case for an initial clone?

There should not be any need for initial clone hacks.

> First thing an initial clone does is copy all of the pack files from
> the server to the client without even looking at them.

This is a no go for reasons already stated many times.  There are 
security implications (those packs might contain stuff that you didn't 
intend to be publically accessible) and there might be efficiency 
reasons as well (you might have a shared object store with lots of stuff 
unrelated to the particular clone).

The biggest cost right now when cloning a big packed repo is object 
enumeration.  Any other issues related to memory costs in the GB range 
simply has no reason for it, and is mostly due to misconfigurations or 
bugs that have to be fixed.  Trying to work around the issue by all 
sorts of hacks is simply counter productive.

In the case that started this very thread, I suspect that a small 
misfeature of some delta caching might be the culprit.  I asked Robin H. 
Johnson to perform a really simple config addition to his repo and 
retest, for which we still haven't seen any results yet.


Nicolas

--Boundary_(ID_X7HI39R1C/7upqtVz3YHJw)--
