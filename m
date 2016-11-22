Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840EB1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933367AbcKVTXD (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:23:03 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34127 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933260AbcKVTXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:23:01 -0500
Received: by mail-pg0-f44.google.com with SMTP id x23so10520722pgx.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kf6N+sE9Q+yTl8oytBoJbQn82cP+edVqbw+5xdKUXrU=;
        b=ZWkLlGmOfcWYHyuVNlnEc1XIS2nmBHyb6mhLnkZFRC+guiCToJ3ibqIWjmgx0ypJ9x
         psGYJ3+NMygwuED+PW9qZ8F0HN03CES23iT3q2DKfJUmiBy3yUiRmTkLNSaX4PkysjaE
         IKRfncUbLYfsrQljqRsmsZwcplTAByg4flbud44XkPzRQHuGIPFaZsyjxL9vdAEkk4Yi
         d0Z/UJMmfFFGpPfZJXh6Crdc3HWD9hyGmSswLzZvMXVoZGi396W37IliMG2dSNleX2TY
         2eg+CHj8HAJV+8CZhQZHWSJ+uyFyRzUY5GawZphIl9Lk/kiKcrgA0JbtLQkLtJ3YgLKD
         meNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kf6N+sE9Q+yTl8oytBoJbQn82cP+edVqbw+5xdKUXrU=;
        b=TLmMcJ/KJ6VLS0j+5pflKlONLhXslHvef8kgWezl8jCbIXQ32BluHAipL9R5U3sAKR
         aePepE3EZEQLtDMesBR7x00eRgQbxOIGesFEIME26dP7kqKcS7gOcTGm85oZUxUBUSLD
         8UYDZIvJmzdCS2KmJZoiq6bUBej60UtGiBJklz9j2EJwbdN6026pYc/yLGZZjQXRMfrE
         05yekIOaHf2OaEDBUcVJRDhBse0YY5l9WkpkQVZ3/xtXGg5l1Dv6jkonHja97Zo0ejBX
         2IjbqVwN/Ysh7FP0aE6m6myfddkjXovzwgjtEyT5PW+kUoltzNjHRZk1WeCqeiU40lpI
         32ug==
X-Gm-Message-State: AKaTC034pSda4tHhRqoIFt0V22vGPdQHT+yice6Fkcbrt9qQMj5A39KJ02fOLzRlmTZ2ifuY
X-Received: by 10.84.173.195 with SMTP id p61mr2728411plb.68.1479842565333;
        Tue, 22 Nov 2016 11:22:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id p64sm46972206pfi.88.2016.11.22.11.22.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 11:22:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/4] submodule: use absolute path for computing relative path connecting
Date:   Tue, 22 Nov 2016 11:22:32 -0800
Message-Id: <20161122192235.6055-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122192235.6055-1-sbeller@google.com>
References: <20161122192235.6055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current caller of connect_work_tree_and_git_dir passes
an absolute path for the `git_dir` parameter. In the future patch
we will also pass in relative path for `git_dir`. Extend the functionality
of connect_work_tree_and_git_dir to take relative paths for parameters.

We could work around this in the future patch by computing the absolute
path for the git_dir in the calling site, however accepting relative
paths for either parameter makes the API for this function much harder
to misuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..66c5ce5a24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
+			       relative_path(real_work_tree, real_git_dir,
 					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(real_work_tree);
+	free(real_git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.11.0.rc2.4.g3396b6f.dirty

