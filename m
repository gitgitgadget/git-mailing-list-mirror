From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/blame: destroy initialized commit_info only
Date: Mon, 9 Feb 2015 18:24:36 -0500
Message-ID: <20150209232435.GB24814@peff.net>
References: <1423517287-8354-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Dilyan Palauzov <dilyan.palauzov@aegee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 00:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKxh6-0005Zm-W8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 00:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760165AbbBIXYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 18:24:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:47037 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755796AbbBIXYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 18:24:38 -0500
Received: (qmail 10775 invoked by uid 102); 9 Feb 2015 23:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Feb 2015 17:24:38 -0600
Received: (qmail 2353 invoked by uid 107); 9 Feb 2015 23:24:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Feb 2015 18:24:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2015 18:24:36 -0500
Content-Disposition: inline
In-Reply-To: <1423517287-8354-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263615>

On Mon, Feb 09, 2015 at 04:28:07PM -0500, Eric Sunshine wrote:

> Since ea02ffa3 (mailmap: simplify map_user() interface, 2013-01-05),
> find_alignment() has been invoking commit_info_destroy() on an
> uninitialized auto 'struct commit_info' (when METAINFO_SHOWN is not
> set). commit_info_destroy() calls strbuf_release() for each of
> 'commit_info' strbuf member, which randomly invokes free() on whatever
> random stack value happens to be reside in strbuf.buf, thus leading to
> periodic crashes.
> 
> Reported-by: Dilyan Palauzov <dilyan.palauzov@aegee.org>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> 
> No test accompanying this fix since I don't know how to formulate one.
> 
> Discussion: http://thread.gmane.org/gmane.comp.version-control.git/263534

Thanks, good catch. This is almost certainly the source of the reported
bug. I was curious why we didn't find this until now, and what we could
do to detect similar problems. You can stop reading if you're not
interested. :)

We call strbuf_release on each of the uninitialized components. That
will only call free(sb->buf) if sb->alloc is non-zero. And if sb->buf is
0, then that is OK (it is a noop to free NULL). So the bug only shows
itself when the uninitialized memory is such that both are non-zero.

We're in a loop here, where we set the METAINFO_SHOWN to avoid
processing commits from the loop twice. So generally the first time
through the loop (when we really do have uninitialized crap in the
struct), that flag will not be set, and we will fill in the struct. Then
a later iteration of the loop does have the flag set, and does not fill
in the struct. But quite often we'll have whatever was left in the
struct from the previous loop iteration. Which, because strbuf_release()
re-initializes the strbufs, is a valid strbuf which it is a noop to
free.

Of course, that's entirely up to the compiler. It's reasonable to use
the same block for the variable in each iteration of the loop, but it is
free to do whatever it likes. It may even come and go with various
optimization settings.

Obviously if we hit a compiler that feeds the uninitialized values to
free(), this is pretty easy to detect with valgrind or another
heap-checking library. But let's assume we have a compiler that does the
"reuse" behavior. There's no bug in the generated code, but it's
technically undefined behavior. Can we detect it?

The compiler _could_ know statically that this is a use of uninitialized
memory, except that it only sees:

    commit_info_destroy(&ci);

on the uninitialized memory. Since we are passing a pointer to a
function it can't see, it has to assume that it's actually initializing
the memory for us (i.e., it looks the same as commit_info_init). So it
doesn't catch it. I don't know of a way to annotate the pointers better,
or if there is a way to get the compiler to see the code in a more
global way.

Valgrind cannot detect this. With the "reuse" behavior, we never even
call malloc, so there's nothing for it to see there. We are accessing
uninitialized memory, but it's on the stack. Valgrind doesn't even know
about it, or that we are looping here.

Clang's address sanitizer has compiler support, so it does get to see
this memory and could put a canary value in for each loop iteration. But
it doesn't. Instead, you're supposed to use the "memory sanitizer" to
catch uninitialized memory.

I tried that, but got overwhelmed with false positives. Like valgrind,
it has problems accepting that memory written by zlib is actually
initialized. But in theory, if we went to the work to annotate some
false positives, it should be able to find this problem.

-Peff
