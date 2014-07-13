From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 00/31] Support multiple checkouts
Date: Sun, 13 Jul 2014 11:50:37 +0700
Message-ID: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bmk-0007Lo-0E
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaGMExH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 00:53:07 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59634 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaGMExE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:53:04 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so658648pad.10
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L+Sz2IVuoDsOjA/OdNA/RwE+wN4vMK7mg16vkFcvtWs=;
        b=KHcaWILYL4k2utNxuu6PW2NQfOS08W908FRGGrMGUJbyLf5mIqvrA3uJHQTnaM7fc9
         2BcyrEcOH0QMOTTrd+zaOlAWe+/AlVDeahhkljPto/QsDk+zhYb4D+s77hO8JyWYnPkW
         ToM7b8N+uB7bagbK814ZO4FNXFDPciAPTeUiNvK/GGZnr+EDyslQLjMFUoO4FT1Vm7+C
         MiZjhY0pMm0Zo/wEe7HDyI1XWXn9iGbRTQ0Ye4ld8YIABbrHxkwzc2buAqKiyyvTA5JW
         vPZq1sOWsGL42DwPluZStrp3H2M7CRbF5cPH8WZplYYtI2I7t9oXH6o4ejBre/2tDmC2
         +z1Q==
X-Received: by 10.68.57.194 with SMTP id k2mr8766112pbq.67.1405227183010;
        Sat, 12 Jul 2014 21:53:03 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id y3sm9090260pdy.27.2014.07.12.21.52.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:53:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:53:02 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253403>

v7 fixes all comments from Eric and Max. Jeff's two patches are
dropped because they have landed in latest master now. Diff against
v6:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 470f979..57999fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1215,7 +1215,7 @@ gc.prunereposexpire::
 	When 'git gc' is run, it will call
 	'prune --repos --expire 3.months.ago'.
 	Override the grace period with this config variable. The value
-	"now" may be used to disable the grace period and always prune
+	"now" may be used to disable the grace period and prune
 	$GIT_DIR/repos immediately.
 
 gc.reflogexpire::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index dc8503a..c83f476 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1010,15 +1010,13 @@ static int check_linked_checkout(struct branch_info *new,
 				  const char *name, const char *path)
 {
 	struct strbuf sb = STRBUF_INIT;
-	char *start, *end;
-	if (strbuf_read_file(&sb, path, 0) < 0)
-		return 0;
-	if (!starts_with(sb.buf, "ref:")) {
+	const char *start, *end;
+	if (strbuf_read_file(&sb, path, 0) < 0 ||
+	    !skip_prefix(sb.buf, "ref:", &start)) {
 		strbuf_release(&sb);
 		return 0;
 	}
 
-	start = sb.buf + 4;
 	while (isspace(*start))
 		start++;
 	end = start;
@@ -1200,8 +1198,14 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else
 		new->path = NULL; /* not an existing branch */
 
-	if (new->path)
-		check_linked_checkouts(new);
+	if (new->path) {
+		unsigned char sha1[20];
+		int flag;
+		char *head_ref = resolve_refdup("HEAD", sha1, 0, &flag);
+		if (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path))
+			check_linked_checkouts(new);
+		free(head_ref);
+	}
 
 	new->commit = lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
diff --git a/builtin/gc.c b/builtin/gc.c
index 1190183..0c65808 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -57,6 +57,17 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
 
+static int git_config_date_string(const char **output,
+				  const char *var, const char *value)
+{
+	if (value && strcmp(value, "now")) {
+		unsigned long now = approxidate("now");
+		if (approxidate(value) >= now)
+			return error(_("Invalid %s: '%s'"), var, value);
+	}
+	return git_config_string(output, var, value);
+}
+
 static int gc_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.packrefs")) {
@@ -86,22 +97,10 @@ static int gc_config(const char *var, const char *value, void *cb)
 		detach_auto = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "gc.pruneexpire")) {
-		if (value && strcmp(value, "now")) {
-			unsigned long now = approxidate("now");
-			if (approxidate(value) >= now)
-				return error(_("Invalid %s: '%s'"), var, value);
-		}
-		return git_config_string(&prune_expire, var, value);
-	}
-	if (!strcmp(var, "gc.prunereposexpire")) {
-		if (value && strcmp(value, "now")) {
-			unsigned long now = approxidate("now");
-			if (approxidate(value) >= now)
-				return error(_("Invalid %s: '%s'"), var, value);
-		}
-		return git_config_string(&prune_repos_expire, var, value);
-	}
+	if (!strcmp(var, "gc.pruneexpire"))
+		return git_config_date_string(&prune_expire, var, value);
+	if (!strcmp(var, "gc.prunereposexpire"))
+		return git_config_date_string(&prune_repos_expire, var, value);
 	return git_default_config(var, value, cb);
 }
 
