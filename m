From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] teach config parsers to diagnose missing values
Date: Mon, 11 Feb 2008 01:22:12 -0800
Message-ID: <7v3arzalvf.fsf_-_@gitster.siamese.dyndns.org>
References: <20080211082216.e9212310.chriscool@tuxfamily.org>
	<7vskzzaoop.fsf@gitster.siamese.dyndns.org>
	<7vmyq7anji.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 10:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUsS-000637-Hy
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbYBKJW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 04:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbYBKJW1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:22:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbYBKJWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 04:22:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CCF6C2148;
	Mon, 11 Feb 2008 04:22:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B9D3B2147;
	Mon, 11 Feb 2008 04:22:14 -0500 (EST)
In-Reply-To: <7vmyq7anji.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Feb 2008 00:46:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73490>

I really hate to do this.

I announced an opportunity for new people to start hacking, and
I really wanted to stay out of their way.  It was a relatively
easy way for people to get their hands dirty.

But then I somehow was trapped in a discussion that suggested to
introduce a needless regression that breaks people's existing
repositories, and had to argue against the insanity, because the
suggestion would have discouraged new people from actually
looking at the code and futzing with it.

Somehow I ended up doing this myself, which meant that the easy
entrance opportunity was robbed from them.  I am really unhappy
about this, not about the resulting code, but about the process.

Anyway, here it is.  I think I've caught all of them (except the
one in builtin-gc that Miklos Vajna earlier sent in, and the one
in archive-tar.c that I demonstrated in my original message).

---

 builtin-apply.c       |    2 ++
 builtin-branch.c      |    9 ++++++---
 builtin-clean.c       |    1 +
 builtin-commit.c      |    2 ++
 builtin-config.c      |    2 ++
 builtin-log.c         |    2 +-
 builtin-reflog.c      |   16 +++++++++++-----
 builtin-show-branch.c |    2 ++
 builtin-tag.c         |    2 +-
 cache.h               |    1 +
 config.c              |    9 +++++++++
 connect.c             |    2 ++
 convert.c             |    4 ++--
 diff.c                |   14 ++++++++++++--
 git.c                 |    2 ++
 help.c                |    2 ++
 http.c                |   25 +++++++++++++++----------
 merge-recursive.c     |   11 ++++++-----
 remote.c              |    9 ++++++---
 setup.c               |    2 ++
 wt-status.c           |    2 ++
 21 files changed, 89 insertions(+), 32 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 15432b6..a11b1bb 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2746,6 +2746,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 static int git_apply_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "apply.whitespace")) {
+		if (!value)
+			return config_error_nonbool(var);
 		apply_default_whitespace = xstrdup(value);
 		return 0;
 	}
diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..e414c88 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -70,12 +70,15 @@ static int git_branch_config(const char *var, const char *value)
 	}
 	if (!prefixcmp(var, "color.branch.")) {
 		int slot = parse_branch_color_slot(var, 13);
+		if (!value)
+			return config_error_nonbool(var);
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
-	if (!strcmp(var, "branch.autosetupmerge"))
-			branch_track = git_config_bool(var, value);
-
+	if (!strcmp(var, "branch.autosetupmerge")) {
+		branch_track = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
diff --git a/builtin-clean.c b/builtin-clean.c
index eb853a3..99739a6 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -20,6 +20,7 @@ static const char *const builtin_clean_usage[] = {
 
 static int git_clean_config(const char *var, const char *value)
 {
+	/* This is value=NULL safe */
 	if (!strcmp(var, "clean.requireforce"))
 		force = !git_config_bool(var, value);
 	return git_default_config(var, value);
diff --git a/builtin-commit.c b/builtin-commit.c
index c787bed..06e8a34 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -743,6 +743,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 int git_commit_config(const char *k, const char *v)
 {
 	if (!strcmp(k, "commit.template")) {
+		if (!v)
+			return config_error_nonbool(v);
 		template_file = xstrdup(v);
 		return 0;
 	}
diff --git a/builtin-config.c b/builtin-config.c
index e4a12e3..077d8ef 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -168,6 +168,8 @@ static char parsed_color[COLOR_MAXLEN];
 static int git_get_color_config(const char *var, const char *value)
 {
 	if (!strcmp(var, get_color_slot)) {
+		if (!value)
+			config_error_nonbool(var);
 		color_parse(value, var, parsed_color);
 		get_color_found = 1;
 	}
diff --git a/builtin-log.c b/builtin-log.c
index dcc9f81..9458428 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -219,7 +219,7 @@ static int git_log_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "format.subjectprefix")) {
 		if (!value)
-			die("format.subjectprefix without value");
+			config_error_nonbool(var);
 		fmt_patch_subject_prefix = xstrdup(value);
 		return 0;
 	}
diff --git a/builtin-reflog.c b/builtin-reflog.c
index e6834dd..4836ec9 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -307,13 +307,19 @@ static int collect_reflog(const char *ref, const unsigned char *sha1, int unused
 
 static int reflog_expire_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "gc.reflogexpire"))
+	if (!strcmp(var, "gc.reflogexpire")) {
+		if (!value)
+			config_error_nonbool(var);
 		default_reflog_expire = approxidate(value);
-	else if (!strcmp(var, "gc.reflogexpireunreachable"))
+		return 0;
+	}
+	if (!strcmp(var, "gc.reflogexpireunreachable")) {
+		if (!value)
+			config_error_nonbool(var);
 		default_reflog_expire_unreachable = approxidate(value);
-	else
-		return git_default_config(var, value);
-	return 0;
+		return 0;
+	}
+	return git_default_config(var, value);
 }
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 6dc835d..019abd3 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -536,6 +536,8 @@ static void append_one_rev(const char *av)
 static int git_show_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "showbranch.default")) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (default_alloc <= default_num + 1) {
 			default_alloc = default_alloc * 3 / 2 + 20;
 			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
diff --git a/builtin-tag.c b/builtin-tag.c
index 03e7015..4a4a88c 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -258,7 +258,7 @@ static int git_tag_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
-			die("user.signingkey without value");
+			return config_error_nonbool(value);
 		set_signingkey(value);
 		return 0;
 	}
