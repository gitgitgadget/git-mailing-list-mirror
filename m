From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 09:12:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904060901250.6741@xanadu.home>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
 <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
 <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
 <7vab6ue520.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@lang.hm, Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqoeJ-0001z4-I6
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbZDFNMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbZDFNMa
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:12:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37715 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbZDFNM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:12:29 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHO003PJKOMCY30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 09:12:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vab6ue520.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115819>

On Sun, 5 Apr 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > What git-pack-objects does in this case is not a full repack.  It 
> > instead _reuse_ as much of the existing packs as possible, and only does 
> > the heavy packing processing for loose objects and/or inter pack 
> > boundaryes when gluing everything together for streaming over the net.  
> > If for example you have a single pack because your repo is already fully 
> > packed, then the "packing operation" involved during a clone should 
> > merely copy the existing pack over with no further attempt at delta 
> > compression.
> 
> One possibile scenario that you still need to spend memory and cycle is if
> the cloned repository was packed to an excessive depth to cause many of
> its objects to be in deltified form on insanely deep chains, while cloning
> send-pack uses a depth that is more reasonable.  Then pack-objects invoked
> by send-pack is not allowed to reuse most of the objects and would end up
> redoing the delta on them.

Nope.  When pack data is reused, there is simply no consideration what 
so ever for the actual delta depth limit.  Only when an object already 
being used as a delta base for reused deltas is itself subject to delta 
compression does the real depth of the concerned delta chain is 
evaluated in order to not purposely bust the specified delta depth limit 
(otherwise a delta chain could grow unbounded).


Nicolas
