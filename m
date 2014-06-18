From: Jeff King <peff@peff.net>
Subject: [PATCH 08/16] use skip_prefix to avoid magic numbers
Date: Wed, 18 Jun 2014 15:47:50 -0400
Message-ID: <20140618194750.GH22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:48:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLpu-0003R6-26
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbaFRTrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:47:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:46952 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754580AbaFRTrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:47:52 -0400
Received: (qmail 30250 invoked by uid 102); 18 Jun 2014 19:47:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:47:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:47:50 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252040>

It's a common idiom to match a prefix and then skip past it
with a magic number, like:

  if (starts_with(foo, "bar"))
	  foo += 3;

This is easy to get wrong, since you have to count the
prefix string yourself, and there's no compiler check if the
string changes.  We can use skip_prefix to avoid the magic
numbers here.

Note that some of these conversions could be much shorter.
For example:

  if (starts_with(arg, "--foo=")) {
	  bar = arg + 6;
	  continue;
  }

could become:

  if (skip_prefix(arg, "--foo=", &bar))
	  continue;

However, I have left it as:

  if (skip_prefix(arg, "--foo=", &v)) {
	  bar = v;
	  continue;
  }

to visually match nearby cases which need to actually
process the string. Like:

  if (skip_prefix(arg, "--foo=", &v)) {
	  bar = atoi(v);
	  continue;
  }

Signed-off-by: Jeff King <peff@peff.net>
---
 alias.c        |  3 ++-
 connect.c      | 11 +++++----
 convert.c      |  4 ++--
 daemon.c       | 73 ++++++++++++++++++++++++++++++----------------------------
 diff.c         | 65 ++++++++++++++++++++++++++-------------------------
 fast-import.c  | 69 +++++++++++++++++++++++++++++-------------------------
 fetch-pack.c   |  9 ++++----
 git.c          | 18 +++++++--------
 help.c         |  6 +++--
 http-backend.c | 11 +++++----
 http-push.c    | 11 +++++----
 11 files changed, 149 insertions(+), 131 deletions(-)

