From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH] index-pack: Issue a warning if deltaBaseCacheLimit is
 too small
Date: Thu, 17 Jul 2008 19:45:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807171914270.3213@xanadu.home>
References: <20080717220251.GA3072@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 01:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJdAn-0005n5-2O
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 01:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760624AbYGQXpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760710AbYGQXpH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 19:45:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53587 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760292AbYGQXpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 19:45:05 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K46001DLCN3WL90@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Jul 2008 19:45:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080717220251.GA3072@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88936>

On Thu, 17 Jul 2008, Shawn O. Pearce wrote:

> Its rare that we should exceed deltaBaseCacheLimit while resolving
> delta compressed objects.  By default this limit is 16M, and most
> chains are under 50 objects in length.  This affords about 327K per
> object in the chain, which is quite large by source code standards.
> 
> If we have to recreate a prior delta base because we evicted it to
> stay within the deltaBaseCacheLimit we can warn the user that their
> configured limit is perhaps too low for this repository data set.
> If the user keeps seeing the warning they can research it in the
> documentation, and consider setting it higher on this repository,
> or just globally on their system.

As I said earlier, I don't think this is a good idea, but I'll elaborate 
a bit more.

First, this is a really bad clue for setting deltaBaseCacheLimit.  The 
likelyhood of this warning to actually show up during an initial clone 
is relatively high, yet this doesn't mean that deltaBaseCacheLimit has 
to be changed at all.  For one, the real time usage of 
deltaBaseCacheLimit is to cap a cache of objects for multiple delta 
chains with random access, and not only one chain traversed linearly 
like in the index-pack case, 
and that cache is 
likely to always be full and in active eviction mode -- that's the point 
of a cap after all.  In the index-pack this is only used to avoid 
excessive memory usage for intermediate delta results and not really a 
cache.  In other words, we have two rather different usages for the same 
settings.  Now don't read me wrong: I think that reusing this setting is 
sensible, but its value should not be determined by what index-pack may 
happen to do with it, especially on a first clone.  And issuing warnings 
on the first clone is not the way to give new users confidence either.

Secondly, on subsequent fetches, the warning is likely to never appear 
again due to the fact that the delta chains will typically be much 
shorter.  And that would be true even if in reality the runtime access 
to the repository would benefit a lot from deltaBaseCacheLimit being 
raised.  And it is the runtime access which is important here, not the 
occasional fetch.  Yet the full delta chains are not likely to be walked 
in their entirety very often anyway either.

Thirdly, if such indication is considered useful, then it should really 
be part of some statistic/analysis tool, such as verify-pack for 
example.  Such a tool could compute the exact memory requirements for a 
given repository usage and possibly provide suggestions as to what the 
optimal deltaBaseCacheLimit value could be.  But yet that cache has a 
hardcoded number of entries at the moment and its hash function might 
not be optimal either, making the connection with index-pack even more 
apart.

And finally, I think that index-pack would benefit a lot from a really 
simple optimization which is to free the resulting intermediate delta 
base object right away when there is only one delta child to resolve, 
before that child is itself used as a base for further delta 
grand-children.  That is likely to cover most cases of big delta chains 
already, making that warning an even worse indicator.

> Suggested-by: Stephan Hennig <mailing_list@arcor.de>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Unrecommended-by: Nicolas Pitre <nico@cam.org>


Nicolas
