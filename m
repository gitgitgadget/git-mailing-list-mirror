From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Convert isatty() calls to git_isatty()
Date: Fri,  3 Feb 2012 15:35:01 +0700
Message-ID: <1328258101-10636-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 09:31:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtEXv-0003Or-44
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 09:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab2BCIa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 03:30:58 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38794 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab2BCIa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 03:30:57 -0500
Received: by dadp15 with SMTP id p15so2557658dad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 00:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=7XaytL2I7En6Alq6sHtS0Rn12wTat+dBKwTtkzrrDZ8=;
        b=Kfp6aNDX+B/iBJhgzKTy43Mgf4Mwuj39C9NzSzDDMSsKRQfXgl5FNX3hs7F44kpCck
         l9XSnxA3Pz9UP4VbpINXuQrLO5izB+05Ao1Ueph1ClwzqbCPCl5xOMDOuq8FlUrjPA8j
         3YQxww6X0YgMIkeVe9BYL8FTEb5XMK5NKJCO4=
Received: by 10.68.189.102 with SMTP id gh6mr15849425pbc.4.1328257856644;
        Fri, 03 Feb 2012 00:30:56 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id z5sm11442938pbc.5.2012.02.03.00.30.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 00:30:55 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 15:35:01 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189743>

isatty() is used to check for interactive use cases. However if pager i=
s
set up, standard file handles may be redirected and istty() calls later
on no longer reflect the original state.

Convert isatty() calls to git_isatty() and allow git_isatty() to cache
tty info before pager is set up.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c         |    2 +-
 builtin/fsck.c           |    2 +-
 builtin/merge.c          |    4 ++--
 builtin/pack-objects.c   |    2 +-
 builtin/pack-redundant.c |    2 +-
 builtin/prune-packed.c   |    2 +-
 builtin/prune.c          |    2 +-
 builtin/revert.c         |    2 +-
 builtin/shortlog.c       |    4 ++--
 builtin/unpack-objects.c |    2 +-
 cache.h                  |    1 +
 color.c                  |    2 +-
 pager.c                  |   17 +++++++++++++++++
 transport.c              |    4 ++--
 14 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eba1377..cc72f13 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -672,7 +672,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 =3D "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
-		if (isatty(0))
+		if (git_isatty(0))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
 			die_errno(_("could not read log from standard input"));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8c479a7..0b4e8cf 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -637,7 +637,7 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 	argc =3D parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
=20
 	if (show_progress =3D=3D -1)
-		show_progress =3D isatty(2);
+		show_progress =3D git_isatty(2);
 	if (verbose)
 		show_progress =3D 0;
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index 62c7b68..49b9176 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -714,7 +714,7 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
=20
 		o.renormalize =3D option_renormalize;
 		o.show_rename_progress =3D
