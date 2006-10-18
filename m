From: Junio C Hamano <junkio@cox.net>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 18:30:13 -0700
Message-ID: <7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
	<7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171251210.1971@xanadu.home>
	<7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171437250.1971@xanadu.home>
	<20061017233630.72a0aae5.vsu@altlinux.ru>
	<Pine.LNX.4.64.0610171615340.1971@xanadu.home>
	<Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610171706260.1971@xanadu.home>
	<Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610171959070.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 03:30:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0GD-0008Jv-4V
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWJRBaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWJRBaR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:30:17 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7143 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751230AbWJRBaP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 21:30:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018013014.XMLN22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 21:30:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bdW01V0061kojtg0000000
	Tue, 17 Oct 2006 21:30:01 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610171959070.1971@xanadu.home> (Nicolas Pitre's
	message of "Tue, 17 Oct 2006 20:20:09 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29166>

Nicolas Pitre <nico@cam.org> writes:

> So let me summarize:
>
>  - the union is a hash.
>
>  - the hash is either an offset value or a sha1 digest.
>
>  - this hash is used for fast object lookup _only_.
>
>  - it does sort differently on big vs little endian machines.
>
>  - but we don't care at all because
>
>  - it is a private algorithmic thing that doesn't "bleed" into any 
>    _real_ data structure, and
>
>  - it doesn't have any influence on the format of the end result.
>
>  - it is only a runtime abstraction and nothing else.
>
>  - It never gets into the pack nor the pack index themselves.
>
> Do you still have issues with that?

The part you pointed out to me about "accidental collision"
still bothers me somewhat.

Right now we do not produce ref-delta and ofs-delta in the same
stream, but if somebody did so then it would mean a disaster to
have an accidental collision of an 8-byte offset value plus
12-byte traiing NUL and another base object whose object name
happens to match that pattern.

I am actually Ok if we say the code assumes one stream has only
ref-delta or ofs-delta and never both.

But then I suspect the first pass of parse_pack_objects() should
make sure that assumption holds true for the pack being
inspected and barf if it is not.  Also the second pass do not
have to run two find_delta_childs() calls per delta object
because by that time we know which kind would never appear in
the packfile.

By the way can we call that find_delta_children() pretty please?