@@ -295,7 +294,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
 		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
 			N_("prune unreferenced objects"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire},
+			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
diff --git a/builtin/prune.c b/builtin/prune.c
index 6db6bcc..28b7adf 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -112,23 +112,41 @@ static void prune_object_dir(const char *path)
 	}
 }
 
-static const char *prune_repo_dir(const char *id, struct stat *st)
+static int prune_repo_dir(const char *id, struct stat *st, struct strbuf *reason)
 {
 	char *path;
 	int fd, len;
+
+	if (!is_directory(git_path("repos/%s", id))) {
+		strbuf_addf(reason, _("Removing repos/%s: not a valid directory"), id);
+		return 1;
+	}
 	if (file_exists(git_path("repos/%s/locked", id)))
-		return NULL;
+		return 0;
 	if (stat(git_path("repos/%s/gitdir", id), st)) {
 		st->st_mtime = expire;
-		return _("gitdir does not exist");
+		strbuf_addf(reason, _("Removing repos/%s: gitdir file does not exist"), id);
+		return 1;
 	}
 	fd = open(git_path("repos/%s/gitdir", id), O_RDONLY);
+	if (fd < 0) {
+		st->st_mtime = expire;
+		strbuf_addf(reason, _("Removing repos/%s: unable to read gitdir file (%s)"),
+			    id, strerror(errno));
+		return 1;
+	}
 	len = st->st_size;
 	path = xmalloc(len + 1);
 	read_in_full(fd, path, len);
 	close(fd);
-	while (path[len - 1] == '\n' || path[len - 1] == '\r')
+	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
+	if (!len) {
+		st->st_mtime = expire;
+		strbuf_addf(reason, _("Removing repos/%s: invalid gitdir file"), id);
+		free(path);
+		return 1;
+	}
 	path[len] = '\0';
 	if (!file_exists(path)) {
 		struct stat st_link;
@@ -139,41 +157,48 @@ static const char *prune_repo_dir(const char *id, struct stat *st)
 		 */
 		if (!stat(git_path("repos/%s/link", id), &st_link) &&
 		    st_link.st_nlink > 1)
-			return NULL;
-		return _("gitdir points to non-existing file");
+			return 0;
+		strbuf_addf(reason, _("Removing repos/%s: gitdir file points to non-existent location"), id);
+		return 1;
 	}
 	free(path);
-	return NULL;
+	return 0;
 }
 
 static void prune_repos_dir(void)
 {
-	const char *reason;
+	struct strbuf reason = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
 	DIR *dir = opendir(git_path("repos"));
 	struct dirent *d;
-	int removed = 0;
+	int ret;
 	struct stat st;
 	if (!dir)
 		return;
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-		if ((reason = prune_repo_dir(d->d_name, &st)) != NULL &&
-		    st.st_mtime <= expire) {
-			struct strbuf sb = STRBUF_INIT;
-			if (show_only || verbose)
-				printf(_("Removing repos/%s: %s\n"), d->d_name, reason);
-			if (show_only)
-				continue;
-			strbuf_addstr(&sb, git_path("repos/%s", d->d_name));
-			remove_dir_recursively(&sb, 0);
-			strbuf_release(&sb);
-			removed = 1;
-		}
+		strbuf_reset(&reason);
+		if (!prune_repo_dir(d->d_name, &st, &reason) ||
+		    st.st_mtime > expire)
+			continue;
+		if (show_only || verbose)
+			printf("%s\n", reason.buf);
+		if (show_only)
+			continue;
+		strbuf_reset(&path);
+		strbuf_addstr(&path, git_path("repos/%s", d->d_name));
+		ret = remove_dir_recursively(&path, 0);
+		if (ret < 0 && errno == ENOTDIR)
+			ret = unlink(path.buf);
+		if (ret)
+			error(_("failed to remove: %s"), strerror(errno));
 	}
 	closedir(dir);
