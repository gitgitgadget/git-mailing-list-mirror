From: Junio C Hamano <junkio@cox.net>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 14:54:54 -0700
Message-ID: <7vr6x6ip5d.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
	<7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171251210.1971@xanadu.home>
	<7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171437250.1971@xanadu.home>
	<20061017233630.72a0aae5.vsu@altlinux.ru>
	<Pine.LNX.4.64.0610171615340.1971@xanadu.home>
	<Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 23:55:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZwto-0004Ml-8y
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 23:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWJQVy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 17:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWJQVy5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 17:54:57 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63439 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750989AbWJQVy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 17:54:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017215455.GPIB6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 17:54:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bZui1V0021kojtg0000000
	Tue, 17 Oct 2006 17:54:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 17 Oct 2006 13:51:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29121>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 17 Oct 2006, Nicolas Pitre wrote:
>> On Tue, 17 Oct 2006, Sergey Vlasov wrote:
>> > 
>> > Yes, on x86_64 this is 24 because of 8-byte alignment for longs:
>> 
>> Ah bummer.  Then this is most likely the cause.  And here's a simple 
>> fix (Junio please confirm):
>
> Why do you use "unsigned long" in the first place?
>
> For some structure like this, it sounds positively wrong. Pack-files 
> should be architecture-neutral, which means that they shouldn't depend on 
> word-size, and they should be in some neutral byte-order.

This is an in-core structure if I am not mistaken, and is never
written out in the resulting pack file.  The program is reading
from .pack and building .idx that corresponds to it.  I agree
that it is ugly, but I do not hink using neutral byte-order in
this part of the processing buys us anything in this particular
case.

> In contrast, the new union introduced in "next" is just horrid. There's 
> not even any way to know which member to use, except apparently that it 
> expects that a SHA1 is never zero in the last 12 bytes. Which is probably 
> true, but still - that's some ugly stuff.

Again I agree with the ugliness objection, and I raised the
"expecting no collision" issue which Nico refuted later.  The
code is probably safe (not just safe in practice but safe in
theory as well), although that would not change the fact that it
is ugly X-<.

Nico, could we have an un-uglied version please?