diff --git a/cache.h b/cache.h
index 549f4bb..6abcee4 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,7 @@ extern int git_config_set_multivar(const char *, const char *, const char *, int
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value);
+extern int config_error_nonbool(const char *);
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index 498259e..e9a9a6f 100644
--- a/config.c
+++ b/config.c
@@ -1074,3 +1074,12 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	free(config_filename);
 	return ret;
 }
+
+/*
+ * Call this to report error for your variable that should not
+ * get a boolean value (i.e. "[my] var" means "true").
+ */
+int config_error_nonbool(const char *var)
+{
+	return error("Missing value for '%s'", var);
+}
diff --git a/connect.c b/connect.c
index 3aefd4a..71597d4 100644
--- a/connect.c
+++ b/connect.c
@@ -370,6 +370,8 @@ static int git_proxy_command_options(const char *var, const char *value)
 
 		if (git_proxy_command)
 			return 0;
+		if (!value)
+			return config_error_nonbool(var);
 		/* [core]
 		 * ;# matches www.kernel.org as well
 		 * gitproxy = netcatter-1 for kernel.org
diff --git a/convert.c b/convert.c
index 80f114b..552707e 100644
--- a/convert.c
+++ b/convert.c
@@ -326,14 +326,14 @@ static int read_convert_config(const char *var, const char *value)
 
 	if (!strcmp("smudge", ep)) {
 		if (!value)
-			return error("%s: lacks value", var);
+			return config_error_nonbool(var);
 		drv->smudge = strdup(value);
 		return 0;
 	}
 
 	if (!strcmp("clean", ep)) {
 		if (!value)
-			return error("%s: lacks value", var);
+			return config_error_nonbool(var);
 		drv->clean = strdup(value);
 		return 0;
 	}
diff --git a/diff.c b/diff.c
index 5b8afdc..4d2e23a 100644
--- a/diff.c
+++ b/diff.c
@@ -158,6 +158,8 @@ int git_diff_ui_config(const char *var, const char *value)
 		return 0;
 	}
 	if (!strcmp(var, "diff.external")) {
+		if (!value)
+			return config_error_nonbool(var);
 		external_diff_cmd_cfg = xstrdup(value);
 		return 0;
 	}
@@ -165,8 +167,11 @@ int git_diff_ui_config(const char *var, const char *value)
 		const char *ep = strrchr(var, '.');
 
 		if (ep != var + 4) {
-			if (!strcmp(ep, ".command"))
+			if (!strcmp(ep, ".command")) {
+				if (!value)
+					return config_error_nonbool(var);
 				return parse_lldiff_command(var, ep, value);
+			}
 		}
 	}
 
@@ -177,6 +182,8 @@ int git_diff_basic_config(const char *var, const char *value)
 {
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
+		if (!value)
+			return config_error_nonbool(var);
 		color_parse(value, var, diff_colors[slot]);
 		return 0;
 	}
@@ -184,8 +191,11 @@ int git_diff_basic_config(const char *var, const char *value)
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 		if (ep != var + 4) {
-			if (!strcmp(ep, ".funcname"))
+			if (!strcmp(ep, ".funcname")) {
+				if (!value)
+					return config_error_nonbool(var);
 				return parse_funcname_pattern(var, ep, value);
+			}
 		}
 	}
 
diff --git a/git.c b/git.c
index 15fec89..0cb8688 100644
--- a/git.c
+++ b/git.c
@@ -93,6 +93,8 @@ static char *alias_string;
 static int git_alias_config(const char *var, const char *value)
 {
 	if (!prefixcmp(var, "alias.") && !strcmp(var + 6, alias_command)) {
+		if (!value)
+			return config_error_nonbool(var);
 		alias_string = xstrdup(value);
 	}
 	return 0;
diff --git a/help.c b/help.c
index 1302a61..95e7640 100644
--- a/help.c
+++ b/help.c
@@ -40,6 +40,8 @@ static void parse_help_format(const char *format)
 static int git_help_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "help.format")) {
+		if (!value)
+			return config_error_nonbool(var);
 		help_default_format = xstrdup(value);
 		return 0;
 	}
diff --git a/http.c b/http.c
index d2c11ae..5925d07 100644
--- a/http.c
+++ b/http.c
@@ -101,16 +101,18 @@ static int http_options(const char *var, const char *value)
 
 	if (!strcmp("http.sslcert", var)) {
 		if (ssl_cert == NULL) {
-			ssl_cert = xmalloc(strlen(value)+1);
-			strcpy(ssl_cert, value);
+			if (!value)
+				return config_error_nonbool(var);
+			ssl_cert = xstrdup(value);
 		}
 		return 0;
 	}
 #if LIBCURL_VERSION_NUM >= 0x070902
 	if (!strcmp("http.sslkey", var)) {
 		if (ssl_key == NULL) {
-			ssl_key = xmalloc(strlen(value)+1);
-			strcpy(ssl_key, value);
+			if (!value)
+				return config_error_nonbool(var);
+			ssl_key = xstrdup(value);
 		}
 		return 0;
 	}
@@ -118,16 +120,18 @@ static int http_options(const char *var, const char *value)
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("http.sslcapath", var)) {
 		if (ssl_capath == NULL) {
-			ssl_capath = xmalloc(strlen(value)+1);
-			strcpy(ssl_capath, value);
+			if (!value)
+				return config_error_nonbool(var);
+			ssl_capath = xstrdup(value);
 		}
 		return 0;
 	}
 #endif
 	if (!strcmp("http.sslcainfo", var)) {
 		if (ssl_cainfo == NULL) {
-			ssl_cainfo = xmalloc(strlen(value)+1);
-			strcpy(ssl_cainfo, value);
+			if (!value)
+				return config_error_nonbool(var);
+			ssl_cainfo = xstrdup(value);
 		}
 		return 0;
 	}
@@ -157,8 +161,9 @@ static int http_options(const char *var, const char *value)
 	}
 	if (!strcmp("http.proxy", var)) {
 		if (curl_http_proxy == NULL) {
-			curl_http_proxy = xmalloc(strlen(value)+1);
-			strcpy(curl_http_proxy, value);
+			if (!value)
+				return config_error_nonbool(var);
+			curl_http_proxy = xstrdup(value);
 		}
 		return 0;
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index c292a77..34e3167 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -844,8 +844,9 @@ static int read_merge_config(const char *var, const char *value)
 	int namelen;
 
 	if (!strcmp(var, "merge.default")) {
-		if (value)
-			default_ll_merge = strdup(value);
+		if (!value)
+			return config_error_nonbool(var);
+		default_ll_merge = strdup(value);
 		return 0;
 	}
 
@@ -878,14 +879,14 @@ static int read_merge_config(const char *var, const char *value)
 
 	if (!strcmp("name", ep)) {
 		if (!value)
-			return error("%s: lacks value", var);
+			return config_error_nonbool(var);
 		fn->description = strdup(value);
 		return 0;
 	}
 
 	if (!strcmp("driver", ep)) {
 		if (!value)
-			return error("%s: lacks value", var);
+			return config_error_nonbool(var);
 		/*
 		 * merge.<name>.driver specifies the command line:
 		 *
@@ -908,7 +909,7 @@ static int read_merge_config(const char *var, const char *value)
 
 	if (!strcmp("recursive", ep)) {
 		if (!value)
-			return error("%s: lacks value", var);
+			return config_error_nonbool(var);
 		fn->recursive = strdup(value);
 		return 0;
 	}
diff --git a/remote.c b/remote.c
index 0e00680..20abbc0 100644
--- a/remote.c
+++ b/remote.c
@@ -222,15 +222,18 @@ static int handle_config(const char *key, const char *value)
 		subkey = strrchr(name, '.');
 		if (!subkey)
 			return 0;
-		if (!value)
-			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
+			if (!value)
+				return config_error_nonbool(key);
 			branch->remote_name = xstrdup(value);
 			if (branch == current_branch)
 				default_remote_name = branch->remote_name;
-		} else if (!strcmp(subkey, ".merge"))
+		} else if (!strcmp(subkey, ".merge")) {
+			if (!value)
+				return config_error_nonbool(key);
 			add_merge(branch, xstrdup(value));
+		}
 		return 0;
 	}
 	if (prefixcmp(key,  "remote."))
diff --git a/setup.c b/setup.c
index adede16..4509598 100644
--- a/setup.c
+++ b/setup.c
@@ -372,6 +372,8 @@ int check_repository_format_version(const char *var, const char *value)
 		if (is_bare_repository_cfg == 1)
 			inside_work_tree = -1;
 	} else if (strcmp(var, "core.worktree") == 0) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (git_work_tree_cfg)
 			free(git_work_tree_cfg);
 		git_work_tree_cfg = xstrdup(value);
diff --git a/wt-status.c b/wt-status.c
index c0c2472..bfd1b0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -402,6 +402,8 @@ int git_status_config(const char *k, const char *v)
 	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
 		int slot = parse_status_slot(k, 13);
+		if (!v)
+			return config_error_nonbool(k);
 		color_parse(v, k, wt_status_colors[slot]);
 		return 0;
 	}
