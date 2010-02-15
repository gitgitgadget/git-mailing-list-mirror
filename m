From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 00:48:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002150016110.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
 <20100214024259.GB9704@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
 <32541b131002141513m29f9a796ma8fb5855a45f91e9@mail.gmail.com>
 <alpine.LFD.2.00.1002142252020.1946@xanadu.home>
 <32541b131002142101i226663cfk90d1ba14f1031788@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:48:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngtp9-00074f-R8
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0BOFsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:48:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58009 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab0BOFsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:48:42 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXV00130C55STG0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Feb 2010 00:48:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <32541b131002142101i226663cfk90d1ba14f1031788@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139985>

On Mon, 15 Feb 2010, Avery Pennarun wrote:

> - git-prune only prunes unpacked objects
> 
> - git-repack claims to be willing to explode unreachable objects back
> into loose objects with -A, but I'm not quite sure if its definition
> of "unreachable" is the same as mine.  

Unreachable means not referenced by the specified rev-list 
specification.  So if you give it --all --reflog then it means any 
objects that is not reachable through either your branches, tags or 
reflog entries.

> And I'm not sure rewriting a
> pack with -A makes the old pack reliably unreachable according to -d.

Reachability doesn't apply to packs.  That applies to objects.  And 
unreachable objects may be copied to loose objects with -A, or simply 
forgotten about with -a.  Then -d will literally delete the old pack 
file.

> - there seems to be no documented situation in which you can ever
> delete unused objects from a pack without using repack -a or -A, which
> can be amazingly slow if your packs are huge.  (Ideally you'd only
> repack the particular packs that you want to shrink.)  For example, my
> bup repo is currently 200 GB.

Ideally you don't keep volatile objects into huge packs.  That's why we 
have .keep to flag those packs that are huge and pure so not to touch 
them anymore.

Incremental repacking is there to gather only those _reachable_ loose 
objects into a new pack.  The objects that you're likely to make 
unreachable are probably going to come from a temporary branch that you 
deleted which is likely to affect objects only from that latest and 
small pack.

And repacking can be done unattended and in parallel to normal Git 
operations with no issues.  So even if it is slow to repack huge packs, 
it is something that you might do during the night and only once in a 
while.

But if you really want to shrink only one pack without touching the 
other packs, and you do know which objects have to be removed from that 
pack, then it is trivial to write a small script using git-show-index, 
sorting the output by offset, filter out the unwanted objects, keeping 
only the SHA1 column, and feeding the result into git-pack-objects.  Oh 
and delete the original pack when done of course.  It is also trivial to 
generate the list of all packed objects, compare it to the list of all 
reachable objects, and prune objects from the packs that contains those 
objects which are not to be found in the reachable object list.


Nicolas