-	if (removed)
+	if (!show_only)
 		rmdir(git_path("repos"));
+	strbuf_release(&reason);
+	strbuf_release(&path);
 }
 
 /*
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index a219851..b0d97a0 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -54,6 +54,14 @@ test_expect_success 'detach if the same branch is already checked out' '
 	)
 '
 
+test_expect_success 'not detach on re-checking out current branch' '
+	(
+		cd there &&
+		git checkout newmaster &&
+		git symbolic-ref HEAD
+	)
+'
+
 test_expect_success 'checkout --to from a bare repo' '
 	(
 		git clone --bare . bare &&
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
new file mode 100755
index 0000000..4ccfa4e
--- /dev/null
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='prune $GIT_DIR/repos'
+
+. ./test-lib.sh
+
+test_expect_success 'prune --repos on normal repo' '
+	git prune --repos &&
+	test_must_fail git prune --repos abc
+'
+
+test_expect_success 'prune files inside $GIT_DIR/repos' '
+	mkdir .git/repos &&
+	: >.git/repos/abc &&
+	git prune --repos --verbose >actual &&
+	cat >expect <<EOF &&
+Removing repos/abc: not a valid directory
+EOF
+	test_i18ncmp expect actual &&
+	! test -f .git/repos/abc &&
+	! test -d .git/repos
+'
+
+test_expect_success 'prune directories without gitdir' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	cat >expect <<EOF &&
+Removing repos/def: gitdir file does not exist
+EOF
+	git prune --repos --verbose >actual &&
+	test_i18ncmp expect actual &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success POSIXPERM 'prune directories with unreadable gitdir' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	: >.git/repos/def/gitdir &&
+	chmod u-r .git/repos/def/gitdir &&
+	git prune --repos --verbose >actual &&
+	test_i18ngrep "Removing repos/def: unable to read gitdir file" actual &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success 'prune directories with invalid gitdir' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	: >.git/repos/def/gitdir &&
+	git prune --repos --verbose >actual &&
+	test_i18ngrep "Removing repos/def: invalid gitdir file" actual &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success 'prune directories with gitdir pointing to nowhere' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	echo "$TRASH_DIRECTORY"/nowhere >.git/repos/def/gitdir &&
+	git prune --repos --verbose >actual &&
+	test_i18ngrep "Removing repos/def: gitdir file points to non-existent location" actual &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success 'not prune locked checkout' '
+	test_when_finished rm -r .git/repos
+	mkdir -p .git/repos/ghi &&
+	: >.git/repos/ghi/locked &&
+	git prune --repos &&
+	test -d .git/repos/ghi
+'
+
+test_expect_success 'not prune recent checkouts' '
+	test_when_finished rm -r .git/repos
+	mkdir zz &&
+	mkdir -p .git/repos/jlm &&
+	echo "$TRASH_DIRECTORY"/zz >.git/repos/jlm/gitdir &&
+	git prune --repos --verbose &&
+	test -d .git/repos/jlm
+'
+
+test_done

-- 
1.9.1.346.ga2b5940
