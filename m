From: Jeff King <peff@github.com>
Subject: Re: [PATCHv2 9/9] upload-archive: allow user to turn off filters
Date: Tue, 21 Jun 2011 23:17:35 -0400
Message-ID: <20110622031735.GA13879@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
 <20110622013545.GI30604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 05:17:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZDwl-0001RL-Cr
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 05:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab1FVDRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 23:17:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57284
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757714Ab1FVDRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 23:17:37 -0400
Received: (qmail 9482 invoked by uid 107); 22 Jun 2011 03:17:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 23:17:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 23:17:35 -0400
Content-Disposition: inline
In-Reply-To: <20110622013545.GI30604@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176217>

On Tue, Jun 21, 2011 at 09:35:45PM -0400, Jeff King wrote:

> Some tar filters may be very expensive to run, so sites do
> not want to expose them via upload-archive. This patch lets
> users configure tar.<filter>.remote to turn them off.
> 
> By default, gzip filters are left on, as they are about as
> expensive as creating zip archives.

Argh, sorry, wrong version of the patch. This one has a slight
refactoring typo that makes it not compile. Correct patch is below.

-- >8 --
Subject: upload-archive: allow user to turn off filters

Some tar filters may be very expensive to run, so sites do
not want to expose them via upload-archive. This patch lets
users configure tar.<filter>.remote to turn them off.

By default, gzip filters are left on, as they are about as
expensive as creating zip archives.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-archive.txt |    6 ++++++
 archive-tar.c                 |   11 ++++++++++-
 archive-zip.c                 |    2 +-
 archive.c                     |   11 ++++++-----
 archive.h                     |    3 ++-
 builtin/archive.c             |    2 +-
 builtin/upload-archive.c      |    2 +-
 t/t5000-tar-tree.sh           |   25 ++++++++++++++++++++++---
 8 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 8b0080a..1320c87 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -114,6 +114,12 @@ tar.<format>.command::
 The "tar.gz" and "tgz" formats are defined automatically and default to
 `gzip -cn`. You may override them with custom commands.
 
+tar.<format>.remote::
+	If true, enable `<format>` for use by remote clients via
+	linkgit:git-upload-archive[1]. Defaults to false for
+	user-defined formats, but true for the "tar.gz" and "tgz"
+	formats.
+
 ATTRIBUTES
 ----------
 
diff --git a/archive-tar.c b/archive-tar.c
index f470ebe..20af005 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -274,6 +274,13 @@ static int tar_filter_config(const char *var, const char *value, void *data)
 		ar->data = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(type, "remote")) {
+		if (git_config_bool(var, value))
+			ar->flags |= ARCHIVER_REMOTE;
+		else
+			ar->flags &= ~ARCHIVER_REMOTE;
+		return 0;
+	}
 
 	return 0;
 }
@@ -349,7 +356,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 static struct archiver tar_archiver = {
 	"tar",
 	write_tar_archive,
-	0
+	ARCHIVER_REMOTE
 };
 
 void init_tar_archiver(void)
