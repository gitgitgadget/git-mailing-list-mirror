From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/24] Let 'git <command> -h' show usage without a git dir
Date: Mon,  9 Nov 2009 09:05:01 -0600
Message-ID: <1257779104-23884-21-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfE-0002nn-HA
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbZKIOzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbZKIOzt
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:49 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643AbZKIOzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:47 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eBCCLH4bklUkRWMvbc3eCPXm+3SpAwCCI9EL4BBXqkc=;
        b=sx32UB75zjU8aBw7CSMasFnI0pjD3yZOBWEuSsbZf3eCK0T+5dsuIj8qL+OUjBqa74
         2+QCpqxGNgexrNtGfF5fB5PEdIY2F+kA7MpgEurCwjHyE6IE7LnSWsz6lgNE/FRKpmee
         51/QCwbPkcKXH8V57qi7YPz2u1f//0ptU2A9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tM0eC3LLs2kz1e/GZ8KiU+ATsBqHNdliGqJhnmkCyEUy5aZJTDNdvvdK9i1qfb/ISa
         dDoGs6vuwSCIIIDn1u6SrxkHHGkx4WnXyLR60rq4tC0FTVUdI2DO4mYLauvzIQktoUSZ
         LTP3nH5GyugMJgSu6z5Sz3JEMnjfbK0UZliAM=
Received: by 10.216.90.67 with SMTP id d45mr2504238wef.42.1257778552497;
        Mon, 09 Nov 2009 06:55:52 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:51 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132481>

There is no need for "git <command> -h" to depend on being inside
a repository.

Reported by Gerfried Fuchs through http://bugs.debian.org/462557

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-log.c       |    6 ++++++
 builtin-mv.c        |    8 ++++----
 builtin-read-tree.c |    4 ++--
 builtin-reflog.c    |    3 +++
 builtin-rerere.c    |    3 +++
 git.c               |   21 ++++++++++++---------
 index-pack.c        |    3 +++
 pack-redundant.c    |    3 +++
 8 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5248507..a0fa30c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -50,6 +50,12 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	if (default_date_mode)
 		rev->date_mode = parse_date_format(default_date_mode);
 
+	/*
+	 * Check for -h before setup_revisions(), or "git log -h" will
+	 * fail when run without a git directory.
+	 */
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(builtin_log_usage);
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
diff --git a/builtin-mv.c b/builtin-mv.c
index 1b20028..f633d81 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -64,15 +64,15 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	newfd = hold_locked_index(&lock_file, 1);
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
 			     builtin_mv_usage, 0);
 	if (--argc < 1)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
+	newfd = hold_locked_index(&lock_file, 1);
+	if (read_cache() < 0)
+		die("index file corrupt");
+
 	source = copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
 	dest_path = copy_pathspec(prefix, argv + argc, 1, 0);
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 14c836b..2a3a32c 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -108,11 +108,11 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	git_config(git_default_config, NULL);
 
-	newfd = hold_locked_index(&lock_file, 1);
-
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
+	newfd = hold_locked_index(&lock_file, 1);
+
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
diff --git a/builtin-reflog.c b/builtin-reflog.c
index e23b5ef..7498210 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -698,6 +698,9 @@ static const char reflog_usage[] =
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
+	if (argc > 1 && !strcmp(argv[1], "-h"))
+		usage(reflog_usage);
+
 	/* With no command, we default to showing it. */
 	if (argc < 2 || *argv[1] == '-')
 		return cmd_log_reflog(argc, argv, prefix);
diff --git a/builtin-rerere.c b/builtin-rerere.c
index adfb7b5..343d6cd 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -106,6 +106,9 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (argc < 2)
 		return rerere();
 
+	if (!strcmp(argv[1], "-h"))
+		usage(git_rerere_usage);
+
 	fd = setup_rerere(&merge_rr);
 	if (fd < 0)
 		return 0;
diff --git a/git.c b/git.c
index f295561..743ee57 100644
--- a/git.c
+++ b/git.c
@@ -229,21 +229,24 @@ struct cmd_struct {
 
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
-	int status;
+	int status, help;
 	struct stat st;
 	const char *prefix;
 
 	prefix = NULL;
-	if (p->option & RUN_SETUP)
-		prefix = setup_git_directory();
-
-	if (use_pager == -1 && p->option & RUN_SETUP)
-		use_pager = check_pager_config(p->cmd);
-	if (use_pager == -1 && p->option & USE_PAGER)
-		use_pager = 1;
+	help = argc == 2 && !strcmp(argv[1], "-h");
+	if (!help) {
+		if (p->option & RUN_SETUP)
+			prefix = setup_git_directory();
+
+		if (use_pager == -1 && p->option & RUN_SETUP)
+			use_pager = check_pager_config(p->cmd);
+		if (use_pager == -1 && p->option & USE_PAGER)
+			use_pager = 1;
+	}
 	commit_pager_choice();
 
-	if (p->option & NEED_WORK_TREE)
+	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
 	trace_argv_printf(argv, "trace: built-in: git");
diff --git a/index-pack.c b/index-pack.c
index b4f8278..190f372 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -882,6 +882,9 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(index_pack_usage);
+
 	/*
 	 * We wish to read the repository's config file if any, and
 	 * for that it is necessary to call setup_git_directory_gently().
diff --git a/pack-redundant.c b/pack-redundant.c
index 69a7ab2..21c61db 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -603,6 +603,9 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(pack_redundant_usage);
+
 	setup_git_directory();
 
 	for (i = 1; i < argc; i++) {
-- 
1.6.5.2
