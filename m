From: Jeff King <peff@peff.net>
Subject: Re: git 2.2.2 annotate crash (strbuf.c:32)
Date: Sun, 8 Feb 2015 20:28:58 -0500
Message-ID: <20150209012858.GB21072@peff.net>
References: <54D7D634.2050807@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dilyan Palauzov <dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKd9u-00066B-0r
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 02:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759175AbbBIB3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 20:29:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:46620 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755653AbbBIB3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 20:29:00 -0500
Received: (qmail 16974 invoked by uid 102); 9 Feb 2015 01:29:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 19:29:00 -0600
Received: (qmail 26940 invoked by uid 107); 9 Feb 2015 01:29:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Feb 2015 20:29:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:28:58 -0500
Content-Disposition: inline
In-Reply-To: <54D7D634.2050807@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263542>

On Sun, Feb 08, 2015 at 10:33:40PM +0100, Dilyan Palauzov wrote:

> I use git 2.2.2 and on my system git annotate crashed with the following
> log.

I couldn't reproduce it with a few simple examples. Is it possible for
you to show us the repository and command that caused this?

> (gdb) bt full
> #0  0x00007fe420649655 in raise () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007fe42064aad8 in abort () from /lib64/libc.so.6
> No symbol table info available.
> #2  0x00007fe42068928b in __libc_message () from /lib64/libc.so.6
> No symbol table info available.
> #3  0x00007fe42068ee36 in malloc_printerr () from /lib64/libc.so.6
> No symbol table info available.
> #4  0x00007fe42068fbb3 in _int_free () from /lib64/libc.so.6
> No symbol table info available.
> #5  0x000000000041335a in strbuf_release (sb=0x7fff44797480) at strbuf.c:32
>         sb = 0x7fff44797480

So presumably the sb->buf we pass to free() is not valid. Given the
address of the strbuf, and the address of the commit_info here:

> #6  commit_info_destroy (ci=0x7fff447973e0) at builtin/blame.c:1646
> No locals.

we are at offset 160, which is almost certainly the ci->summary strbuf.
Which is:

>           summary = {
>             alloc = 26,
>             len = 25,
>             buf = 0xe05b50 <incomplete sequence \330>
>           }

The alloc/len look reasonable, but the buffer looks odd (it should
probably have some actual text in it). I don't see anywhere in the code
that we assign to that buffer or do anything questionable, though. We
just strbuf_add and then eventually strbuf_release it. You cannot even
get into this situation by calling strbuf_release twice, as it sets the
pointer to a known value after it is freed.

-Peff
