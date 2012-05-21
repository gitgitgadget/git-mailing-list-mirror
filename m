From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] fetch-pack: avoid quadratic loop in filter_refs
Date: Mon, 21 May 2012 18:23:29 -0400
Message-ID: <20120521222329.GE22914@sigill.intra.peff.net>
References: <20120521221417.GA22664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWb0r-0005Bo-5z
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab2EUWXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:23:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51155
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757391Ab2EUWXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:23:32 -0400
Received: (qmail 7140 invoked by uid 107); 21 May 2012 22:23:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 18:23:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 18:23:29 -0400
Content-Disposition: inline
In-Reply-To: <20120521221417.GA22664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198142>

We have a list of refs that we want to compare against the
"match" array. The current code searches the match list
linearly, giving quadratic behavior over the number of refs
when you want to fetch all of them.

Instead, we can compare the lists as we go, giving us linear
behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the only actual tricky patch in the series. I think I got the
list traversing right, but more eyeballs are appreciated.

This makes the result O(n).  An alternative implementation would be to
simply binary-search the sorted "match" array for each ref. That's O(n
lg n), but we've already spent O(n lg n) sorting in the first place, so
it's not a big deal. The code for that would be a little bit simpler.
However, it's not as simple as you'd like, because we zero-out the match
array to mark entries as "found". So we'd have to add a separate
bit array.

I think this version is simple enough.

 builtin/fetch-pack.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bee329f..d091865 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -528,6 +528,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
 	struct ref *fastarray[32];
+	int match_pos;
 
 	if (nr_match && !args.fetch_all) {
 		if (ARRAY_SIZE(fastarray) < nr_match)
@@ -540,6 +541,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	else
 		return_refs = NULL;
 
+	match_pos = 0;
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
@@ -553,15 +555,20 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 			continue;
 		}
 		else {
-			int i;
-			for (i = 0; i < nr_match; i++) {
-				if (!strcmp(ref->name, match[i])) {
-					match[i][0] = '\0';
-					return_refs[i] = ref;
+			int cmp = -1;
+			while (match_pos < nr_match) {
+				cmp = strcmp(ref->name, match[match_pos]);
+				if (cmp < 0) /* definitely do not have it */
+					break;
+				else if (cmp == 0) { /* definitely have it */
+					match[match_pos][0] = '\0';
+					return_refs[match_pos] = ref;
 					break;
 				}
+				else /* might have it; keep looking */
+					match_pos++;
 			}
-			if (i < nr_match)
+			if (!cmp)
 				continue; /* we will link it later */
 		}
 		free(ref);
-- 
1.7.10.1.19.g711d603
