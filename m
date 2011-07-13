From: Jeff King <peff@peff.net>
Subject: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Wed, 13 Jul 2011 03:06:44 -0400
Message-ID: <20110713070644.GF18566@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 09:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtX0-0006Sf-NW
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994Ab1GMHGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:06:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43249
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab1GMHGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:06:46 -0400
Received: (qmail 21288 invoked by uid 107); 13 Jul 2011 07:07:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 03:07:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 03:06:44 -0400
Content-Disposition: inline
In-Reply-To: <20110713064709.GA18499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177004>

When looking for commits that contain other commits (e.g.,
via "git tag --contains"), we can end up traversing useless
portions of the graph. For example, if I am looking for a
tag that contains a commit made last week, there is not much
point in traversing portions of the history graph made five
years ago.

This optimization can provide massive speedups. For example,
doing "git tag --contains HEAD~1000" in the linux-2.6
repository goes from:

  real    0m3.139s
  user    0m3.044s
  sys     0m0.092s

to:

  real    0m0.035s
  user    0m0.028s
  sys     0m0.004s

We could use commit timestamps to know when we are going too
far back in history, but they are sometimes not trustworthy.
Extreme clock skew on committers' machines (or bugs in
commit-generating software) mean that we may stop the
traversal too early when seeing commits skewed into the
past.

Instead, we use the calculated commit generation, which is a
propery of the graph itself (but since we cache it, it's
still cheap to consult).

Signed-off-by: Jeff King <peff@peff.net>
---
Same as previous version.

 builtin/tag.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 63bce6e..df6de47 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -40,7 +40,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 }
 
 static int contains_recurse(struct commit *candidate,
-			    const struct commit_list *want)
+			    const struct commit_list *want,
+			    unsigned long cutoff)
 {
 	struct commit_list *p;
 
@@ -57,9 +58,13 @@ static int contains_recurse(struct commit *candidate,
 	if (parse_commit(candidate) < 0)
 		return 0;
 
+	/* stop searching if we go too far back in time */
+	if (commit_generation(candidate) < cutoff)
+		return 0;
+
 	/* Otherwise recurse and mark ourselves for future traversals. */
 	for (p = candidate->parents; p; p = p->next) {
-		if (contains_recurse(p->item, want)) {
+		if (contains_recurse(p->item, want, cutoff)) {
 			candidate->object.flags |= TMP_MARK;
 			return 1;
 		}
@@ -70,7 +75,16 @@ static int contains_recurse(struct commit *candidate,
 
 static int contains(struct commit *candidate, const struct commit_list *want)
 {
-	return contains_recurse(candidate, want);
+	unsigned long cutoff = ULONG_MAX;
+	const struct commit_list *c;
+
+	for (c = want; c; c = c->next) {
+		unsigned long g = commit_generation(c->item);
+		if (g < cutoff)
+			cutoff = g;
+	}
+
+	return contains_recurse(candidate, want, cutoff);
 }
 
 static int show_reference(const char *refname, const unsigned char *sha1,
-- 
1.7.6.37.g989c6
