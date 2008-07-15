From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 22:21:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142203530.12484@xanadu.home>
References: <20080713011512.GB31050@spearce.org>
 <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <alpine.LFD.1.10.0807132220570.12484@xanadu.home>
 <20080714031242.GA14542@spearce.org>
 <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
 <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se>
 <alpine.DEB.1.00.0807141322140.8950@racer> <487B4BD8.5030208@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jul 15 04:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIaBi-0005DH-Ta
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 04:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897AbYGOCVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 22:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756490AbYGOCVn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 22:21:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16224 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860AbYGOCVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 22:21:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4000NK2ZW53551@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 22:21:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <487B4BD8.5030208@op5.se>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88500>

On Mon, 14 Jul 2008, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Mon, 14 Jul 2008, Andreas Ericsson wrote:
> > 
> > > Sorry for being clueless here, but why does the older versions need
> > > to be kept in-memory anyway? Aren't we applying the delta each time
> > > we find one, repeatedly creating a new base-object in-memory for
> > > each delta? If we aren't doing that, why do we need more than just
> > > a small amount of memory just for keeping the delta?
> > 
> > Think of a delta chain of 49 delta objects, 1 base object.  Now reconstruct
> > all of the objects.
> > 
> > If you do it one by one, not storing the intermediate results, you end up
> > applying 1 delta for the first, 2 for the second (first the first, then the
> > second), and so on, in total 1 + 2 + 3 + ... + 49 = 49 * 50 / 2 = 1225
> > times.
> > 
> > Compare that to the 49 times when reusing the intermediate results.
> > 
> 
> That's only true if you discard the result of applying D1 to DB though.
> What I'm wondering is; Why isn't it done like this (pseudo-code):
> 
> while (delta = find_earlier_delta(sha1)) {
> 	if (is_base_object(delta)) {
> 		base_object = delta;
> 		break;
> 	}
> 	push_delta(delta, patch_stack);
> }
> 
> while (pop_delta(patch_stack))
> 	apply_delta(base_object, delta);
> 
> 
> 
> where "apply_delta" replaces the base_object->blob with the delta
> applied, releasing the previously used memory?
> 
> That way, you'll never use more memory than the largest ever size
> of the object + 1 delta at a time and still not apply the delta
> more than delta_chain_length-1 times.

Those delta chains aren't simple chained lists.  They are trees of 
deltas where one object might be the base for an unlimited number of 
deltas of depth 1, and in turn each of those deltas might constitute the 
base for an unlimited number of deltas of depth 2, and so on.

So what the code does is to find out which objects are not deltas but 
are the base for a delta.  Then, for each of them, all deltas having 
given object for base are found and they are recursively resolved so 
each resolved delta is then considered a possible base for more deltas, 
etc.  In other words, those deltas are resolved by walking the delta 
tree in a "depth first" fashion.

If we discard previous delta bases, we will have to recreate them each 
time a delta sibling is processed.  And if those delta bases are 
themselves deltas then you have an explosion of delta results to 
re-compute.


Nicolas
