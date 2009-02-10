From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 07:56:26 -0800
Message-ID: <20090210155626.GM30949@spearce.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWuzj-00047k-8P
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZBJP42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbZBJP42
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:56:28 -0500
Received: from george.spearce.org ([209.20.77.23]:42006 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZBJP41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:56:27 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 95D9238210; Tue, 10 Feb 2009 15:56:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109259>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 9 Feb 2009, Daniel Barkalow wrote:
> 
> > I'm getting a "fatal: failed to apply delta" from fast-import. I'm using 
> > a lot of checkpoints, and I haven't had it happen without making 
> > progress, so I was eventually able to import what I was importing (bunch 
> > of stuff I can't distribute, imported from perforce with the latest 
> > version of my p4 importer that I'm still working on). Also, everything 
> > that was saved by the checkpoints was valid and correct (at least after 
> > the fact).
> > 
> > I'm going to see if it's reproducable, and, if so, if I can get a test 
> > case that I can distribute, but I wanted to post to see if anyone had 
> > any special debugging advice for this error message and program 
> > combination.
> 
> I see three likely candidates: two in index-pack.c and one in sha1_file.c.  

It has to be the one in sha1_file.c.  fast-import never calls into the
code in index-pack.c.

> My advice: instrument the code (IOW litter the code with debug output that 
> tells you where it did what), and then run it on the same test case you 
> had the problems.

My initial guess is, we're probably having trouble reading from
the pack we are writing.  This shouldn't be possible; fast-import
uses an index of all objects in memory to locate the byte offset
and then reads from that block.

I wonder if this is a write(2) vs. mmap(2) inconsistency in the
VM system of your OS.  fast-import plays some games here where
it is actively writing into areas that might have been mmap'd.
We should be closing the existing mmap's and opening them again
when we switch from writing to reading (see gfi_unpack_entry),
but if that's failing for some reason then we might be trying to
read a VM page which isn't correctly initialized, and the delta
isn't valid, and we can't inflate it.

-- 
Shawn.
