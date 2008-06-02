From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up
 git-cherry
Date: Mon, 2 Jun 2008 16:37:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806021635220.13507@racer.site.net>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>  <alpine.DEB.1.00.0806020649110.13507@racer.site.net>  <20080602064218.GA15144@sigill.intra.peff.net> <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3C8S-0003tI-L4
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYFBPiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbYFBPiy
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:38:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:54236 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751965AbYFBPix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:38:53 -0400
Received: (qmail invoked by alias); 02 Jun 2008 15:38:51 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 02 Jun 2008 17:38:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189M6Nppmc9B/pUuxwndWnYIRiv+Ak+nRgaq8fn+a
	7xisDyHjZeyYjJ
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83532>

Hi,

On Mon, 2 Jun 2008, Geoffrey Irving wrote:

> On Sun, Jun 1, 2008 at 11:42 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Jun 02, 2008 at 07:13:14AM +0100, Johannes Schindelin wrote:
> >
> >> I do not think that this "read-the-entire-table-into-memory" paradigm 
> >> is a wise choice. mmap()ing, I would have understood, but reading a 
> >> potentially pretty large table into memory?
> >
> > When I was just a git-youth, I wrote a fast mmap-based cache for 
> > storing SHA1 pairs. It might give some direction. You should be able 
> > to find it here:
> >
> >  http://mid.gmane.org/20060629035849.GA30749@coredump.intra.peff.net
> >
> > It mmaps and binary searches a sorted list. New entries are added to 
> > an in-memory list, and then at the end of a run, the two sorted lists 
> > are merged to create the new on-disk version.
> 
> I don't need sorting (and neither did you), so I think a hash table is 
> better (O(1) instead of O(log n), and we don't even need to compute hash 
> keys.  I'll leave it up to you and Dscho (or anyone else who cares to 
> chime in) which one you think I should do.

My tests suggested that the lookup time advantage of hashes makes them a 
more appropriate choice than sorted lists, if you look up often, but add 
rarely.

Another issue that just hit me: this cache is append-only, so if it grows 
too large, you have no other option than to scratch and recreate it.  
Maybe this needs porcelain support, too?  (git gc?)

Ciao,
Dscho
