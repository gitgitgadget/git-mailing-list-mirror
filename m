From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/86] remote*: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:05:57 +0100
Message-ID: <20131109070720.18178.98413.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2i0-0005uf-Fz
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933399Ab3KIHLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:40 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65329 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932938Ab3KIHIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id BF04040;
	Sat,  9 Nov 2013 08:08:20 +0100 (CET)
X-git-sha1: 74db95bffce2647660b84aff93dd22e84fcdd7c8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237539>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 remote-curl.c    | 14 +++++++-------
 remote-testsvn.c | 10 +++++-----
 remote.c         | 46 +++++++++++++++++++++++-----------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index b5ebe01..437b863 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -212,7 +212,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	free_discovery(last);
 
 	strbuf_addf(&buffer, "%sinfo/refs", url);
-	if ((!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) &&
+	if ((has_prefix(url, "http://") || has_prefix(url, "https://")) &&
 	     git_env_bool("GIT_SMART_HTTP", 1)) {
 		maybe_smart = 1;
 		if (!strchr(url, '?'))
@@ -740,7 +740,7 @@ static void parse_fetch(struct strbuf *buf)
 	int alloc_heads = 0, nr_heads = 0;
 
 	do {
-		if (!prefixcmp(buf->buf, "fetch ")) {
+		if (has_prefix(buf->buf, "fetch ")) {
 			char *p = buf->buf + strlen("fetch ");
 			char *name;
 			struct ref *ref;
@@ -863,7 +863,7 @@ static void parse_push(struct strbuf *buf)
 	int alloc_spec = 0, nr_spec = 0, i, ret;
 
 	do {
-		if (!prefixcmp(buf->buf, "push ")) {
+		if (has_prefix(buf->buf, "push ")) {
 			ALLOC_GROW(specs, nr_spec + 1, alloc_spec);
 			specs[nr_spec++] = xstrdup(buf->buf + 5);
 		}
@@ -928,19 +928,19 @@ int main(int argc, const char **argv)
 		}
 		if (buf.len == 0)
 			break;
-		if (!prefixcmp(buf.buf, "fetch ")) {
+		if (has_prefix(buf.buf, "fetch ")) {
 			if (nongit)
 				die("Fetch attempted without a local repo");
 			parse_fetch(&buf);
 
-		} else if (!strcmp(buf.buf, "list") || !prefixcmp(buf.buf, "list ")) {
+		} else if (!strcmp(buf.buf, "list") || has_prefix(buf.buf, "list ")) {
 			int for_push = !!strstr(buf.buf + 4, "for-push");
 			output_refs(get_refs(for_push));
 
-		} else if (!prefixcmp(buf.buf, "push ")) {
+		} else if (has_prefix(buf.buf, "push ")) {
 			parse_push(&buf);
 
-		} else if (!prefixcmp(buf.buf, "option ")) {
+		} else if (has_prefix(buf.buf, "option ")) {
 			char *name = buf.buf + strlen("option ");
 			char *value = strchr(name, ' ');
 			int result;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index d7cd5d2..7a5d4c8 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -82,7 +82,7 @@ static int parse_rev_note(const char *msg, struct rev_note *res)
 		len = end ? end - msg : strlen(msg);
 
 		key = "Revision-number: ";
-		if (!prefixcmp(msg, key)) {
+		if (has_prefix(msg, key)) {
 			long i;
 			char *end;
 			value = msg + strlen(key);
@@ -154,7 +154,7 @@ static void check_or_regenerate_marks(int latestrev)
 	} else {
 		strbuf_addf(&sb, ":%d ", latestrev);
 		while (strbuf_getline(&line, marksfile, '\n') != EOF) {
-			if (!prefixcmp(line.buf, sb.buf)) {
+			if (has_prefix(line.buf, sb.buf)) {
 				found++;
 				break;
 			}
@@ -264,7 +264,7 @@ static int do_command(struct strbuf *line)
 		return 1;	/* end of command stream, quit */
 	}
 	if (batch_cmd) {
-		if (prefixcmp(batch_cmd->name, line->buf))
+		if (!has_prefix(batch_cmd->name, line->buf))
 			die("Active %s batch interrupted by %s", batch_cmd->name, line->buf);
 		/* buffer batch lines */
 		string_list_append(&batchlines, line->buf);
@@ -272,7 +272,7 @@ static int do_command(struct strbuf *line)
 	}
 
 	for (p = input_command_list; p->name; p++) {
-		if (!prefixcmp(line->buf, p->name) && (strlen(p->name) == line->len ||
+		if (has_prefix(line->buf, p->name) && (strlen(p->name) == line->len ||
 				line->buf[strlen(p->name)] == ' ')) {
 			if (p->batchable) {
 				batch_cmd = p;
@@ -304,7 +304,7 @@ int main(int argc, char **argv)
 	remote = remote_get(argv[1]);
 	url_in = (argc == 3) ? argv[2] : remote->url[0];
 
-	if (!prefixcmp(url_in, "file://")) {
+	if (has_prefix(url_in, "file://")) {
 		dump_from_file = 1;
 		url = url_decode(url_in + sizeof("file://")-1);
 	} else {
diff --git a/remote.c b/remote.c
index e9fedfa..84c0d9f 100644
--- a/remote.c
+++ b/remote.c
@@ -76,7 +76,7 @@ static const char *alias_url(const char *url, struct rewrites *r)
 		if (!r->rewrite[i])
 			continue;
 		for (j = 0; j < r->rewrite[i]->instead_of_nr; j++) {
-			if (!prefixcmp(url, r->rewrite[i]->instead_of[j].s) &&
+			if (has_prefix(url, r->rewrite[i]->instead_of[j].s) &&
 			    (!longest ||
 			     longest->len < r->rewrite[i]->instead_of[j].len)) {
 				longest = &(r->rewrite[i]->instead_of[j]);
@@ -239,13 +239,13 @@ static void read_remotes_file(struct remote *remote)
 		int value_list;
 		char *s, *p;
 
-		if (!prefixcmp(buffer, "URL:")) {
+		if (has_prefix(buffer, "URL:")) {
 			value_list = 0;
 			s = buffer + 4;
-		} else if (!prefixcmp(buffer, "Push:")) {
+		} else if (has_prefix(buffer, "Push:")) {
 			value_list = 1;
 			s = buffer + 5;
-		} else if (!prefixcmp(buffer, "Pull:")) {
+		} else if (has_prefix(buffer, "Pull:")) {
 			value_list = 2;
 			s = buffer + 5;
 		} else
@@ -337,7 +337,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
-	if (!prefixcmp(key, "branch.")) {
+	if (has_prefix(key, "branch.")) {
 		name = key + 7;
 		subkey = strrchr(name, '.');
 		if (!subkey)
@@ -361,7 +361,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		}
 		return 0;
 	}
-	if (!prefixcmp(key, "url.")) {
+	if (has_prefix(key, "url.")) {
 		struct rewrite *rewrite;
 		name = key + 4;
 		subkey = strrchr(name, '.');
@@ -380,7 +380,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		}
 	}
 
-	if (prefixcmp(key,  "remote."))
+	if (!has_prefix(key,  "remote."))
 		return 0;
 	name = key + 7;
 
@@ -487,7 +487,7 @@ static void read_config(void)
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
-	    !prefixcmp(head_ref, "refs/heads/")) {
+	    has_prefix(head_ref, "refs/heads/")) {
 		current_branch =
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
@@ -982,8 +982,8 @@ static int count_refspec_match(const char *pattern,
 		 */
 		if (namelen != patlen &&
 		    patlen != namelen - 5 &&
-		    prefixcmp(name, "refs/heads/") &&
-		    prefixcmp(name, "refs/tags/")) {
+		    !has_prefix(name, "refs/heads/") &&
+		    !has_prefix(name, "refs/tags/")) {
 			/* We want to catch the case where only weak
 			 * matches are found and there are multiple
 			 * matches, and where more than one strong
@@ -1054,9 +1054,9 @@ static char *guess_ref(const char *name, struct ref *peer)
 	if (!r)
 		return NULL;
 
-	if (!prefixcmp(r, "refs/heads/"))
+	if (has_prefix(r, "refs/heads/"))
 		strbuf_addstr(&buf, "refs/heads/");
-	else if (!prefixcmp(r, "refs/tags/"))
+	else if (has_prefix(r, "refs/tags/"))
 		strbuf_addstr(&buf, "refs/tags/");
 	else
 		return NULL;
@@ -1104,7 +1104,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
-		     prefixcmp(dst_value, "refs/heads/")))
+		     !has_prefix(dst_value, "refs/heads/")))
 			die("%s cannot be resolved to branch.",
 			    matched_src->name);
 	}
@@ -1193,7 +1193,7 @@ static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref
 		 * including refs outside refs/heads/ hierarchy, but
 		 * that does not make much sense these days.
 		 */
-		if (!send_mirror && prefixcmp(ref->name, "refs/heads/"))
+		if (!send_mirror && !has_prefix(ref->name, "refs/heads/"))
 			return NULL;
 		name = xstrdup(ref->name);
 	}
@@ -1248,7 +1248,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			add_to_tips(&sent_tips, ref->peer_ref->new_sha1);
 		else
 			add_to_tips(&sent_tips, ref->old_sha1);
-		if (!prefixcmp(ref->name, "refs/tags/"))
+		if (has_prefix(ref->name, "refs/tags/"))
 			string_list_append(&dst_tag, ref->name);
 	}
 	clear_commit_marks_many(sent_tips.nr, sent_tips.tip, TMP_MARK);
@@ -1257,7 +1257,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 
 	/* Collect tags they do not have. */
 	for (ref = src; ref; ref = ref->next) {
-		if (prefixcmp(ref->name, "refs/tags/"))
+		if (!has_prefix(ref->name, "refs/tags/"))
 			continue; /* not a tag */
 		if (string_list_has_string(&dst_tag, ref->name))
 			continue; /* they already have it */
@@ -1481,7 +1481,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 */
 
 		else if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
-			if (!prefixcmp(ref->name, "refs/tags/"))
+			if (has_prefix(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
 			else if (!has_sha1_file(ref->old_sha1))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
@@ -1607,12 +1607,12 @@ static struct ref *get_local_ref(const char *name)
 	if (!name || name[0] == '\0')
 		return NULL;
 
-	if (!prefixcmp(name, "refs/"))
+	if (has_prefix(name, "refs/"))
 		return alloc_ref(name);
 
-	if (!prefixcmp(name, "heads/") ||
-	    !prefixcmp(name, "tags/") ||
-	    !prefixcmp(name, "remotes/"))
+	if (has_prefix(name, "heads/") ||
+	    has_prefix(name, "tags/") ||
+	    has_prefix(name, "remotes/"))
 		return alloc_ref_with_prefix("refs/", 5, name);
 
 	return alloc_ref_with_prefix("refs/heads/", 11, name);
@@ -1647,7 +1647,7 @@ int get_fetch_map(const struct ref *remote_refs,
 
 	for (rmp = &ref_map; *rmp; ) {
 		if ((*rmp)->peer_ref) {
-			if (prefixcmp((*rmp)->peer_ref->name, "refs/") ||
+			if (!has_prefix((*rmp)->peer_ref->name, "refs/") ||
 			    check_refname_format((*rmp)->peer_ref->name, 0)) {
 				struct ref *ignore = *rmp;
 				error("* Ignoring funny ref '%s' locally",
@@ -1931,7 +1931,7 @@ struct ref *guess_remote_head(const struct ref *head,
 	/* Look for another ref that points there */
 	for (r = refs; r; r = r->next) {
 		if (r != head &&
-		    !prefixcmp(r->name, "refs/heads/") &&
+		    has_prefix(r->name, "refs/heads/") &&
 		    !hashcmp(r->old_sha1, head->old_sha1)) {
 			*tail = copy_ref(r);
 			tail = &((*tail)->next);
-- 
1.8.4.1.566.geca833c
