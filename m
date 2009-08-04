From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] git apply: option to ignore whitespace differences
Date: Tue,  4 Aug 2009 13:16:49 +0200
Message-ID: <1249384609-30240-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYI15-0007Sq-3C
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 13:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZHDLRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 07:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZHDLRB
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 07:17:01 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54108 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZHDLQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 07:16:59 -0400
Received: by bwz19 with SMTP id 19so3002709bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pjrUN752e+VIwJOXqJiAZRucwnAEZYToaigiDTSdpOs=;
        b=II0MvMogdsMBlNkufI8zYPvC4wn827YjJLzbx2/h3ZMNJlnrXszXUNqJnHNVrv9k2M
         0hqtkiV2rex9SEBoN3YYQryTcFm0WLqLEPKup0oj930oUVWvh5uURa1edfEpa/yjf1Z8
         werioBAumR3X5XWejryTg+yU42EsNG+RBH5as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TNEHJDLMIXlYyL0jBGQ3vHV4Ye5mD+jyzfshdbXoujdL5dtlaJAmc8unk42oPTTEyP
         uwx6F8xbGIyiYI0u1alpH5/STF3DVeAjR7Q6f9QDRrbuqmzW3jDNrXTX/SPx31+hjdHa
         ts2NCro4aj7fGMzl/T+yKQw0EkkJ7O1F/0VXI=
Received: by 10.204.100.11 with SMTP id w11mr9886284bkn.32.1249384618806;
        Tue, 04 Aug 2009 04:16:58 -0700 (PDT)
Received: from localhost (host-78-13-62-199.cust-adsl.tiscali.it [78.13.62.199])
        by mx.google.com with ESMTPS id 18sm11873772fks.40.2009.08.04.04.16.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 04:16:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.216.g15680.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124777>

Introduce --ignore-whitespace option and corresponding config bool to
ignore whitespace differences while applying patches, akin to the
'patch' program.

'git am', 'git rebase' and the bash git completion are made aware of
this option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Following Junio's suggestion, the whitespace in the test has been replaced as
appropriate with Z to prevent mangling on patch application. Some test cases
have also been made more credible, and documentation has been added to all of
them.

 Documentation/config.txt               |    8 ++
 Documentation/git-am.txt               |    5 +-
 Documentation/git-apply.txt            |   13 +++
 Documentation/git-rebase.txt           |    3 +-
 builtin-apply.c                        |  172 ++++++++++++++++++++++++++++++--
 cache.h                                |    1 +
 contrib/completion/git-completion.bash |    3 +
 environment.c                          |    1 +
 git-am.sh                              |    4 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |  176 ++++++++++++++++++++++++++++++++
 11 files changed, 379 insertions(+), 10 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c6f09f8..0b53cab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -461,6 +461,14 @@ it will be treated as a shell command.  For example, defining
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
 
+apply.ignorewhitespace::
+	When set to 'change', tells 'git-apply' to ignore changes in
+	whitespace, in the same way as the '--ignore-space-change'
+	option.
+	When set to one of: no, none, never, false tells 'git-apply' to
+	respect all whitespace differences.
+	See linkgit:git-apply[1].
+
 apply.whitespace::
 	Tells 'git-apply' how to handle whitespaces, in the same way
 	as the '--whitespace' option. See linkgit:git-apply[1].
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 32e689b..fcacc94 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
 	 [--3way] [--interactive] [--committer-date-is-author-date]
-	 [--ignore-date]
+	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--reject] [-q | --quiet]
 	 [<mbox> | <Maildir>...]
@@ -65,6 +65,9 @@ default.   You can use `--no-utf8` to override this.
 	it is supposed to apply to and we have those blobs
 	available locally.
 
+--ignore-date::
+--ignore-space-change::
+--ignore-whitespace::
 --whitespace=<option>::
 -C<n>::
 -p<n>::
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 735374d..5ee8c91 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
+	  [--ignore-space-change | --ignore-whitespace ]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
 	  [--exclude=PATH] [--include=PATH] [--directory=<root>]
 	  [--verbose] [<patch>...]
