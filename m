From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] fetch-pack: remove dead assignment to ref->new_sha1
Date: Thu, 19 Mar 2015 16:39:36 -0400
Message-ID: <20150319203935.GD7666@peff.net>
References: <20150319203126.GA31663@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:39:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhEF-0008W2-8D
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbbCSUjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:39:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:35432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750914AbbCSUji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:39:38 -0400
Received: (qmail 3700 invoked by uid 102); 19 Mar 2015 20:39:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 15:39:38 -0500
Received: (qmail 17307 invoked by uid 107); 19 Mar 2015 20:39:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:39:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 16:39:36 -0400
Content-Disposition: inline
In-Reply-To: <20150319203126.GA31663@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265829>

In everything_local(), we used to assign the current ref's value
found in ref->old_sha1 to ref->new_sha1 when we already have all the
necessary objects to complete the history leading to that
commit.  This copying was broken at 49bb805e (Do not ask for
objects known to be complete., 2005-10-19) and ever since we
instead stuffed a random bytes in ref->new_sha1 here.  No
code complained or failed due to this breakage.

It turns out that no code path that comes after this
assignment even looks at ref->new_sha1 at all.

 - The only caller of everything_local(), do_fetch_pack(),
   returns this list of refs, whose element has bogus
   new_sha1 values, to its caller.  It does not look at the
   elements itself, but does pass them to find_common, which
   looks only at the name and old_sha1 fields.

 - The only caller of do_fetch_pack(), fetch_pack(), returns this
   list to its caller.  It does not look at the elements nor act on
   them.

 - One of the two callers of fetch_pack() is cmd_fetch_pack(), the
   top-level that implements "git fetch-pack".  The only thing it
   looks at in the elements of the returned ref list is the old_sha1
   and name fields.

 - The other caller of fetch_pack() is fetch_refs_via_pack() in the
   transport layer, which is a helper that implements "git fetch".
   It only cares about whether the returned list is empty (i.e.
   failed to fetch anything).

Just drop the bogus assignment, that is not even necessary.  The
remote-tracking refs are updated based on a different list and not
using the ref list being manipulated by this code path; the caller
do_fetch_pack() created a copy of that real ref list and passed the
copy down to this function, and modifying the elements here does not
affect anything.

Noticed-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 84d5a66..48526aa 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -628,7 +628,6 @@ static int everything_local(struct fetch_pack_args *args,
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
-		unsigned char local[20];
 		struct object *o;
 
 		o = lookup_object(remote);
@@ -641,8 +640,6 @@ static int everything_local(struct fetch_pack_args *args,
 				ref->name);
 			continue;
 		}
-
-		hashcpy(ref->new_sha1, local);
 		if (!args->verbose)
 			continue;
 		fprintf(stderr,
-- 
2.3.3.520.g3cfbb5d
