From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 22/23] remote: refactor guess_remote_head
Date: Tue, 24 Feb 2009 04:51:10 -0500
Message-ID: <9fcb7dbd8ec6fbed4701098a2fecc5728521dbc7.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu05-0002Ej-Iz
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbZBXJwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbZBXJwO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:14 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:58685 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbZBXJwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:52:12 -0500
Received: by mail-gx0-f174.google.com with SMTP id 22so6475210gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9850Cx6BFKd74S+GKrGX/SxPT7zTkdMMVlYwvO4C6e8=;
        b=WhSCMySB7jlkExnqPnelXp2fvmQAsCCh3eGqVehtac82dJxmJCRoruHf20qMXV4B2X
         /2pTl15whs0S2IrwZRwmDkcFZFFgfLtuR4PhLbZ2b0G28z1YouH9ldfAi6xD7UsMJ+Ni
         exkibhXV2KzyjB4mf3hl+sZxB8kOzBCqA/p6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B4bq1JWsDeDqrsYL2SD5/rlvYXDH5Lym+Rs61vnXQDNIWYV53VdRihNHxnPdDmiqWa
         qI70SRYUO6IH/+TXwZoJrzgQXzq8ViRtOPerTJR3HqYZuT5jt7CbOCllSrw3Uue3BW1D
         oRJOhGfXDM2UVGf4pEqk/HMicgB1ZUKZfMIxY=
Received: by 10.100.242.20 with SMTP id p20mr4736268anh.88.1235469130467;
        Tue, 24 Feb 2009 01:52:10 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c14sm6218282ana.1.2009.02.24.01.52.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:52:09 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111269>

From: Jeff King <peff@peff.net>

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
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
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
index 80ab7af..d5a575f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -385,7 +385,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 static int get_head_names(const struct ref *remote_refs,
 	const char *remote_name, struct ref_states *states)
 {
-	struct ref *ref, *matches = NULL;
+	struct ref *ref, *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
 	struct refspec refspec;
 
@@ -394,7 +394,8 @@ static int get_head_names(const struct ref *remote_refs,
 	refspec.src = refspec.dst = "refs/heads/";
 	states->heads.strdup_strings = 1;
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
-	guess_remote_head(remote_refs, fetch_map, NULL, &matches);
+	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
+					fetch_map, 1);
 	for(ref = matches; ref; ref = ref->next)
 		string_list_append(abbrev_branch(ref->name), &states->heads);
 
diff --git a/remote.c b/remote.c
index f07ecf4..96d5c95 100644
--- a/remote.c
+++ b/remote.c
@@ -1431,53 +1431,43 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
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
 
 static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
diff --git a/remote.h b/remote.h
index 1f78a0a..903712f 100644
--- a/remote.h
+++ b/remote.h
@@ -139,17 +139,14 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
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
 
 struct ref *get_local_heads(void);
 #endif
-- 
1.6.2.rc1.291.g83eb