@@ -149,6 +150,14 @@ patch to each path is used.  A patch to a path that does not match any
 include/exclude pattern is used by default if there is no include pattern
 on the command line, and ignored if there is any include pattern.
 
+--ignore-space-change::
+--ignore-whitespace::
+	When applying a patch, ignore changes in whitespace in context
+	lines if necessary.
+	Context lines will preserve their whitespace, and they will not
+	undergo whitespace fixing regardless of the value of the
+	`--whitespace` option. New lines will still be fixed, though.
+
 --whitespace=<action>::
 	When applying a patch, detect a new or modified line that has
 	whitespace errors.  What are considered whitespace errors is
@@ -205,6 +214,10 @@ running `git apply --directory=modules/git-gui`.
 Configuration
 -------------
 
+apply.ignorewhitespace::
+	Set to 'change' if you want changes in whitespace to be ignored by default.
+	Set to one of: no, none, never, false if you want changes in
+	whitespace to be significant.
 apply.whitespace::
 	When no `--whitespace` flag is given from the command
 	line, this configuration item is used as the default.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index db1b71d..0aefc34 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -268,8 +268,9 @@ OPTIONS
 	exit with the message "Current branch is up to date" in such a
 	situation.
 
+--ignore-whitespace::
 --whitespace=<option>::
-	This flag is passed to the 'git-apply' program
+	These flag are passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Incompatible with the --interactive option.
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 39dc96a..7ec5b8b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -61,6 +61,13 @@ static enum ws_error_action {
 static int whitespace_error;
 static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
+
+static enum ws_ignore {
+	ignore_ws_none,
+	ignore_ws_change,
+} ws_ignore_action = ignore_ws_none;
+
+
 static const char *patch_input_file;
 static const char *root;
 static int root_len;
@@ -97,6 +104,21 @@ static void parse_whitespace_option(const char *option)
 	die("unrecognized whitespace option '%s'", option);
 }
 
+static void parse_ignorewhitespace_option(const char *option)
+{
+	if (!option || !strcmp(option, "no") ||
+	    !strcmp(option, "false") || !strcmp(option, "never") ||
+	    !strcmp(option, "none")) {
+		ws_ignore_action = ignore_ws_none;
+		return;
+	}
+	if (!strcmp(option, "change")) {
+		ws_ignore_action = ignore_ws_change;
+		return;
+	}
+	die("unrecognized whitespace ignore option '%s'", option);
+}
+
 static void set_default_whitespace_mode(const char *whitespace_option)
 {
 	if (!whitespace_option && !apply_default_whitespace)
@@ -214,6 +236,62 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
+/*
+ * Compare lines s1 of length n1 and s2 of length n2, ignoring
+ * whitespace difference. Returns 1 if they match, 0 otherwise
+ */
+static int fuzzy_matchlines(const char *s1, size_t n1,
+			    const char *s2, size_t n2)
+{
+	const char *last1 = s1 + n1 - 1;
+	const char *last2 = s2 + n2 - 1;
+	int result = 0;
+
+	if (n1 < 0 || n2 < 0)
+		return 0;
+
+	/* ignore line endings */
+	while ((*last1 == '\r') || (*last1 == '\n'))
+		last1--;
+	while ((*last2 == '\r') || (*last2 == '\n'))
+		last2--;
+
+	/* skip leading whitespace */
+	while (isspace(*s1) && (s1 <= last1))
+		s1++;
+	while (isspace(*s2) && (s2 <= last2))
+		s2++;
+	/* early return if both lines are empty */
+	if ((s1 > last1) && (s2 > last2))
+		return 1;
+	while (!result) {
+		result = *s1++ - *s2++;
+		/*
+		 * Skip whitespace inside. We check for whitespace on
+		 * both buffers because we don't want "a b" to match
+		 * "ab"
+		 */
+		if (isspace(*s1) && isspace(*s2)) {
+			while (isspace(*s1) && s1 <= last1)
+				s1++;
+			while (isspace(*s2) && s2 <= last2)
+				s2++;
+		}
+		/*
+		 * If we reached the end on one side only,
+		 * lines don't match
+		 */
+		if (
+		    ((s2 > last2) && (s1 <= last1)) ||
+		    ((s1 > last1) && (s2 <= last2)))
+			return 0;
+		if ((s1 > last1) && (s2 > last2))
+			break;
+	}
+
+	return !result;
+}
+
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
@@ -1672,10 +1750,17 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	}
 }
 
