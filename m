From: Jeff King <peff@peff.net>
Subject: [PATCH] read_in_full: always report errors
Date: Thu, 26 May 2011 12:30:27 -0400
Message-ID: <20110526163027.GC4049@sigill.intra.peff.net>
References: <87tych5zrh.fsf@rho.meyering.net>
 <20110526141130.GB18520@sigill.intra.peff.net>
 <87hb8h5y09.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu May 26 18:30:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPdSF-00034N-Dk
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600Ab1EZQaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:30:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40963
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756480Ab1EZQa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:30:29 -0400
Received: (qmail 13612 invoked by uid 107); 26 May 2011 16:30:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 12:30:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 12:30:27 -0400
Content-Disposition: inline
In-Reply-To: <87hb8h5y09.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174544>

On Thu, May 26, 2011 at 04:37:10PM +0200, Jim Meyering wrote:

> > It looks like if we get -1 on the _first_ read, we will then return -1.
> > Subsequent errors are then ignored, and we return the (possibly
> > truncated) result.
> >
> > Which, to be honest, seems kind of insane to me. I'd think:
> >
> >   while (count > 0) {
> >           ssize_t loaded = xread(fd, p, count);
> >           if (loaded < 0)
> >                   return loaded;
> >           if (loaded == 0)
> >                   return total;
> >           ...
> >   }
> >
> > would be much more sensible semantics.
> 
> That looks better to me, too.

I was worried that some caller might care about the truncated output,
but after looking through the code, that is not the case. So I think we
should do this.

-- >8 --
Subject: [PATCH] read_in_full: always report errors

The read_in_full function repeatedly calls read() to fill a
buffer. If the first read() returns an error, we notify the
caller by returning the error. However, if we read some data
and then get an error on a subsequent read, we simply return
the amount of data that we did read, and the caller is
unaware of the error.

This makes the tradeoff that seeing the partial data is more
important than the fact that an error occurred. In practice,
this is generally not the case; we care more if an error
occurred, and should throw away any partial data.

I audited the current callers. In most cases, this will make
no difference at all, as they do:

  if (read_in_full(fd, buf, size) != size)
	  error("short read");

However, it will help in a few cases:

  1. In sha1_file.c:index_stream, we would fail to notice
     errors in the incoming stream.

  2. When reading symbolic refs in resolve_ref, we would
     fail to notice errors and potentially use a truncated
     ref name.

  3. In various places, we will get much better error
     messages. For example, callers of safe_read would
     erroneously print "the remote end hung up unexpectedly"
     instead of showing the read error.

Signed-off-by: Jeff King <peff@peff.net>
---
 wrapper.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 2829000..85f09df 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -148,8 +148,10 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 
 	while (count > 0) {
 		ssize_t loaded = xread(fd, p, count);
-		if (loaded <= 0)
-			return total ? total : loaded;
+		if (loaded < 0)
+			return -1;
+		if (loaded == 0)
+			return total;
 		count -= loaded;
 		p += loaded;
 		total += loaded;
-- 
1.7.4.5.13.gd3ff5
