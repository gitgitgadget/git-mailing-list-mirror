From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 18:18:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902081815170.10279@pacific.mpi-cbg.de>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de> <200902081704.59439.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1826537183-1234113507=:10279"
Cc: Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 18:19:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWDJh-0002R8-6T
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 18:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbZBHRRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 12:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbZBHRRr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 12:17:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:51717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbZBHRRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 12:17:46 -0500
Received: (qmail invoked by alias); 08 Feb 2009 17:17:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 08 Feb 2009 18:17:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AXN8j9ziAXDVseStzWYo9KsUKUijS24ugXue+xv
	IAMZaC/VIri8Fv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200902081704.59439.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108992>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1826537183-1234113507=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 8 Feb 2009, Robin Rosenberg wrote:

> söndag 08 februari 2009 15:56:38 skrev Johannes Schindelin:
> 
> > On Sun, 8 Feb 2009, Robin Rosenberg wrote:
> > 
> > > I've seen this. Running git gc on Windows, while having Elipse open 
> > > can kill your object database.
> > 
> > You had me really scared with the mail subject!
> 
> Losing a repo *is* scary., especially if your boss is the one losing it. 
> That should simply not happen unless there is a disk failure. 
> Fortunately I believe the two lost branches did not contain anything 
> useful.

If you care about your data, you don't use Windows, IMHO.

> > > if gc doesn't find a new optimal pack it tries to rewrite a new pack 
> > > with the same id. So it rm's the idx file (fine) and the the pack 
> > > file (not ok) and gives up,
> > 
> > I disagree with your notion that it is fine to kill the existing idx 
> > file until the new one has been written successfully.
>
> Then you misunderstood me. I meant that the repack script thought it was 
> fine.
> 
> > My preliminary guess is that this code in pack-write.c needs to use the 
> > lock file paradigm:
> 
> > 
> >         if (!index_name) {
> > 		[...]
> >         } else {
> >                 unlink(index_name);
> >                 fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
> >         }
> 
> Yeah, it needs to check that it can actually delete both files before 
> actually doing it.

Nope.  It needs to avoid unlinking until it knows what it did was fine.

> Then again if it wants to replace a file with a new one just like it, 

It might have the same name, but that does not mean that it is bytewise 
identical.  The name depends on the uncompressed objects.

> Isn't that the only case I see where we can lose data?

No, you said so yourself: Eclipse prevents the pack from being deleted.  
There are a gazillion idiotic programs on Windows who think they should 
lock random files.

So you could hit the very same issue even if your repository has twenty 
packs, and therefore could do with some gc'ing.

Ciao,
Dscho
--8323328-1826537183-1234113507=:10279--
