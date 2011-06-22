From: Jeff King <peff@peff.net>
Subject: [PATCHv2 9/9] upload-archive: allow user to turn off filters
Date: Tue, 21 Jun 2011 21:35:45 -0400
Message-ID: <20110622013545.GI30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:35:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCMF-0000d3-Ex
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739Ab1FVBfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 21:35:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60640
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757714Ab1FVBft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:35:49 -0400
Received: (qmail 7706 invoked by uid 107); 22 Jun 2011 01:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:36:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:35:45 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176212>

Some tar filters may be very expensive to run, so sites do
not want to expose them via upload-archive. This patch lets
users configure tar.<filter>.remote to turn them off.

By default, gzip filters are left on, as they are about as
expensive as creating zip archives.

Signed-off-by: Jeff King <peff@peff.net>
---
This is my response to Ren=C3=A9's:

  [archive]
    remoteFormats =3D tar zip tgz tar.gz

It's a little more verbose, but it lets you turn individual formats off
and on without having to enumerate the whole list.

By itself, this may not be that useful. It seems unlikely that somebody
would both to configure a filter globally on a machine serving
upload-pack, and then not want it remotely available. You can also
disable the builtin gzip filter, but it's not really much more expensiv=
e
than zip.

But two possible follow-on patches would be:

  1. tar.remote and zip.remote, to turn those formats off. I can see
     wanting to turn off _all_ compression, including zip and gzip, if
     your CPU is terrible (but git servers are almost always I/O bound,
     so I don't know how common that will be). I can also see wanting t=
o
     turn off uncompressed tar, because bandwidth is expensive, CPU is
     cheap, and source code repositories compress well.

  2. adding default bzip2 config; this should be off by default for
     upload-archive

 Documentation/git-archive.txt |    6 ++++++
 archive-tar.c                 |   11 ++++++++++-
 archive-zip.c                 |    2 +-
 archive.c                     |   11 ++++++-----
 archive.h                     |    3 ++-
 builtin/archive.c             |    2 +-
 builtin/upload-archive.c      |    2 +-
 t/t5000-tar-tree.sh           |   25 ++++++++++++++++++++++---
 8 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index 8b0080a..1320c87 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -114,6 +114,12 @@ tar.<format>.command::
 The "tar.gz" and "tgz" formats are defined automatically and default t=
o
 `gzip -cn`. You may override them with custom commands.
=20
+tar.<format>.remote::
+	If true, enable `<format>` for use by remote clients via
+	linkgit:git-upload-archive[1]. Defaults to false for
+	user-defined formats, but true for the "tar.gz" and "tgz"
+	formats.
+
 ATTRIBUTES
 ----------
=20
diff --git a/archive-tar.c b/archive-tar.c
index f470ebe..01ab43f 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -274,6 +274,13 @@ static int tar_filter_config(const char *var, cons=
t char *value, void *data)
 		ar->data =3D xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(type, "remote")) {
+		if (git_config_bool(var, value))
+			tf->flags |=3D ARCHIVER_REMOTE;
+		else
+			tf->flags &=3D ~ARCHIVER_REMOTE;
+		return 0;
+	}
=20
 	return 0;
 }
@@ -349,7 +356,7 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
 static struct archiver tar_archiver =3D {
 	"tar",
 	write_tar_archive,
-	0
+	ARCHIVER_REMOTE
 };
=20
 void init_tar_archiver(void)
@@ -358,7 +365,9 @@ void init_tar_archiver(void)
 	register_archiver(&tar_archiver);
