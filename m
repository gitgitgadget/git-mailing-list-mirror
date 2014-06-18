From: Jeff King <peff@peff.net>
Subject: [PATCH 10/16] fast-import: use skip_prefix for parsing input
Date: Wed, 18 Jun 2014 15:49:12 -0400
Message-ID: <20140618194912.GJ22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLrD-0004ne-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbaFRTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:49:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:46956 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754590AbaFRTtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:49:14 -0400
Received: (qmail 30363 invoked by uid 102); 18 Jun 2014 19:49:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:49:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:49:12 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252042>

Fast-import does a lot of parsing of commands and
dispatching to sub-functions. For example, given "option
foo", we might recognize "option " using starts_with, and
then hand it off to parse_option() to do the rest.

However, we do not let parse_option know that we have parsed
the first part already. It gets the full buffer, and has to
skip past the uninteresting bits. Some functions simply add
a magic constant:

  char *option = command_buf.buf + 7;

Others use strlen:

  char *option = command_buf.buf + strlen("option ");

And others use strchr:

  char *option = strchr(command_buf.buf, ' ') + 1;

All of these are brittle and easy to get wrong (especially
given that the starts_with call and the code that assumes
the presence of the prefix are far apart). Instead, we can
use skip_prefix, and just pass each handler a pointer to its
arguments.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 125 +++++++++++++++++++++++++---------------------------------
 1 file changed, 53 insertions(+), 72 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a3ffe30..5f17adb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -371,8 +371,8 @@ static volatile sig_atomic_t checkpoint_requested;
 static int cat_blob_fd = STDOUT_FILENO;
 
 static void parse_argv(void);
-static void parse_cat_blob(void);
-static void parse_ls(struct branch *b);
+static void parse_cat_blob(const char *p);
+static void parse_ls(const char *p, struct branch *b);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1861,6 +1861,8 @@ static int read_next_command(void)
 	}
 
 	for (;;) {
+		const char *p;
+
 		if (unread_command_buf) {
 			unread_command_buf = 0;
 		} else {
@@ -1893,8 +1895,8 @@ static int read_next_command(void)
 			rc->prev->next = rc;
 			cmd_tail = rc;
 		}
-		if (starts_with(command_buf.buf, "cat-blob ")) {
-			parse_cat_blob();
+		if (skip_prefix(command_buf.buf, "cat-blob ", &p)) {
+			parse_cat_blob(p);
 			continue;
 		}
 		if (command_buf.buf[0] == '#')
@@ -2273,9 +2275,8 @@ static uintmax_t parse_mark_ref_space(const char **p)
 	return mark;
 }
 
-static void file_change_m(struct branch *b)
+static void file_change_m(const char *p, struct branch *b)
 {
-	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
 	struct object_entry *oe;
@@ -2376,9 +2377,8 @@ static void file_change_m(struct branch *b)
 	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);
 }
 
-static void file_change_d(struct branch *b)
+static void file_change_d(const char *p, struct branch *b)
 {
-	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
 
@@ -2391,15 +2391,14 @@ static void file_change_d(struct branch *b)
 	tree_content_remove(&b->branch_tree, p, NULL, 1);
 }
 
-static void file_change_cr(struct branch *b, int rename)
+static void file_change_cr(const char *s, struct branch *b, int rename)
 {
-	const char *s, *d;
+	const char *d;
 	static struct strbuf s_uq = STRBUF_INIT;
 	static struct strbuf d_uq = STRBUF_INIT;
 	const char *endp;
 	struct tree_entry leaf;
 
-	s = command_buf.buf + 2;
 	strbuf_reset(&s_uq);
 	if (!unquote_c_style(&s_uq, s, &endp)) {
 		if (*endp != ' ')
@@ -2444,9 +2443,8 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.tree);
 }
 
