From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 19:24:29 -0700
Message-ID: <7vir8f24o2.fsf@assigned-by-dhcp.cox.net>
References: <858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
	<863azk78yp.fsf@lola.quinscape.zz>
	<FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
	<7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	David Kastrup <dak@gnu.org>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 04:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBiAW-0003w1-Fg
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 04:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbXGTCYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 22:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbXGTCYc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 22:24:32 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58157 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbXGTCYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 22:24:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720022430.RUZ1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 22:24:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ReQV1X00g1kojtg0000000; Thu, 19 Jul 2007 22:24:30 -0400
In-Reply-To: <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 19 Jul 2007 17:33:29 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53047>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So the whole notion of "remembering" whether a directory was added 
> explicitly as an empty directory or not is just not a sensible concept in 
> git. 

That is true if it is implemented as David suggested, to have a
phony "." entry in the tree object itself.  The object name of
such a tree (when it contains blobs and trees underneath) will
be different from a tree that contains the same set of blobs and
trees.  It would destroy the fundamental concepts of git.

But you _could_ treat that "should-be-kept-even-when-empty"-ness
just like we treat executable bit on blobs, I think.

When blobs with the same contents but of different type (REG vs
LNK) and regular file with or without executable bit are entered
in git, they all get the same SHA-1 but we can still tell them
apart because the index and the tree entry have mode bits.  So
hypothetically, you could introduce "sticky" directory in tree
entries to mark "this will not go away when emptied".

In a 'tree' object, they might appear as:

        40000 ordinary-directory '\0' 20-byte SHA-1
        41000 directory-dontremove-even-if-empty '\0' 20-byte SHA-1

In 'index', as your "I'm soft" patch, we do not have to add
nonsticky kind of tree nodes, but for "empty" ones, we can add:

	041000 directory-dontremove-even-if-empty '\0' 20-byte SHA-1

in the index and (unlike your patch) keep it there even after a
blob or a tree is added underneath it.

The "sticky" bit on such a directory would have to obey the
usual rule of 3-way merge, which would be a huge change to do
so, but I do no see there is anything fundamental that prevents
you from doing this.  Other than the fact that probably no git
long timer is interested in spending time on such a feature,
that is.

Obviously, this "sticky" bit will cascade up and make your
otherwise equivalent parent tree's different, but I think that
is just as a sane behaviour as two trees that contain the same
blob with only executable-bit differences have different names.

This will involve a lot of changes, so I would not recommend
anybody doing so, though.
