From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 09:23:47 -0700
Message-ID: <20080808162347.GD9152@spearce.org>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080808143918.GB9152@spearce.org> <alpine.DEB.1.00.0808081647580.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808081716010.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, nico@cam.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:25:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRUlm-0003qR-IJ
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYHHQXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYHHQXs
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:23:48 -0400
Received: from george.spearce.org ([209.20.77.23]:44132 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYHHQXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:23:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9FCAB38420; Fri,  8 Aug 2008 16:23:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808081716010.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91687>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 8 Aug 2008, Johannes Schindelin wrote:
> > On Fri, 8 Aug 2008, Shawn O. Pearce wrote:
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > my auto gc kicked in, and shows this:
> > > > 
> > > > fatal: corrupt packed object for 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> > > > error: failed to run repack

Here's another idea.

You have the good object loose.  So do something like this:

  $ mkdir foo
  $ cd foo
  $ git init
  $ cp ../../the_good_loose_obj .git/objects/??/....

  $ cd ../corrupt_repo
  $ (
   cd ../foo;
   echo blob; 
   echo data $(git cat-file -s the_good_loose_obj);
   git cat-file blob the_good_loose_obj;
  ) | git fast-import
  $ git repack -a -d

The new pack file created by gfi will have a newer timestamp than the
one with the corruption.  This will cause it to sort higher in the
pack list, and we'll take objects from the first pack we find it in.

-- 
Shawn.
