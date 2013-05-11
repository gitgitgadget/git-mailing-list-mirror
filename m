From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] refactor "ref->merge" flag
Date: Sat, 11 May 2013 18:15:59 +0200
Message-ID: <20130511161558.GC3270@sigill.intra.peff.net>
References: <20130511161320.GA14990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCSu-0003Fr-Io
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab3EKQQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:16:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:58763 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219Ab3EKQQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:16:02 -0400
Received: (qmail 9302 invoked by uid 102); 11 May 2013 16:16:26 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 11:16:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 18:15:59 +0200
Content-Disposition: inline
In-Reply-To: <20130511161320.GA14990@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223979>

Each "struct ref" has a boolean flag that is set by the
fetch code to determine whether the ref should be marked as
"not-for-merge" or not when we write it out to FETCH_HEAD.

It would be useful to turn this boolean into a tri-state,
with the third state meaning "do not bother writing it out
to FETCH_HEAD at all". That would let us add extra refs to
the set of refs to be stored (e.g., to store copies of
things we fetched) without impacting FETCH_HEAD.

This patch turns it into an enum that covers the tri-state
case, and hopefully makes the code more explicit and easier
to read.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 57 +++++++++++++++++++++++++++++++++++----------------------
 cache.h         | 14 +++++++++++++-
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..287cf4c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -119,7 +119,7 @@ static void add_merge_config(struct ref **head,
 
 		for (rm = *head; rm; rm = rm->next) {
 			if (branch_merge_matches(branch, i, rm->name)) {
-				rm->merge = 1;
+				rm->fetch_head_status = FETCH_HEAD_MERGE;
 				break;
 			}
 		}
@@ -140,7 +140,7 @@ static void add_merge_config(struct ref **head,
 		refspec.src = branch->merge[i]->src;
 		get_fetch_map(remote_refs, &refspec, tail, 1);
 		for (rm = *old_tail; rm; rm = rm->next)
-			rm->merge = 1;
+			rm->fetch_head_status = FETCH_HEAD_MERGE;
 	}
 }
 
@@ -167,7 +167,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		}
 		/* Merge everything on the command line, but not --tags */
 		for (rm = ref_map; rm; rm = rm->next)
-			rm->merge = 1;
+			rm->fetch_head_status = FETCH_HEAD_MERGE;
 		if (tags == TAGS_SET)
 			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	} else {
@@ -186,7 +186,7 @@ static struct ref *get_ref_map(struct transport *transport,
 					*autotags = 1;
 				if (!i && !has_merge && ref_map &&
 				    !remote->fetch[0].pattern)
-					ref_map->merge = 1;
+					ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			}
 			/*
 			 * if the remote we're fetching from is the same
@@ -202,7 +202,7 @@ static struct ref *get_ref_map(struct transport *transport,
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
 				die(_("Couldn't find remote ref HEAD"));
-			ref_map->merge = 1;
+			ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			tail = &ref_map->next;
 		}
 	}
@@ -389,7 +389,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
-	int want_merge;
+	int want_status;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -407,19 +407,22 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	}
 
 	/*
-	 * The first pass writes objects to be merged and then the
-	 * second pass writes the rest, in order to allow using
-	 * FETCH_HEAD as a refname to refer to the ref to be merged.
+	 * We do a pass for each fetch_head_status type in their enum order, so
+	 * merged entries are written before not-for-merge. That lets readers
+	 * use FETCH_HEAD as a refname to refer to the ref to be merged.
 	 */
-	for (want_merge = 1; 0 <= want_merge; want_merge--) {
+	for (want_status = FETCH_HEAD_MERGE;
+	     want_status <= FETCH_HEAD_IGNORE;
+	     want_status++) {
 		for (rm = ref_map; rm; rm = rm->next) {
 			struct ref *ref = NULL;
+			const char *merge_status_marker = "";
 
 			commit = lookup_commit_reference_gently(rm->old_sha1, 1);
 			if (!commit)
-				rm->merge = 0;
+				rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
 
-			if (rm->merge != want_merge)
+			if (rm->fetch_head_status != want_status)
 				continue;
 
 			if (rm->peer_ref) {
@@ -465,16 +468,26 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 					strbuf_addf(&note, "%s ", kind);
 				strbuf_addf(&note, "'%s' of ", what);
 			}
-			fprintf(fp, "%s\t%s\t%s",
-				sha1_to_hex(rm->old_sha1),
-				rm->merge ? "" : "not-for-merge",
-				note.buf);
-			for (i = 0; i < url_len; ++i)
-				if ('\n' == url[i])
-					fputs("\\n", fp);
-				else
-					fputc(url[i], fp);
-			fputc('\n', fp);
+			switch (rm->fetch_head_status) {
+			case FETCH_HEAD_NOT_FOR_MERGE:
+				merge_status_marker = "not-for-merge";
+				/* fall-through */
+			case FETCH_HEAD_MERGE:
+				fprintf(fp, "%s\t%s\t%s",
+					sha1_to_hex(rm->old_sha1),
+					merge_status_marker,
+					note.buf);
+				for (i = 0; i < url_len; ++i)
+					if ('\n' == url[i])
+						fputs("\\n", fp);
+					else
+						fputc(url[i], fp);
+				fputc('\n', fp);
+				break;
+			default:
+				/* do not write anything to FETCH_HEAD */
+				break;
+			}
 
 			strbuf_reset(&note);
 			if (ref) {
diff --git a/cache.h b/cache.h
index 94ca1ac..9670d99 100644
--- a/cache.h
+++ b/cache.h
@@ -1024,9 +1024,21 @@ struct ref {
 	unsigned int
 		force:1,
 		forced_update:1,
-		merge:1,
 		deletion:1,
 		matched:1;
+
+	/*
+	 * Order is important here, as we write to FETCH_HEAD
+	 * in numeric order. And the default NOT_FOR_MERGE
+	 * should be 0, so that xcalloc'd structures get it
+	 * by default.
+	 */
+	enum {
+		FETCH_HEAD_MERGE = -1,
+		FETCH_HEAD_NOT_FOR_MERGE = 0,
+		FETCH_HEAD_IGNORE = 1
+	} fetch_head_status;
+
 	enum {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
-- 
1.8.3.rc1.2.g12db477
