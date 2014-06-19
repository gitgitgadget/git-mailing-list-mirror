From: Jeff King <peff@peff.net>
Subject: [PATCH v2 04/10] use xstrfmt to replace xmalloc + sprintf
Date: Thu, 19 Jun 2014 17:24:33 -0400
Message-ID: <20140619212433.GD28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:24:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxjp2-0004rV-2K
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965552AbaFSVYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:24:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:47781 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964831AbaFSVYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:24:35 -0400
Received: (qmail 16855 invoked by uid 102); 19 Jun 2014 21:24:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:24:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:24:33 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252187>

This is one line shorter, and makes sure the length in the
malloc and sprintf steps match.

These conversions are very straightforward; we can drop the
malloc entirely, and replace the sprintf with xstrfmt.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a note on one thing I would look for as a reviewer:

  In theory this could introduce a time-of-use error (either we xstrfmt
  at the malloc, in which case the arguments to format might not be
  ready yet, or we xstrfmt where the old sprintf was, in which case the
  pointer is uninitialized earlier). In practice, this is not an issue.
  The two are almost always right next to each other. And even when they
  are not, the xmalloc already runs strlen() on the arguments, so it
  should be safe to do xstrfmt there, too. I.e., if there is a bug, it
  was already there. :)

 builtin/fmt-merge-msg.c |  7 ++-----
 builtin/show-branch.c   | 10 ++++------
 http-push.c             | 18 +++++-------------
 http-walker.c           |  3 +--
 match-trees.c           |  9 ++-------
 merge-recursive.c       | 12 ++++--------
 6 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..c462e19 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -178,11 +178,8 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 		int len = strlen(origin);
 		if (origin[0] == '\'' && origin[len - 1] == '\'')
 			origin = xmemdupz(origin + 1, len - 2);
