From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Wed, 29 May 2013 03:50:20 -0400
Message-ID: <20130529075020.GC11955@sigill.intra.peff.net>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
 <20130529062007.GA11955@sigill.intra.peff.net>
 <20130529072225.GB11955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 29 09:50:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhb9Q-0002Ow-LP
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961Ab3E2HuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 03:50:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:36785 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964863Ab3E2HuX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:50:23 -0400
Received: (qmail 17967 invoked by uid 102); 29 May 2013 07:51:03 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 02:51:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 03:50:20 -0400
Content-Disposition: inline
In-Reply-To: <20130529072225.GB11955@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225770>

On Wed, May 29, 2013 at 03:22:25AM -0400, Jeff King wrote:

>   revs=origin/master...origin/jk/submodule-subdirectory-ok
>         stock    |    you   |    me
>         -------------------------------
>   real  0m0.501s | 0m0.078s | 0m0.098s
>   user  0m0.480s | 0m0.056s | 0m0.084s
>   sys   0m0.016s | 0m0.020s | 0m0.012s
> 
>   revs=origin/next...origin/pu
>         stock    |    you   |    me
>         -------------------------------
>   real  0m0.857s | 0m0.847s | 0m0.519s
>   user  0m0.828s | 0m0.812s | 0m0.488s
>   sys   0m0.024s | 0m0.028s | 0m0.024s
> 
> So it performs slightly less well on the small case, and a bit better on
> the large case. I think part of the problem is that when we do have a
> "loose" hit, we end up re-doing the tree diff to find the strict, which
> involves re-inflating the trees. It's unavoidable for the lazy entries
> unless we want to cache the whole diff_queued_diff, but for the non-lazy
> entries we should be able to do the strict patch-id incrementally. We
> just need to improve the function interfaces.

The (somewhat hacky) patch below, on top of my previous one, does that
optimization.  But the timings aren't improved by much. My best-of-five
for the second case went down to:

  real    0m0.495s
  user    0m0.488s
  sys     0m0.004s

However, the actual time to just do "git log --raw $revs" is:

  real    0m0.333s
  user    0m0.292s
  sys     0m0.032s

which provides a lower-bound for how well we can do, as it is just doing
a single tree diff for each commit. So I think we have reaped most of
the benefits of this approach already (and we will generally have to do
_some_ true patch-id calculations, so we can never meet that lower
bound).

---
 diff.c      | 11 +++-------
 diff.h      |  3 ++-
 patch-ids.c | 39 ++++++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index 3b55788..161c5bf 100644
--- a/diff.c
+++ b/diff.c
@@ -4233,8 +4233,8 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 }
 
 /* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
-			     int loose)
+int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
+		      int loose)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -4330,21 +4330,16 @@ int diff_flush_patch_id(struct diff_options *options,
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options,
-			unsigned char *sha1,
-			int loose)
+void diff_queue_clear(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, sha1, loose);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
 
 	free(q->queue);
 	DIFF_QUEUE_CLEAR(q);
-
-	return result;
 }
 
 static int is_summary_empty(const struct diff_queue_struct *q)
diff --git a/diff.h b/diff.h
index b018aaf..7207d4b 100644
--- a/diff.h
+++ b/diff.h
@@ -320,7 +320,8 @@ extern int do_diff_cache(const unsigned char *, struct diff_options *);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
 extern int do_diff_cache(const unsigned char *, struct diff_options *);
-extern int diff_flush_patch_id(struct diff_options *, unsigned char *, int loose);
+extern int diff_get_patch_id(struct diff_options *, unsigned char *, int loose);
+extern void diff_queue_clear(void);
 
 extern int diff_result_code(struct diff_options *, int);
 
diff --git a/patch-ids.c b/patch-ids.c
index 3a83ee6..83cda92 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -4,8 +4,7 @@
 #include "sha1-lookup.h"
 #include "patch-ids.h"
 
-static int commit_patch_id(struct commit *commit, struct diff_options *options,
-			   unsigned char *sha1, int loose)
+static void start_patch_id(struct commit *commit, struct diff_options *options)
 {
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.sha1,
@@ -13,7 +12,6 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.sha1, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1, loose);
 }
 
 int init_patch_ids(struct patch_ids *ids)
@@ -50,12 +48,16 @@ static struct patch_id *add_commit(struct commit *commit,
 				   int no_add)
 {
 	struct patch_id *p;
-	unsigned char loose[20], strict[20];
+	unsigned char loose[20], strict[20] = {0};
 	unsigned long hash;
 	void **pos;
 
-	if (commit_patch_id(commit, &ids->diffopts, loose, 1))
+	start_patch_id(commit, &ids->diffopts);
+	if (diff_get_patch_id(&ids->diffopts, loose, 1)) {
+		diff_queue_clear();
 		return NULL;
+	}
+
 	hash = hash_sha1(loose);
 
 	p = lookup_hash(hash, &ids->table);
@@ -66,15 +68,24 @@ static struct patch_id *add_commit(struct commit *commit,
 
 		/*
 		 * We have a real loose match; lazily load and cache the strict
-		 * id to compare.
+		 * id to compare. We must do the "current" commit first, as its
+		 * incremental state is waiting in the diff machinery.
 		 */
+		if (is_null_sha1(strict)) {
+			int result = diff_get_patch_id(&ids->diffopts, strict, 0);
+			diff_queue_clear();
+			if (result)
+				return NULL;
+		}
+
 		if (is_null_sha1(p->strict)) {
-			if (commit_patch_id(p->commit, &ids->diffopts,
-					    p->strict, 0))
+			int result;
+			start_patch_id(p->commit, &ids->diffopts);
+			result = diff_get_patch_id(&ids->diffopts, p->strict, 0);
+			diff_queue_clear();
+			if (result)
 				return NULL;
 		}
-		if (commit_patch_id(commit, &ids->diffopts, strict, 0))
-			return NULL;
 
 		/*
 		 * If the strict ones match, we do not need to look farther;
@@ -85,6 +96,14 @@ static struct patch_id *add_commit(struct commit *commit,
 	}
 
 	/*
+	 * If we get here and have not filled in strict, then we do not need
+	 * to compute it (for now), but we must clean up the leftover diff
+	 * state.
+	 */
+	if (is_null_sha1(strict))
+		diff_queue_clear();
+
+	/*
 	 * Otherwise, we may have a loose but not strict match, or even no
 	 * loose match at all. Now we can add the new entry (or return failure
 	 * to look it up).
