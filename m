From: Paul Mackerras <paulus@samba.org>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 14:52:46 +1000
Message-ID: <17192.65054.520959.454610@cargo.ozlabs.ibm.com>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
	<59a6e583050914114054b1564d@mail.gmail.com>
	<Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
	<17192.56103.803096.526568@cargo.ozlabs.ibm.com>
	<17192.56292.867933.739867@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0509142032300.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Wayne Scott <wsc9tt@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 06:54:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFlkG-0004xB-II
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 06:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVIOEwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 00:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVIOEwy
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 00:52:54 -0400
Received: from ozlabs.org ([203.10.76.45]:38323 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932171AbVIOEwy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 00:52:54 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C1CBA68270; Thu, 15 Sep 2005 14:52:52 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509142032300.26803@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8584>

Linus Torvalds writes:

> It works, but it does end up complaining about things like 
> 
> 	==23756== Invalid read of size 4
> 	==23756==    at 0x25A38990: strlen (in /lib/libc-2.3.5.so)
> 	..
> 	==23756==  Address 0x25B86754 is 3 bytes after a block of size 17 alloc'd
> 
> which seems to be just strlen prefetching the next word or something like 
> that. 

The strlen() in glibc for ppc is unbearably clever hand-coded
assembly, which loads up 8 bytes at a time (once it has the address
8-byte aligned), and does various ANDs and ORs and ADDs and
conditional branches.  If some of the 8 bytes aren't defined, it will
in many cases branch one way or the other based on the undefined
bytes, but end up computing the same result on either branch.

Valgrind is right in that strlen is loading up some bytes that are
past the end of a malloc'd block.  In fact those bytes don't end up
affecting the result, and in fact the load couldn't cause a segfault,
but it's not surprising that Valgrind can't see that, since the value
of the extra bytes can actually affect whether a conditional branch is
taken or not, but we end up with the same result either way.

Valgrind sets LD_PRELOAD so that you get a simple Valgrind-supplied
set of string functions, including strlen, from vgpreload_memcheck.so
rather than the fancy glibc ones.  However, that doesn't seem to catch
the calls to strlen from inside glibc - the call from vfprintf is a
direct branch rather than going through the PLT, for instance.

I could add a suppression to suppress all errors in strlen, but that
would mean you would miss real errors, where the string is not
null-terminated within the malloc'd block, and strlen runs off the
end.

I wish I had a good answer for this problem, but I don't.  Maybe we
need a debugging version of glibc that doesn't use the fancy
bit-fiddling algorithms in the string functions.

(Just for interest: here are the comments from strlen.S:

   1) Given a word 'x', we can test to see if it contains any 0 bytes
      by subtracting 0x01010101, and seeing if any of the high bits of each
      byte changed from 0 to 1. This works because the least significant
      0 byte must have had no incoming carry (otherwise it's not the least
      significant), so it is 0x00 - 0x01 == 0xff. For all other
      byte values, either they have the high bit set initially, or when
      1 is subtracted you get a value in the range 0x00-0x7f, none of which
      have their high bit set. The expression here is
      (x + 0xfefefeff) & ~(x | 0x7f7f7f7f), which gives 0x00000000 when
      there were no 0x00 bytes in the word.

   2) Given a word 'x', we can test to see _which_ byte was zero by
      calculating ~(((x & 0x7f7f7f7f) + 0x7f7f7f7f) | x | 0x7f7f7f7f).
      This produces 0x80 in each byte that was zero, and 0x00 in all
      the other bytes. The '| 0x7f7f7f7f' clears the low 7 bits in each
      byte, and the '| x' part ensures that bytes with the high bit set
      produce 0x00. The addition will carry into the high bit of each byte
      iff that byte had one of its low 7 bits set. We can then just see
      which was the most significant bit set and divide by 8 to find how
      many to add to the index.
      This is from the book 'The PowerPC Compiler Writer's Guide',
      by Steve Hoxey, Faraydon Karim, Bill Hay and Hank Warren.
)

Paul.
