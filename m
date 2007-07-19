From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 02:09:22 -0400
Message-ID: <20070719060922.GF32566@spearce.org>
References: <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Kastrup <dak@gnu.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 08:09:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBPCm-0004aX-Fl
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 08:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbXGSGJf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 02:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbXGSGJe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 02:09:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39508 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598AbXGSGJd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 02:09:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBPCV-0005gg-QO; Thu, 19 Jul 2007 02:09:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 46E0720FBAE; Thu, 19 Jul 2007 02:09:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070719053858.GE32566@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52941>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Another issue I thought about was what you would do in the step
> > 3 in the following:
> > 
> >  1. David says "mkdir D; git add D"; you add S_IFDIR entry in
> >     the index at D;
> > 
> >  2. David says "date >D/F; git add D/F"; presumably you drop D
> >     from the index (to keep the index more backward compatible)
> >     and add S_IFREG entry at D/F.
> > 
> >  3. David says "git rm D/F".
> > 
> > Have we stopped keeping track of the "empty directory" at this
> > point?
> 
> Sadly yes.  But I don't think that's what the folks who want to
> track empty directories want to have happen here.
> 
> Which is why I'm thinking we just need to track the directory, as a
> node in the index, even if there are files in it, and even if we got
> that directory and its contained files there by just unpacking trees.

I take this back.  I really don't want that behavior.

If I do:

  mkdir -p foo/bar
  echo hello >foo/bar/world
  git add foo
  git -f rm foo/bar/world

I never asked for foo/bar or foo to stay.  In fact I want them
to disappear from Git entirely, as foo/bar is now empty and has
no content.


But we also cannot do a special --mkdir option for update-index
either, because how do we know that the user designated subtree is
a directory we must always keep in the index?

So I think the only way this works is to have a new mode that we use
in tree (04755 ?) that tells us not only is this thing a subtree,
but also that the user wants it to stay here, even if it is empty.
Those trees are always in the index as a real tree entry, even if
there are files contained in it.

And as far as getting that directory entry created/removed from
the index, well, I think a special flag to update-index would be
in order, much like --chmod=[+-]x.

Just my $0.0002 USD, which really ain't worth much at all.

-- 
Shawn.
