From: Jeff King <peff@peff.net>
Subject: [PATCH 12/15] use get_commit_buffer everywhere
Date: Mon, 9 Jun 2014 14:13:23 -0400
Message-ID: <20140609181323.GL20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:13:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu44d-0000Ps-PI
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbaFISNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:13:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:40396 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754320AbaFISNY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:13:24 -0400
Received: (qmail 15989 invoked by uid 102); 9 Jun 2014 18:13:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:13:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:13:23 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251098>

Each of these sites assumes that commit->buffer is valid.
Since they would segfault if this was not the case, they are
likely to be correct in practice. However, we can
future-proof them by using get_commit_buffer.

And as a side effect, we abstract away the final bare uses
of commit->buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c   |  5 ++++-
 builtin/fmt-merge-msg.c |  5 ++++-
 builtin/log.c           |  7 +++++--
 fsck.c                  | 13 +++++++++++--
 merge-recursive.c       |  4 +++-
 notes-merge.c           |  4 +++-
 sequencer.c             |  4 +++-
 7 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b8d8a3a..7ee5e08 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -279,6 +279,7 @@ static const char *find_encoding(const char *begin, const char *end)
 static void handle_commit(struct commit *commit, struct rev_info *rev)
 {
 	int saved_output_format = rev->diffopt.output_format;
+	const char *commit_buffer;
 	const char *author, *author_end, *committer, *committer_end;
 	const char *encoding, *message;
 	char *reencoded = NULL;
@@ -288,7 +289,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
 
 	parse_commit_or_die(commit);
-	author = strstr(commit->buffer, "\nauthor ");
+	commit_buffer = get_commit_buffer(commit);
+	author = strstr(commit_buffer, "\nauthor ");
 	if (!author)
 		die ("Could not find author in commit %s",
 		     sha1_to_hex(commit->object.sha1));
@@ -335,6 +337,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 			  ? strlen(message) : 0),
 	       reencoded ? reencoded : message ? message : "");
 	free(reencoded);
+	unuse_commit_buffer(commit, commit_buffer);
 
 	for (i = 0, p = commit->parents; p; p = p->next) {
 		int mark = get_object_mark(&p->item->object);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..01f6d59 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -230,12 +230,14 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 static void record_person(int which, struct string_list *people,
 			  struct commit *commit)
 {
+	const char *buffer;
 	char *name_buf, *name, *name_end;
 	struct string_list_item *elem;
 	const char *field;
 
 	field = (which == 'a') ? "\nauthor " : "\ncommitter ";
-	name = strstr(commit->buffer, field);
+	buffer = get_commit_buffer(commit);
+	name = strstr(buffer, field);
 	if (!name)
 		return;
 	name += strlen(field);
@@ -247,6 +249,7 @@ static void record_person(int which, struct string_list *people,
 	if (name_end < name)
 		return;
 	name_buf = xmemdupz(name, name_end - name + 1);
+	unuse_commit_buffer(commit, buffer);
 
 	elem = string_list_lookup(people, name_buf);
 	if (!elem) {
diff --git a/builtin/log.c b/builtin/log.c
index 226f8f2..2c74260 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -918,9 +918,12 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
 				&need_8bit_cte);
 
-	for (i = 0; !need_8bit_cte && i < nr; i++)
-		if (has_non_ascii(list[i]->buffer))
+	for (i = 0; !need_8bit_cte && i < nr; i++) {
+		const char *buf = get_commit_buffer(list[i]);
+		if (has_non_ascii(buf))
 			need_8bit_cte = 1;
+		unuse_commit_buffer(list[i], buf);
+	}
 
 	if (!branch_name)
 		branch_name = find_branch_name(rev);
diff --git a/fsck.c b/fsck.c
index abed62b..8223780 100644
--- a/fsck.c
+++ b/fsck.c
@@ -276,9 +276,10 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 	return 0;
 }
 
-static int fsck_commit(struct commit *commit, fsck_error error_func)
+static int fsck_commit_buffer(struct commit *commit, const char *buffer,
+			      fsck_error error_func)
 {
-	const char *buffer = commit->buffer, *tmp;
+	const char *tmp;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
@@ -336,6 +337,14 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	return 0;
 }
 
+static int fsck_commit(struct commit *commit, fsck_error error_func)
+{
+	const char *buffer = get_commit_buffer(commit);
+	int ret = fsck_commit_buffer(commit, buffer, error_func);
+	unuse_commit_buffer(commit, buffer);
+	return ret;
+}
+
 static int fsck_tag(struct tag *tag, fsck_error error_func)
 {
 	struct object *tagged = tag->tagged;
diff --git a/merge-recursive.c b/merge-recursive.c
index 2b37d42..0dd6039 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -190,9 +190,11 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 			printf(_("(bad commit)\n"));
 		else {
 			const char *title;
-			int len = find_commit_subject(commit->buffer, &title);
+			const char *msg = get_commit_buffer(commit);
+			int len = find_commit_subject(msg, &title);
 			if (len)
 				printf("%.*s\n", len, title);
+			unuse_commit_buffer(commit, msg);
 		}
 	}
 }
diff --git a/notes-merge.c b/notes-merge.c
index 94a1a8a..7885ab2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -671,7 +671,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 	DIR *dir;
 	struct dirent *e;
 	struct strbuf path = STRBUF_INIT;
-	char *msg = strstr(partial_commit->buffer, "\n\n");
+	const char *buffer = get_commit_buffer(partial_commit);
+	const char *msg = strstr(buffer, "\n\n");
 	struct strbuf sb_msg = STRBUF_INIT;
 	int baselen;
 
@@ -720,6 +721,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	}
 
 	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
+	unuse_commit_buffer(partial_commit, buffer);
 	create_notes_commit(partial_tree, partial_commit->parents, &sb_msg,
 			    result_sha1);
 	if (o->verbosity >= 4)
diff --git a/sequencer.c b/sequencer.c
index 4632f7d..5609ab3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -666,10 +666,12 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	int subject_len;
 
 	for (cur = todo_list; cur; cur = cur->next) {
+		const char *commit_buffer = get_commit_buffer(cur->item);
 		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		subject_len = find_commit_subject(cur->item->buffer, &subject);
+		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
 			subject_len, subject);
+		unuse_commit_buffer(cur->item, commit_buffer);
 	}
 	return 0;
 }
-- 
2.0.0.729.g520999f
