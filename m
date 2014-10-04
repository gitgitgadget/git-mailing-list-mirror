From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Sat, 04 Oct 2014 20:54:50 +0200
Message-ID: <5430427A.5080800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 04 20:56:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaUV5-0006jq-Fm
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 20:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbaJDS4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2014 14:56:04 -0400
Received: from mout.web.de ([212.227.17.11]:58355 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbaJDS4C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2014 14:56:02 -0400
Received: from [192.168.178.27] ([79.253.146.81]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MIeQO-1XchPu0KVs-002EIb; Sat, 04 Oct 2014 20:55:54
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:f3LSZO8pqno0R/Brb809l5oxThwAfxc+uhwSoVsaKB9obegdqqn
 cjr7Mnrl7SNOzD3kOSzcMazpoSEpe+9k+U5fBCaaDHgzXawDNkuwDyGcln7vcafHNEc/F+/
 duKpiGUBSrZ/ch9xtDKmnousZYhm6xxe2rW0iezNoDuQX5w+DA5c9V6kz6Nr112OMYiKayS
 Nj0EJnjOwnCRgTw8A1edA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257891>

Continue where ae021d87 (use skip_prefix to avoid magic numbers) left off
and use skip_prefix() in more places for determining the lengths of prefix
strings to avoid using dependent constants and other indirect methods.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/apply.c             |  2 +-
 builtin/branch.c            | 29 +++++++++++------------
 builtin/cat-file.c          |  5 ++--
 builtin/checkout.c          |  6 ++---
 builtin/clean.c             |  7 +++---
 builtin/commit.c            | 18 +++++++--------
 builtin/get-tar-commit-id.c |  5 ++--
 builtin/log.c               |  6 +++--
 builtin/remote-ext.c        | 10 ++++----
 pretty.c                    | 56 +++++++++++++++++++++------------------------
 10 files changed, 69 insertions(+), 75 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8714a88..97f7e8e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -435,7 +435,7 @@ static unsigned long linelen(const char *buffer, unsigned long size)
 
 static int is_dev_null(const char *str)
 {
-	return !memcmp("/dev/null", str, 9) && isspace(str[9]);
+	return skip_prefix(str, "/dev/null", &str) && isspace(*str);
 }
 
 #define TERM_SPACE	1
diff --git a/builtin/branch.c b/builtin/branch.c
index 9e4666f..6785097 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -81,14 +81,16 @@ static int parse_branch_color_slot(const char *var, int ofs)
 
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
+	const char *slot_name;
+
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "branch", &colopts);
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color = git_config_colorbool(var, value);
 		return 0;
 	}
