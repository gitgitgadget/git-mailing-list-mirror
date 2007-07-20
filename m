From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 03:34:36 -0700
Message-ID: <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
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
	<85644fvdrn.fsf@lola.goet he.zz> <46A08006.4020500@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Jul 20 12:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBpoy-0000bo-Uh
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbXGTKei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbXGTKei
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:34:38 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57455 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbXGTKeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 06:34:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720103437.JKJG1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Jul 2007 06:34:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rmac1X00H1kojtg0000000; Fri, 20 Jul 2007 06:34:37 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53080>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> You are mistaking things.  Like the executable bit on a file
> is not content, the fact that a directory should be kept
> despite being empty is also an *attribute* of the directory.
> This is meta-data, not actual data (content).  So no matter
> how elegant tracking the "." entry might be (and I think it
> is, because it covers a lot of corner cases already), it puts
> the information at the wrong place.

Actually, I do not think there is absolute right or wrong here.
The difference is not that the information is at the "right" or
"wrong" place, but one approach places the information at more
efficient-to-use place than the other.  In that sense, the
attribute approach _is_ a more elegant solution between the two.

Making it an attribute has a huge practical advantage.

By treating executable bit as a piece metadata, we can compare
the "contents" quickly.  If you "chmod +x" a blob without
changing anything else, we can detect that fact, because blob
object names are equal.  At the philosophical level, you _could_
argue that the executable-ness is one bit of content and include
that in the object name computation for the blob.  There is
nothing fundamentally wrong about that approach, but that
destroys the nice "cheap comparability" between blobs that
differ only by executable-ness.

David's "." in tree is essentially the same argument as treating
the executable-ness as one extra bit of content.  The fact that
a particular tree wants to stay even after emptied can be
treated as part of contents (thereby reflected in its object
name).  There is nothing fundamentally wrong there, either.  But
that means two trees that contain otherwise identical set of
blobs and subtrees, but differ only in the behaviour of when
they are emptied, would get different object names, hence you
need to descend into them to see if they are different.

Using attribute that is detached from the content itself allows
you to hoist that one bit one level up.  By treating
executable-ness not as part of content, we can compare two blobs
with different executable bits cheaply.  You can avoid
descending into such a tree when comparing it with another tree
that is different only by the "will-stay-when-emptied"-ness the
same way.
