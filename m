Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27C9202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbdCHRqx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:46:53 -0500
Received: from forward11j.cmail.yandex.net ([5.255.227.175]:38920 "EHLO
        forward11j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751720AbdCHRpX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 12:45:23 -0500
Received: from smtp3m.mail.yandex.net (smtp3m.mail.yandex.net [77.88.61.130])
        by forward11j.cmail.yandex.net (Yandex) with ESMTP id 155D820432
        for <git@vger.kernel.org>; Wed,  8 Mar 2017 20:44:55 +0300 (MSK)
Received: from smtp3m.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp3m.mail.yandex.net (Yandex) with ESMTP id 39DCD28409CA;
        Wed,  8 Mar 2017 20:44:53 +0300 (MSK)
Received: by smtp3m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id vgM9CTNvCg-irsOAZtd;
        Wed, 08 Mar 2017 20:44:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1488995093;
        bh=q538OuMk4XgoDcSOzZGhSWE32q18b1Br2wE+C2YxU/s=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=q0ws/pUN9vgEexlqgUE0QtElNfURe5vAt3+ztkWK9x6fuPx702pdLBh4HQPQVOmTP
         aywgwf59RTph4TH8y9IC/SmWzoeXU/xw40DdEPAB0OjMz23VZTWgfRtSRm3MzneRyW
         n4EeAOpyqjWD0aOgazwCjmVgAFTaqwhPwzwTlKKU=
Authentication-Results: smtp3m.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 1130000030716801
From:   me@vtolstov.org
To:     git@vger.kernel.org
Cc:     Valery Tolstov <me@vtolstov.org>
Subject: [PATCH] submodule--helper.c: remove duplicate code
Date:   Wed,  8 Mar 2017 20:44:49 +0300
Message-Id: <20170308174449.24266-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.190.g250ed7eaf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Valery Tolstov <me@vtolstov.org>

Remove code fragment from module_clone that duplicates functionality
of connect_work_tree_and_git_dir in dir.c

Signed-off-by: Valery Tolstov <me@vtolstov.org>
---
>> I think we can reuse code from module_clone that writes .git link.
>> Possibly this code fragment needs to be factored out from module_clone
>
> That fragment already exists, see dir.h:
> connect_work_tree_and_git_dir(work_tree, git_dir);
> Maybe another good microproject is to use that in module_clone.

By suggestion of Stefan Beller I would like to make this micro
improvement as my microproject for GSoc.

 builtin/submodule--helper.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e..cda8a3bc1 100644
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
-
-	/* Redirect the worktree of the submodule in the superproject's config */
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
-	git_config_set_in_file(p, "core.worktree",
-			       relative_path(path, sm_gitdir, &rel_path));
+
+	/* Connect module worktree and git dir */
+	connect_work_tree_and_git_dir(path, sm_gitdir);
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	git_config_get_string("submodule.alternateLocation", &sm_alternate);
-- 
2.12.0.190.g250ed7eaf

