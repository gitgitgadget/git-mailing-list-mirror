Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7781AC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 00:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiAMApe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiAMApY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745FAC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:24 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id v21-20020a17090331d500b0014a5895b639so4309763ple.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=WoYIcjHgGW1DqOxfX6Lz8hLNGouPkmz8MISk1Vm5tH59evV8U28PXgct9IWdB+JEyd
         A5UGwPkpqfVI+f/FCH+5odOmIW332A4Qkf+/sFuoSSKCaC+QO3ZWm5B3K6ClcrOOBKAV
         4hHCBzJTD+8WQ5W/jLSG5eXyCOSr8pMwHxJ7PjDB0vWmXHuNev47mxJH7rye06BCmUex
         QqpYLzBKqPv9h4tggGqTg3Rs1Ft3hOu2PxdhGXVUnyyfyfxppUMvVWKuWB4otZ7j3lof
         EUflVgPxsS5738PIUQ+Go0lbVXGlJe7qwhxP3Li5xs7N1TCkDy+ajgwWfHty8mbI2CZA
         V0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=oWVEd4Dh5CR2sXZPAaca9p1FqQKW+TmSGYWpWgDzlMGEtR6T+8N+qZ/g/EN+r/VxDl
         kcS1NlrblK9liIrC0OUHVQmplmKlcNK1dRMMQMR5/KOswYuhRtLpW1PeSO9MAgnoH7Y4
         zVJs3/tW3E+ibJH+5MPlaLETW4/b4EerP8ANd4kX58K23s+ya02UGIyWcRmlK2pRPng8
         pELSDS6JevvuY9wxM7EZelN381JgWLrzjcfS4GhPPcDn/HXWISI9/IqKqhtRdL35B1OH
         dWVXs/HaMAv3XdJlNxOsBvaWoD9QLtC8i+FrXyq+XvXNlw/bpGXqW2Kt+NuoDN1++S+e
         8GlQ==
X-Gm-Message-State: AOAM531uEDXrVozlxKBphx+F5bR6FXPabdJxLQpPjq5WgjKSPB+5TgWD
        qwtlJET4u3LlHRiz07VMNtLTR+ZbDiLMG1fm1tdkvURKx4NGq/o9gdAhhOjQLGOOn5YUVkWg/dO
        2tAdjqb7/WHUa5n6N4CpbcxwH2ak+LLK20G6FVAfaq9/PDy6qUB6nmIQEO6oakck=
X-Google-Smtp-Source: ABdhPJwCE5L6mMgapa0Cc+VvgJjw5AO5A7fBNHGxWOc65oMvSHgP7J8S7LWsOQ+riDsFwvotNEhDHOJSMqVV/A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1e50:: with SMTP id
 pi16mr2431002pjb.118.1642034723694; Wed, 12 Jan 2022 16:45:23 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:44:59 -0800
In-Reply-To: <20220113004501.78822-1-chooglen@google.com>
Message-Id: <20220113004501.78822-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211222001134.28933-1-chooglen@google.com> <20220113004501.78822-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v4 1/3] fetch: use goto cleanup in cmd_fetch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace an early return with 'goto cleanup' in cmd_fetch() so that the
string_list is always cleared (the string_list_clear() call is purely
cleanup; the string_list is not reused). This makes cleanup consistent
so that a subsequent commit can use 'goto cleanup' to bail out early.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eaab8056bf..0a625cb137 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2095,7 +2095,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
 			warning(_("protocol does not support --negotiate-only, exiting"));
-			return 1;
+			result = 1;
+			goto cleanup;
 		}
 		if (server_options.nr)
 			gtransport->server_options = &server_options;
@@ -2151,8 +2152,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
-	string_list_clear(&list, 0);
-
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
@@ -2170,5 +2169,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (enable_auto_gc)
 		run_auto_maintenance(verbosity < 0);
 
+ cleanup:
+	string_list_clear(&list, 0);
 	return result;
 }
-- 
2.33.GIT

