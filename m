From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 12:15:52 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902101118110.19665@iabervon.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwEb-0002xV-SM
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbZBJRPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbZBJRPy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:15:54 -0500
Received: from iabervon.org ([66.92.72.58]:54370 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZBJRPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:15:54 -0500
Received: (qmail 21420 invoked by uid 1000); 10 Feb 2009 17:15:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2009 17:15:52 -0000
In-Reply-To: <20090210155626.GM30949@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109277>

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 9 Feb 2009, Daniel Barkalow wrote:
> > 
> > > I'm getting a "fatal: failed to apply delta" from fast-import. I'm using 
> > > a lot of checkpoints, and I haven't had it happen without making 
> > > progress, so I was eventually able to import what I was importing (bunch 
> > > of stuff I can't distribute, imported from perforce with the latest 
> > > version of my p4 importer that I'm still working on). Also, everything 
> > > that was saved by the checkpoints was valid and correct (at least after 
> > > the fact).
> > > 
> > > I'm going to see if it's reproducable, and, if so, if I can get a test 
> > > case that I can distribute, but I wanted to post to see if anyone had 
> > > any special debugging advice for this error message and program 
> > > combination.
> > 
> > I see three likely candidates: two in index-pack.c and one in sha1_file.c.  
> 
> It has to be the one in sha1_file.c.  fast-import never calls into the
> code in index-pack.c.

Yup, it's that one. I added some sizes to the message and got them.

> > My advice: instrument the code (IOW litter the code with debug output that 
> > tells you where it did what), and then run it on the same test case you 
> > had the problems.
> 
> My initial guess is, we're probably having trouble reading from
> the pack we are writing.  This shouldn't be possible; fast-import
> uses an index of all objects in memory to locate the byte offset
> and then reads from that block.
>
> I wonder if this is a write(2) vs. mmap(2) inconsistency in the
> VM system of your OS. 

This is Linux 2.6.22 (ubuntu generic x86), so I don't think it does 
anything we don't expect.

> fast-import plays some games here where it is actively writing into 
> areas that might have been mmap'd.  We should be closing the existing 
> mmap's and opening them again when we switch from writing to reading 
> (see gfi_unpack_entry), but if that's failing for some reason then we 
> might be trying to read a VM page which isn't correctly initialized, and 
> the delta isn't valid, and we can't inflate it.

I wonder if we're somehow getting the wrong object. I'm getting a 
base_size of 584 but the object pointed to is a tree of size 1882. This 
seems to me like correctly initialized memory that just isn't what we 
wanted.

Is there some way to see if the pack it was writing is actually corrupt 
(beyond not having the hash set)?

	-Daniel
*This .sig left intentionally blank*
