From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/6] archive: add baselen member to struct archiver_args
Date: Mon, 14 Jul 2008 21:23:53 +0200
Message-ID: <487BA7C9.6090908@lsrfire.ath.cx>
References: <487B92FC.5030103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:36:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITqh-0001Bx-2r
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbYGNTfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbYGNTfQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:35:16 -0400
Received: from india601.server4you.de ([85.25.151.105]:45933 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbYGNTfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:35:09 -0400
Received: from [10.0.1.200] (p57B7FF09.dip.t-dialin.net [87.183.255.9])
	by india601.server4you.de (Postfix) with ESMTPSA id E91C12F8215;
	Mon, 14 Jul 2008 21:24:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487B92FC.5030103@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88459>

Calculate the length of base and save it in a new member of struct
archiver_args.  This way we don't have to compute it in each of the
format backends.

Note: parse_archive_args() guarantees that ->base won't ever be NULL.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c     |    8 +++-----
 archive-zip.c     |    8 +++-----
 archive.h         |    1 +
 builtin-archive.c |    1 +
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 6eaf59e..63cc2ec 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -268,19 +268,17 @@ static int write_tar_entry(const unsigned char
*sha1, const char *base,

 int write_tar_archive(struct archiver_args *args)
 {
-	int plen = args->base ? strlen(args->base) : 0;
-
 	git_config(git_tar_config, NULL);

 	archive_time = args->time;
 	verbose = args->verbose;
 	commit = args->commit;
-	base_len = args->base ? strlen(args->base) : 0;
+	base_len = args->baselen;

 	if (args->commit_sha1)
 		write_global_extended_header(args->commit_sha1);

-	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
+	if (args->baselen > 0 && args->base[args->baselen - 1] == '/') {
 		char *base = xstrdup(args->base);
 		int baselen = strlen(base);

@@ -290,7 +288,7 @@ int write_tar_archive(struct archiver_args *args)
 				0, NULL);
 		free(base);
 	}
-	read_tree_recursive(args->tree, args->base, plen, 0,
+	read_tree_recursive(args->tree, args->base, args->baselen, 0,
 			    args->pathspec, write_tar_entry, NULL);
 	write_trailer();

diff --git a/archive-zip.c b/archive-zip.c
index 0d24f3f..d18254c 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -316,17 +316,15 @@ static void dos_time(time_t *time, int *dos_date,
int *dos_time)

 int write_zip_archive(struct archiver_args *args)
 {
-	int plen = strlen(args->base);
-
 	dos_time(&args->time, &zip_date, &zip_time);

 	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
 	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
 	verbose = args->verbose;
 	commit = args->commit;
-	base_len = args->base ? strlen(args->base) : 0;
+	base_len = args->baselen;

-	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
+	if (args->baselen > 0 && args->base[args->baselen - 1] == '/') {
 		char *base = xstrdup(args->base);
 		int baselen = strlen(base);

@@ -336,7 +334,7 @@ int write_zip_archive(struct archiver_args *args)
 				0, NULL);
 		free(base);
 	}
-	read_tree_recursive(args->tree, args->base, plen, 0,
+	read_tree_recursive(args->tree, args->base, args->baselen, 0,
 			    args->pathspec, write_zip_entry, NULL);
 	write_zip_trailer(args->commit_sha1);

diff --git a/archive.h b/archive.h
index 1b24ae3..34151f4 100644
--- a/archive.h
+++ b/archive.h
@@ -6,6 +6,7 @@

 struct archiver_args {
 	const char *base;
+	size_t baselen;
 	struct tree *tree;
 	const unsigned char *commit_sha1;
 	const struct commit *commit;
diff --git a/builtin-archive.c b/builtin-archive.c
index 6ee3677..e7f4ec6 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -192,6 +192,7 @@ int parse_archive_args(int argc, const char **argv,
const struct archiver **ar,
 	}
 	args->verbose = verbose;
 	args->base = base;
+	args->baselen = strlen(base);

 	return i;
 }
-- 
1.5.6.2.212.g08b51
