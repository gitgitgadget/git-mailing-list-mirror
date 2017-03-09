Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D729520135
	for <e@80x24.org>; Thu,  9 Mar 2017 00:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbdCIAJc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 19:09:32 -0500
Received: from forward16o.cmail.yandex.net ([37.9.109.213]:41639 "EHLO
        forward16o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754711AbdCIAIs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 19:08:48 -0500
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [77.88.29.86])
        by forward16o.cmail.yandex.net (Yandex) with ESMTP id E620B21F00;
        Thu,  9 Mar 2017 03:05:46 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp3p.mail.yandex.net (Yandex) with ESMTP id 3A47D1320062;
        Thu,  9 Mar 2017 03:05:44 +0300 (MSK)
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id w4bRePZkSb-5iTKwxaH;
        Thu, 09 Mar 2017 03:05:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489017944;
        bh=POtoJIJxByVkNmp8GP/xUbsKdNSOZLbV9TJEfLnP4DU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=AIO1PLvjnlzZX/s5peSXoKV4WzvO00EiUjfL/ggjmm9ac1KSB8PN/R8qL5YlxMKfA
         ul3zYfbWJ7MBgv+1DhQNBJ90Ml8IxgPENtbwVhWWCHS4LvLUXAuq8g304PleACWDoz
         CfLWetnVWvv5AMrzo1AhHnbPsi70/f831NPeOdmA=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 1130000030716801,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, me@vtolstov.org, gitster@pobox.com
Subject: [PATCH v2 2/2] submodule--helper.c: remove duplicate code
Date:   Thu,  9 Mar 2017 03:03:52 +0300
Message-Id: <20170309000352.18330-3-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <20170309000352.18330-1-me@vtolstov.org>
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
 <20170309000352.18330-1-me@vtolstov.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code fragment from module_clone that duplicates functionality
of connect_work_tree_and_git_dir in dir.c

Signed-off-by: Valery Tolstov <me@vtolstov.org>
---
 builtin/submodule--helper.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e..405cbea07 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -579,7 +579,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *name = NULL, *url = NULL, *depth = NULL;
 	int quiet = 0;
 	int progress = 0;
-	FILE *submodule_dot_git;
 	char *p, *path = NULL, *sm_gitdir;
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -653,27 +652,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
-- 
2.12.0.192.gbdb9d28a5

