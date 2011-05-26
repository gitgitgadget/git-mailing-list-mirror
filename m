From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remove unnecessary test and dead diagnostic
Date: Thu, 26 May 2011 12:28:44 -0400
Message-ID: <20110526162844.GB4049@sigill.intra.peff.net>
References: <87tych5zrh.fsf@rho.meyering.net>
 <20110526141130.GB18520@sigill.intra.peff.net>
 <87mxi95y4z.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu May 26 18:28:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPdQa-0001su-SA
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab1EZQ2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:28:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40957
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757567Ab1EZQ2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:28:46 -0400
Received: (qmail 13547 invoked by uid 107); 26 May 2011 16:28:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 12:28:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 12:28:44 -0400
Content-Disposition: inline
In-Reply-To: <87mxi95y4z.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174542>

On Thu, May 26, 2011 at 04:34:20PM +0200, Jim Meyering wrote:

> Argh.  I went in with blinders on, thinking that the caller was
> right in using a type of size_t, and then read this "xread" name and
> assumed that it would exit upon failure.

I've made the same mistake, as many of our x* functions are designed to
die on error.

> Subject: [PATCH] use the correct type (ssize_t, not size_t) for read-style function
> 
> * sha1_file.c (index_stream): Using an unsigned type,
> we would fail to detect a read error and then proceed to
> try to write (size_t)-1 bytes.

This version looks right to me.

There's another one, too:

-- >8 --
Subject: [PATCH] read_gitfile_gently: use ssize_t to hold read result

Otherwise, a negative error return becomes a very large read
value. We catch this in practice because we compare the
expected and actual numbers of bytes (and you are not likely
to be reading (size_t)-1 bytes), but this makes the
correctness a little more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 013ad11..ce87900 100644
--- a/setup.c
+++ b/setup.c
@@ -382,7 +382,7 @@ const char *read_gitfile_gently(const char *path)
 	const char *slash;
 	struct stat st;
 	int fd;
-	size_t len;
+	ssize_t len;
 
 	if (stat(path, &st))
 		return NULL;
-- 
1.7.4.5.13.gd3ff5
