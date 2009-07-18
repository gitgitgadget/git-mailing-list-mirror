From: Jeff King <peff@peff.net>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 11:31:49 -0400
Message-ID: <20090718153148.GA9367@sigill.intra.peff.net>
References: <20090718134551.GC16708@vidovic>
 <20090718135649.GA6759@sigill.intra.peff.net>
 <20090718141658.GE16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 18 17:32:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSBtJ-0002LU-M3
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 17:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZGRPbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 11:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbZGRPbv
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 11:31:51 -0400
Received: from peff.net ([208.65.91.99]:52600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbZGRPbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 11:31:51 -0400
Received: (qmail 375 invoked by uid 107); 18 Jul 2009 15:33:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 18 Jul 2009 11:33:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Jul 2009 11:31:49 -0400
Content-Disposition: inline
In-Reply-To: <20090718141658.GE16708@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123525>

On Sat, Jul 18, 2009 at 04:16:58PM +0200, Nicolas Sebrecht wrote:

> It fails on:
>   - next
>   - v1.6.3
>   - b67b9612e1a90ae093445abeaeff930e9f4cf936
>   - (other I don't remember, but does it really matter?)

Hmm. So it is clearly reproducible on your system, but not on mine. I
wonder what the difference could be.

Are you compiling with any special options? I usually compile with just
"-g -Wall -Werror", but I also tried with "-O2" and couldn't reproduce.
Maybe compiler version? I'm using gcc 4.3.3.

> ==10807== Invalid read of size 1
> ==10807==    at 0x4C22349: strlen (in /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so)
> ==10807==    by 0x5616ED6: vfprintf (in /lib64/libc-2.8.so)
> ==10807==    by 0x563C159: vsnprintf (in /lib64/libc-2.8.so)
> ==10807==    by 0x495E90: git_vsnprintf (snprintf.c:38)
> ==10807==    by 0x48917B: strbuf_addf (strbuf.c:203)
> ==10807==    by 0x412AA0: cmd_checkout (builtin-checkout.c:364)
> ==10807==    by 0x404222: handle_internal_command (git.c:243)
> ==10807==    by 0x404466: main (git.c:483)
> ==10807==  Address 0x1 is not stack'd, malloc'd or (recently) free'd

Looking at that strbuf_addf call, we presumably have a bogus pointer
either in old->name or new->name. Which is odd, since reading the code,
both get memset() to zero, and then assigned from something which should
be sane.

At this point, I would try either running it under gdb or putting in
some debugging printfs into update_refs_for_switch to try to isolate
where the bogus value is coming from (valgrind sees it as cmd_checkout,
but presumably that is because it inlines the static
update_refs_for_switch).

Can you try that? Otherwise, I'm not sure how to proceed because I can't
reproduce it on my box.

-Peff
