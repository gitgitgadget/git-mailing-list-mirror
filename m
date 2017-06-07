Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B4E1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbdFGQGz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:06:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:57448 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdFGQGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:06:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWxtA-1dOBPM4BE4-00VuQH; Wed, 07
 Jun 2017 18:06:45 +0200
Date:   Wed, 7 Jun 2017 18:06:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] read_early_config(): optionally return the worktree's
 top-level directory
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GCtdpV46vvSW4yOzRFCDrDiIWrktTS8cwPs+HYgOBZpAxXA3aym
 sFzU2QZLacilgDwd2UiJCR/bzkB6EFXVciG82RJklFmz8xCrZDrqGr1TD8BikA1o+OF75VD
 OqY+Ev914nLNYiA+n+IXCoisexF9iso40Qdny8DiKSnQ01vnXB3JSNGLdcSJHicvfmWiCKv
 mK3t7gzaPZtfrq879kwlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZwRVui78pQA=:aFNDgdFr3XKqr0z4CCMrZG
 CuAXZKPYRnroDf8j2pFgJXgelYLUcBkJdiiNAH/QEvi4r8WYlKV1T1Jk4D0CqkSEVFtvjMHBJ
 EEdzAY2tqj/FVgVChpmmVk+ahB1sTPYRvU3zjFcJYYRGULrbn4xZdjMB1bTNVsah9zxM0SEH/
 oyFUcpHBpFPJL4dvvu3XRVQ4MP7sUdt3Lxch4sIG0DiyZbwlmDKybtXLic3VBRC/67b3HdsaA
 9Q6N9yZDecpZ924FXaU3t9oWPIJdlZAAxtRS5/xrgKm4rOkzJEqJcozvS0KDddONkKGroU4G/
 pT26M5a4kBh8P/9i8VIFeZpkvQVa1mAxnamvhNpHyGTSSo71Yl6x/g5XAq20/pEFOhZJ5KHqV
 GsJGYCp1rsgW3/HhRJBeqRggthsjf9PoZJnUg83JqfXYx+ybJ0zDwdChp0wrJYJW/b1qThLer
 LQFKNFsblUJ96RqjcuzHwB0dPBSbF2YBjb6P1G/wNo+3YPgG4YQpRyJwv7PFWwNPJGbURjQov
 7tFtDdAoNkhTwbT9j9PSDaQ5kDWtp2KK9kTzRNLY0XyZ0I9yhNFiMKS96d1U9fA85vFoxiBrO
 yaFXhLwbghVoHLwbi/6ajtVOIObRlhxf1E2ghbrMrcFRcTa04DV+iRQttej+sAQh/sVC4Fdi7
 s04qO5dMRSesZJYm993zGpoKwTtDWXFU6FAz71odPTq6weehB3vzI34Lram7DT+kSnIShrWtk
 8XMjwSTw9X4RJUQxspCDs058LM/UOG788DlePz8o1syvjgabrpBTlfR2DcUkQoMPE2Cgq7JfJ
 B6Vy1LG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, when we invoked the early config code path, we implicitly
determined the top-level directory of the worktree while discovering the
.git/ directory.

And then we simply forgot that information.

However, when we expand aliases, we very much need that information, as
aliases expanding to shell commands, i.e. whose value starts with an
exclamation point, have to be executed in the top-level directory of the
worktree. There are exceptions abound, not only with non-shell aliases
(which are supposed to be executed in the original working directory
instead), but also when being started inside the .git/ directory or in a
worktree created via `git worktree add`.

In preparation for allowing the alias machinery to make use of the early
config machinery, let's add an optional strbuf parameter to the
read_early_config() function; if not NULL, the path of said top-level
directory is appended to the strbuf. As a special case, nothing is
appended if setup_git_directory() would have restored the original
working directory before returning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h                |  5 +++--
 config.c               |  4 ++--
 help.c                 |  2 +-
 pager.c                |  4 ++--
 setup.c                | 12 ++++++++++--
 t/helper/test-config.c |  2 +-
 6 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 4d92aae0e81..a8bbddf5955 100644
--- a/cache.h
+++ b/cache.h
@@ -530,7 +530,7 @@ extern void setup_work_tree(void);
  * appended to gitdir. The return value is either NULL if no repository was
  * found, or pointing to the path inside gitdir's buffer.
  */
