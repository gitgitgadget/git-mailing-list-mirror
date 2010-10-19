From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] builtins: check for startup_info->help, print and exit early
Date: Tue, 19 Oct 2010 20:35:20 +0700
Message-ID: <1287495320-27278-3-git-send-email-pclouds@gmail.com>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 15:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8CMI-0000Tq-Ck
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 15:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695Ab0JSNf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 09:35:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55600 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758668Ab0JSNfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 09:35:55 -0400
Received: by mail-pz0-f46.google.com with SMTP id 3so252126pzk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SUKORBtBGpzjlHo9/jzGIm+OWQn2wITRpxii5+QVowg=;
        b=Tr411y6j3ouin1ATBHIfD1GNUzp1zcVM6IxgP99fqhpJLCmLBvPFHhPrRX2crTyH4T
         YCPNhcUJuGpVK5AG3foUsU2O7JsFJHWVYU5sfTQ6wIzvltTGAwDF+CuzpR+HvP77tFkq
         FVcWHATYfWOH5DhZB9QhfShXRXBzviMZWVG3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=V+Vq9TbXkQdfFb3+hYmdOtSiHGG0j9GWv+e2zw6QHQsjkv+QKCq0tPuUTPSs8Zkxwo
         FxCbs4fggo9/kSlO1PFJZ0r27vEjcBwspr/y1/H8XEHnTR9ZQdyIWGiQ+KwuJFjRfdd+
         X4Njsovb1/mvmXx+xasvOBXjNAzrOdUth68Yk=
Received: by 10.142.48.6 with SMTP id v6mr4645544wfv.73.1287495355474;
        Tue, 19 Oct 2010 06:35:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id y42sm19051526wfd.22.2010.10.19.06.35.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 06:35:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 19 Oct 2010 20:35:44 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159328>

These commands need more than just git_config() before parsing
commmand line arguments. Some of these activities will unconditionally
look into a repository. When startup_info->help is TRUE, no repository
is set up and the caller expects callees to print help usage and exit,
no more.

Do as expected.
---
 builtin/branch.c         |    3 +++
 builtin/checkout-index.c |    3 +++
 builtin/commit.c         |    6 ++++++
 builtin/gc.c             |    3 +++
 builtin/ls-files.c       |    3 +++
 builtin/merge.c          |    3 +++
 builtin/update-index.c   |    3 +++
 builtin/upload-archive.c |    7 ++++---
 t/t3905-help.sh          |   20 ++++++++++++++++++++
 9 files changed, 48 insertions(+), 3 deletions(-)
 create mode 100755 t/t3905-help.sh

diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..9f152ed 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -667,6 +667,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (startup_info->help)
+		usage_with_options(builtin_branch_usage, options);
+
 	git_config(git_branch_config, NULL);
 
 	if (branch_use_color == -1)
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a7a5ee1..7f25cd7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -241,6 +241,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (startup_info->help)
+		usage_with_options(builtin_checkout_index_usage, builtin_checkout_index_options);
+
 	git_config(git_default_config, NULL);
 	state.base_dir = "";
 	prefix_length = prefix ? strlen(prefix) : 0;
diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..8b086f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1070,6 +1070,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (startup_info->help)
+		usage_with_options(builtin_status_usage, builtin_status_options);
+
 	if (null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
 
@@ -1255,6 +1258,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	int allow_fast_forward = 1;
 	struct wt_status s;
 
+	if (startup_info->help)
+		usage_with_options(builtin_commit_usage, builtin_commit_options);
+
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
 	in_merge = file_exists(git_path("MERGE_HEAD"));
diff --git a/builtin/gc.c b/builtin/gc.c
index c304638..f040171 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -191,6 +191,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	git_config(gc_config, NULL);
 
+	if (startup_info->help)
+		usage_with_options(builtin_gc_usage, builtin_gc_options);
+
 	if (pack_refs < 0)
 		pack_refs = !is_bare_repository();
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bb4f612..814da51 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -530,6 +530,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_END()
 	};
 
+	if (startup_info->help)
+		usage_with_options(ls_files_usage, builtin_ls_files_options);
+
 	memset(&dir, 0, sizeof(dir));
 	prefix = cmd_prefix;
 	if (prefix)
diff --git a/builtin/merge.c b/builtin/merge.c
index 2dba3b9..0169694 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -917,6 +917,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
 
+	if (startup_info->help)
+		usage_with_options(builtin_merge_usage, builtin_merge_options);
+
 	if (read_cache_unmerged()) {
 		die_resolve_conflict("merge");
 	}
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..46a53f5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -589,6 +589,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int lock_error = 0;
 	struct lock_file *lock_file;
 
+	if (startup_info->help)
+		usage(update_index_usage);
+
 	git_config(git_default_config, NULL);
 
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 73f788e..d4f4741 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -26,9 +26,6 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	int sent_argc;
 	int len;
 
-	if (argc != 2)
-		usage(upload_archive_usage);
-
 	if (strlen(argv[1]) + 1 > sizeof(buf))
 		die("insanely long repository name");
 
@@ -98,6 +95,10 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	pid_t writer;
 	int fd1[2], fd2[2];
+
+	if (startup_info->help || argc != 2)
+		usage(upload_archive_usage);
+
 	/*
 	 * Set up sideband subprocess.
 	 *
diff --git a/t/t3905-help.sh b/t/t3905-help.sh
new file mode 100755
index 0000000..c7e80c5
--- /dev/null
+++ b/t/t3905-help.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='tests that git foo -h should work even in broken repos'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git config core.repositoryformatversion 99 &&
+	test_must_fail git rev-parse HEAD
+'
+
+CMDS="branch checkout-index commit gc ls-files merge update-index upload-archive"
+for cmd in $CMDS; do
+	test_expect_success "$cmd -h" "
+		test_must_fail git $cmd -h &&
+		test \$exit_code = 129
+	"
+done
+
+test_done
-- 
1.7.0.2.445.gcbdb3
