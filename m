From: Nicolas Pitre <nico@cam.org>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Mon, 30 Jun 2008 15:09:23 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806301457590.19095@xanadu.home>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com>
 <20080626204606.GX11793@spearce.org>
 <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
 <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
 <7vhcbfojgf.fsf@gitster.siamese.dyndns.org>
 <20080627025715.GB19568@fieldses.org> <1214578229.7437.14.camel@localhost>
 <20080630003203.GJ11793@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>, logank@sent.com,
	Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org,
	Trond Myklebust <trond@netapp.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 21:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDOlc-0000rM-3v
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 21:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762046AbYF3TJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 15:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758269AbYF3TJ0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 15:09:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54763 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005AbYF3TJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 15:09:25 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3A00MEMIJNV460@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 30 Jun 2008 15:09:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080630003203.GJ11793@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86931>

On Sun, 29 Jun 2008, Shawn O. Pearce wrote:

> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> > Is the file only being read, or could there be a simultaneous write to
> > the same file? I'm surmising this could be an effect resulting from
> > simultaneous cache invalidations: prior to Linux 2.6.20 or so, we
> > weren't rigorously following the VFS/VM rules for page locking, and so
> > page cache invalidation in particular could have some curious
> > side-effects.
> 
> The file was created and opened O_CREAT|O_EXCL|O_RDWR, by this
> process, written linearly using write(2), without any lseeks.
> We kept the file descriptor open and starting issuing pread(2)
> calls for earlier offsets we had alread written.  One of those
> kicks back EOF far too early (and results in this bug report).
> 
> Note the only accesses we are using is write(2) and pread(2), and
> once we start reading we don't ever go back to writing.

That's not exact.  With a thin pack, we continue appending data to the 
file after a bunch of pread() have occurred.  And only after those 
pread()'s do we know that we actually have a thin pack.

> The pread(2)
> calls are typically issued in ascending offsets, and we read each
> position only once.  This is to try and take advantage of any
> read-ahead the kernel may be able to do.

That's not exact.  The pread() calls are done when resolving deltas, 
hence a base object is read and every deltas based on it are recursively 
resolved to find their SHA1 signature.  Then another base is picked up 
and the same process repeated.  And in practice all those delta chains 
are all interleaced in the pack file due to the fact that objects are 
stored so to optimize access to recent commits.  Therefore they're more 
or less random.


Nicolas
