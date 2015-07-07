From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 00/44] Make git-am a builtin
Date: Tue,  7 Jul 2015 22:20:18 +0800
Message-ID: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:21:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTkS-0003xU-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423AbbGGOVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:21:20 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36028 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138AbbGGOVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:16 -0400
Received: by pacgz10 with SMTP id gz10so40432142pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=YZT7QjGXeOAHs1iYXFg/4CqlwleXXf5J3vQO5E2skhA=;
        b=SCqV7muSPytIbQGeSdisimAO0FDFkVh/4QAtWZ/pSHGN2iq9O4euSesjC2mqm7OFlr
         +uV88wJIekZ/EyvwNcXU+fDCyfq7iTpRhum9gAgu4RSK284GaSwdKo9/ePEqzwyzM+X2
         m4U8HCBqg5VNu49qAs5fqd2voG4pkOKXteqT51b/wAecfeTwmUs1UwtGwonP8GERwN6f
         WAqwlOwKewgs1YQpjazwiomm+1wykCX8QuMJpoPSkxWuYjsYuuLIvWoCvRm9ZWkaeTsN
         WB9wSj+k+d0BnG1ISK7aCtb7xMYEGzgVdO3mzbBdoP2HhxxZUbQkifTdiQuQra6EL8Lq
         sH0A==
X-Received: by 10.68.241.69 with SMTP id wg5mr9375729pbc.120.1436278876131;
        Tue, 07 Jul 2015 07:21:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273520>

This patch series depends on pt/pull-builtin.

This is a re-roll of [v4]. Thanks Torsten, Stefan, Junio for the reviews last
round. Interdiff below.

Previous versions:

[WIP v1] http://thread.gmane.org/gmane.comp.version-control.git/270048
[WIP v2] http://thread.gmane.org/gmane.comp.version-control.git/271381
[WIP v3] http://thread.gmane.org/gmane.comp.version-control.git/271967
[v4] http://thread.gmane.org/gmane.comp.version-control.git/272876

git-am is a commonly used command for applying a series of patches from a
mailbox to the current branch. Currently, it is implemented by the shell script
git-am.sh. However, compared to C, shell scripts have certain deficiencies:
they need to spawn a lot of processes, introduce a lot of dependencies and
cannot take advantage of git's internal caches.

This patch series rewrites git-am.sh into optimized C builtin/am.c, and is
part of my GSoC project to rewrite git-pull and git-am into C builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (44):
  wrapper: implement xopen()
  wrapper: implement xfopen()
  builtin-am: implement skeletal builtin am
  builtin-am: implement patch queue mechanism
  builtin-am: split out mbox/maildir patches with git-mailsplit
  builtin-am: auto-detect mbox patches
  builtin-am: extract patch and commit info with git-mailinfo
  builtin-am: apply patch with git-apply
  builtin-am: implement committing applied patch
  builtin-am: refuse to apply patches if index is dirty
  builtin-am: implement --resolved/--continue
  builtin-am: implement --skip
  builtin-am: implement --abort
  builtin-am: reject patches when there's a session in progress
  builtin-am: implement -q/--quiet
  builtin-am: exit with user friendly message on failure
  builtin-am: implement -s/--signoff
  cache-tree: introduce write_index_as_tree()
  builtin-am: implement --3way, am.threeWay
  builtin-am: implement --rebasing mode
  builtin-am: bypass git-mailinfo when --rebasing
  builtin-am: handle stray state directory
  builtin-am: implement -u/--utf8
  builtin-am: implement -k/--keep, --keep-non-patch
  builtin-am: implement --[no-]message-id, am.messageid
  builtin-am: support --keep-cr, am.keepcr
  builtin-am: implement --[no-]scissors
  builtin-am: pass git-apply's options to git-apply
  builtin-am: implement --ignore-date
  builtin-am: implement --committer-date-is-author-date
  builtin-am: implement -S/--gpg-sign, commit.gpgsign
  builtin-am: invoke post-rewrite hook
  builtin-am: support automatic notes copying
  builtin-am: invoke applypatch-msg hook
  builtin-am: invoke pre-applypatch hook
  builtin-am: invoke post-applypatch hook
  builtin-am: rerere support
  builtin-am: support and auto-detect StGit patches
  builtin-am: support and auto-detect StGit series files
  builtin-am: support and auto-detect mercurial patches
  builtin-am: implement -i/--interactive
  builtin-am: implement legacy -b/--binary option
  builtin-am: check for valid committer ident
  builtin-am: remove redirection to git-am.sh

 Makefile                                |    2 +-
 builtin.h                               |    1 +
 builtin/am.c                            | 2331 +++++++++++++++++++++++++++++++
 cache-tree.c                            |   29 +-
 cache-tree.h                            |    1 +
 git-am.sh => contrib/examples/git-am.sh |    0
 git-compat-util.h                       |    2 +
 git.c                                   |    1 +
 wrapper.c                               |   56 +
 9 files changed, 2410 insertions(+), 13 deletions(-)
 create mode 100644 builtin/am.c
 rename git-am.sh => contrib/examples/git-am.sh (100%)