diff --git a/alias.c b/alias.c
index 5efc3d6..758c867 100644
--- a/alias.c
+++ b/alias.c
@@ -5,7 +5,8 @@ static char *alias_val;
 
 static int alias_lookup_cb(const char *k, const char *v, void *cb)
 {
-	if (starts_with(k, "alias.") && !strcmp(k + 6, alias_key)) {
+	const char *name;
+	if (skip_prefix(k, "alias.", &name) && !strcmp(name, alias_key)) {
 		if (!v)
 			return config_error_nonbool(k);
 		alias_val = xstrdup(v);
diff --git a/connect.c b/connect.c
index 94a6650..37ff018 100644
--- a/connect.c
+++ b/connect.c
@@ -129,6 +129,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		char *name;
 		int len, name_len;
 		char *buffer = packet_buffer;
+		const char *arg;
 
 		len = packet_read(in, &src_buf, &src_len,
 				  packet_buffer, sizeof(packet_buffer),
@@ -140,12 +141,12 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		if (!len)
 			break;
 
-		if (len > 4 && starts_with(buffer, "ERR "))
-			die("remote error: %s", buffer + 4);
+		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
+			die("remote error: %s", arg);
 
-		if (len == 48 && starts_with(buffer, "shallow ")) {
-			if (get_sha1_hex(buffer + 8, old_sha1))
-				die("protocol error: expected shallow sha-1, got '%s'", buffer + 8);
+		if (len == 48 && skip_prefix(buffer, "shallow ", &arg)) {
+			if (get_sha1_hex(arg, old_sha1))
+				die("protocol error: expected shallow sha-1, got '%s'", arg);
 			if (!shallow_points)
 				die("repository on the other end cannot be shallow");
 			sha1_array_append(shallow_points, old_sha1);
diff --git a/convert.c b/convert.c
index ab80b72..cb5fbb4 100644
--- a/convert.c
+++ b/convert.c
@@ -1121,9 +1121,9 @@ static int is_foreign_ident(const char *str)
 {
 	int i;
 
-	if (!starts_with(str, "$Id: "))
+	if (!skip_prefix(str, "$Id: ", &str))
 		return 0;
-	for (i = 5; str[i]; i++) {
+	for (i = 0; str[i]; i++) {
 		if (isspace(str[i]) && str[i+1] != '$')
 			return 1;
 	}
diff --git a/daemon.c b/daemon.c
index 18818c3..6d25828 100644
--- a/daemon.c
+++ b/daemon.c
@@ -235,8 +235,10 @@ static int service_enabled;
 
 static int git_daemon_config(const char *var, const char *value, void *cb)
 {
-	if (starts_with(var, "daemon.") &&
-	    !strcmp(var + 7, service_looking_at->config_name)) {
+	const char *service;
+
+	if (skip_prefix(var, "daemon.", &service) &&
+	    !strcmp(service, service_looking_at->config_name)) {
 		service_enabled = git_config_bool(var, value);
 		return 0;
 	}
@@ -1133,16 +1135,17 @@ int main(int argc, char **argv)
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
+		const char *v;
 
-		if (starts_with(arg, "--listen=")) {
-			string_list_append(&listen_addr, xstrdup_tolower(arg + 9));
+		if (skip_prefix(arg, "--listen=", &v)) {
+			string_list_append(&listen_addr, xstrdup_tolower(v));
 			continue;
 		}
-		if (starts_with(arg, "--port=")) {
+		if (skip_prefix(arg, "--port=", &v)) {
 			char *end;
 			unsigned long n;
-			n = strtoul(arg+7, &end, 0);
-			if (arg[7] && !*end) {
+			n = strtoul(v, &end, 0);
+			if (*v && !*end) {
 				listen_port = n;
 				continue;
 			}
@@ -1168,20 +1171,20 @@ int main(int argc, char **argv)
 			export_all_trees = 1;
 			continue;
 		}
-		if (starts_with(arg, "--access-hook=")) {
-			access_hook = arg + 14;
+		if (skip_prefix(arg, "--access-hook=", &v)) {
+			access_hook = v;
 			continue;
 		}
-		if (starts_with(arg, "--timeout=")) {
-			timeout = atoi(arg+10);
+		if (skip_prefix(arg, "--timeout=", &v)) {
+			timeout = atoi(v);
 			continue;
 		}
-		if (starts_with(arg, "--init-timeout=")) {
-			init_timeout = atoi(arg+15);
+		if (skip_prefix(arg, "--init-timeout=", &v)) {
+			init_timeout = atoi(v);
 			continue;
 		}
-		if (starts_with(arg, "--max-connections=")) {
-			max_connections = atoi(arg+18);
+		if (skip_prefix(arg, "--max-connections=", &v)) {
+			max_connections = atoi(v);
 			if (max_connections < 0)
 				max_connections = 0;	        /* unlimited */
 			continue;
@@ -1190,16 +1193,16 @@ int main(int argc, char **argv)
 			strict_paths = 1;
 			continue;
 		}
-		if (starts_with(arg, "--base-path=")) {
-			base_path = arg+12;
+		if (skip_prefix(arg, "--base-path=", &v)) {
+			base_path = v;
 			continue;
 		}
 		if (!strcmp(arg, "--base-path-relaxed")) {
 			base_path_relaxed = 1;
 			continue;
 		}
-		if (starts_with(arg, "--interpolated-path=")) {
-			interpolated_path = arg+20;
+		if (skip_prefix(arg, "--interpolated-path=", &v)) {
+			interpolated_path = v;
 			continue;
 		}
 		if (!strcmp(arg, "--reuseaddr")) {
@@ -1210,12 +1213,12 @@ int main(int argc, char **argv)
 			user_path = "";
 			continue;
 		}
-		if (starts_with(arg, "--user-path=")) {
-			user_path = arg + 12;
+		if (skip_prefix(arg, "--user-path=", &v)) {
+			user_path = v;
 			continue;
 		}
-		if (starts_with(arg, "--pid-file=")) {
-			pid_file = arg + 11;
+		if (skip_prefix(arg, "--pid-file=", &v)) {
+			pid_file = v;
 			continue;
 		}
 		if (!strcmp(arg, "--detach")) {
@@ -1223,28 +1226,28 @@ int main(int argc, char **argv)
 			log_syslog = 1;
 			continue;
 		}
-		if (starts_with(arg, "--user=")) {
-			user_name = arg + 7;
+		if (skip_prefix(arg, "--user=", &v)) {
+			user_name = v;
 			continue;
 		}
-		if (starts_with(arg, "--group=")) {
-			group_name = arg + 8;
+		if (skip_prefix(arg, "--group=", &v)) {
+			group_name = v;
 			continue;
 		}
-		if (starts_with(arg, "--enable=")) {
-			enable_service(arg + 9, 1);
+		if (skip_prefix(arg, "--enable=", &v)) {
+			enable_service(v, 1);
 			continue;
 		}
-		if (starts_with(arg, "--disable=")) {
-			enable_service(arg + 10, 0);
+		if (skip_prefix(arg, "--disable=", &v)) {
+			enable_service(v, 0);
 			continue;
 		}
-		if (starts_with(arg, "--allow-override=")) {
-			make_service_overridable(arg + 17, 1);
+		if (skip_prefix(arg, "--allow-override=", &v)) {
+			make_service_overridable(v, 1);
 			continue;
 		}
-		if (starts_with(arg, "--forbid-override=")) {
-			make_service_overridable(arg + 18, 0);
+		if (skip_prefix(arg, "--forbid-override=", &v)) {
+			make_service_overridable(v, 0);
 			continue;
 		}
 		if (!strcmp(arg, "--informative-errors")) {
diff --git a/diff.c b/diff.c
index 77c5eb4..97db932 100644
--- a/diff.c
+++ b/diff.c
@@ -231,6 +231,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 
 int git_diff_basic_config(const char *var, const char *value, void *cb)
 {
+	const char *name;
+
 	if (!strcmp(var, "diff.renamelimit")) {
 		diff_rename_limit_default = git_config_int(var, value);
 		return 0;
@@ -239,8 +241,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	if (starts_with(var, "diff.color.") || starts_with(var, "color.diff.")) {
-		int slot = parse_diff_color_slot(var + 11);
+	if (skip_prefix(var, "diff.color.", &name) ||
+	    skip_prefix(var, "color.diff.", &name)) {
+		int slot = parse_diff_color_slot(name);
 		if (slot < 0)
 			return 0;
 		if (!value)
@@ -2341,6 +2344,7 @@ static void builtin_diff(const char *name_a,
 	} else {
 		/* Crazy xdl interfaces.. */
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
+		const char *v;
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		struct emit_callback ecbdata;
@@ -2379,10 +2383,10 @@ static void builtin_diff(const char *name_a,
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
 		if (!diffopts)
 			;
-		else if (starts_with(diffopts, "--unified="))
-			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
-		else if (starts_with(diffopts, "-u"))
-			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
+		else if (skip_prefix(diffopts, "--unified=", &v))
+			xecfg.ctxlen = strtoul(v, NULL, 10);
+		else if (skip_prefix(diffopts, "-u", &v))
+			xecfg.ctxlen = strtoul(v, NULL, 10);
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
@@ -3609,17 +3613,17 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
 	else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
 		return parse_dirstat_opt(options, "");
-	else if (starts_with(arg, "-X"))
-		return parse_dirstat_opt(options, arg + 2);
-	else if (starts_with(arg, "--dirstat="))
-		return parse_dirstat_opt(options, arg + 10);
+	else if (skip_prefix(arg, "-X", &arg))
+		return parse_dirstat_opt(options, arg);
+	else if (skip_prefix(arg, "--dirstat=", &arg))
+		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
 		return parse_dirstat_opt(options, "cumulative");
 	else if (!strcmp(arg, "--dirstat-by-file"))
 		return parse_dirstat_opt(options, "files");
-	else if (starts_with(arg, "--dirstat-by-file=")) {
+	else if (skip_prefix(arg, "--dirstat-by-file=", &arg)) {
 		parse_dirstat_opt(options, "files");
-		return parse_dirstat_opt(options, arg + 18);
+		return parse_dirstat_opt(options, arg);
 	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
@@ -3669,9 +3673,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, RENAME_EMPTY);
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
-	else if (starts_with(arg, "--relative=")) {
+	else if (skip_prefix(arg, "--relative=", &arg)) {
 		DIFF_OPT_SET(options, RELATIVE_NAME);
-		options->prefix = arg + 11;
+		options->prefix = arg;
 	}
 
 	/* xdiff options */
@@ -3722,8 +3726,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
-	else if (starts_with(arg, "--color=")) {
-		int value = git_config_colorbool(NULL, arg+8);
+	else if (skip_prefix(arg, "--color=", &arg)) {
+		int value = git_config_colorbool(NULL, arg);
 		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
 		options->use_color = value;
@@ -3734,29 +3738,28 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
-	else if (starts_with(arg, "--color-words=")) {
+	else if (skip_prefix(arg, "--color-words=", &arg)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
-		options->word_regex = arg + 14;
+		options->word_regex = arg;
 	}
 	else if (!strcmp(arg, "--word-diff")) {
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
 	}
-	else if (starts_with(arg, "--word-diff=")) {
-		const char *type = arg + 12;
-		if (!strcmp(type, "plain"))
+	else if (skip_prefix(arg, "--word-diff=", &arg)) {
+		if (!strcmp(arg, "plain"))
 			options->word_diff = DIFF_WORDS_PLAIN;
-		else if (!strcmp(type, "color")) {
+		else if (!strcmp(arg, "color")) {
 			options->use_color = 1;
 			options->word_diff = DIFF_WORDS_COLOR;
 		}
-		else if (!strcmp(type, "porcelain"))
+		else if (!strcmp(arg, "porcelain"))
 			options->word_diff = DIFF_WORDS_PORCELAIN;
-		else if (!strcmp(type, "none"))
+		else if (!strcmp(arg, "none"))
 			options->word_diff = DIFF_WORDS_NONE;
 		else
-			die("bad --word-diff argument: %s", type);
+			die("bad --word-diff argument: %s", arg);
 	}
 	else if ((argcount = parse_long_opt("word-diff-regex", av, &optarg))) {
 		if (options->word_diff == DIFF_WORDS_NONE)
@@ -3779,13 +3782,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--ignore-submodules")) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, "all");
-	} else if (starts_with(arg, "--ignore-submodules=")) {
+	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
-		handle_ignore_submodules_arg(options, arg + 20);
+		handle_ignore_submodules_arg(options, arg);
 	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
-	else if (starts_with(arg, "--submodule="))
-		return parse_submodule_opt(options, arg + 12);
+	else if (skip_prefix(arg, "--submodule=", &arg))
+		return parse_submodule_opt(options, arg);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
@@ -3820,8 +3823,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
-	else if (starts_with(arg, "--abbrev=")) {
-		options->abbrev = strtoul(arg + 9, NULL, 10);
+	else if (skip_prefix(arg, "--abbrev=", &arg)) {
+		options->abbrev = strtoul(arg, NULL, 10);
 		if (options->abbrev < MINIMUM_ABBREV)
 			options->abbrev = MINIMUM_ABBREV;
 		else if (40 < options->abbrev)
diff --git a/fast-import.c b/fast-import.c
index b2030cc..a3ffe30 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1912,8 +1912,9 @@ static void skip_optional_lf(void)
 
 static void parse_mark(void)
 {
-	if (starts_with(command_buf.buf, "mark :")) {
-		next_mark = strtoumax(command_buf.buf + 6, NULL, 10);
+	const char *v;
+	if (skip_prefix(command_buf.buf, "mark :", &v)) {
+		next_mark = strtoumax(v, NULL, 10);
 		read_next_command();
 	}
 	else
@@ -1922,14 +1923,15 @@ static void parse_mark(void)
 
 static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 {
+	const char *data;
 	strbuf_reset(sb);
 
-	if (!starts_with(command_buf.buf, "data "))
+	if (!skip_prefix(command_buf.buf, "data ", &data))
 		die("Expected 'data n' command, found: %s", command_buf.buf);
 
-	if (starts_with(command_buf.buf + 5, "<<")) {
-		char *term = xstrdup(command_buf.buf + 5 + 2);
-		size_t term_len = command_buf.len - 5 - 2;
+	if (skip_prefix(data, "<<", &data)) {
+		char *term = xstrdup(data);
+		size_t term_len = command_buf.len - (data - command_buf.buf);
 
 		strbuf_detach(&command_buf, NULL);
 		for (;;) {
@@ -1944,7 +1946,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 		free(term);
 	}
 	else {
-		uintmax_t len = strtoumax(command_buf.buf + 5, NULL, 10);
+		uintmax_t len = strtoumax(data, NULL, 10);
 		size_t n = 0, length = (size_t)len;
 
 		if (limit && limit < len) {
@@ -2676,6 +2678,7 @@ static void parse_new_commit(void)
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
 	unsigned char prev_fanout, new_fanout;
+	const char *v;
 
 	/* Obtain the branch name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2685,12 +2688,12 @@ static void parse_new_commit(void)
 
 	read_next_command();
 	parse_mark();
-	if (starts_with(command_buf.buf, "author ")) {
-		author = parse_ident(command_buf.buf + 7);
+	if (skip_prefix(command_buf.buf, "author ", &v)) {
+		author = parse_ident(v);
 		read_next_command();
 	}
-	if (starts_with(command_buf.buf, "committer ")) {
-		committer = parse_ident(command_buf.buf + 10);
+	if (skip_prefix(command_buf.buf, "committer ", &v)) {
+		committer = parse_ident(v);
 		read_next_command();
 	}
 	if (!committer)
@@ -2777,6 +2780,7 @@ static void parse_new_tag(void)
 	uintmax_t from_mark = 0;
 	unsigned char sha1[20];
 	enum object_type type;
+	const char *v;
 
 	/* Obtain the new tag name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2819,8 +2823,8 @@ static void parse_new_tag(void)
 	read_next_command();
 
 	/* tagger ... */
-	if (starts_with(command_buf.buf, "tagger ")) {
-		tagger = parse_ident(command_buf.buf + 7);
+	if (skip_prefix(command_buf.buf, "tagger ", &v)) {
+		tagger = parse_ident(v);
 		read_next_command();
 	} else
 		tagger = NULL;
@@ -3207,9 +3211,9 @@ static void option_export_pack_edges(const char *edges)
 
 static int parse_one_option(const char *option)
 {
-	if (starts_with(option, "max-pack-size=")) {
+	if (skip_prefix(option, "max-pack-size=", &option)) {
 		unsigned long v;
-		if (!git_parse_ulong(option + 14, &v))
+		if (!git_parse_ulong(option, &v))
 			return 0;
 		if (v < 8192) {
 			warning("max-pack-size is now in bytes, assuming --max-pack-size=%lum", v);
@@ -3219,17 +3223,17 @@ static int parse_one_option(const char *option)
 			v = 1024 * 1024;
 		}
 		max_packsize = v;
-	} else if (starts_with(option, "big-file-threshold=")) {
+	} else if (skip_prefix(option, "big-file-threshold=", &option)) {
 		unsigned long v;
-		if (!git_parse_ulong(option + 19, &v))
+		if (!git_parse_ulong(option, &v))
 			return 0;
 		big_file_threshold = v;
-	} else if (starts_with(option, "depth=")) {
-		option_depth(option + 6);
-	} else if (starts_with(option, "active-branches=")) {
-		option_active_branches(option + 16);
-	} else if (starts_with(option, "export-pack-edges=")) {
-		option_export_pack_edges(option + 18);
+	} else if (skip_prefix(option, "depth=", &option)) {
+		option_depth(option);
+	} else if (skip_prefix(option, "active-branches=", &option)) {
+		option_active_branches(option);
+	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
+		option_export_pack_edges(option);
 	} else if (starts_with(option, "quiet")) {
 		show_stats = 0;
 	} else if (starts_with(option, "stats")) {
@@ -3243,15 +3247,16 @@ static int parse_one_option(const char *option)
 
 static int parse_one_feature(const char *feature, int from_stream)
 {
-	if (starts_with(feature, "date-format=")) {
-		option_date_format(feature + 12);
-	} else if (starts_with(feature, "import-marks=")) {
-		option_import_marks(feature + 13, from_stream, 0);
-	} else if (starts_with(feature, "import-marks-if-exists=")) {
-		option_import_marks(feature + strlen("import-marks-if-exists="),
-					from_stream, 1);
-	} else if (starts_with(feature, "export-marks=")) {
-		option_export_marks(feature + 13);
+	const char *arg;
+
+	if (skip_prefix(feature, "date-format=", &arg)) {
+		option_date_format(arg);
+	} else if (skip_prefix(feature, "import-marks=", &arg)) {
+		option_import_marks(arg, from_stream, 0);
+	} else if (skip_prefix(feature, "import-marks-if-exists=", &arg)) {
+		option_import_marks(arg, from_stream, 1);
+	} else if (skip_prefix(feature, "export-marks=", &arg)) {
+		option_export_marks(arg);
 	} else if (!strcmp(feature, "cat-blob")) {
 		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "relative-marks")) {
diff --git a/fetch-pack.c b/fetch-pack.c
index eeee2bb..3de3bd5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -319,18 +319,19 @@ static int find_common(struct fetch_pack_args *args,
 
 	if (args->depth > 0) {
 		char *line;
+		const char *arg;
 		unsigned char sha1[20];
 
 		send_request(args, fd[1], &req_buf);
 		while ((line = packet_read_line(fd[0], NULL))) {
-			if (starts_with(line, "shallow ")) {
-				if (get_sha1_hex(line + 8, sha1))
+			if (skip_prefix(line, "shallow ", &arg)) {
+				if (get_sha1_hex(arg, sha1))
 					die("invalid shallow line: %s", line);
 				register_shallow(sha1);
 				continue;
 			}
-			if (starts_with(line, "unshallow ")) {
-				if (get_sha1_hex(line + 10, sha1))
+			if (skip_prefix(line, "unshallow ", &arg)) {
+				if (get_sha1_hex(arg, sha1))
 					die("invalid unshallow line: %s", line);
 				if (!lookup_object(sha1))
 					die("object not found: %s", line);
diff --git a/git.c b/git.c
index 7780572..b2bb09e 100644
--- a/git.c
+++ b/git.c
@@ -54,8 +54,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		/*
 		 * Check remaining flags.
 		 */
-		if (starts_with(cmd, "--exec-path")) {
-			cmd += 11;
+		if (skip_prefix(cmd, "--exec-path", &cmd)) {
 			if (*cmd == '=')
 				git_set_argv_exec_path(cmd + 1);
 			else {
@@ -92,8 +91,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (starts_with(cmd, "--git-dir=")) {
-			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+		} else if (skip_prefix(cmd, "--git-dir=", &cmd)) {
+			setenv(GIT_DIR_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--namespace")) {
@@ -106,8 +105,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (starts_with(cmd, "--namespace=")) {
-			setenv(GIT_NAMESPACE_ENVIRONMENT, cmd + 12, 1);
+		} else if (skip_prefix(cmd, "--namespace=", &cmd)) {
+			setenv(GIT_NAMESPACE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
@@ -120,8 +119,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (starts_with(cmd, "--work-tree=")) {
-			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
+		} else if (skip_prefix(cmd, "--work-tree=", &cmd)) {
+			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
@@ -578,8 +577,7 @@ int main(int argc, char **av)
 	 * So we just directly call the builtin handler, and die if
 	 * that one cannot handle it.
 	 */
-	if (starts_with(cmd, "git-")) {
-		cmd += 4;
+	if (skip_prefix(cmd, "git-", &cmd)) {
 		argv[0] = cmd;
 		handle_builtin(argc, argv);
 		die("cannot handle %s as a builtin", cmd);
diff --git a/help.c b/help.c
index b266b09..b0f1a69 100644
--- a/help.c
+++ b/help.c
@@ -251,11 +251,13 @@ static struct cmdnames aliases;
 
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
+	const char *p;
+
 	if (!strcmp(var, "help.autocorrect"))
 		autocorrect = git_config_int(var,value);
 	/* Also use aliases for command lookup */
-	if (starts_with(var, "alias."))
-		add_cmdname(&aliases, var + 6, strlen(var + 6));
+	if (skip_prefix(var, "alias.", &p))
+		add_cmdname(&aliases, p, strlen(p));
 
 	return git_default_config(var, value, cb);
 }
diff --git a/http-backend.c b/http-backend.c
index d2c0a62..57290d9 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -221,17 +221,19 @@ static void get_idx_file(char *name)
 
 static int http_config(const char *var, const char *value, void *cb)
 {
+	const char *p;
+
 	if (!strcmp(var, "http.getanyfile")) {
 		getanyfile = git_config_bool(var, value);
 		return 0;
 	}
 
-	if (starts_with(var, "http.")) {
+	if (skip_prefix(var, "http.", &p)) {
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 			struct rpc_service *svc = &rpc_service[i];
-			if (!strcmp(var + 5, svc->config_name)) {
+			if (!strcmp(p, svc->config_name)) {
 				svc->enabled = git_config_bool(var, value);
 				return 0;
 			}
@@ -244,15 +246,16 @@ static int http_config(const char *var, const char *value, void *cb)
 
 static struct rpc_service *select_service(const char *name)
 {
+	const char *svc_name;
 	struct rpc_service *svc = NULL;
 	int i;
 
-	if (!starts_with(name, "git-"))
+	if (!skip_prefix(name, "git-", &svc_name))
 		forbidden("Unsupported service: '%s'", name);
 
 	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 		struct rpc_service *s = &rpc_service[i];
-		if (!strcmp(s->name, name + 4)) {
+		if (!strcmp(s->name, svc_name)) {
 			svc = s;
 			break;
 		}
diff --git a/http-push.c b/http-push.c
index de00d16..26dfa67 100644
--- a/http-push.c
+++ b/http-push.c
@@ -770,9 +770,9 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 			lock->owner = xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->owner, ctx->cdata);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TIMEOUT)) {
-			if (starts_with(ctx->cdata, "Second-"))
-				lock->timeout =
-					strtol(ctx->cdata + 7, NULL, 10);
+			const char *arg;
+			if (skip_prefix(ctx->cdata, "Second-", &arg))
+				lock->timeout = strtol(arg, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			lock->token = xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->token, ctx->cdata);
@@ -1561,6 +1561,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
+	const char *name;
 
 	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", repo->url, path);
@@ -1578,8 +1579,8 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 		return;
 
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
-	if (starts_with((char *)buffer.buf, "ref: ")) {
-		*symref = xmemdupz((char *)buffer.buf + 5, buffer.len - 6);
+	if (skip_prefix(buffer.buf, "ref: ", &name)) {
+		*symref = xmemdupz(name, buffer.len - (name - buffer.buf));
 	} else {
 		get_sha1_hex(buffer.buf, sha1);
 	}
-- 
2.0.0.566.gfe3e6b2
