From: Nix <nix@esperi.org.uk>
Subject: Re: git 2.0.0 PROFILE=BUILD check-phase problems with ./t5561-http-backend.sh; GIT_TEST_HTTPD=false problems with t5537-fetch-shallow.sh
Date: Fri, 30 May 2014 10:28:59 +0100
Message-ID: <87ppiv8vj8.fsf@spindle.srvr.nix>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
	<20140530010649.GD28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 11:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqJ7g-0006vR-3w
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 11:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbaE3J3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 05:29:07 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:49170 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbaE3J3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 05:29:05 -0400
Received: from spindle.srvr.nix (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.9/8.14.8) with ESMTP id s4U9T0AU004628;
	Fri, 30 May 2014 10:29:00 +0100
Emacs: more than just a Lisp interpreter, a text editor as well!
In-Reply-To: <20140530010649.GD28683@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 29 May 2014 21:06:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
X-DCC-URT-Metrics: spindle 1060; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250436>

On 30 May 2014, Jeff King told this:

> On Thu, May 29, 2014 at 11:44:37PM +0100, Nix wrote:
>
>> I observe test failures with git 2.0.0 which are attributable to the
>> change to run network tests by default. I'm lumping them both together
>> into one report because I'm lazy and I've blown too much time on this
>> already.
>
> Weird. I also see a strange failure on t5310 when building with
> PROFILE=BUILD. We get a segfault when reading jgit-produced bitmaps.

I don't see that, but this may be a compiler difference, or
environmental difference, or something.

> Tracking it down, we're getting inexplicably bogus data from an mmap'd
> file (!). Compiling without PROFILE=BUILD, the test passes fine (even
> with valgrind).
>
> If I instrument it like this:
>
> diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
> index f7f700e..8cafacf 100644
> --- a/ewah/ewah_io.c
> +++ b/ewah/ewah_io.c
> @@ -119,6 +119,7 @@ int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
>  	ptr += sizeof(uint32_t);
>  
>  	self->buffer_size = self->alloc_size = get_be32(ptr);
> +	warning("got buffer_size of %lu from %lu", self->buffer_size, *(uint32_t *)ptr);
>  	ptr += sizeof(uint32_t);
>  
>  	self->buffer = ewah_realloc(self->buffer,
>
> a regular test-run reads:
>
>   warning: got buffer_size of 2 from 33554432
>   warning: got buffer_size of 2 from 33554432
>   warning: got buffer_size of 3 from 50331648
>   warning: got buffer_size of 1 from 16777216
>   warning: got buffer_size of 2 from 33554432
>
> and a PROFILE=BUILD one reads:
>
>   warning: got buffer_size of 2 from 33554432
>   warning: got buffer_size of 2 from 33554432
>   warning: got buffer_size of 3 from 50331648
>   warning: got buffer_size of 1 from 16777216
>   warning: got buffer_size of 131072 from 512
>
> I'm willing to believe we're doing something weird that violates the C
> standard there, but I really can't see it.

It's doubly strange because you're not building with -flto at all, all
callers of ewah_read_mmap() are in a separate file, and there are no
conditionals or loops above the warning() locus. Maybe the error is in a
different file, and is causing a nonsense 'len' to get passed in?

But I think this *may* be a false alarm. *(uint32_t *)ptr on a uint8_t
(in your logging line) is an aliasing violation, and the nearly-
uninitialized '512' is pretty much what I'd expect GCC to do now and
then, given that. Just a guess.

(I'm surprised this doesn't cause a problem *always*, though.)

>> It appears that the Apache daemon is writing to the log slowly enough
>> that its log lines only get there after the testsuite has written its
>> separator, so a bunch of log lines appear to be attached to the wrong
>> test, and the comparison fails.
>
> Yeah, that looks to me like what is happening, too. If I put a 'sleep
> 1' into log_div, it passes. I would think apache would write the log
> before serving the file, but perhaps not.

It does a straight write() via APR, which should work, I'd have thought.
This is on a tmpfs, not a network filesystem or anything.

(Aside: the flushing semantics are quite tangled, but shouldn't matter,
given that we're just doing a write(). Apache calls apr_file_flush() on
the logfile, but that's just flushing apr's analogue of stdio buffers:
it does nothing if the file is unbuffered -- and the error log file is
unbuffered. It does not call apr_file_sync(), but you shouldn't need a
sync() for one process to see another process's output.)

>                                           And like you, I would expect
> gcov to make things slower, not faster. Could there be something in the
> environment that

I'm more inclined to blame the kernel or the compiler, but I *always*
blame the kernel or the compiler. :P

> I'm not sure what the best fix is. We could check the logfiles after
> each test instead of at the end, but that will just end up with the same
> race: we may check them before apache has written them.

Yeah, that seems less than useful.

-- 
NULL && (void)