-	if (starts_with(var, "color.branch.")) {
-		int slot = parse_branch_color_slot(var, 13);
+	if (skip_prefix(var, "color.branch.", &slot_name)) {
+		int slot = parse_branch_color_slot(var, slot_name - var);
 		if (slot < 0)
 			return 0;
 		if (!value)
@@ -335,20 +337,18 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	static struct {
 		int kind;
 		const char *prefix;
-		int pfxlen;
 	} ref_kind[] = {
-		{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
-		{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
+		{ REF_LOCAL_BRANCH, "refs/heads/" },
+		{ REF_REMOTE_BRANCH, "refs/remotes/" },
 	};
 
 	/* Detect kind */
 	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
 		prefix = ref_kind[i].prefix;
-		if (strncmp(refname, prefix, ref_kind[i].pfxlen))
-			continue;
-		kind = ref_kind[i].kind;
-		refname += ref_kind[i].pfxlen;
-		break;
+		if (skip_prefix(refname, prefix, &refname)) {
+			kind = ref_kind[i].kind;
+			break;
+		}
 	}
 	if (ARRAY_SIZE(ref_kind) <= i)
 		return 0;
@@ -872,13 +872,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	head = resolve_refdup("HEAD", head_sha1, 0, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
-	if (!strcmp(head, "HEAD")) {
+	if (!strcmp(head, "HEAD"))
 		detached = 1;
-	} else {
-		if (!starts_with(head, "refs/heads/"))
-			die(_("HEAD not found below refs/heads!"));
-		head += 11;
-	}
+	else if (!skip_prefix(head, "refs/heads/", &head))
+		die(_("HEAD not found below refs/heads!"));
 	hashcpy(merge_filter_ref, head_sha1);
 
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7073304..f8d8129 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -82,8 +82,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 				enum object_type type;
 				unsigned long size;
 				char *buffer = read_sha1_file(sha1, &type, &size);
-				if (memcmp(buffer, "object ", 7) ||
-				    get_sha1_hex(buffer + 7, blob_sha1))
+				const char *target;
+				if (!skip_prefix(buffer, "object ", &target) ||
+				    get_sha1_hex(target, blob_sha1))
 					die("%s not a valid tag", sha1_to_hex(sha1));
 				free(buffer);
 			} else
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8afdf2b..cef1996 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1150,10 +1150,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die (_("--track needs a branch name"));
-		if (starts_with(argv0, "refs/"))
-			argv0 += 5;
-		if (starts_with(argv0, "remotes/"))
-			argv0 += 8;
+		skip_prefix(argv0, "refs/", &argv0);
+		skip_prefix(argv0, "remotes/", &argv0);
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die (_("Missing branch name; try -b"));
diff --git a/builtin/clean.c b/builtin/clean.c
index 3beeea6..c35505e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -100,6 +100,8 @@ static int parse_clean_color_slot(const char *var)
 
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
+	const char *slot_name;
+
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "clean", &colopts);
 
@@ -109,9 +111,8 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		clean_use_color = git_config_colorbool(var, value);
 		return 0;
 	}
-	if (starts_with(var, "color.interactive.")) {
-		int slot = parse_clean_color_slot(var +
-						  strlen("color.interactive."));
+	if (skip_prefix(var, "color.interactive.", &slot_name)) {
+		int slot = parse_clean_color_slot(slot_name);
 		if (slot < 0)
 			return 0;
 		if (!value)
diff --git a/builtin/commit.c b/builtin/commit.c
index b0fe784..cff7802 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1294,6 +1294,7 @@ static int parse_status_slot(const char *var, int offset)
 static int git_status_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
+	const char *slot_name;
 
 	if (starts_with(k, "column."))
 		return git_column_config(k, v, "status", &s->colopts);
@@ -1323,8 +1324,9 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		s->display_comment_prefix = git_config_bool(k, v);
 		return 0;
 	}
-	if (starts_with(k, "status.color.") || starts_with(k, "color.status.")) {
-		int slot = parse_status_slot(k, 13);
+	if (skip_prefix(k, "status.color.", &slot_name) ||
+	    skip_prefix(k, "color.status.", &slot_name)) {
+		int slot = parse_status_slot(k, slot_name - k);
 		if (slot < 0)
 			return 0;
 		if (!v)
@@ -1513,13 +1515,11 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	diff_setup_done(&rev.diffopt);
 
 	head = resolve_ref_unsafe("HEAD", junk_sha1, 0, NULL);
-	printf("[%s%s ",
-		starts_with(head, "refs/heads/") ?
-			head + 11 :
-			!strcmp(head, "HEAD") ?
-				_("detached HEAD") :
-				head,
-		initial_commit ? _(" (root-commit)") : "");
+	if (!strcmp(head, "HEAD"))
+		head = _("detached HEAD");
+	else
+		skip_prefix(head, "refs/heads/", &head);
+	printf("[%s%s ", head, initial_commit ? _(" (root-commit)") : "");
 
 	if (!log_tree_commit(&rev, commit)) {
 		rev.always_show_header = 1;
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index aa72596..6f4147a 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -19,6 +19,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	char buffer[HEADERSIZE];
 	struct ustar_header *header = (struct ustar_header *)buffer;
 	char *content = buffer + RECORDSIZE;
+	const char *comment;
 	ssize_t n;
 
 	if (argc != 1)
@@ -29,10 +30,10 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		die("git get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
-	if (memcmp(content, "52 comment=", 11))
+	if (!skip_prefix(content, "52 comment=", &comment))
 		return 1;
 
-	n = write_in_full(1, content + 11, 41);
+	n = write_in_full(1, comment, 41);
 	if (n < 41)
 		die_errno("git get-tar-commit-id: write error");
 
diff --git a/builtin/log.c b/builtin/log.c
index 2fb34c7..1202eba 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -368,6 +368,8 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value, void *cb)
 {
+	const char *slot_name;
+
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
@@ -388,8 +390,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
-	if (starts_with(var, "color.decorate."))
-		return parse_decorate_color_config(var, 15, value);
+	if (skip_prefix(var, "color.decorate.", &slot_name))
+		return parse_decorate_color_config(var, slot_name - var, value);
 	if (!strcmp(var, "log.mailmap")) {
 		use_mailmap_config = git_config_bool(var, value);
 		return 0;
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index d699d28..3b8c22c 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -30,16 +30,14 @@ static char *strip_escapes(const char *str, const char *service,
 	size_t rpos = 0;
 	int escape = 0;
 	char special = 0;
-	size_t psoff = 0;
+	const char *service_noprefix = service;
 	struct strbuf ret = STRBUF_INIT;
 
-	/* Calculate prefix length for \s and lengths for \s and \S */
-	if (!strncmp(service, "git-", 4))
-		psoff = 4;
+	skip_prefix(service_noprefix, "git-", &service_noprefix);
 
 	/* Pass the service to command. */
 	setenv("GIT_EXT_SERVICE", service, 1);
-	setenv("GIT_EXT_SERVICE_NOPREFIX", service + psoff, 1);
+	setenv("GIT_EXT_SERVICE_NOPREFIX", service_noprefix, 1);
 
 	/* Scan the length of argument. */
 	while (str[rpos] && (escape || str[rpos] != ' ')) {
@@ -85,7 +83,7 @@ static char *strip_escapes(const char *str, const char *service,
 				strbuf_addch(&ret, str[rpos]);
 				break;
 			case 's':
-				strbuf_addstr(&ret, service + psoff);
+				strbuf_addstr(&ret, service_noprefix);
 				break;
 			case 'S':
 				strbuf_addstr(&ret, service);
diff --git a/pretty.c b/pretty.c
index 5fd9de6..a181ac6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -73,10 +73,9 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 	if (git_config_string(&fmt, var, value))
 		return -1;
 
-	if (starts_with(fmt, "format:") || starts_with(fmt, "tformat:")) {
-		commit_format->is_tformat = fmt[0] == 't';
-		fmt = strchr(fmt, ':') + 1;
-	} else if (strchr(fmt, '%'))
+	if (skip_prefix(fmt, "format:", &fmt))
+		commit_format->is_tformat = 0;
+	else if (skip_prefix(fmt, "tformat:", &fmt) || strchr(fmt, '%'))
 		commit_format->is_tformat = 1;
 	else
 		commit_format->is_alias = 1;
@@ -157,12 +156,12 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		rev->commit_format = CMIT_FMT_DEFAULT;
 		return;
 	}
-	if (starts_with(arg, "format:") || starts_with(arg, "tformat:")) {
-		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
+	if (skip_prefix(arg, "format:", &arg)) {
+		save_user_format(rev, arg, 0);
 		return;
 	}
 
-	if (!*arg || strchr(arg, '%')) {
+	if (!*arg || skip_prefix(arg, "tformat:", &arg) || strchr(arg, '%')) {
 		save_user_format(rev, arg, 1);
 		return;
 	}
@@ -809,18 +808,19 @@ static void parse_commit_header(struct format_commit_context *context)
 	int i;
 
 	for (i = 0; msg[i]; i++) {
+		const char *name;
 		int eol;
 		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
 			; /* do nothing */
 
 		if (i == eol) {
 			break;
-		} else if (starts_with(msg + i, "author ")) {
-			context->author.off = i + 7;
-			context->author.len = eol - i - 7;
-		} else if (starts_with(msg + i, "committer ")) {
-			context->committer.off = i + 10;
-			context->committer.len = eol - i - 10;
+		} else if (skip_prefix(msg + i, "author ", &name)) {
+			context->author.off = name - msg;
+			context->author.len = msg + eol - name;
+		} else if (skip_prefix(msg + i, "committer ", &name)) {
+			context->committer.off = name - msg;
+			context->committer.len = msg + eol - name;
 		}
 		i = eol;
 	}
@@ -951,6 +951,8 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 			  const char *placeholder,
 			  struct format_commit_context *c)
 {
+	const char *rest = placeholder;
+
 	if (placeholder[1] == '(') {
 		const char *begin = placeholder + 2;
 		const char *end = strchr(begin, ')');
@@ -958,10 +960,9 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 
 		if (!end)
 			return 0;
-		if (starts_with(begin, "auto,")) {
+		if (skip_prefix(begin, "auto,", &begin)) {
 			if (!want_color(c->pretty_ctx->color))
 				return end - placeholder + 1;
-			begin += 5;
 		}
 		color_parse_mem(begin,
 				end - begin,
@@ -969,20 +970,15 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, color);
 		return end - placeholder + 1;
 	}
-	if (starts_with(placeholder + 1, "red")) {
+	if (skip_prefix(placeholder + 1, "red", &rest))
 		strbuf_addstr(sb, GIT_COLOR_RED);
-		return 4;
-	} else if (starts_with(placeholder + 1, "green")) {
+	else if (skip_prefix(placeholder + 1, "green", &rest))
 		strbuf_addstr(sb, GIT_COLOR_GREEN);
-		return 6;
-	} else if (starts_with(placeholder + 1, "blue")) {
+	else if (skip_prefix(placeholder + 1, "blue", &rest))
 		strbuf_addstr(sb, GIT_COLOR_BLUE);
-		return 5;
-	} else if (starts_with(placeholder + 1, "reset")) {
+	else if (skip_prefix(placeholder + 1, "reset", &rest))
 		strbuf_addstr(sb, GIT_COLOR_RESET);
-		return 6;
-	} else
-		return 0;
+	return rest - placeholder;
 }
 
 static size_t parse_padding_placeholder(struct strbuf *sb,
@@ -1522,7 +1518,7 @@ static void pp_header(struct pretty_print_context *pp,
 	int parents_shown = 0;
 
 	for (;;) {
-		const char *line = *msg_p;
+		const char *name, *line = *msg_p;
 		int linelen = get_one_line(*msg_p);
 
 		if (!linelen)
@@ -1557,14 +1553,14 @@ static void pp_header(struct pretty_print_context *pp,
 		 * FULL shows both authors but not dates.
 		 * FULLER shows both authors and dates.
 		 */
-		if (starts_with(line, "author ")) {
+		if (skip_prefix(line, "author ", &name)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Author", sb, line + 7, encoding);
+			pp_user_info(pp, "Author", sb, name, encoding);
 		}
-		if (starts_with(line, "committer ") &&
+		if (skip_prefix(line, "committer ", &name) &&
 		    (pp->fmt == CMIT_FMT_FULL || pp->fmt == CMIT_FMT_FULLER)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Commit", sb, line + 10, encoding);
+			pp_user_info(pp, "Commit", sb, name, encoding);
 		}
 	}
 }
-- 
2.1.2
