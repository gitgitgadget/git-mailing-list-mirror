From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-pack-objects for 64-bit platforms
Date: Thu, 11 May 2006 11:52:20 -0700
Message-ID: <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
	<Pine.LNX.4.64.0605111054290.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 11 20:52:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeGGv-0005Qq-QI
	for gcvg-git@gmane.org; Thu, 11 May 2006 20:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWEKSwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 14:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWEKSwX
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 14:52:23 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:30181 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932131AbWEKSwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 May 2006 14:52:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060511185221.DNPV17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 May 2006 14:52:21 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 11 May 2006 10:58:32 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19910>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 11 May 2006, Dennis Stosberg wrote:
>> 
>> I am not sure whether an int cast or an int32_t cast is more
>> appropriate here.  An int is not guaranteed to be four bytes wide,
>> but I don't know of any modern platform where that's not the case.
>> On the other hand int32_t is not necessarily available before C99.
>> 
>> Any opinions?  I wonder why no one has hit this on x86_64...
>
> I think the "ntohl()" hides it. It loads a 64-bit value, but since x86-64 
> is little-endian, the low 32 bits are correct. The htonl() will then strip 
> the high bits and make it all be big-endian.

That sounds sensible.

Since I saw a patch that touches only one place, I thought I'd
better point this out...

There are a few more places that knows about this
((char*)base_pointer + (entry_count * 24)) magic in our code.

$ git grep -n -e '24  *\*' -e '\*  *24' master -- '*.c'

master:pack-objects.c:159:		long hl = *((long *)(index + 24 * i));

	This is yours.

master:sha1_file.c:447:	if (idx_size != 4*256 + nr * 24 + 20 + 20)
master:sha1_file.c:1148:	memcpy(sha1, (index + 24 * n + 4), 20);
master:sha1_file.c:1162:		int cmp = memcmp(index + 24 * mi + 4, sha1, 20);

	These three should be OK, I think.

master:sha1_file.c:1164:			e->offset = ntohl(*((int*)(index + 24 * mi)));

	This you might want to look at; I suspect it is what
	Linus suggests.

Also we _might_ have uglier magic that assumes the base_pointer to
be a pointer to a 4-byte integer and uses offset of multiple of
6 instead of 24, although I do not think it is likely.

I have to leave the keyboard in a few minutes so I cannot verify
nor fix them myself for the next 8 hours or so.  Sorry.

> And while I actually run a 64-bit big-endian machine myself (G5 ppc64), my 
> user space is all 32-bit by default, so it never showed up on linux-ppc64 
> either.
>
> Anyway, the correct type to use is "uint32_t" in this case. That's what 
> htonl() takes.

Is uint32_t guaranteed to be exactly 32-bit, or merely enough to
hold 32-bit?