@@ -358,7 +365,9 @@ void init_tar_archiver(void)
 	register_archiver(&tar_archiver);
 
 	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tar.gz.remote", "true", NULL);
 	git_config(git_tar_config, NULL);
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
diff --git a/archive-zip.c b/archive-zip.c
index 42df660..3c102a1 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -283,7 +283,7 @@ static int write_zip_archive(const struct archiver *ar,
 static struct archiver zip_archiver = {
 	"zip",
 	write_zip_archive,
-	ARCHIVER_WANT_COMPRESSION_LEVELS
+	ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE
 };
 
 void init_zip_archiver(void)
diff --git a/archive.c b/archive.c
index 41065a8..2a7a28e 100644
--- a/archive.c
+++ b/archive.c
@@ -299,7 +299,7 @@ static void parse_treeish_arg(const char **argv,
 
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args,
-		const char *name_hint)
+		const char *name_hint, int is_remote)
 {
 	const char *format = NULL;
 	const char *base = NULL;
@@ -356,7 +356,8 @@ static int parse_archive_args(int argc, const char **argv,
 
 	if (list) {
 		for (i = 0; i < nr_archivers; i++)
-			printf("%s\n", archivers[i]->name);
+			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
+				printf("%s\n", archivers[i]->name);
 		exit(0);
 	}
 
@@ -369,7 +370,7 @@ static int parse_archive_args(int argc, const char **argv,
 	if (argc < 1)
 		usage_with_options(archive_usage, opts);
 	*ar = lookup_archiver(format);
-	if (!*ar)
+	if (!*ar || (is_remote && !((*ar)->flags & ARCHIVER_REMOTE)))
 		die("Unknown archive format '%s'", format);
 
 	args->compression_level = Z_DEFAULT_COMPRESSION;
@@ -390,7 +391,7 @@ static int parse_archive_args(int argc, const char **argv,
 }
 
 int write_archive(int argc, const char **argv, const char *prefix,
-		  int setup_prefix, const char *name_hint)
+		  int setup_prefix, const char *name_hint, int remote)
 {
 	int nongit = 0;
 	const struct archiver *ar = NULL;
@@ -403,7 +404,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	init_tar_archiver();
 	init_zip_archiver();
 
-	argc = parse_archive_args(argc, argv, &ar, &args, name_hint);
+	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (nongit) {
 		/*
 		 * We know this will die() with an error, so we could just
diff --git a/archive.h b/archive.h
index 202d528..2b0884f 100644
--- a/archive.h
+++ b/archive.h
@@ -15,6 +15,7 @@ struct archiver_args {
 };
 
 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
+#define ARCHIVER_REMOTE 2
 struct archiver {
 	const char *name;
 	int (*write_archive)(const struct archiver *, struct archiver_args *);
@@ -29,7 +30,7 @@ extern void init_zip_archiver(void);
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
-extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix, const char *name_hint);
+extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix, const char *name_hint, int remote);
 
 const char *archive_format_from_filename(const char *filename);
 
diff --git a/builtin/archive.c b/builtin/archive.c
index 2578cf5..883c009 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -106,5 +106,5 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	return write_archive(argc, argv, prefix, 1, output);
+	return write_archive(argc, argv, prefix, 1, output, 0);
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index e6bb97d..2d0b383 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -64,7 +64,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	sent_argv[sent_argc] = NULL;
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argc, sent_argv, prefix, 0, NULL);
+	return write_archive(sent_argc, sent_argv, prefix, 0, NULL, 1);
 }
 
 __attribute__((format (printf, 1, 2)))
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 070250e..9e3ba98 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -256,7 +256,8 @@ test_expect_success 'git-archive --prefix=olde-' '
 
 test_expect_success 'setup tar filters' '
 	git config tar.tar.foo.command "tr ab ba" &&
-	git config tar.bar.command "tr ab ba"
+	git config tar.bar.command "tr ab ba" &&
+	git config tar.bar.remote true
 '
 
 test_expect_success 'archive --list mentions user filter' '
@@ -265,9 +266,9 @@ test_expect_success 'archive --list mentions user filter' '
 	grep "^bar\$" output
 '
 
-test_expect_success 'archive --list shows remote user filters' '
+test_expect_success 'archive --list shows only enabled remote filters' '
 	git archive --list --remote=. >output &&
-	grep "^tar\.foo\$" output &&
+	! grep "^tar\.foo\$" output &&
 	grep "^bar\$" output
 '
 
@@ -297,6 +298,13 @@ test_expect_success 'extension matching requires dot' '
 	test_cmp b.tar config-implicittar.foo
 '
 
+test_expect_success 'only enabled filters are available remotely' '
+	test_must_fail git archive --remote=. --format=tar.foo HEAD \
+		>remote.tar.foo &&
+	git archive --remote=. --format=bar >remote.bar HEAD &&
+	test_cmp remote.bar config.bar
+'
+
 if $GZIP --version >/dev/null 2>&1; then
 	test_set_prereq GZIP
 else
@@ -333,4 +341,15 @@ test_expect_success GZIP,GUNZIP 'extract tgz file' '
 	test_cmp b.tar j.tar
 '
 
+test_expect_success GZIP 'remote tar.gz is allowed by default' '
+	git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
+	test_cmp j.tgz remote.tar.gz
+'
+
+test_expect_success GZIP 'remote tar.gz can be disabled' '
+	git config tar.tar.gz.remote false &&
+	test_must_fail git archive --remote=. --format=tar.gz HEAD \
+		>remote.tar.gz
+'
+
 test_done
-- 
1.7.5.4.44.g4b107