-extern const char *discover_git_directory(struct strbuf *gitdir);
+extern const char *discover_git_directory(struct strbuf *gitdir, struct strbuf *worktree_dir);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
@@ -1913,7 +1913,8 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
 				     const unsigned char *sha1, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern void read_early_config(config_fn_t cb, void *data);
+extern void read_early_config(config_fn_t cb, void *data,
+			      struct strbuf *worktree_dir);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
diff --git a/config.c b/config.c
index 9b88531a70d..3d78c11fc00 100644
--- a/config.c
+++ b/config.c
@@ -1651,7 +1651,7 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	}
 }
 
-void read_early_config(config_fn_t cb, void *data)
+void read_early_config(config_fn_t cb, void *data, struct strbuf *worktree_dir)
 {
 	struct config_options opts = {0};
 	struct strbuf buf = STRBUF_INIT;
@@ -1668,7 +1668,7 @@ void read_early_config(config_fn_t cb, void *data)
 	 * notably, the current working directory is still the same after the
 	 * call).
 	 */
-	else if (discover_git_directory(&buf))
+	else if (discover_git_directory(&buf, worktree_dir))
 		opts.git_dir = buf.buf;
 
 	git_config_with_options(cb, data, NULL, &opts);
diff --git a/help.c b/help.c
index b44c55ec2da..f78747e8413 100644
--- a/help.c
+++ b/help.c
@@ -289,7 +289,7 @@ const char *help_unknown_cmd(const char *cmd)
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	memset(&aliases, 0, sizeof(aliases));
 
-	read_early_config(git_unknown_cmd_config, NULL);
+	read_early_config(git_unknown_cmd_config, NULL, NULL);
 
 	load_command_list("git-", &main_cmds, &other_cmds);
 
diff --git a/pager.c b/pager.c
index c113d898a4a..857cf5ecb32 100644
--- a/pager.c
+++ b/pager.c
@@ -53,7 +53,7 @@ const char *git_pager(int stdout_is_tty)
 	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
-			read_early_config(core_pager_config, NULL);
+			read_early_config(core_pager_config, NULL, NULL);
 		pager = pager_program;
 	}
 	if (!pager)
@@ -214,7 +214,7 @@ int check_pager_config(const char *cmd)
 	data.want = -1;
 	data.value = NULL;
 
-	read_early_config(pager_command_config, &data);
+	read_early_config(pager_command_config, &data, NULL);
 
 	if (data.value)
 		pager_program = data.value;
diff --git a/setup.c b/setup.c
index 2435186e448..771822fd0ca 100644
--- a/setup.c
+++ b/setup.c
@@ -945,10 +945,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
-const char *discover_git_directory(struct strbuf *gitdir)
+const char *discover_git_directory(struct strbuf *gitdir,
+				   struct strbuf *worktree_dir)
 {
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
-	size_t gitdir_offset = gitdir->len, cwd_len;
+	size_t gitdir_offset = gitdir->len, cwd_len, worktree_dir_offset;
 	struct repository_format candidate;
 
 	if (strbuf_getcwd(&dir))
@@ -973,6 +974,11 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
 	}
 
+	if (worktree_dir) {
+		worktree_dir_offset = worktree_dir->len;
+		strbuf_addbuf(worktree_dir, &dir);
+	}
+
 	strbuf_reset(&dir);
 	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
 	read_repository_format(&candidate, dir.buf);
@@ -983,6 +989,8 @@ const char *discover_git_directory(struct strbuf *gitdir)
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
 		strbuf_setlen(gitdir, gitdir_offset);
+		if (worktree_dir)
+			strbuf_setlen(worktree_dir, worktree_dir_offset);
 		return NULL;
 	}
 
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 8e3ed6a76cb..5e1e78f8fa2 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -84,7 +84,7 @@ int cmd_main(int argc, const char **argv)
 	struct config_set cs;
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
-		read_early_config(early_config_cb, (void *)argv[2]);
+		read_early_config(early_config_cb, (void *)argv[2], NULL);
 		return 0;
 	}
 
-- 
2.13.0.windows.1.460.g13f583bedb5