-static void note_change_n(struct branch *b, unsigned char *old_fanout)
+static void note_change_n(const char *p, struct branch *b, unsigned char *old_fanout)
 {
-	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	struct object_entry *oe;
 	struct branch *s;
@@ -2587,7 +2585,7 @@ static int parse_from(struct branch *b)
 	const char *from;
 	struct branch *s;
 
-	if (!starts_with(command_buf.buf, "from "))
+	if (!skip_prefix(command_buf.buf, "from ", &from))
 		return 0;
 
 	if (b->branch_tree.tree) {
@@ -2595,7 +2593,6 @@ static int parse_from(struct branch *b)
 		b->branch_tree.tree = NULL;
 	}
 
-	from = strchr(command_buf.buf, ' ') + 1;
 	s = lookup_branch(from);
 	if (b == s)
 		die("Can't create a branch from itself: %s", b->name);
@@ -2636,8 +2633,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 	struct branch *s;
 
 	*count = 0;
-	while (starts_with(command_buf.buf, "merge ")) {
-		from = strchr(command_buf.buf, ' ') + 1;
+	while (skip_prefix(command_buf.buf, "merge ", &from)) {
 		n = xmalloc(sizeof(*n));
 		s = lookup_branch(from);
 		if (s)
@@ -2668,11 +2664,10 @@ static struct hash_list *parse_merge(unsigned int *count)
 	return list;
 }
 
-static void parse_new_commit(void)
+static void parse_new_commit(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
 	struct branch *b;
-	char *sp;
 	char *author = NULL;
 	char *committer = NULL;
 	struct hash_list *merge_list = NULL;
@@ -2680,11 +2675,9 @@ static void parse_new_commit(void)
 	unsigned char prev_fanout, new_fanout;
 	const char *v;
 
-	/* Obtain the branch name from the rest of our command */
-	sp = strchr(command_buf.buf, ' ') + 1;
-	b = lookup_branch(sp);
+	b = lookup_branch(arg);
 	if (!b)
-		b = new_branch(sp);
+		b = new_branch(arg);
 
 	read_next_command();
 	parse_mark();
@@ -2713,20 +2706,22 @@ static void parse_new_commit(void)
 
 	/* file_change* */
 	while (command_buf.len > 0) {
-		if (starts_with(command_buf.buf, "M "))
-			file_change_m(b);
-		else if (starts_with(command_buf.buf, "D "))
-			file_change_d(b);
-		else if (starts_with(command_buf.buf, "R "))
-			file_change_cr(b, 1);
-		else if (starts_with(command_buf.buf, "C "))
-			file_change_cr(b, 0);
-		else if (starts_with(command_buf.buf, "N "))
-			note_change_n(b, &prev_fanout);
+		const char *v;
+
+		if (skip_prefix(command_buf.buf, "M ", &v))
+			file_change_m(v, b);
+		else if (skip_prefix(command_buf.buf, "D ", &v))
+			file_change_d(v, b);
+		else if (skip_prefix(command_buf.buf, "R ", &v))
+			file_change_cr(v, b, 1);
+		else if (skip_prefix(command_buf.buf, "C ", &v))
+			file_change_cr(v, b, 0);
+		else if (skip_prefix(command_buf.buf, "N ", &v))
+			note_change_n(v, b, &prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
-		else if (starts_with(command_buf.buf, "ls "))
-			parse_ls(b);
+		else if (skip_prefix(command_buf.buf, "ls ", &v))
+			parse_ls(v, b);
 		else {
 			unread_command_buf = 1;
 			break;
@@ -2769,10 +2764,9 @@ static void parse_new_commit(void)
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
-static void parse_new_tag(void)
+static void parse_new_tag(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
-	char *sp;
 	const char *from;
 	char *tagger;
 	struct branch *s;
@@ -2782,11 +2776,9 @@ static void parse_new_tag(void)
 	enum object_type type;
 	const char *v;
 
-	/* Obtain the new tag name from the rest of our command */
-	sp = strchr(command_buf.buf, ' ') + 1;
 	t = pool_alloc(sizeof(struct tag));
 	memset(t, 0, sizeof(struct tag));
-	t->name = pool_strdup(sp);
+	t->name = pool_strdup(arg);
 	if (last_tag)
 		last_tag->next_tag = t;
 	else
@@ -2795,9 +2787,8 @@ static void parse_new_tag(void)
 	read_next_command();
 
 	/* from ... */
-	if (!starts_with(command_buf.buf, "from "))
+	if (!skip_prefix(command_buf.buf, "from ", &from))
 		die("Expected from command, got %s", command_buf.buf);
-	from = strchr(command_buf.buf, ' ') + 1;
 	s = lookup_branch(from);
 	if (s) {
 		if (is_null_sha1(s->sha1))
@@ -2853,14 +2844,11 @@ static void parse_new_tag(void)
 		t->pack_id = pack_id;
 }
 
-static void parse_reset_branch(void)
+static void parse_reset_branch(const char *arg)
 {
 	struct branch *b;
-	char *sp;
 
-	/* Obtain the branch name from the rest of our command */
-	sp = strchr(command_buf.buf, ' ') + 1;
-	b = lookup_branch(sp);
+	b = lookup_branch(arg);
 	if (b) {
 		hashclr(b->sha1);
 		hashclr(b->branch_tree.versions[0].sha1);
@@ -2871,7 +2859,7 @@ static void parse_reset_branch(void)
 		}
 	}
 	else
-		b = new_branch(sp);
+		b = new_branch(arg);
 	read_next_command();
 	parse_from(b);
 	if (command_buf.len > 0)
@@ -2929,14 +2917,12 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 		free(buf);
 }
 
-static void parse_cat_blob(void)
+static void parse_cat_blob(const char *p)
 {
-	const char *p;
 	struct object_entry *oe = oe;
 	unsigned char sha1[20];
 
 	/* cat-blob SP <object> LF */
-	p = command_buf.buf + strlen("cat-blob ");
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_eol(p));
 		if (!oe)
@@ -3053,14 +3039,12 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 	cat_blob_write(line.buf, line.len);
 }
 
-static void parse_ls(struct branch *b)
+static void parse_ls(const char *p, struct branch *b)
 {
-	const char *p;
 	struct tree_entry *root = NULL;
 	struct tree_entry leaf = {NULL};
 
 	/* ls SP (<tree-ish> SP)? <path> */
-	p = command_buf.buf + strlen("ls ");
 	if (*p == '"') {
 		if (!b)
 			die("Not in a commit: %s", command_buf.buf);
@@ -3276,10 +3260,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 	return 1;
 }
 
-static void parse_feature(void)
+static void parse_feature(const char *feature)
 {
-	char *feature = command_buf.buf + 8;
-
 	if (seen_data_command)
 		die("Got feature command '%s' after data command", feature);
 
@@ -3289,10 +3271,8 @@ static void parse_feature(void)
 	die("This version of fast-import does not support feature %s.", feature);
 }
 
-static void parse_option(void)
+static void parse_option(const char *option)
 {
-	char *option = command_buf.buf + 11;
-
 	if (seen_data_command)
 		die("Got option command '%s' after data command", option);
 
@@ -3408,26 +3388,27 @@ int main(int argc, char **argv)
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
 	while (read_next_command() != EOF) {
+		const char *v;
 		if (!strcmp("blob", command_buf.buf))
 			parse_new_blob();
-		else if (starts_with(command_buf.buf, "ls "))
-			parse_ls(NULL);
-		else if (starts_with(command_buf.buf, "commit "))
-			parse_new_commit();
-		else if (starts_with(command_buf.buf, "tag "))
-			parse_new_tag();
-		else if (starts_with(command_buf.buf, "reset "))
-			parse_reset_branch();
+		else if (skip_prefix(command_buf.buf, "ls ", &v))
+			parse_ls(v, NULL);
+		else if (skip_prefix(command_buf.buf, "commit ", &v))
+			parse_new_commit(v);
+		else if (skip_prefix(command_buf.buf, "tag ", &v))
+			parse_new_tag(v);
+		else if (skip_prefix(command_buf.buf, "reset ", &v))
+			parse_reset_branch(v);
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!strcmp("done", command_buf.buf))
 			break;
 		else if (starts_with(command_buf.buf, "progress "))
 			parse_progress();
-		else if (starts_with(command_buf.buf, "feature "))
-			parse_feature();
-		else if (starts_with(command_buf.buf, "option git "))
-			parse_option();
+		else if (skip_prefix(command_buf.buf, "feature ", &v))
+			parse_feature(v);
+		else if (skip_prefix(command_buf.buf, "option git ", &v))
+			parse_option(v);
 		else if (starts_with(command_buf.buf, "option "))
 			/* ignore non-git options*/;
 		else
-- 
2.0.0.566.gfe3e6b2
