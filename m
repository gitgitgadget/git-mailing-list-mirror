From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 2/4] limit "contains" traversals based on commit
 timestamp
Date: Mon, 5 Jul 2010 08:34:19 -0400
Message-ID: <20100705123419.GB25699@sigill.intra.peff.net>
References: <20100705122723.GB21146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 05 14:34:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVksV-0002QW-H2
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab0GEMeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:34:22 -0400
Received: from peff.net ([208.65.91.99]:38144 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754419Ab0GEMeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 08:34:21 -0400
Received: (qmail 12146 invoked by uid 107); 5 Jul 2010 12:35:17 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 08:35:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 08:34:19 -0400
Content-Disposition: inline
In-Reply-To: <20100705122723.GB21146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150262>

When looking for commits that contain other commits (e.g.,
via "git tag --contains"), we can end up traversing useless
portions of the graph. For example, if I am looking for a
tag that contains a commit made last week, there is not much
point in traversing portions of the history graph made five
years ago.

This optimization can provide massive speedups. For example,
doing "git tag --contains HEAD~200" in the linux-2.6
repository goes from:

  real    0m5.302s
  user    0m5.116s
  sys     0m0.184s

to:

  real    0m0.030s
  user    0m0.020s
  sys     0m0.008s

The downside is that we will no longer find some answers in
the face of extreme clock skew, as we will stop the
traversal early when seeing commits skewed too far into the
past.

Name-rev already implements a similar optimization, using a
"slop" of one day to allow for a certain amount of clock
skew in commit timestamps. This patch introduces a
"core.clockskew" variable, which allows specifying the
allowable amount of clock skew in seconds.  For safety, it
defaults to "none", causing a full traversal (i.e., no
change in behavior from previous versions).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  |    1 +
 commit.c |   27 ++++++++++++++++++++++++---
 config.c |    8 ++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index c9fa3df..2dfb636 100644
--- a/cache.h
+++ b/cache.h
@@ -551,6 +551,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_clock_skew;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/commit.c b/commit.c
index 20354c6..c849b50 100644
--- a/commit.c
+++ b/commit.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "notes.h"
 
+int core_clock_skew = -1;
 int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
@@ -855,7 +856,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 }
 
 static int contains_recurse(struct commit *candidate,
-			    const struct commit_list *want)
+			    const struct commit_list *want,
+			    unsigned long cutoff)
 {
 	struct commit_list *p;
 
@@ -872,9 +874,13 @@ static int contains_recurse(struct commit *candidate,
 	if (parse_commit(candidate) < 0)
 		return 0;
 
+	/* stop searching if we go too far back in time */
+	if (candidate->date < cutoff)
+		return 0;
+
 	/* Otherwise recurse and mark ourselves for future traversals. */
 	for (p = candidate->parents; p; p = p->next) {
-		if (contains_recurse(p->item, want)) {
+		if (contains_recurse(p->item, want, cutoff)) {
 			candidate->object.flags |= TMP_MARK;
 			return 1;
 		}
@@ -885,5 +891,20 @@ static int contains_recurse(struct commit *candidate,
 
 int contains(struct commit *candidate, const struct commit_list *want)
 {
-	return contains_recurse(candidate, want);
+	unsigned long cutoff = 0;
+
+	if (core_clock_skew >= 0) {
+		const struct commit_list *c;
+		unsigned long min_date = ULONG_MAX;
+		for (c = want; c; c = c->next) {
+			if (parse_commit(c->item) < 0)
+				continue;
+			if (c->item->date < min_date)
+				min_date = c->item->date;
+		}
+		if (min_date > core_clock_skew)
+			cutoff = min_date - core_clock_skew;
+	}
+
+	return contains_recurse(candidate, want, cutoff);
 }
diff --git a/config.c b/config.c
index cdcf583..7a18bc9 100644
--- a/config.c
+++ b/config.c
@@ -595,6 +595,14 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.clockskew")) {
+		if (!value || !strcmp(value, "none"))
+			core_clock_skew = -1;
+		else
+			core_clock_skew = git_config_int(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
-- 
1.7.2.rc1.209.g2a36c
