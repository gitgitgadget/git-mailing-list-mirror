From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Add --verbose to git-archive
Date: Sun, 10 Sep 2006 00:12:12 -0700
Message-ID: <7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 09:11:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMJTl-0005Id-2T
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 09:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWIJHLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 03:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWIJHLg
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 03:11:36 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:47535 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750714AbWIJHLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 03:11:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910071135.DCRM12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 03:11:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LXBb1V00L1kojtg0000000
	Sun, 10 Sep 2006 03:11:36 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 10 Sep 2006 00:09:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26787>

And teach backends about it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This is not interesting yet, and the output is discarded if
   you are running the remote archiver against git-daemon, but
   would be a useful progress indicator when we implement the
   side-band in git-archive protocol, which is probably a
   requirement before this "git-archive" series can graduate to
   "master" branch.

 archive.h          |    1 +
 builtin-archive.c  |    8 +++++++-
 builtin-tar-tree.c |    4 ++++
 builtin-zip-tree.c |    4 ++++
 4 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/archive.h b/archive.h
index e0782b9..16dcdb8 100644
--- a/archive.h
+++ b/archive.h
@@ -10,6 +10,7 @@ struct archiver_args {
 	const unsigned char *commit_sha1;
 	time_t time;
 	const char **pathspec;
+	unsigned int verbose : 1;
 	void *extra;
 };
 
diff --git a/builtin-archive.c b/builtin-archive.c
index c70488c..b78d6d8 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -12,7 +12,7 @@ #include "exec_cmd.h"
 #include "pkt-line.h"
 
 static const char archive_usage[] = \
-"git-archive --format=<fmt> [--prefix=<prefix>/] [<extra>] <tree-ish> [path...]";
+"git-archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
 
 struct archiver archivers[] = {
 	{
@@ -148,6 +148,7 @@ int parse_archive_args(int argc, const c
 	int extra_argc = 0;
 	const char *format = NULL; /* might want to default to "tar" */
 	const char *base = "";
+	int verbose = 0;
 	int i;
 
 	for (i = 1; i < argc; i++) {
@@ -158,6 +159,10 @@ int parse_archive_args(int argc, const c
 				printf("%s\n", archivers[i].name);
 			exit(0);
 		}
+		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
+			verbose = 1;
+			continue;
+		}
 		if (!strncmp(arg, "--format=", 9)) {
 			format = arg + 9;
 			continue;
@@ -192,6 +197,7 @@ int parse_archive_args(int argc, const c
 			die("%s", default_parse_extra(ar, extra_argv));
 		ar->args.extra = ar->parse_extra(extra_argc, extra_argv);
 	}
+	ar->args.verbose = verbose;
 	ar->args.base = base;
 
 	return i;
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index c20eb0e..fae2c0b 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -22,6 +22,7 @@ static unsigned long offset;
 
 static time_t archive_time;
 static int tar_umask;
+static int verbose;
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
@@ -169,6 +170,8 @@ static void write_entry(const unsigned c
 		mode = 0100666;
 		sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
 	} else {
+		if (verbose)
+			fprintf(stderr, "%.*s\n", path->len, path->buf);
 		if (S_ISDIR(mode)) {
 			*header.typeflag = TYPEFLAG_DIR;
 			mode = (mode | 0777) & ~tar_umask;
@@ -385,6 +388,7 @@ int write_tar_archive(struct archiver_ar
 	git_config(git_tar_config);
 
 	archive_time = args->time;
+	verbose = args->verbose;
 
 	if (args->commit_sha1)
 		write_global_extended_header(args->commit_sha1);
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
index 4e79633..0ebd547 100644
--- a/builtin-zip-tree.c
+++ b/builtin-zip-tree.c
@@ -13,6 +13,7 @@ #include "archive.h"
 static const char zip_tree_usage[] =
 "git-zip-tree [-0|...|-9] <tree-ish> [ <base> ]";
 
+static int verbose;
 static int zip_date;
 static int zip_time;
 
@@ -164,6 +165,8 @@ static int write_zip_entry(const unsigne
 	crc = crc32(0, Z_NULL, 0);
 
 	path = construct_path(base, baselen, filename, S_ISDIR(mode), &pathlen);
+	if (verbose)
+		fprintf(stderr, "%s\n", path);
 	if (pathlen > 0xffff) {
 		error("path too long (%d chars, SHA1: %s): %s", pathlen,
 		      sha1_to_hex(sha1), path);
@@ -361,6 +364,7 @@ int write_zip_archive(struct archiver_ar
 
 	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
 	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
+	verbose = args->verbose;
 
 	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
 		char *base = strdup(args->base);
-- 
1.4.2.gc52f
