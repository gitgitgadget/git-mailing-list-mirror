From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] diff: avoid useless filespec population
Date: Thu, 1 Apr 2010 20:14:24 -0400
Message-ID: <20100402001424.GG16462@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUX3-0002tx-QV
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759058Ab0DBAOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:14:37 -0400
Received: from peff.net ([208.65.91.99]:46468 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759038Ab0DBAOg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:14:36 -0400
Received: (qmail 5273 invoked by uid 107); 2 Apr 2010 00:15:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:15:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:14:24 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143768>

builtin_diff calls fill_mmfile fairly early, which in turn
calls diff_populate_filespec, which actually retrieves the
file's blob contents into a buffer. Long ago, this was
sensible as we would need to look at the blobs eventually.

These days, however, we may not ever want those blobs if we
end up using a textconv cache, and for large binary files
(exactly the sort for which you might have a textconv
cache), just retrieving the objects can be costly.

This patch just pushes the fill_mmfile call a bit later, so
we can avoid populating the filespec in some cases.  There
is one thing to note that looks like a bug but isn't. We
push the fill_mmfile down into the first branch of a
conditional. It seems like we would need it on the other
branch, too, but we don't; fill_textconv does it for us (in
fact, before this, we were just writing over the results of
the fill_mmfile on that branch).

Here's a timing sample on a commit with 45 changed jpgs and
avis. The result is fully textconv cached, but we still
wasted a lot of time just pulling the blobs from storage.
The total size of the blobs (source and dest) is about
180M.

  [before]
  $ time git show >/dev/null
  real    0m0.352s
  user    0m0.148s
  sys     0m0.200s

  [after]
  $ time git show >/dev/null
  real    0m0.009s
  user    0m0.004s
  sys     0m0.004s

And that's on a warm cache. On a cold cache, the "after"
case is not much worse, but the "before" case has to do an
extra 180M of I/O.

Signed-off-by: Jeff King <peff@peff.net>
---
I remember when I first started using git having it go so fast that I
had to double-check that it had actually worked correctly. I had another
of those moments when I ran this. But it correctly processed everything
I threw at it. More stress-testing appreciated. :)

 diff.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 72d8503..4cb6d9a 100644
--- a/diff.c
+++ b/diff.c
@@ -1680,12 +1680,11 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
-	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
-		die("unable to read files to diff");
-
 	if (!DIFF_OPT_TST(o, TEXT) &&
-	    ( (diff_filespec_is_binary(one) && !textconv_one) ||
-	      (diff_filespec_is_binary(two) && !textconv_two) )) {
+	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
+	      (!textconv_two && diff_filespec_is_binary(two)) )) {
+		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+			die("unable to read files to diff");
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
-- 
1.7.0.4.299.gba9d4