=20
 	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tar.gz.remote", "true", NULL);
 	git_config(git_tar_config, NULL);
 	for (i =3D 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
diff --git a/archive-zip.c b/archive-zip.c
index 42df660..3c102a1 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -283,7 +283,7 @@ static int write_zip_archive(const struct archiver =
*ar,
 static struct archiver zip_archiver =3D {
 	"zip",
 	write_zip_archive,
-	ARCHIVER_WANT_COMPRESSION_LEVELS
+	ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE
 };
=20
 void init_zip_archiver(void)
diff --git a/archive.c b/archive.c
index 41065a8..2a7a28e 100644
--- a/archive.c
+++ b/archive.c
@@ -299,7 +299,7 @@ static void parse_treeish_arg(const char **argv,
=20
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args,
-		const char *name_hint)
+		const char *name_hint, int is_remote)
 {
 	const char *format =3D NULL;
 	const char *base =3D NULL;
@@ -356,7 +356,8 @@ static int parse_archive_args(int argc, const char =
**argv,
=20
 	if (list) {
 		for (i =3D 0; i < nr_archivers; i++)
-			printf("%s\n", archivers[i]->name);
+			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
+				printf("%s\n", archivers[i]->name);
 		exit(0);
 	}
=20
@@ -369,7 +370,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	if (argc < 1)
 		usage_with_options(archive_usage, opts);
 	*ar =3D lookup_archiver(format);
-	if (!*ar)
+	if (!*ar || (is_remote && !((*ar)->flags & ARCHIVER_REMOTE)))
 		die("Unknown archive format '%s'", format);
=20
 	args->compression_level =3D Z_DEFAULT_COMPRESSION;
@@ -390,7 +391,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 }
=20
 int write_archive(int argc, const char **argv, const char *prefix,
-		  int setup_prefix, const char *name_hint)
+		  int setup_prefix, const char *name_hint, int remote)
 {
 	int nongit =3D 0;
 	const struct archiver *ar =3D NULL;
@@ -403,7 +404,7 @@ int write_archive(int argc, const char **argv, cons=
t char *prefix,
 	init_tar_archiver();
 	init_zip_archiver();
=20
-	argc =3D parse_archive_args(argc, argv, &ar, &args, name_hint);
+	argc =3D parse_archive_args(argc, argv, &ar, &args, name_hint, remote=
);
 	if (nongit) {
 		/*
 		 * We know this will die() with an error, so we could just
diff --git a/archive.h b/archive.h
index 202d528..2b0884f 100644
--- a/archive.h
+++ b/archive.h
@@ -15,6 +15,7 @@ struct archiver_args {
 };
=20
 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
+#define ARCHIVER_REMOTE 2
 struct archiver {
 	const char *name;
 	int (*write_archive)(const struct archiver *, struct archiver_args *)=
;
@@ -29,7 +30,7 @@ extern void init_zip_archiver(void);
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, co=
nst unsigned char *sha1, const char *path, size_t pathlen, unsigned int=
 mode, void *buffer, unsigned long size);
=20
 extern int write_archive_entries(struct archiver_args *args, write_arc=
hive_entry_fn_t write_entry);
-extern int write_archive(int argc, const char **argv, const char *pref=
ix, int setup_prefix, const char *name_hint);
+extern int write_archive(int argc, const char **argv, const char *pref=
ix, int setup_prefix, const char *name_hint, int remote);
=20
 const char *archive_format_from_filename(const char *filename);
=20
diff --git a/builtin/archive.c b/builtin/archive.c
index 2578cf5..883c009 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -106,5 +106,5 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
=20
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
=20
-	return write_archive(argc, argv, prefix, 1, output);
+	return write_archive(argc, argv, prefix, 1, output, 0);
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index e6bb97d..2d0b383 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -64,7 +64,7 @@ static int run_upload_archive(int argc, const char **=
argv, const char *prefix)
 	sent_argv[sent_argc] =3D NULL;
=20
 	/* parse all options sent by the client */
-	return write_archive(sent_argc, sent_argv, prefix, 0, NULL);
+	return write_archive(sent_argc, sent_argv, prefix, 0, NULL, 1);
 }
=20
 __attribute__((format (printf, 1, 2)))
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 070250e..9e3ba98 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -256,7 +256,8 @@ test_expect_success 'git-archive --prefix=3Dolde-' =
'
=20
 test_expect_success 'setup tar filters' '
 	git config tar.tar.foo.command "tr ab ba" &&
-	git config tar.bar.command "tr ab ba"
+	git config tar.bar.command "tr ab ba" &&
+	git config tar.bar.remote true
 '
=20
 test_expect_success 'archive --list mentions user filter' '
@@ -265,9 +266,9 @@ test_expect_success 'archive --list mentions user f=
ilter' '
 	grep "^bar\$" output
 '
=20
-test_expect_success 'archive --list shows remote user filters' '
+test_expect_success 'archive --list shows only enabled remote filters'=
 '
 	git archive --list --remote=3D. >output &&
-	grep "^tar\.foo\$" output &&
+	! grep "^tar\.foo\$" output &&
 	grep "^bar\$" output
 '
=20
@@ -297,6 +298,13 @@ test_expect_success 'extension matching requires d=
ot' '
 	test_cmp b.tar config-implicittar.foo
 '
=20
+test_expect_success 'only enabled filters are available remotely' '
+	test_must_fail git archive --remote=3D. --format=3Dtar.foo HEAD \
+		>remote.tar.foo &&
+	git archive --remote=3D. --format=3Dbar >remote.bar HEAD &&
+	test_cmp remote.bar config.bar
+'
+
 if $GZIP --version >/dev/null 2>&1; then
 	test_set_prereq GZIP
 else
@@ -333,4 +341,15 @@ test_expect_success GZIP,GUNZIP 'extract tgz file'=
 '
 	test_cmp b.tar j.tar
 '
=20
+test_expect_success GZIP 'remote tar.gz is allowed by default' '
+	git archive --remote=3D. --format=3Dtar.gz HEAD >remote.tar.gz &&
+	test_cmp j.tgz remote.tar.gz
+'
+
+test_expect_success GZIP 'remote tar.gz can be disabled' '
+	git config tar.tar.gz.remote false &&
+	test_must_fail git archive --remote=3D. --format=3Dtar.gz HEAD \
+		>remote.tar.gz
+'
+
 test_done
--=20
1.7.5.4.44.g4b107
