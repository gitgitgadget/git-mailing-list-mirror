From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] archive: support user tar-filters via --format
Date: Wed, 15 Jun 2011 18:33:12 -0400
Message-ID: <20110615223312.GC16807@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:33:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyeG-0007xJ-LY
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab1FOWdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:33:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45240
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab1FOWdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:33:15 -0400
Received: (qmail 7489 invoked by uid 107); 15 Jun 2011 22:33:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:33:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:33:12 -0400
Content-Disposition: inline
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175859>

The previous commit set up the infrastructure to read
tar-filter configuration. This commit actually uses it to
pipe the tar output through the specified filter.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar-filter.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 archive.c            |   16 +++++++++++++---
 archive.h            |    2 ++
 t/t5000-tar-tree.sh  |    6 +++---
 4 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/archive-tar-filter.c b/archive-tar-filter.c
index 211f1df..ffe510e 100644
--- a/archive-tar-filter.c
+++ b/archive-tar-filter.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "archive.h"
+#include "run-command.h"
 
 struct tar_filter *tar_filters;
 static struct tar_filter **tar_filters_tail = &tar_filters;
@@ -110,3 +111,50 @@ extern void tar_filter_load_config(void)
 	git_config(tar_filter_config, NULL);
 	remove_filters_without_command();
 }
+
+static int write_tar_to_filter(struct archiver_args *args, const char *cmd)
+{
+	struct child_process filter;
+	const char *argv[2];
+	int r;
+
+	memset(&filter, 0, sizeof(filter));
+	argv[0] = cmd;
+	argv[1] = NULL;
+	filter.argv = argv;
+	filter.use_shell = 1;
+	filter.in = -1;
+
+	if (start_command(&filter) < 0)
+		die_errno("unable to start '%s' filter", argv[0]);
+	close(1);
+	if (dup2(filter.in, 1) < 0)
+		die_errno("unable to redirect descriptor");
+	close(filter.in);
+
+	r = write_tar_archive(args);
+
+	close(1);
+	if (finish_command(&filter) != 0)
+		die("'%s' filter reported error", argv[0]);
+
+	return r;
+}
+
+int write_tar_filter_archive(struct archiver_args *args)
+{
+	struct strbuf cmd = STRBUF_INIT;
+	int r;
+
+	if (!args->tar_filter)
+		die("BUG: tar-filter archiver called with no filter defined");
+
+	strbuf_addstr(&cmd, args->tar_filter->command);
+	if (args->tar_filter->use_compression && args->compression_level >= 0)
+		strbuf_addf(&cmd, " -%d", args->compression_level);
+
+	r = write_tar_to_filter(args, cmd.buf);
+
+	strbuf_release(&cmd);
+	return r;
+}
diff --git a/archive.c b/archive.c
index 2ed9259..cf58faa 100644
--- a/archive.c
+++ b/archive.c
@@ -24,6 +24,9 @@ static const struct archiver {
 	{ "tar", write_tar_archive },
 	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
 };
+static const struct archiver tar_filter_archiver = {
+	"tar-filter", write_tar_filter_archive
+};
 
 static void format_subst(const struct commit *commit,
                          const char *src, size_t len,
@@ -364,12 +367,19 @@ static int parse_archive_args(int argc, const char **argv,
 	if (argc < 1)
 		usage_with_options(archive_usage, opts);
 	*ar = lookup_archiver(format);
-	if (!*ar)
-		die("Unknown archive format '%s'", format);
+
+	/* Fallback to user-configured tar filters */
+	if (!*ar) {
+		args->tar_filter = tar_filter_by_name(format);
+		if (!args->tar_filter)
+			die("Unknown archive format '%s'", format);
+		*ar = &tar_filter_archiver;
+	}
 
 	args->compression_level = Z_DEFAULT_COMPRESSION;
 	if (compression_level != -1) {
-		if ((*ar)->flags & USES_ZLIB_COMPRESSION)
+		if ((*ar)->flags & USES_ZLIB_COMPRESSION ||
+		    (args->tar_filter && args->tar_filter->use_compression))
 			args->compression_level = compression_level;
 		else {
 			die("Argument not supported for format '%s': -%d",
diff --git a/archive.h b/archive.h
index 8386c46..fb2bb9e 100644
--- a/archive.h
+++ b/archive.h
@@ -14,6 +14,7 @@ struct archiver_args {
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
 	int compression_level;
+	struct tar_filter *tar_filter;
 };
 
 typedef int (*write_archive_fn_t)(struct archiver_args *);
@@ -25,6 +26,7 @@ typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsign
  */
 extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
+extern int write_tar_filter_archive(struct archiver_args *);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index c3e1a4e..2b2b128 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -256,11 +256,11 @@ test_expect_success 'setup fake tar filter' '
 	git config tarfilter.fake.command "cat >/dev/null; echo args: "
 '
 
-test_expect_failure 'filter does not allow compression levels by default' '
+test_expect_success 'filter does not allow compression levels by default' '
 	test_must_fail git archive --format=fake -9 HEAD >output
 '
 
-test_expect_failure 'filters can allow compression levels' '
+test_expect_success 'filters can allow compression levels' '
 	git config tarfilter.fake.compressionlevels true &&
 	echo "args: -9" >expect &&
 	git archive --format=fake -9 HEAD >output &&
@@ -283,7 +283,7 @@ test_expect_success 'setup slightly more useful tar filter' '
 	git config --add tarfilter.foo.extension bar
 '
 
-test_expect_failure 'archive outputs in configurable format' '
+test_expect_success 'archive outputs in configurable format' '
 	git archive --format=foo HEAD >config.tar.foo &&
 	tr ab ba <config.tar.foo >config.tar &&
 	test_cmp b.tar config.tar
-- 
1.7.6.rc1.4.g49204
