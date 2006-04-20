From: Nicolas Pitre <nico@cam.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 17:02:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
References: <20060420133640.GA31198@spearce.org>
 <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org>
 <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
 <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
 <20060420175554.GH31738@spearce.org>
 <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
 <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 23:02:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWgIB-0000L0-Nj
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 23:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDTVCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 17:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWDTVCV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 17:02:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65475 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751264AbWDTVCU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 17:02:20 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY1000BOH3UZU51@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 17:02:18 -0400 (EDT)
In-reply-to: <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18997>

On Thu, 20 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Thu, 20 Apr 2006, Shawn Pearce wrote:
> >
> >> The more that I think about it the more it seems possible that the
> >> pathname hashing is what may be causing the problem.  Not only did
> >> bisect point to 1d6b38cc76c348e2477506ca9759fc241e3d0d46 but the
> >> directory which contains the bulk of the space has many files with
> >> the same name located in different directories:
> > [...]
> >
> > But the bad commit according to your bisection talks about "thin" packs 
> > which are not involved in your case.  So something looks fishy with that 
> > commit which should not have touched path hashing in the non-thin pack 
> > case...  I think...
> 
> I think this explains it.  The new code hashes full-path, but
> places bins for the paths with the same basename next to each
> other, so before Makefile and doc/Makefile and t/Makefile were
> all in the same bin, but now they are in three different bins
> next to each other.

That is fine.  In fact I did try with a tweaked name_hash() that 
completely ignored all directory components and the resulting pack was 
even bigger, much bigger, when repacking Shawn's repo.

> I originally thought, with one single notable exception of
> Makefile, having the identically named file in many different
> directories is not common nor sane,

I'd tend to disagree with that but...

> and the new code favors to
> delta with the exact same path for deeper history over wasting
> delta window for making delta with objects with the same name in
> different places in more recent history.  I think I benched this
> with kernel repository (git.git was too small for that).

This is obviously fine.  And if a file in a given directory has few 
revisions then the delta window will consider objects for a file with 
the same name in other directories as well, which is also sensible.  So 
if files of the same name are located in different directories they 
should delta well against each other if they're similar enough.  This 
should cover Shawn's repo layout.

> But I suspect we have a built-in "we sort bigger to smaller, and
> we cut off when we switch bins" somewhere in find_delta() loop,
> which I do not recall touching when I did that change, so that
> may be interfering and preventing 0-11-AdjLite.deg from all over
> the place to delta against each other.

I just cannot find something that would do that in the code.  When 
--no-reuse-delta is specified, the only things that will break the loop
in find_delta() is when try_delta() returns -1, and that happens only 
when changing object type or when the size difference is too big, but 
nothing looks at the name hash.

It is also hard to corelate it with commit 1d6b38cc which is the one 
that introduced the regression.


Nicolas
