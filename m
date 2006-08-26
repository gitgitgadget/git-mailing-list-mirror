From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with pack
Date: Sat, 26 Aug 2006 03:31:09 -0700
Message-ID: <7vlkpb3i1e.fsf@assigned-by-dhcp.cox.net>
References: <44EECBE2.7090801@arces.unibo.it>
	<7vu03z3j1y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <scallegari@arces.unibo.it>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Aug 26 12:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGvRg-0002Pd-4A
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 12:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWHZKaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 06:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWHZKaw
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 06:30:52 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:17541 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932304AbWHZKav (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 06:30:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826103051.WYGL12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 06:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EaWp1V0094Noztg0000000
	Sat, 26 Aug 2006 06:30:49 -0400
To: git@vger.kernel.org
In-Reply-To: <7vu03z3j1y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 26 Aug 2006 03:09:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26045>

Junio C Hamano <junkio@cox.net> writes:

> Earlier you said "unpack-objects <$that-pack.pack" fails with
> "error code -3 in inflate..."  What exact error do you get?
> I am guessing that it is get_data() which says:
>
> 	"inflate returned %d\n"
>
> (side note: we should not say \n there).
> ...
> This pattern appears practically everywhere...
> ...  I've been
> wondering if it is possible for inflate to eat some input but
> that was not enough to produce one byte of output, and what [it]
> would return in such a case...

I do not think this fear does not apply to this particular case;
return value -3 is Z_DATA_ERROR, so the deflated stream is
corrupt.

> So there are only a few ways you can get that error message.
> ...

I just realized there is another not so inplausible explanation.

When the problematic pack was made on the mothership,
csum-file.c::sha1write_compressed() gave the data for the base
object to zlib, an alpha particle hit a memory cell that
contained zlib output buffer (resulting in a corrupt deflated
stream in variable "out"), and sha1write() wrote it out while
computing the right checksum.

Is the memory on your mothership reliable (I do not want to make
this message sound like one on the kernel list, but memtest86
might be in order)?
