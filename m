From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] filter_ref: avoid overwriting ref->old_sha1 with garbage
Date: Thu, 19 Mar 2015 16:34:51 -0400
Message-ID: <20150319203451.GA7666@peff.net>
References: <20150319203126.GA31663@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:35:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYh9e-0004Lv-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbCSUey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:34:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35417 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750734AbbCSUey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:34:54 -0400
Received: (qmail 3503 invoked by uid 102); 19 Mar 2015 20:34:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 15:34:53 -0500
Received: (qmail 17247 invoked by uid 107); 19 Mar 2015 20:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:35:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 16:34:51 -0400
Content-Disposition: inline
In-Reply-To: <20150319203126.GA31663@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265826>

If the server supports allow_tip_sha1_in_want, then
fetch-pack's filter_refs function tries to check whether a
ref is a request for a straight sha1 by running:

  if (get_sha1_hex(ref->name, ref->old_sha1))
	  ...

I.e., we are using get_sha1_hex to ask "is this ref name a
sha1?". If it is true, then the contents of ref->old_sha1
will end up unchanged. But if it is false, then get_sha1_hex
makes no guarantees about what it has written. With a ref
name like "abcdefoo", we would overwrite 3 bytes of
ref->old_sha1 before realizing that it was not a sha1.

This is likely not a problem in practice, as anything in
refs->name (besides a sha1) will start with "refs/", meaning
that we would notice on the first character that there is a
problem. Still, we are making assumptions about the state
left in the output when get_sha1_hex returns an error (e.g.,
it could start from the end of the string, or error check
the values only once they were placed in the output). It's
better to be defensive.

We could just check that we have exactly 40 characters of
sha1. But let's be even more careful and make sure that we
have a 40-char hex refname that matches what is in old_sha1.
This is perhaps overly defensive, but spells out our
assumptions clearly.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is not necessary for the others, of course, and we can drop it
if you disagree with the reasoning.

I wonder if the thinking in the original was that it was our
responsibility here to make sure that ref->old_sha1 was filled in. It is
always filled in by the caller who gives us "sought", which makes sense
to me (this matches the rest of the "sought" entries, which come from
reading the remote's ref list, and of course must fill in old_sha1 from
that list).

 fetch-pack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 655ee64..058c258 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -544,10 +544,14 @@ static void filter_refs(struct fetch_pack_args *args,
 	/* Append unmatched requests to the list */
 	if (allow_tip_sha1_in_want) {
 		for (i = 0; i < nr_sought; i++) {
+			unsigned char sha1[20];
+
 			ref = sought[i];
 			if (ref->matched)
 				continue;
-			if (get_sha1_hex(ref->name, ref->old_sha1))
+			if (get_sha1_hex(ref->name, sha1) ||
+			    ref->name[40] != '\0' ||
+			    hashcmp(sha1, ref->old_sha1))
 				continue;
 
 			ref->matched = 1;
-- 
2.3.3.520.g3cfbb5d
