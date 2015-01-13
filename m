From: Jeff King <peff@peff.net>
Subject: [PATCH] http-push: trim trailing newline from remote symref
Date: Mon, 12 Jan 2015 21:28:58 -0500
Message-ID: <20150113022857.GA4087@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 03:29:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YArE7-0000Gb-VP
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 03:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbbAMC27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 21:28:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:33639 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752546AbbAMC26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 21:28:58 -0500
Received: (qmail 20563 invoked by uid 102); 13 Jan 2015 02:28:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:28:58 -0600
Received: (qmail 22943 invoked by uid 107); 13 Jan 2015 02:29:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 21:29:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 21:28:58 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262323>

When we fetch a symbolic ref file from the remote, we get
the whole string "ref: refs/heads/master\n", recognize it by
skipping past the "ref: ", and store the rest. We should
chomp the trailing newline.

This bug was introduced in ae021d8 (use skip_prefix to avoid
magic numbers, 2014-06-18), which did not notice that the
length computation fed to xmemdupz was quietly tweaked by 1
to account for this.

We can solve it by explicitly trimming the newline, which is
more obvious. Note that we use strbuf_rtrim here, which will
actually cut off any trailing whitespace, not just a single
newline. This is a good thing, though, as it makes our
parsing more liberal (and spaces are not valid in refnames
anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
This is a regression in v2.1.0.

It was causing t5540 to fail, but I realized I have been building with
NO_EXPAT for a while, so I didn't notice. Frankly, I'm kind of surprised
and disturbed that nobody noticed it before now. More evidence that we
can kill off dumb http-push? I would have thought somebody else would
have noticed the test failure, though.

I am embarrassed to have introduced the bug during a refactoring patch.
But in my defense, the original code was quite subtle and horrible, and
I think the end result at least is much obvious (and is a good point in
favor of skip_prefix's existence!). The original came from eecc836
(Another memory overrun in http-push.c, 2007-03-01). Looking at that
patch, I can't understand how the code before it ever worked in the
first place.

 http-push.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http-push.c b/http-push.c
index 26dfa67..184d24a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1578,6 +1578,9 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	if (buffer.len == 0)
 		return;
 
+	/* Cut off trailing newline. */
+	strbuf_rtrim(&buffer);
+
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
 	if (skip_prefix(buffer.buf, "ref: ", &name)) {
 		*symref = xmemdupz(name, buffer.len - (name - buffer.buf));
-- 
2.2.1.425.g441bb3c
