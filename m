From: Jeff King <peff@peff.net>
Subject: Re: [Crash] git-push $remote $non_ref:$anything
Date: Mon, 16 Jun 2008 12:15:02 -0400
Message-ID: <20080616161502.GA7219@sigill.intra.peff.net>
References: <20080615193823.GA11218@glandium.org> <20080615195541.GA7683@sigill.intra.peff.net> <alpine.LNX.1.00.0806151626260.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8HNH-00012l-GF
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYFPQPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbYFPQPH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:15:07 -0400
Received: from peff.net ([208.65.91.99]:4720 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbYFPQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:15:05 -0400
Received: (qmail 16598 invoked by uid 111); 16 Jun 2008 16:15:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 16 Jun 2008 12:15:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2008 12:15:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0806151626260.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85202>

On Sun, Jun 15, 2008 at 05:06:52PM -0400, Daniel Barkalow wrote:

> The only thing I can think of is that a user might have made some mistake 
> that would be more obvious with the error messages about both sides. Aside 
> from that, it doesn't seem to have any possible effects anyway.

Hmm. Yes, looking at it more closely, I think the intent was to show
as many errors as possible. We report all errors for the source and
dest sides of every refspec before aborting.

I think the patch below is an improvement. Apologies for the long-winded
commit message, but it took me a while to figure out what was going on,
so I thought it worth explaining.

-- >8 --
clean up error conventions of remote.c:match_explicit

match_explicit is called for each push refspec to try to
fully resolve the source and destination sides of the
refspec.  Currently, we look at each refspec and report
errors on both the source and the dest side before aborting.

It makes sense to report errors for each refspec, since an
error in one is independent of an error in the other.
However, reporting errors on the 'dst' side of a refspec if
there has been an error on the 'src' side does not
necessarily make sense, since the interpretation of the
'dst' side depends on the 'src' side (for example, when
creating a new unqualified remote ref, we use the same type
as the src ref).

This patch lets match_explicit return early when the src
side of the refspec is bogus. We still look at all of the
refspecs before aborting the push, though.

At the same time, we clean up the call signature, which
previously took an extra "errs" flag. This was pointless, as
we didn't act on that flag, but rather just passed it back
to the caller. Instead, we now use the more traditional
"return -1" to signal an error, and the caller aggregates
the error count.

This change fixes two bugs, as well:

  - the early return avoids a segfault when passing a NULL
    matched_src to guess_ref()

  - the check for multiple sources pointing to a single dest
    aborted if the "err" flag was set. Presumably the intent
    was not to bother with the check if we had no
    matched_src. However, since the err flag was passed in
    from the caller, we might abort the check just because a
    previous refspec had a problem, which doesn't make
    sense.

    In practice, this didn't matter, since due to the error
    flag we end up aborting the push anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/remote.c b/remote.c
index 91e3b11..55a8f9c 100644
--- a/remote.c
+++ b/remote.c
@@ -867,8 +867,7 @@ static char *guess_ref(const char *name, struct ref *peer)
 
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
-			  struct refspec *rs,
-			  int errs)
+			  struct refspec *rs)
 {
 	struct ref *matched_src, *matched_dst;
 
@@ -876,7 +875,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	char *dst_guess;
 
 	if (rs->pattern || rs->matching)
-		return errs;
+		return 0;
 
 	matched_src = matched_dst = NULL;
 	switch (count_refspec_match(rs->src, src, &matched_src)) {
@@ -898,14 +897,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	}
 
 	if (!matched_src)
-		errs = 1;
+		return -1;
 
 	if (!dst_value) {
 		unsigned char sha1[20];
 		int flag;
 
-		if (!matched_src)
-			return errs;
 		dst_value = resolve_ref(matched_src->name, sha1, 1, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
@@ -936,18 +933,16 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		      dst_value);
 		break;
 	}
-	if (errs || !matched_dst)
-		return 1;
-	if (matched_dst->peer_ref) {
-		errs = 1;
-		error("dst ref %s receives from more than one src.",
+	if (!matched_dst)
+		return -1;
+	if (matched_dst->peer_ref)
+		return error("dst ref %s receives from more than one src.",
 		      matched_dst->name);
-	}
 	else {
 		matched_dst->peer_ref = matched_src;
 		matched_dst->force = rs->force;
 	}
-	return errs;
+	return 0;
 }
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
@@ -956,8 +951,8 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 {
 	int i, errs;
 	for (i = errs = 0; i < rs_nr; i++)
-		errs |= match_explicit(src, dst, dst_tail, &rs[i], errs);
-	return -errs;
+		errs += match_explicit(src, dst, dst_tail, &rs[i]);
+	return errs;
 }
 
 static const struct refspec *check_pattern_match(const struct refspec *rs,
-- 
1.5.6.rc3.8.gabbfb
