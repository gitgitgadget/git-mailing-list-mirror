From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] remote: refactor guess_remote_head
Date: Sun, 15 Feb 2009 01:16:51 -0500
Message-ID: <20090215061651.GD30414@coredump.intra.peff.net>
References: <20090215060815.GA7473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 07:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYaKc-0005wM-LG
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 07:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbZBOGQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 01:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbZBOGQy
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 01:16:54 -0500
Received: from peff.net ([208.65.91.99]:41106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbZBOGQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 01:16:53 -0500
Received: (qmail 5439 invoked by uid 107); 15 Feb 2009 06:17:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 01:17:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 01:16:51 -0500
Content-Disposition: inline
In-Reply-To: <20090215060815.GA7473@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109969>

This function had a lot of complications which made it hard
to read and extend, and confusing to call (because of
optional unused parameters). This patch attempts to address
that:

  - we used to manually search through the ref lists; this
    should be a one-line call to find_ref_by_name

  - guess_remote_head used to do two things: find the HEAD
    ref, and then find a matching ref. And only one of the
    two callers actually cared about returning the HEAD ref.
    Since it's a one-liner, just have the caller do it
    themselves (and remember it or not as they wish).

  - there were two ways of getting results out of the
    function (a return value, and an "all_matched" out
    parameter), but no caller cared about both. One of them
    returned a pointer into the passed-in ref list and one
    of them returned a newly allocated list (with the
    peer_ref fields stripped). Let's be simple and
    consistent: the return value is always a ref copy with
    a valid peer_ref. If "all" is requested, all candidates
    are returned. Otherwise, the best candidate is returned.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff is horrible to read, and would look much better as a whole
function replacement. It would make a great test case for a "short lines
are uninteresting" diff feature.

 builtin-clone.c  |    5 +--
 builtin-remote.c |    5 ++-
 remote.c         |   62 ++++++++++++++++++++++-------------------------------
 remote.h         |   17 ++++++--------
 4 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index d57818c..7130cab 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -508,9 +508,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		clear_extra_refs();
 
 		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
-
-		head_points_at = guess_remote_head(refs, mapped_refs,
-						   &remote_head, NULL);
+		remote_head = find_ref_by_name(refs, "HEAD");
+		head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/builtin-remote.c b/builtin-remote.c
index 608c0f3..d6958d4 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -275,7 +275,7 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 static int get_head_names(const struct ref *refs,
 	const char *remote_name, struct ref_states *states)
 {
-	struct ref *ref, *matches = NULL;
+	struct ref *ref, *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
 	struct refspec refspec;
 
@@ -284,7 +284,8 @@ static int get_head_names(const struct ref *refs,
 	refspec.src = refspec.dst = "refs/heads/";
 	states->heads.strdup_strings = 1;
 	get_fetch_map(refs, &refspec, &fetch_map_tail, 0);
-	guess_remote_head(refs, fetch_map, NULL, &matches);
+	matches = guess_remote_head(find_ref_by_name(refs, "HEAD"),
+					fetch_map, 1);
 	for(ref = matches; ref; ref = ref->next)
 		string_list_append(abbrev_branch(ref->name), &states->heads);
 
diff --git a/remote.c b/remote.c
index 6385a22..7ba1bff 100644
--- a/remote.c
+++ b/remote.c
@@ -1377,51 +1377,41 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	return 1;
 }
 
-const struct ref *guess_remote_head(const struct ref *refs,
-				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p,
-				    struct ref **all_matches_p)
+struct ref *copy_ref_with_peer(const struct ref *src)
 {
-	const struct ref *remote_head = NULL;
-	const struct ref *remote_master = NULL;
-	const struct ref *ret = NULL;
-	const struct ref *r;
-	struct ref **tail = all_matches_p;
-
-	for (r = refs; r; r = r->next)
-		if (!strcmp(r->name, "HEAD"))
-			remote_head = r;
-
-	if (!all_matches_p)
-		for (r = mapped_refs; r; r = r->next)
-			if (!strcmp(r->name, "refs/heads/master"))
-				remote_master = r;
+	struct ref *dst = copy_ref(src);
+	dst->peer_ref = copy_ref(src->peer_ref);
+	return dst;
+}
 
-	if (remote_head_p)
-		*remote_head_p = remote_head;
+struct ref *guess_remote_head(const struct ref *head,
+			      const struct ref *refs,
+			      int all)
+{
+	const struct ref *r;
+	struct ref *list = NULL;
+	struct ref **tail = &list;
 
-	/* If there's no HEAD value at all, never mind. */
-	if (!remote_head)
+	if (!head)
 		return NULL;
 
 	/* If refs/heads/master could be right, it is. */
-	if (remote_master && !hashcmp(remote_master->old_sha1,
-				      remote_head->old_sha1))
-		return remote_master;
+	if (!all) {
+		const struct ref *m;
+		m = find_ref_by_name(refs, "refs/heads/master");
+		if (m && !hashcmp(m->old_sha1, head->old_sha1))
+			return copy_ref_with_peer(m);
+	}
 
 	/* Look for another ref that points there */
-	for (r = mapped_refs; r; r = r->next)
-		if (r != remote_head &&
-		    !hashcmp(r->old_sha1, remote_head->old_sha1)) {
-			struct ref *cpy;
-			if (!ret)
-				ret = r;
-			if (!all_matches_p)
+	for (r = refs; r; r = r->next) {
+		if (r != head && !hashcmp(r->old_sha1, head->old_sha1)) {
+			*tail = copy_ref_with_peer(r);
+			tail = &((*tail)->next);
+			if (!all)
 				break;
-			*tail = cpy = copy_ref(r);
-			cpy->peer_ref = NULL;
-			tail = &cpy->next;
 		}
+	}
 
-	return ret;
+	return list;
 }
diff --git a/remote.h b/remote.h
index 8409d42..111c4ba 100644
--- a/remote.h
+++ b/remote.h
@@ -138,16 +138,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 /*
- * Look in refs for HEAD. Then look for a matching SHA1 in mapped_refs,
- * first checking if refs/heads/master matches. Return NULL if nothing matches
- * or if there is no HEAD in refs. remote_head_p is assigned HEAD if not NULL.
- * If all_matches_p is NULL, return after the first possible match. Otherwise
- * all_matches_p is set to a ref list of each branch head with the same SHA1 as
- * HEAD.
+ * Find refs from a list which are likely to be pointed to by the given HEAD
+ * ref. If 'all' is false, returns the most likely ref; otherwise, returns a
+ * list of all candidate refs. If no match is found (or 'head' is NULL),
+ * returns NULL. All returns are newly allocated and should be freed.
  */
-const struct ref *guess_remote_head(const struct ref *refs,
-				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p,
-				    struct ref **all_matches_p);
+struct ref *guess_remote_head(const struct ref *head,
+			      const struct ref *refs,
+			      int all);
 
 #endif
-- 
1.6.2.rc0.256.gf004c.dirty
