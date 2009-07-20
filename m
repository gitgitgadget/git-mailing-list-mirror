From: Jeff King <peff@peff.net>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Mon, 20 Jul 2009 05:09:38 -0400
Message-ID: <20090720090937.GA20412@sigill.intra.peff.net>
References: <20090718134551.GC16708@vidovic>
 <200907182106.06776.j6t@kdbg.org>
 <20090718222947.GA31147@coredump.intra.peff.net>
 <200907191301.15533.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 11:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSosV-0001gI-RW
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 11:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbZGTJJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 05:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbZGTJJk
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 05:09:40 -0400
Received: from peff.net ([208.65.91.99]:38544 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbZGTJJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 05:09:39 -0400
Received: (qmail 25187 invoked by uid 107); 20 Jul 2009 09:11:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 20 Jul 2009 05:11:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2009 05:09:38 -0400
Content-Disposition: inline
In-Reply-To: <200907191301.15533.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123582>

On Sun, Jul 19, 2009 at 01:01:15PM +0200, Johannes Sixt wrote:

> Problem is, snprintf was made for very old systems, which typically do
> not have va_copy. (E.g. Windows, but there the situation *might* have
> changed with the switch to gcc 4.)
> 
> The rationale not to use va_copy is that this function is to be used
> *only* if necessary, i.e. portability is already lacking, and if it
> can be verified that this function works as is. Portability and
> correct-by-the-law C code are *not* a goal here. If the function does
> not work as is, don't use it.

OK, I guess I can buy the "don't use this unless you need it" rationale.
But two questions:

  1. _Are_ we sure it works under Windows?  That is, do we know for a
     fact that using a va_list twice is OK there, or are we just going
     on the fact that nobody has reported the bug?

     If we're not sure, then you might want to try running the recipe
     below which consistently produces a segfault for me on Linux amd64
     (but not i386, which seems to use a different representation for
     va_lists).

  2. In this case, using SNPRINTF_RETURNS_BOGUS was a mistake. But
     unfortunately using it erroneously doesn't simply cause the
     compilation to barf, or to use a slower implementation; instead it
     introduces a very subtle and hard to diagnose bug on some
     platforms. Is there anything simple we can do to protect people
     from that?

     I can't really think of anything simple, because such a mechanism
     would basically involve compiling a test program and seeing if it
     segfaults.

Anyway, bug-reproducing recipe is below.

-- >8 --
cat <<'EOF' >test-vsnprintf.c
#define SNPRINTF_RETURNS_BOGUS
#include "git-compat-util.h"
int main() {
        char buf[16];
        /* this 8 may need to be tweaked depending on
         * the system's vsnprintf return value; the goal
         * is to get git_vsnprintf to have to look at
         * it's va_list twice */
        git_snprintf(buf, 8, "%s %s", "foo", "bar");
        return 0;
}
EOF
make test-vsnprintf.o compat/snprintf.o
gcc -o test-vsnprintf test-vsnprintf.o compat/snprintf.o
./test-vsnprintf ;# or valgrind test-vsnprintf