-	} else {
-		char *new_origin = xmalloc(strlen(origin) + strlen(src) + 5);
-		sprintf(new_origin, "%s of %s", origin, src);
-		origin = new_origin;
-	}
+	} else
+		origin = xstrfmt("%s of %s", origin, src);
 	if (strcmp(".", src))
 		origin_data->is_local_branch = 0;
 	string_list_append(&origins, origin)->util = origin_data;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d873172..5fd4e4e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -755,7 +755,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 
 		for (i = 0; i < reflog; i++) {
-			char *logmsg, *m;
+			char *logmsg;
 			const char *msg;
 			unsigned long timestamp;
 			int tz;
@@ -770,11 +770,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				msg = "(none)";
 			else
 				msg++;
-			m = xmalloc(strlen(msg) + 200);
-			sprintf(m, "(%s) %s",
-				show_date(timestamp, tz, 1),
-				msg);
-			reflog_msg[i] = m;
+			reflog_msg[i] = xstrfmt("(%s) %s",
+						show_date(timestamp, tz, 1),
+						msg);
 			free(logmsg);
 			sprintf(nth_desc, "%s@{%d}", *av, base+i);
 			append_ref(nth_desc, sha1, 1);
diff --git a/http-push.c b/http-push.c
index 95650a0..390f74c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -854,8 +854,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	struct xml_ctx ctx;
 	char *escaped;
 
-	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
-	sprintf(url, "%s%s", repo->url, path);
+	url = xstrfmt("%s%s", repo->url, path);
 
 	/* Make sure leading directories exist for the remote ref */
 	ep = strchr(url + strlen(repo->url) + 1, '/');
@@ -1115,7 +1114,7 @@ static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData)
 {
-	char *url = xmalloc(strlen(repo->url) + strlen(path) + 1);
+	char *url = xstrfmt("%s%s", repo->url, path);
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
@@ -1131,8 +1130,6 @@ static void remote_ls(const char *path, int flags,
 	ls.userData = userData;
 	ls.userFunc = userFunc;
 
-	sprintf(url, "%s%s", repo->url, path);
-
 	strbuf_addf(&out_buffer.buf, PROPFIND_ALL_REQUEST);
 
 	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
@@ -1534,10 +1531,9 @@ static void update_remote_info_refs(struct remote_lock *lock)
 
 static int remote_exists(const char *path)
 {
-	char *url = xmalloc(strlen(repo->url) + strlen(path) + 1);
+	char *url = xstrfmt("%s%s", repo->url, path);
 	int ret;
 
-	sprintf(url, "%s%s", repo->url, path);
 
 	switch (http_get_strbuf(url, NULL, NULL)) {
 	case HTTP_OK:
@@ -1557,12 +1553,9 @@ static int remote_exists(const char *path)
 
 static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 {
-	char *url;
+	char *url = xstrfmt("%s%s", repo->url, path);
 	struct strbuf buffer = STRBUF_INIT;
 
-	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
-	sprintf(url, "%s%s", repo->url, path);
-
 	if (http_get_strbuf(url, &buffer, NULL) != HTTP_OK)
 		die("Couldn't get %s for remote symref\n%s", url,
 		    curl_errorstr);
@@ -1671,8 +1664,7 @@ static int delete_remote_branch(const char *pattern, int force)
 	fprintf(stderr, "Removing remote branch '%s'\n", remote_ref->name);
 	if (dry_run)
 		return 0;
-	url = xmalloc(strlen(repo->url) + strlen(remote_ref->name) + 1);
-	sprintf(url, "%s%s", repo->url, remote_ref->name);
+	url = xstrfmt("%s%s", repo->url, remote_ref->name);
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_setup_http_get(slot->curl, url, DAV_DELETE);
diff --git a/http-walker.c b/http-walker.c
index ab6a4fe..dbddfaa 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -341,8 +341,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting alternates list for %s\n", base);
 
-	url = xmalloc(strlen(base) + 31);
-	sprintf(url, "%s/objects/info/http-alternates", base);
+	url = xstrfmt("%s/objects/info/http-alternates", base);
 
 	/*
 	 * Use a callback to process the result, since another request
diff --git a/match-trees.c b/match-trees.c
index e80b4af..1ce0954 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -140,17 +140,12 @@ static void match_trees(const unsigned char *hash1,
 			goto next;
 		score = score_trees(elem, hash2);
 		if (*best_score < score) {
-			char *newpath;
-			newpath = xmalloc(strlen(base) + strlen(path) + 1);
-			sprintf(newpath, "%s%s", base, path);
 			free(*best_match);
-			*best_match = newpath;
+			*best_match = xstrfmt("%s%s", base, path);
 			*best_score = score;
 		}
 		if (recurse_limit) {
-			char *newbase;
-			newbase = xmalloc(strlen(base) + strlen(path) + 2);
-			sprintf(newbase, "%s%s/", base, path);
+			char *newbase = xstrfmt("%s%s/", base, path);
 			match_trees(elem, hash2, best_score, best_match,
 				    newbase, recurse_limit - 1);
 			free(newbase);
diff --git a/merge-recursive.c b/merge-recursive.c
index cab16fa..532a1da 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -969,14 +969,10 @@ merge_file_special_markers(struct merge_options *o,
 	char *side2 = NULL;
 	struct merge_file_info mfi;
 
-	if (filename1) {
-		side1 = xmalloc(strlen(branch1) + strlen(filename1) + 2);
-		sprintf(side1, "%s:%s", branch1, filename1);
-	}
-	if (filename2) {
-		side2 = xmalloc(strlen(branch2) + strlen(filename2) + 2);
-		sprintf(side2, "%s:%s", branch2, filename2);
-	}
+	if (filename1)
+		side1 = xstrfmt("%s:%s", branch1, filename1);
+	if (filename2)
+		side2 = xstrfmt("%s:%s", branch2, filename2);
 
 	mfi = merge_file_1(o, one, a, b,
 			   side1 ? side1 : branch1, side2 ? side2 : branch2);
-- 
2.0.0.566.gfe3e6b2
