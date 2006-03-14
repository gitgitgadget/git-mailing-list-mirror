From: Jeff King <peff@peff.net>
Subject: [OT] Re: [PATCH] Use explicit pointers for execl...() sentinels.
Date: Mon, 13 Mar 2006 19:42:53 -0500
Message-ID: <20060314004253.GA24668@coredump.intra.peff.net>
References: <20060313033121.GA14601@coredump.intra.peff.net> <200603130412.k2D4CW1b011631@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 14 01:43:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIxd6-0001SQ-Rr
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 01:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWCNAm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 19:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWCNAm4
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 19:42:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:29888 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751731AbWCNAm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 19:42:56 -0500
Received: (qmail 34152 invoked from network); 14 Mar 2006 00:42:53 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 14 Mar 2006 00:42:53 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2006 19:42:53 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200603130412.k2D4CW1b011631@laptop11.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17580>

On Mon, Mar 13, 2006 at 12:12:31AM -0400, Horst von Brand wrote:

> Very improbable, they'll be the same normally ("void *" is a way of getting
> rid of the overloading of the meaning of "char *" for this before ANSI C).
> Sure, sizeof(int *) might be 4, but I think that is pretty far off.

Let me clarify my position. The STANDARD doesn't guarantee such things.
In PRACTICE, for modern machines you can assume that all pointers are
the same size (and things like all-bits-zero is a null pointer) if it
makes your code cleaner. In other words, I agree with Linus: git should
follow what works in practice, but you should at least recognize that
you're violating the standard.

That being said, you appear to be making the argument that passing a
'foo *' to a variadic function expecting a 'bar *' doesn't violate the
standard. I believe it invokes undefined behavior.

> There are special rules for variadic functions, probably pointers would be
> cast to/from void * in such a case by the compiler.

The rules indicate that arguments matching the '...' follow "default
argument promotion".  See section 6.5.2.2, paragraph 7.  This default
promotion is the same as what would happen if there were no prototype
for the function, and is defined in paragraph 6:
  ...the integer promotions are performed on each argument, and arguments
  that have type float are promoted to double.
I don't see anything about promoting pointers to void.

Furthermore, when accessing the arguments using va_arg, the types must
match or the behavior is undefined, UNLESS (7.5.1.1, para 2):
  - one type is signed and the other is the matching unsigned type
  - one type is a pointer to void and the other is a pointer of
    character type
IOW, the standard does promise that void* and char* pointers are
represented the same, but nothing else.

> > If you remain unconvinced, I can try to find chapter and verse of the
> > standard.
> Please do.

See above.

-Peff
