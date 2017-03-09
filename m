Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808BB20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932154AbdCIBac (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:30:32 -0500
Received: from forward7j.cmail.yandex.net ([5.255.227.108]:46832 "EHLO
        forward7j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754731AbdCIBaa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 20:30:30 -0500
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [IPv6:2a02:6b8:0:801::ab])
        by forward7j.cmail.yandex.net (Yandex) with ESMTP id 4D25A229FD;
        Thu,  9 Mar 2017 04:27:53 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1j.mail.yandex.net (Yandex) with ESMTP id ED86C3C807F1;
        Thu,  9 Mar 2017 04:27:49 +0300 (MSK)
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id OBpXAf9TTu-RmmGFo7Y;
        Thu, 09 Mar 2017 04:27:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489022869;
        bh=Y7hrJWjZANRxarYT0gmIw9BcxvWBxC38yDKakrH44wU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=UkglWTyYfANgqXNq3ehkLFzOYy4/iJS7S+PpQEzn1vKeCLzHajK+hOMopiSyg/yYj
         0Is4/YutJZIjqugrFx+2dgYpqKI12nZ+RyIdR3DeDVcm4mQC3DrtrcpnZS1gu4BiTF
         3Q1wFUotdhN6ieAW+09FWjIP8bo2fUhXCG8rIP64=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 1130000030716801,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, sbeller@google.com, me@vtolstov.org,
        gitster@pobox.com
Subject: [PATCH v3 2/2] submodule--helper.c: remove duplicate code
Date:   Thu,  9 Mar 2017 04:27:34 +0300
Message-Id: <20170309012734.21541-3-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <20170309012734.21541-1-me@vtolstov.org>
References: <20170309003858.GB153031@google.com>
 <20170309012734.21541-1-me@vtolstov.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code fragment from module_clone that duplicates functionality
of connect_work_tree_and_git_dir in dir.c

Signed-off-by: Valery Tolstov <me@vtolstov.org>
---
 builtin/submodule--helper.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e..86bafe166 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -579,9 +579,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *name = NULL, *url = NULL, *depth = NULL;
 	int quiet = 0;
 	int progress = 0;
-	FILE *submodule_dot_git;
 	char *p, *path = NULL, *sm_gitdir;
-	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	char *sm_alternate = NULL, *error_strategy = NULL;
@@ -653,27 +651,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&sb);
 	}
 
-	/* Write a .git file in the submodule to redirect to the superproject. */
-	strbuf_addf(&sb, "%s/.git", path);
-	if (safe_create_leading_directories_const(sb.buf) < 0)
-		die(_("could not create leading directories of '%s'"), sb.buf);
-	submodule_dot_git = fopen(sb.buf, "w");
-	if (!submodule_dot_git)
-		die_errno(_("cannot open file '%s'"), sb.buf);
-
-	fprintf_or_die(submodule_dot_git, "gitdir: %s\n",
-		       relative_path(sm_gitdir, path, &rel_path));
-	if (fclose(submodule_dot_git))
-		die(_("could not close file %s"), sb.buf);
-	strbuf_reset(&sb);
-	strbuf_reset(&rel_path);
+	/* Connect module worktree and git dir */
+	connect_work_tree_and_git_dir(path, sm_gitdir);
 
-	/* Redirect the worktree of the submodule in the superproject's config */
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
-	git_config_set_in_file(p, "core.worktree",
-			       relative_path(path, sm_gitdir, &rel_path));
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	git_config_get_string("submodule.alternateLocation", &sm_alternate);
@@ -689,7 +672,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	free(error_strategy);
 
 	strbuf_release(&sb);
-	strbuf_release(&rel_path);
 	free(sm_gitdir);
 	free(path);
 	free(p);
-- 
2.12.0.192.gbdb9d28a5

