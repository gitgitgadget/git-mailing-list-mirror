From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 12:12:03 -0800
Message-ID: <20090210201203.GU30949@spearce.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org> <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWyz8-0007gM-IU
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbZBJUMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbZBJUMH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:12:07 -0500
Received: from george.spearce.org ([209.20.77.23]:41287 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbZBJUMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:12:06 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C2C4138210; Tue, 10 Feb 2009 20:12:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109299>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> Is there some easy way to tell what object it was having problems with 
> when it failed to unpack? I've got a whole lot of objects.

Can you use gdb to find it?  If so, walk up the stack into
fast-import.c's load_tree() function and look at sha1 here,
and also, *myoe.
 
> The expected size of the base is 1882, while the actual size is 151. The 
> base offset it found was 12.
> 
> I'm using "checkpoint" a lot, so I've got 24 packs. Two of them have tree 
> objects of size 1882 at offset 12; a different one has a tree object of 
> size 151 at offset 12. The one with the object of size 151 was the one 
> that was still open at the end. There's no tree of size 1882 in this pack, 
> nor in any other pack that has a tree of size 151.
> 
> So maybe it's right about the offsets and all, but it's confused about 
> which pack something was in? Maybe it cached something when the pack 
> containing the object it wants was open, and it ended up thinking it was 
> in the pack that's now open rather than the pack that was open and is now 
> closed?

fast-import keeps all of its object data in a single table of
"struct object_entry", the table is keyed by SHA-1.  Each entry
has a pack_id, which tells it which pack this object is in, and
the offset of the object within that pack.

Sounds like maybe its confusing the pack pointer in the all_packs
array (see gfi_unpack_entry).
 
> I don't suppose there would be an easy way to figure out the object it was 
> trying to unpack by applying the delta?

Not really.  You'd have to write code for this.  Or, since the pack
closes and you can index it, use "verify-pack -v" to find the object
starting at the offset you know its having trouble with, that should
tell you the object's SHA-1.

-- 
Shawn.