+/*
+ * Update the preimage, and the common lines in postimage,
+ * from buffer buf of length len. If postlen is 0 the postimage
+ * is updated in place, otherwise it's updated on a new buffer
+ * of length postlen
+ */
+
 static void update_pre_post_images(struct image *preimage,
 				   struct image *postimage,
 				   char *buf,
-				   size_t len)
+				   size_t len, size_t postlen)
 {
 	int i, ctx;
 	char *new, *old, *fixed;
@@ -1694,11 +1779,19 @@ static void update_pre_post_images(struct image *preimage,
 	*preimage = fixed_preimage;
 
 	/*
-	 * Adjust the common context lines in postimage, in place.
-	 * This is possible because whitespace fixing does not make
-	 * the string grow.
+	 * Adjust the common context lines in postimage. This can be
+	 * done in-place when we are just doing whitespace fixing,
+	 * which does not make the string grow, but needs a new buffer
+	 * when ignoring whitespace causes the update, since in this case
+	 * we could have e.g. tabs converted to multiple spaces.
+	 * We trust the caller to tell us if the update can be done
+	 * in place (postlen==0) or not.
 	 */
-	new = old = postimage->buf;
+	old = postimage->buf;
+	if (postlen)
+		new = postimage->buf = xmalloc(postlen);
+	else
+		new = old;
 	fixed = preimage->buf;
 	for (i = ctx = 0; i < postimage->nr; i++) {
 		size_t len = postimage->line[i].len;
@@ -1773,12 +1866,57 @@ static int match_fragment(struct image *img,
 	    !memcmp(img->buf + try, preimage->buf, preimage->len))
 		return 1;
 
+	/*
+	 * No exact match. If we are ignoring whitespace, run a line-by-line
+	 * fuzzy matching. We collect all the line length information because
+	 * we need it to adjust whitespace if we match.
+	 */
+	if (ws_ignore_action == ignore_ws_change) {
+		size_t imgoff = 0;
+		size_t preoff = 0;
+		size_t postlen = postimage->len;
+		size_t imglen[preimage->nr];
+		for (i = 0; i < preimage->nr; i++) {
+			imglen[i] = img->line[try_lno+i].len;
+			size_t prelen = preimage->line[i].len;
+			if (!fuzzy_matchlines(
+				img->buf + try + imgoff, imglen[i],
+				preimage->buf + preoff, prelen))
+				return 0;
+			if (preimage->line[i].flag & LINE_COMMON)
+				postlen += imglen[i] - prelen;
+			imgoff += imglen[i];
+			preoff += prelen;
+		}
+
+		/*
+		 * Ok, the preimage matches with whitespace fuzz. Update it and
+		 * the common postimage lines to use the same whitespace as the
+		 * target. imgoff now holds the true length of the target that
+		 * matches the preimage, and we need to update the line lengths
+		 * of the preimage to match the target ones.
+		 */
+		fixed_buf = xmalloc(imgoff);
+		memcpy(fixed_buf, img->buf + try, imgoff);
+		for (i = 0; i < preimage->nr; i++)
+			preimage->line[i].len = imglen[i];
+
+		/*
+		 * Update the preimage buffer and the postimage context lines.
+		 */
+		update_pre_post_images(preimage, postimage,
+				fixed_buf, imgoff, postlen);
+		return 1;
+	}
+
 	if (ws_error_action != correct_ws_error)
 		return 0;
 
 	/*
 	 * The hunk does not apply byte-by-byte, but the hash says
-	 * it might with whitespace fuzz.
+	 * it might with whitespace fuzz. We haven't been asked to
+	 * ignore whitespace, we were asked to correct whitespace
+	 * errors, so let's try matching after whitespace correction.
 	 */
 	fixed_buf = xmalloc(preimage->len + 1);
 	buf = fixed_buf;
@@ -1830,7 +1968,7 @@ static int match_fragment(struct image *img,
 	 * hunk match.  Update the context lines in the postimage.
 	 */
 	update_pre_post_images(preimage, postimage,
-			       fixed_buf, buf - fixed_buf);
+			       fixed_buf, buf - fixed_buf, 0);
 	return 1;
 
  unmatch_exit:
@@ -3272,6 +3410,8 @@ static int git_apply_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "apply.whitespace"))
 		return git_config_string(&apply_default_whitespace, var, value);
+	else if (!strcmp(var, "apply.ignorewhitespace"))
+		return git_config_string(&apply_default_ignorewhitespace, var, value);
 	return git_default_config(var, value, cb);
 }
 
