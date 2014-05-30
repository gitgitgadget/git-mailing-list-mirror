From: Jeff King <peff@peff.net>
Subject: Re: git 2.0.0 PROFILE=BUILD check-phase problems with
 ./t5561-http-backend.sh; GIT_TEST_HTTPD=false problems with
 t5537-fetch-shallow.sh
Date: Thu, 29 May 2014 21:06:49 -0400
Message-ID: <20140530010649.GD28683@sigill.intra.peff.net>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Fri May 30 03:06:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqBHc-0007wf-Hn
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 03:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbaE3BGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 21:06:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:33825 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751975AbaE3BGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 21:06:51 -0400
Received: (qmail 647 invoked by uid 102); 30 May 2014 01:06:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 20:06:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 21:06:49 -0400
Content-Disposition: inline
In-Reply-To: <87y4xk8asq.fsf@spindle.srvr.nix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250425>

On Thu, May 29, 2014 at 11:44:37PM +0100, Nix wrote:

> I observe test failures with git 2.0.0 which are attributable to the
> change to run network tests by default. I'm lumping them both together
> into one report because I'm lazy and I've blown too much time on this
> already.

Weird. I also see a strange failure on t5310 when building with
PROFILE=BUILD. We get a segfault when reading jgit-produced bitmaps.
Tracking it down, we're getting inexplicably bogus data from an mmap'd
file (!). Compiling without PROFILE=BUILD, the test passes fine (even
with valgrind).

If I instrument it like this:

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index f7f700e..8cafacf 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -119,6 +119,7 @@ int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 	ptr += sizeof(uint32_t);
 
 	self->buffer_size = self->alloc_size = get_be32(ptr);
+	warning("got buffer_size of %lu from %lu", self->buffer_size, *(uint32_t *)ptr);
 	ptr += sizeof(uint32_t);
 
 	self->buffer = ewah_realloc(self->buffer,

a regular test-run reads:

  warning: got buffer_size of 2 from 33554432
  warning: got buffer_size of 2 from 33554432
  warning: got buffer_size of 3 from 50331648
  warning: got buffer_size of 1 from 16777216
  warning: got buffer_size of 2 from 33554432

and a PROFILE=BUILD one reads:

  warning: got buffer_size of 2 from 33554432
  warning: got buffer_size of 2 from 33554432
  warning: got buffer_size of 3 from 50331648
  warning: got buffer_size of 1 from 16777216
  warning: got buffer_size of 131072 from 512

I'm willing to believe we're doing something weird that violates the C
standard there, but I really can't see it.

Anyway, that's a side note to your problem...

> It appears that the Apache daemon is writing to the log slowly enough
> that its log lines only get there after the testsuite has written its
> separator, so a bunch of log lines appear to be attached to the wrong
> test, and the comparison fails.

Yeah, that looks to me like what is happening, too. If I put a 'sleep
1' into log_div, it passes. I would think apache would write the log
before serving the file, but perhaps not. And like you, I would expect
gcov to make things slower, not faster. Could there be something in the
environment that

I'm not sure what the best fix is. We could check the logfiles after
each test instead of at the end, but that will just end up with the same
race: we may check them before apache has written them.

> Attempting to work around this by building with GIT_TEST_HTTPD=false
> doesn't work either:
> 
> *** t5537-fetch-shallow.sh ***
> ok 1 - setup
> ok 2 - setup shallow clone
> ok 3 - clone from shallow clone
> ok 4 - fetch from shallow clone
> ok 5 - fetch --depth from shallow clone
> ok 6 - fetch --unshallow from shallow clone
> ok 7 - fetch something upstream has but hidden by clients shallow boundaries
> ok 8 - fetch that requires changes in .git/shallow is filtered
> ok 9 - fetch --update-shallow
> error: Can't use skip_all after running some tests
> Makefile:43: recipe for target 't5537-fetch-shallow.sh' failed
> make[3]: *** [t5537-fetch-shallow.sh] Error 1

Hrm. This already came up, and we dealt with it in 0232852 (t5537: move
http tests out to t5539, 2014-02-13). Which is in v2.0.0.

But somehow the code is back in v2.0.0 Presumably this is the result of a
mis-merge. I'll send a patch.

-Peff
