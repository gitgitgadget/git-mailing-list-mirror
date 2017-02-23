Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82CA2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdBWXtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:10 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32775 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f52.google.com with SMTP id z128so2756555pgb.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P42CB0BuEsWJGHnJywdRz1ESeWV7kgsLjX0mr9UEEmM=;
        b=OpRi6RUdusIGwBsge/nnVv8slWkJ5JhC542UN7mbAb6nLi7sVyxjZ2itOymTwb2Tq+
         DM1B0tXbiSHDas43R3GgS/D6xwNjakuPNUmbdYcVA0eiUT7exWkd/TK0B163MQ6QVR/J
         vRhVESWzPgxvqXp3GdCxoiIjQ1E4vk5TkMHZl74asPjXGgUr3W+UKtWwDIRTY2epa4Ol
         6cI4MI3WhVmYfj49sU6/8yuiw7SLCoRKLCU5UBjPVsFUZ5rdClYAPsdRDyaEirL26s/E
         dTeCDcwC+DIaSYaqfWJbY+rnLSNEtrpEMgmLGs1BaIxnzVwJDCOQ63enb/IjpZk81M9m
         akQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P42CB0BuEsWJGHnJywdRz1ESeWV7kgsLjX0mr9UEEmM=;
        b=K4kypX5AMjerFFh0mHZU0ZE1laAHEO93CVSVnZHEVjVKBxjtP3uC+yqYzGQrYegWXE
         BDJdjSV1yWtlrV/gWsWixcQ2CrT/Q97gaJWd7hMTpw9FGNz5GG0xE+zJdZAcRorNkqXf
         QFsYNxw9UhPCusKGWJ7S+xBcoBkNuPKyMHK43l4zTLVZO2V+qFgNDxGGOdQwLXUGYZ/Z
         jYTpMwj2kR3WIgLbpxtnukgkNJs3hfzaB6kHr74ZXjhI0vyqA47ffOI4UrFnQBByRqnW
         BeFa6bGGTclrCxU+M3sBhi+353pTZahlYJBbrsfEqyMHnYpWsikfC7E5lb2qvw+lL+rm
         veQw==
X-Gm-Message-State: AMke39kthqTpYnOqK4n0eNetXzKm0bHUoasVvCKcE/cDKE6/T8ImUhoOjTagmWbC1kkiMiNi
X-Received: by 10.84.225.133 with SMTP id u5mr36212120plj.109.1487893660743;
        Thu, 23 Feb 2017 15:47:40 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:39 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 01/10] submodule: decouple url and submodule existence
Date:   Thu, 23 Feb 2017 15:47:19 -0800
Message-Id: <20170223234728.164111-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the submodule.<name>.url config option is used to determine
if a given submodule exists and is interesting to the user.  This
however doesn't work very well because the URL is a config option for
the scope of a repository, whereas the existence of a submodule is an
option scoped to the working tree.

In a future with worktree support for submodules, there will be multiple
working trees, each of which may only need a subset of the submodules
checked out.  The URL (which is where the submodule repository can be
obtained) should not differ between different working trees.

It may also be convenient for users to more easily specify groups of
submodules they are interested in as apposed to running "git submodule
init <path>" on each submodule they want checked out in their working
tree.

To this end, the config option submodule.active is introduced which
holds a pathspec that specifies which submodules should exist in the
working tree.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4c4f033e8..991066ddf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -217,11 +217,16 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
 int is_submodule_initialized(const char *path)
 {
 	int ret = 0;
-	const struct submodule *module = NULL;
+	const struct string_list *sl;
+	const struct submodule *module = submodule_from_path(null_sha1, path);
 
-	module = submodule_from_path(null_sha1, path);
+	/* early return if there isn't a path->module mapping */
+	if (!module)
+		return 0;
+
+	sl = git_config_get_value_multi("submodule.active");
 
-	if (module) {
+	if (!sl) {
 		char *key = xstrfmt("submodule.%s.url", module->name);
 		char *value = NULL;
 
@@ -229,6 +234,20 @@ int is_submodule_initialized(const char *path)
 
 		free(value);
 		free(key);
+	} else {
+		struct pathspec ps;
+		struct argv_array args = ARGV_ARRAY_INIT;
+		const struct string_list_item *item;
+
+		for_each_string_list_item(item, sl) {
+			argv_array_push(&args, item->string);
+		}
+
+		parse_pathspec(&ps, 0, 0, 0, args.argv);
+		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
+
+		argv_array_clear(&args);
+		clear_pathspec(&ps);
 	}
 
 	return ret;
-- 
2.11.0.483.g087da7b7c-goog

