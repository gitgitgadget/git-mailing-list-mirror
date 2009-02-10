From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 11:09:09 -0800
Message-ID: <20090210190909.GS30949@spearce.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de> <7vprhqnv0c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de> <20090210165610.GP30949@spearce.org> <7vocxam96s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWy1F-00080B-LQ
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 20:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbZBJTJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 14:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099AbZBJTJM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 14:09:12 -0500
Received: from george.spearce.org ([209.20.77.23]:46799 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894AbZBJTJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 14:09:10 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B96A538210; Tue, 10 Feb 2009 19:09:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vocxam96s.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109293>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> I wonder if we can solve this by introducing a local cache that is a flat
> file that looks like:
> 
>     magic number for /usr/bin/file

Don't forget a version number.  Waste 4 bytes now and its easier
to change the format in the future if we need to.

>     tree object SHA-1 the file caches
>     Number of entries in this file
>     256 fan-out offsets into this file
>     N entries of <SHA-1, SHA-1>, sorted
>     Checksum of the file itself
> 
> and use it when availble (otherwise optionally create it upon the first
> lookup).  The file can be used by mmaping it and then doing a newton
> raphson or binary search similar to the way patch-ids.c does.

Yup.  Sort of my thoughts when I was thinking about that external
index for a "git database".

I was considering a much more complex file layout though; one that
would permit editing without completely recopying the file every
time something changes.

More or less a traditional block oriented on-disk M-tree, with
copy-on-write semantics for the blocks.  This would permit us to
quickly append onto the end of the file with new updates, and then
periodically copy and flatten out the the file as necessary to
reclaim the prior dead space.

E.g.:

  magic number
  version
  [intermediate blocks ...]
  [leaf blocks...]
  root block

Writers would append modified leaf and intermediate blocks as
necessary to the end of the file, then append a new root block.

Readers would read the file tail and verify it is a root, then scan
with a traditional M-tree search algorithm.

If the root block has a "magic block header" and a strong checksum
at the tail of the block, readers can concurrently read while a
writer is appending.  Any invalid root block just means the reader
is seeing the middle of a write, or an aborted write, and should
scan backwards to locate the prior valid root.

If the root block also has a commit SHA-1 indicating which commit
that root become valid under, a reader can decide if that root
might give it answers which aren't correct for the current value of
the notes history it is reading, and scan backwards for some older
root block.  We could accelerate that by including the file offset
of the prior root block in each new root.

GC compacting the file is just a matter of write-locking the file
to block out a new writer, then traversing the current root and
copying all blocks that are reachable.

</end-hand-waving>

> I am hoping that I could eventually rewrite rerere to use something like
> this, so that rerere database can be shared, just like the way notes can
> be shared, across repositories.

Ooh, great idea.  If we could toss rerere data into something that
can be transported around, and efficiently accessed.  I like it.

-- 
Shawn.