@@ -3308,6 +3448,16 @@ static int option_parse_z(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_space_change(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (unset)
+		ws_ignore_action = ignore_ws_none;
+	else
+		ws_ignore_action = ignore_ws_change;
+	return 0;
+}
+
 static int option_parse_whitespace(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -3384,6 +3534,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
 			"detect new or modified lines that have whitespace errors",
 			0, option_parse_whitespace },
+		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
+			"ignore changes in whitespace when finding context",
+			PARSE_OPT_NOARG, option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
+			"ignore changes in whitespace when finding context",
+			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
 			"apply the patch in reverse"),
 		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
@@ -3408,6 +3564,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
+	if (apply_default_ignorewhitespace)
+		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
 
 	argc = parse_options(argc, argv, prefix, builtin_apply_options,
 			apply_usage, 0);
diff --git a/cache.h b/cache.h
index 0bbcb1f..69efe1b 100644
--- a/cache.h
+++ b/cache.h
@@ -509,6 +509,7 @@ extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
+extern const char *apply_default_ignorewhitespace;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int core_compression_seen;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5543dc4..bf688e1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -674,6 +674,7 @@ _git_am ()
 	--*)
 		__gitcomp "
 			--3way --committer-date-is-author-date --ignore-date
+			--ignore-whitespace --ignore-space-change
 			--interactive --keep --no-utf8 --signoff --utf8
 			--whitespace=
 			"
@@ -695,6 +696,7 @@ _git_apply ()
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
 			--apply --no-add --exclude=
+			--ignore-whitespace --ignore-space-change
 			--whitespace= --inaccurate-eof --verbose
 			"
 		return
@@ -1537,6 +1539,7 @@ _git_config ()
 	__gitcomp "
 		add.ignore-errors
 		alias.
+		apply.ignorewhitespace
 		apply.whitespace
 		branch.autosetupmerge
 		branch.autosetuprebase
diff --git a/environment.c b/environment.c
index 73bccf1..5de6837 100644
--- a/environment.c
+++ b/environment.c
@@ -26,6 +26,7 @@ const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
+const char *apply_default_ignorewhitespace;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
diff --git a/git-am.sh b/git-am.sh
index d64d997..ab39b3c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 whitespace=     pass it through git-apply
+ignore-space-change pass it through git-apply
+ignore-whitespace pass it through git-apply
 directory=      pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
@@ -303,7 +305,7 @@ do
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
 	--patch-format)
 		shift ; patch_format="$1" ;;
-	--reject)
+	--reject|--ignore-whitespace|--ignore-space-change)
 		git_apply_opt="$git_apply_opt $1" ;;
 	--committer-date-is-author-date)
 		committer_date_is_author_date=t ;;
diff --git a/git-rebase.sh b/git-rebase.sh
index 18bc694..d741752 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -333,6 +333,9 @@ do
 			;;
 		esac
 		;;
+	--ignore-whitespace)
+		git_am_opt="$git_am_opt $1"
+		;;
 	--committer-date-is-author-date|--ignore-date)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
