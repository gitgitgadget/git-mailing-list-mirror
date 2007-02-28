From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 23:12:51 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702272258080.29426@xanadu.home>
References: <20070226235510.GF1639@spearce.org>
 <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
 <20070227003118.GH1639@spearce.org>
 <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
 <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
 <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
 <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
 <20070227161122.GE3230@spearce.org>
 <2BBADC5E-7188-4F77-BF5A-28131B435EF0@adacore.com>
 <alpine.LRH.0.82.0702271235260.29426@xanadu.home>
 <20070228035248.GB5597@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 05:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGBp-0001jt-OH
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbXB1EMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXB1EMy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:12:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33930 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXB1EMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:12:53 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE500ISQNPFCEM2@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 23:12:52 -0500 (EST)
In-reply-to: <20070228035248.GB5597@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40889>

On Tue, 27 Feb 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 27 Feb 2007, Geert Bosch wrote:
> > > For smaller packs, the I/O is all going to be buffered anyway,
> > > but if we're going to have >4GB pack files, it adds a lot of real
> > > I/O  and SHA1 computation for no good reason. If we get a rare chance
> > > to have a new pack format, why not fix this wart at the same time?
> > 
> > Fair enough.
> 
> OK, so lets say that if both ends of a network transport support
> pack v4 then we can use pack v4.  If pack v4 omits the count field
> from its header (because its easily derived or obtained from the
> index, and doesn't add any additional data protection over the
> SHA-1s)

I don't agree we should omit it at all.

I agree it might just not be included in the whole pack SHA1. Actually 
the whole pack header might be ommitted from the pack SHA1. This way, if 
data is appended at the end like index-pack does in the thin pack case, 
the header can be fixed up without invalidating the SHA1 that was 
computed while receiving the pack.  Why the whole header?  Well who 
knows if we won't dynamically change the pack version while receiving it 
as well in the future.  In fact, we could just add the header to the 
SHA1 checksum but after the data payload (for the checksum only not in 
the actual pack).  this way we preserve the same protection/validity 
strength as we have today.

> why not add some machine-readable sideband that can provide
> transfer progress?
> 
> I think we would want four values, number of objects (sent/total)
> and uncompressed bytes (sent/total), to send to the client.

Uncompressed bytes is meaningless when evaluating throughput of 
compressed data since compression ratio is variable during a single 
fetch.  It doesn't provide more accurate progress than what we have 
today with number of objects either.

> Estimating the total uncompressed bytes is very easy in pack-objects
> before we start sending even the header; actually if we are reusing
> a majority of the objects from an existing packfile we even have
> a good approximation of the compressed size ready.  That would
> give the client a reasonable progress meter; certainly better than
> nothing at all!  ;-)

IMHO it is not worth it.  And it won't help git-pack-index if run on a 
local pack either.


Nicolas