diff --git a/builtin/am.c b/builtin/am.c
index fb91145..c548129 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -71,8 +71,8 @@ static int linelen(const char *msg)
  */
 static int str_isspace(const char *str)
 {
-	while (*str)
-		if (!isspace(*(str)++))
+	for (; *str; str++)
+		if (!isspace(*str))
 			return 0;
 
 	return 1;
@@ -94,8 +94,8 @@ enum keep_type {
 
 enum scissors_type {
 	SCISSORS_UNSET = -1,
-	SCISSORS_TRUE,  /* pass --scissors to git-mailinfo */
-	SCISSORS_FALSE  /* pass --no-scissors to git-mailinfo */
+	SCISSORS_FALSE = 0,  /* pass --no-scissors to git-mailinfo */
+	SCISSORS_TRUE        /* pass --scissors to git-mailinfo */
 };
 
 struct am_state {
@@ -160,8 +160,7 @@ struct am_state {
  */
 static void am_state_init(struct am_state *state, const char *dir)
 {
-	const char *quiet;
-	int sign_commit;
+	int gpgsign;
 
 	memset(state, 0, sizeof(*state));
 
@@ -172,10 +171,6 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	git_config_get_bool("am.threeway", &state->threeway);
 
-	quiet = getenv("GIT_QUIET");
-	if (quiet && *quiet)
-		state->quiet = 1;
-
 	state->utf8 = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
@@ -184,8 +179,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	argv_array_init(&state->git_apply_opts);
 
-	if (!git_config_get_bool("commit.gpgsign", &sign_commit))
-		state->sign_commit = sign_commit ? "" : NULL;
+	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
+		state->sign_commit = gpgsign ? "" : NULL;
 }
 
 /**
@@ -918,7 +913,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 			fprintf(out, "From: %s\n", str);
 		else if (skip_prefix(sb.buf, "# Date ", &str)) {
 			unsigned long timestamp;
-			long tz;
+			long tz, tz2;
 			char *end;
 
 			errno = 0;
@@ -942,10 +937,11 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 			 * however git's timezone is in hours + minutes east of
 			 * UTC. Convert it.
 			 */
-			tz = tz / (60 * 60) * 100 + tz % (60 * 60);
-			tz = -tz;
+			tz2 = labs(tz) / 3600 * 100 + labs(tz) % 3600 / 60;
+			if (tz > 0)
+				tz2 = -tz2;
 
-			fprintf(out, "Date: %s\n", show_date(timestamp, tz, DATE_RFC2822));
+			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_RFC2822));
 		} else if (starts_with(sb.buf, "# ")) {
 			continue;
 		} else {
@@ -1555,7 +1551,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 }
 
 /**
- * Builds a index that contains just the blobs needed for a 3way merge.
+ * Builds an index that contains just the blobs needed for a 3way merge.
  */
 static int build_fake_ancestor(const struct am_state *state, const char *index_file)
 {
diff --git a/wrapper.c b/wrapper.c
index f127eb3..e451463 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -197,20 +197,30 @@ int xopen(const char *path, int oflag, ...)
 	mode_t mode = 0;
 	va_list ap;
 
+	/*
+	 * va_arg() will have undefined behavior if the specified type is not
+	 * compatible with the argument type. Since integers are promoted to
+	 * ints, we fetch the next argument as an int, and then cast it to a
+	 * mode_t to avoid undefined behavior.
+	 */
 	va_start(ap, oflag);
 	if (oflag & O_CREAT)
-		mode = va_arg(ap, mode_t);
+		mode = va_arg(ap, int);
 	va_end(ap);
 
-	assert(path);
-
 	for (;;) {
 		int fd = open(path, oflag, mode);
 		if (fd >= 0)
 			return fd;
 		if (errno == EINTR)
 			continue;
-		die_errno(_("could not open '%s'"), path);
+
+		if ((oflag & O_RDWR) == O_RDWR)
+			die_errno(_("could not open '%s' for reading and writing"), path);
+		else if ((oflag & O_WRONLY) == O_WRONLY)
+			die_errno(_("could not open '%s' for writing"), path);
+		else
+			die_errno(_("could not open '%s' for reading"), path);
 	}
 }
 
@@ -341,16 +351,19 @@ int xdup(int fd)
  */
 FILE *xfopen(const char *path, const char *mode)
 {
-	assert(path);
-	assert(mode);
-
 	for (;;) {
 		FILE *fp = fopen(path, mode);
 		if (fp)
 			return fp;
 		if (errno == EINTR)
 			continue;
-		die_errno(_("could not open '%s'"), path);
+
+		if (*mode && mode[1] == '+')
+			die_errno(_("could not open '%s' for reading and writing"), path);
+		else if (*mode == 'w' || *mode == 'a')
+			die_errno(_("could not open '%s' for writing"), path);
+		else
+			die_errno(_("could not open '%s' for reading"), path);
 	}
 }
 

-- 
2.5.0.rc1.76.gf60a929
