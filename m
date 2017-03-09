Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A64202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbdCIWZj (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:25:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:50599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753551AbdCIWZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:25:38 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ll0tl-1cDahA31Aj-00aiGS; Thu, 09
 Mar 2017 23:25:29 +0100
Date:   Thu, 9 Mar 2017 23:25:28 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 10/11] setup_git_directory_gently_1(): avoid die()ing
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ha0WomudtDSKE4M4aIH7xDpeIH6q0sZqWL0QUGY7u1KHp6SC7xs
 PfsMVWp76PJYbgDtYPrMsg1rZ85pAriRIDcb0NyzM9bXMYBXnZqM8fbM768AeYMPIVhpUQk
 FQQ2fnbNFgmzzUAHUwCr7YfGFkJyMIGsTm9jjD4V/VtZkkCg3qQyjGA+qwcGfeKEkipvA9O
 33Ri0GBBXJEUVM8eCtCyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a4D2zBvBbLU=:znkA1GJmiPVXzQOJ9vWiDR
 ZkuWHTj5VN4Zv9befixputspB1+nC0SUo0ZFje7ppuC17xhCu7CgGma88RWXYWCxE35AQIXRg
 a686ZxTYVncMZ5UhYNd/kIuV5xfvD+IyCHcibzc3c9nd4MKxiZ5vjzsLC9zaelIv49oFgOFrU
 K4gnMCKQM+Db5ortjRNzLGntWlCig17Qv0fNMYNrJUMSYIq1hDHiSiwZzwW86kaBgw1p5HYG/
 hJGJF7QURck2vBFHaOQrO2dPh0oQrHPNui7YGQzDu6FIaVjJRgrgPJ6B9ZCFVqmposQVvNM3x
 LYJ8wd+GL/5HlPB95d5x9q1PGFgXE8tu5Dkt4kHQ2hIcP7drXrHno4V+KKgtSAIqx7JWziaOd
 bpRmwyGgvTw48vg0VfRy1OUZHSRMLwkg93ljKaOH+NBa6WvrDHTZufTJZv5sGunBdPcNtGgyC
 AM5Vkxfx9y9tY9WVl1Ger39R+OcfsWsQBMpjPB9uMuad9tCeE0Zt5lv76ThggVIxuId/b/GBk
 lIBDqPz0O7YLCxRDSgMiNZ7UoZ5vb5w6XNWRz1SBJ4z58XBBeTzPef7sr0+F4olUB6E+Dibkj
 45Jgj98thMaVcyFofqiQ/gqu9mPcHANV1TOA5v83VCdcouSgKETW43AYWFYPLBWhTdpEWoD8E
 62H8ZOiB1fdH4LflX/bCqKFpaxmJCawEX2RK2D4W388Fj0BPK3J+TprWRdr+zYao4zyYge7PZ
 SyxeB902gJ7RGs2w9qbNdMIqL5HrXk6NdUIzeUvFakkd4BsF9uC98BNwv6dpAcHWB/bmP+3jM
 oNw7G3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function now has a new caller in addition to setup_git_directory():
the newly introduced discover_git_directory(). That function wants to
discover the current .git/ directory, and in case of a corrupted one
simply pretend that there is none to be found.

Example: if a stale .git file exists in the parent directory, and the
user calls `git -p init`, we want Git to simply *not* read any
repository config for the pager (instead of aborting with a message that
the .git file is corrupt).

Let's actually pretend that there was no GIT_DIR to be found in that case
when being called from discover_git_directory(), but keep the previous
behavior (i.e. to die()) for the setup_git_directory() case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 43f522fa996..b0a28f609e2 100644
--- a/setup.c
+++ b/setup.c
@@ -825,7 +825,8 @@ enum discovery_result {
 	GIT_DIR_BARE,
 	/* these are errors */
 	GIT_DIR_HIT_CEILING = -1,
-	GIT_DIR_HIT_MOUNT_POINT = -2
+	GIT_DIR_HIT_MOUNT_POINT = -2,
+	GIT_DIR_INVALID_GITFILE = -3
 };
 
 /*
@@ -842,7 +843,8 @@ enum discovery_result {
  * `dir` (i.e. *not* necessarily the cwd).
  */
 static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
-							  struct strbuf *gitdir)
+							  struct strbuf *gitdir,
+							  int die_on_error)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
@@ -890,14 +892,22 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	if (one_filesystem)
 		current_device = get_device_or_die(dir->buf, NULL, 0);
 	for (;;) {
-		int offset = dir->len;
+		int offset = dir->len, error_code = 0;
 
 		if (offset > min_offset)
 			strbuf_addch(dir, '/');
 		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
-		gitdirenv = read_gitfile(dir->buf);
-		if (!gitdirenv && is_git_directory(dir->buf))
-			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
+						NULL : &error_code);
+		if (!gitdirenv) {
+			if (die_on_error ||
+			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
+				if (is_git_directory(dir->buf))
+					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+			} else if (error_code &&
+				   error_code != READ_GITFILE_ERR_STAT_FAILED)
+				return GIT_DIR_INVALID_GITFILE;
+		}
 		strbuf_setlen(dir, offset);
 		if (gitdirenv) {
 			strbuf_addstr(gitdir, gitdirenv);
@@ -934,7 +944,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		return NULL;
 
 	cwd_len = dir.len;
-	if (setup_git_directory_gently_1(&dir, gitdir) <= 0) {
+	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
 		strbuf_release(&dir);
 		return NULL;
 	}
@@ -994,7 +1004,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
+	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
 	case GIT_DIR_NONE:
 		prefix = NULL;
 		break;
-- 
2.12.0.windows.1.7.g94dafc3b124


