Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640001F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdHMTga (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:36:30 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37451 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdHMTg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:36:26 -0400
Received: by mail-it0-f65.google.com with SMTP id 77so6832608itj.4
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=va2YKAkme835LWvf0j0QvGjp2el3mbsAM37HEHSf+sM=;
        b=mzEiCGqqd9IeRwg9v0vtDzuOQKo72FCU1mk6wthO5g4nBN2RoaPsDllw/jv/74X8+6
         3rnCxFEIuCBiLCs1CbwHXmcNJEqXwKC4289OcEv2zE6K6wlqo0LSkJYqaW5msz+oQ5Uq
         ppI2aI1Z4vv3Y9otuaggH6e2WHohySvjO37hJzApYq9anjKOPrkmGLfaouRS7jBZZ0Hr
         f/ih6Fiy4zFPxDVQJi8DSclLT0Gh0U3SUjkT+XdVS5uJ60Y/Z1UE7zDD6T2jAGbb6jZy
         /VW9+N6lQUB4JjbXoyx1wPpOzRJQhN2sIgjTCme7NsdQ5AbPMBlZ6tmUNxwO7rcVN5xw
         sS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=va2YKAkme835LWvf0j0QvGjp2el3mbsAM37HEHSf+sM=;
        b=Xn60juOlXoJ+rDuTSkdMeVeyhx68yafK6gzOryTXxVQNlqPQZPqiIitoAgQ5BOsEs7
         6KeHy4kHdwuqpvRlyIN/EJ8+AuN94SJ4Kr+Oi7NlDXpg4ww1jzmLt/xgNU/vgtTvlaBx
         vYvvHU68epz4TPOzIgfR1DrfhDbu0dfXCYOHs4C6/h19FkpsI2Y9TpSNM0dBdNaIFxGi
         G8XyGmDCWSL1D+C3VEWk4zxUnYb/WLi3S8dL8iuLF25Fk84A3fU4fgxjY1xh+lx6AuFH
         9LX3Oo/2DbxdU0SOUYRaecf9/t+ElC6Jp7RndGfTAi0F62dZMeBRQx9c6NaxOsOXfvI0
         cTcw==
X-Gm-Message-State: AHYfb5ioiQiyTdbzNxWgztidvSTaD5yYgw7VzjLJ7KWZ4Sk8YSAiJb39
        bGO4pwIS+VRRe/Lx9/I=
X-Received: by 10.36.99.69 with SMTP id j66mr4059963itc.100.1502652985313;
        Sun, 13 Aug 2017 12:36:25 -0700 (PDT)
Received: from localhost.localdomain ([192.252.136.182])
        by smtp.gmail.com with ESMTPSA id s66sm2045678ita.9.2017.08.13.12.36.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 12:36:24 -0700 (PDT)
From:   Richard Maw <richard.maw@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] Add git_configset_add_standard
Date:   Sun, 13 Aug 2017 20:36:06 +0100
Message-Id: <20170813193611.4233-3-richard.maw@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This exposes implementation details of repo_read_config
so a configset can be populated with a repository's standard config,
without needing to create a full repository.

This allows config lookup to use the same codepath
whether the repository is ready or not,
which allows it to be used during git init.
---
 config.c | 7 ++++++-
 config.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 231f9a7..d0af812 100644
--- a/config.c
+++ b/config.c
@@ -1764,6 +1764,11 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
 	return git_config_from_file(config_set_callback, filename, cs);
 }
 
+int git_configset_add_standard(struct config_set *cs, const struct config_options *opts)
+{
+	return config_with_options(config_set_callback, cs, NULL, opts);
+}
+
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
@@ -1879,7 +1884,7 @@ static void repo_read_config(struct repository *repo)
 
 	git_configset_init(repo->config);
 
-	if (config_with_options(config_set_callback, repo->config, NULL, &opts) < 0)
+	if (git_configset_add_standard(repo->config, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
diff --git a/config.h b/config.h
index 0352da1..0b7b8d2 100644
--- a/config.h
+++ b/config.h
@@ -151,6 +151,7 @@ struct config_set {
 
 extern void git_configset_init(struct config_set *cs);
 extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_add_standard(struct config_set *cs, const struct config_options *opts);
 extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
 extern void git_configset_clear(struct config_set *cs);
-- 
2.9.0

