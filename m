From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] resolve_ref: close race condition for packed refs
Date: Wed, 15 May 2013 23:47:21 -0400
Message-ID: <20130516034721.GD13296@sigill.intra.peff.net>
References: <20130507023610.GA22053@sigill.intra.peff.net>
 <20130507023802.GA22940@sigill.intra.peff.net>
 <51901E05.1080905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 16 05:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcpA8-0000Ek-BW
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab3EPDrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:47:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:44890 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab3EPDrY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:47:24 -0400
Received: (qmail 21317 invoked by uid 102); 16 May 2013 03:47:52 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 May 2013 22:47:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2013 23:47:21 -0400
Content-Disposition: inline
In-Reply-To: <51901E05.1080905@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224476>

On Mon, May 13, 2013 at 12:56:05AM +0200, Michael Haggerty wrote:

> > + * This should be called from resolve_ref_unsafe when a loose ref cannot be
> > + * accessed; err must represent the errno from the last attempt to access the
> > + * loose ref, and the other options are forwarded from resolve_safe_unsaefe.
> 
> s/resolve_ref_unsaefe/resolve_ref_unsafe/

Oops, thanks.

> > -			return NULL;
> > +			return handle_loose_ref_failure(errno, refname, sha1,
> > +							reading, flag);
> 
> I probably would have separated the rest of the patch, which is a pure
> refactoring, from this last chunk, which is a functional change.  But
> that's just me.

Yeah, I go back and forth on whether it is better to have strict
refactors followed by changes or not. Sometimes it is hard to understand
the motivation for the refactor without seeing the change, and you end
up explaining it twice.

My usual rule of thumb is:

  - If you are factoring out some code, and then are going to change
    that code, make it two separate changes. That keeps the diffs
    readable (the first one is pure movement and you do not need to look
    closely, and the second shows a sane diff of the change).

  - If you are factoring out some code, and then adding more callers,
    it's OK to do it together. The new caller provides the motivation
    for the refactor.

This is the latter case. But I'm open to arguments that the rule is not
a good one. :)

> I suggest adding a comment here mentioning briefly the race condition
> that the call to handle_loose_ref_failure() is meant to address;
> otherwise somebody not thinking of race conditions might have the clever
> idea of "inlining" the call to "return NULL" because it seems redundant
> with the check of ENOENT following the lstat() call above.

Yeah, I thought I had mentioned that at the top of
handle_loose_ref_failure, but I see that I didn't. Probably something
like this squashed on top makes sense:

diff --git a/refs.c b/refs.c
index c127baf..1a7e4ef 100644
--- a/refs.c
+++ b/refs.c
@@ -1111,7 +1111,7 @@ static int get_packed_ref(const char *refname, unsigned char *sha1)
 /*
  * This should be called from resolve_ref_unsafe when a loose ref cannot be
  * accessed; err must represent the errno from the last attempt to access the
- * loose ref, and the other options are forwarded from resolve_safe_unsaefe.
+ * loose ref, and the other options are forwarded from resolve_safe_unsafe.
  */
 static const char *handle_loose_ref_failure(int err,
 					    const char *refname,
@@ -1200,9 +1200,16 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		 * a ref
 		 */
 		fd = open(path, O_RDONLY);
-		if (fd < 0)
+		if (fd < 0) {
+			/*
+			 * We need to check again here for ENOENT and fall back
+			 * to the packed-refs file to avoid a race condition in
+			 * which the ref is packed and pruned between our
+			 * lstat() and open() calls.
+			 */
 			return handle_loose_ref_failure(errno, refname, sha1,
 							reading, flag);
+		}
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 		close(fd);
 		if (len < 0)
