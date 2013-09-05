From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 37/38] pack v4: introduce "escape hatches" in the name and
 path indexes
Date: Thu, 05 Sep 2013 15:02:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309051445140.14472@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-38-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 21:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHepR-0006z7-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900Ab3IETCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:02:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57470 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894Ab3IETCs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:02:48 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSO006FB28A12C0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 15:02:35 -0400 (EDT)
In-reply-to: <1378362001-1738-38-git-send-email-nico@fluxnic.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233980>

On Thu, 5 Sep 2013, Nicolas Pitre wrote:

> If the path or name index is zero, this means the entry data is to be
> found inline rather than being located in the dictionary table. This is
> there to allow easy completion of thin packs without having to add new
> table entries which would have required a full rewrite of the pack data.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

I'm now dropping this patch.  Please also remove this from your 
documentation patch.

I think that we've found a way to better support thin packs.

You said:

> What if the sender prepares the sha-1 table to contain missing objects
> in advance? The sender should know what base objects are missing. Then
> we only need to append objects at the receiving end and verify that
> all new objects are also present in the sha-1 table.

So the SHA1 table is covered.

Missing objects in a thin pack cannot themselves be deltas.  We had 
their undeltified form at the end of a pack for the pack to be complete.  
Therefore those missing objects serve only as base objects for other 
deltas.

Although this is possible to have deltified commit objects in pack v2, I 
don't think this happens very often. There is no deltified commit 
objects in pack v4.

Blob objects are the same in pack v2 and pack v4.  No dictionary 
references are needed.

That leaves only tree objects.  And because we've also discussed the 
need to have non transcoded object representations for those odd cases 
such as zero padded file modes, we might as well simply use that for the 
appended tree objects already needed to complete a thin pack.  At least 
the strings in tree entries will be compressed that way.

Problem solved, and one less special case in the code.

What do you think?


Nicolas