new file mode 100755
index 0000000..821449c
--- /dev/null
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -0,0 +1,176 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Giuseppe Bilotta
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply --ignore-whitespace.
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat > patch1.patch <<\EOF
+diff --git a/main.c b/main.c
+new file mode 100644
+--- /dev/null
++++ b/main.c
+@@ -0,0 +1,22 @@
++#include <stdio.h>
++
++void print_int(int num);
++int func(int num);
++
++int main() {
++       int i;
++
++       for (i = 0; i < 10; i++) {
++               print_int(func(i)); /* stuff */
++       }
++
++       return 0;
++}
++
++int func(int num) {
++       return num * num;
++}
++
++void print_int(int num) {
++       printf("%d", num);
++}
+EOF
+
+# Since whitespace is very significant and we want to prevent whitespace
+# mangling when creating this test from a patch, we protect 'fixable'
+# whitespace by replacing spaces with Z and replacing them at patch
+# creation time, hence the sed trick.
+
+
+# This patch will fail unless whitespace differences are being ignored
+
+sed -e 's/Z/ /g' > patch2.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -10,6 +10,8 @@
+Z		print_int(func(i)); /* stuff */
+Z	}
+Z
++	printf("\n");
++
+Z	return 0;
+Z}
+Z
+EOF
+
+# This patch will fail even though whitespace differences are being ignored
+# because of the missing string at EOL. TODO: this testcase should be
+# improved by creating a line that has the same hash with and without
+# the final string.
+
+sed -e 's/Z/ /g' > patch3.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -10,3 +10,4 @@
+Z	for (i = 0; i < 10; i++) {
+Z		print_int(func(i));Z
++		/* stuff */
+Z	}
+EOF
+
+# This patch will fail even though whitespace differences are being ignored
+# because of the missing EOL at EOF.
+
+sed -e 's/Z/ /g' > patch4.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -21,1 +21,1 @@
+-	};Z
+\ No newline at end of file
++	};
+EOF
+
+# This patch will fail unless whitespace differences are being ignored
+
+sed -e 's/Z/ /g' > patch5.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -2,2 +2,3 @@
+Z	void print_int(int num);
++	/* a comment */
+Z	int func(int num);
+EOF
+
+# And this is how the final output should be
+cat > main.c.final <<\EOF
+#include <stdio.h>
+
+void print_int(int num);
+	/* a comment */
+int func(int num);
+
+int main() {
+       int i;
+
+       for (i = 0; i < 10; i++) {
+               print_int(func(i)); /* stuff */
+       }
+
+	printf("\n");
+
+       return 0;
+}
+
+int func(int num) {
+       return num * num;
+}
+
+void print_int(int num) {
+       printf("%d", num);
+}
+EOF
+
+test_expect_success "file creation" \
+    'git-apply patch1.patch'
+
+test_expect_success "patch2 fails (retab)" \
+    'test_must_fail git-apply patch2.patch'
+
+test_expect_success "patch2 applies with --ignore-whitespace" \
+    'git-apply --ignore-whitespace patch2.patch'
+
+test_expect_success "patch2 reverse applies with --ignore-space-change" \
+    'git-apply -R --ignore-space-change patch2.patch'
+
+git config apply.ignorewhitespace change
+
+test_expect_success "patch2 applies (apply.ignorewhitespace = change)" \
+    'git-apply patch2.patch'
+
+test_expect_success "patch3 fails (missing string at EOL)" \
+    'test_must_fail git-apply patch3.patch'
+
+test_expect_success "patch4 fails (missing EOL at EOF)" \
+    'test_must_fail git-apply patch4.patch'
+
+test_expect_success "patch5 applies (leading whitespace)" \
+    'git-apply patch5.patch'
+
+test_expect_success "patches don't mangle whitespace" \
+    'diff -q main.c main.c.final'
+
+rm -f main.c
+test_expect_success "re-create file (with --ignore-whitespace)" \
+    'git-apply patch1.patch'
+
+test_expect_success "patch5 fails (--no-ignore-whitespace)" \
+    'test_must_fail git-apply --no-ignore-whitespace patch5.patch'
+
+test_done
+
+
-- 
1.6.4.216.g15680.dirty