-			show_progress =3D=3D -1 ? isatty(2) : show_progress;
+			show_progress =3D=3D -1 ? git_isatty(2) : show_progress;
=20
 		for (x =3D 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
@@ -1129,7 +1129,7 @@ static int default_edit_option(void)
 	/* Use editor if stdin and stdout are the same and is a tty */
 	return (!fstat(0, &st_stdin) &&
 		!fstat(1, &st_stdout) &&
-		isatty(0) &&
+		git_isatty(0) &&
 		st_stdin.st_dev =3D=3D st_stdout.st_dev &&
 		st_stdin.st_ino =3D=3D st_stdout.st_ino &&
 		st_stdin.st_mode =3D=3D st_stdout.st_mode);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0f2e7b8..4468c84 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2328,7 +2328,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level =3D core_compression_level;
=20
-	progress =3D isatty(2);
+	progress =3D git_isatty(2);
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f5c6afc..8197c9e 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -646,7 +646,7 @@ int cmd_pack_redundant(int argc, const char **argv,=
 const char *prefix)
=20
 	/* ignore objects given on stdin */
 	llist_init(&ignore);
-	if (!isatty(0)) {
+	if (!git_isatty(0)) {
 		while (fgets(buf, sizeof(buf), stdin)) {
 			sha1 =3D xmalloc(20);
 			if (get_sha1_hex(buf, sha1))
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f9463de..498c6e9 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -71,7 +71,7 @@ void prune_packed_objects(int opts)
=20
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int opts =3D isatty(2) ? VERBOSE : 0;
+	int opts =3D git_isatty(2) ? VERBOSE : 0;
 	const struct option prune_packed_options[] =3D {
 		OPT_BIT('n', "dry-run", &opts, "dry run", DRY_RUN),
 		OPT_NEGBIT('q', "quiet", &opts, "be quiet", VERBOSE),
diff --git a/builtin/prune.c b/builtin/prune.c
index 58d7cb8..821772e 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -158,7 +158,7 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 	}
=20
 	if (show_progress =3D=3D -1)
-		show_progress =3D isatty(2);
+		show_progress =3D git_isatty(2);
 	if (show_progress)
 		progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
=20
diff --git a/builtin/revert.c b/builtin/revert.c
index e6840f2..6f87c9b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -199,7 +199,7 @@ int cmd_revert(int argc, const char **argv, const c=
har *prefix)
 	int res;
=20
 	memset(&opts, 0, sizeof(opts));
-	if (isatty(0))
+	if (git_isatty(0))
 		opts.edit =3D 1;
 	opts.action =3D REPLAY_REVERT;
 	git_config(git_default_config, NULL);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 37f3193..c77b472 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -289,10 +289,10 @@ parse_done:
 	log.abbrev =3D rev.abbrev;
=20
 	/* assume HEAD if from a tty */
-	if (!nongit && !rev.pending.nr && isatty(0))
+	if (!nongit && !rev.pending.nr && git_isatty(0))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr =3D=3D 0) {
-		if (isatty(0))
+		if (git_isatty(0))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		read_from_stdin(&log);
 	}
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 14e04e6..4aaba69 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -501,7 +501,7 @@ int cmd_unpack_objects(int argc, const char **argv,=
 const char *prefix)
=20
 	git_config(git_default_config, NULL);
=20
-	quiet =3D !isatty(2);
+	quiet =3D !git_isatty(2);
=20
 	for (i =3D 1 ; i < argc; i++) {
 		const char *arg =3D argv[i];
diff --git a/cache.h b/cache.h
index 9bd8c2d..4073fc9 100644
--- a/cache.h
+++ b/cache.h
@@ -1176,6 +1176,7 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
+extern int git_isatty(int);
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/color.c b/color.c
index e8e2681..7151b48 100644
--- a/color.c
+++ b/color.c
@@ -183,7 +183,7 @@ int git_config_colorbool(const char *var, const cha=
r *value)
 static int check_auto_color(void)
 {
 	if (color_stdout_is_tty < 0)
-		color_stdout_is_tty =3D isatty(1);
+		color_stdout_is_tty =3D git_isatty(1);
 	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
 		char *term =3D getenv("TERM");
 		if (term && strcmp(term, "dumb"))
diff --git a/pager.c b/pager.c
index 975955b..a9380ab 100644
--- a/pager.c
+++ b/pager.c
@@ -72,12 +72,17 @@ const char *git_pager(int stdout_is_tty)
 void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
+	int i;
=20
 	if (!pager)
 		return;
=20
 	setenv("GIT_PAGER_IN_USE", "true", 1);
=20
+	/* cache tty info */
+	for (i =3D 0; i <=3D 2; i++)
+		git_isatty(i);
+
 	/* spawn the pager */
 	pager_argv[0] =3D pager;
 	pager_process.use_shell =3D 1;
@@ -110,3 +115,15 @@ int pager_in_use(void)
 	env =3D getenv("GIT_PAGER_IN_USE");
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
+
+int git_isatty(int fd)
+{
+	static int tty[3] =3D { -1, -1, -1 };
+
+	if (fd < 0 || fd > 2)
+		return isatty(fd);
+
+	if (tty[fd] =3D=3D -1)
+		tty[fd] =3D isatty(fd);
+	return tty[fd];
+}
diff --git a/transport.c b/transport.c
index cac0c06..af48f7c 100644
--- a/transport.c
+++ b/transport.c
@@ -880,7 +880,7 @@ struct transport *transport_get(struct remote *remo=
te, const char *url)
 	const char *helper;
 	struct transport *ret =3D xcalloc(1, sizeof(*ret));
=20
-	ret->progress =3D isatty(2);
+	ret->progress =3D git_isatty(2);
=20
 	if (!remote)
 		die("No remote provided to transport_get()");
@@ -997,7 +997,7 @@ void transport_set_verbosity(struct transport *tran=
sport, int verbosity,
 	 *   2. Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
 	 *   3. Report progress if isatty(2) is 1.
 	 **/
-	transport->progress =3D force_progress || (verbosity >=3D 0 && isatty=
(2));
+	transport->progress =3D force_progress || (verbosity >=3D 0 && git_is=
atty(2));
 }
=20
 int transport_push(struct transport *transport,
--=20
1.7.8.36.g69ee2
