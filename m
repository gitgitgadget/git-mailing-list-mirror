Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7581D20831
	for <e@80x24.org>; Fri, 23 Jun 2017 19:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbdFWTNP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:13:15 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36835 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdFWTNN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:13:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so27401769pfl.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhSiepeUHOfSoghtXMW/KUB4m1vUAw6Ju/gNeLTP7l4=;
        b=tQHB1K/5Sr6bWCBojjFYp7ZWXICEINlk85qOfjd9lxC+NkBRQAHvI6dWyXL5KQyUsd
         CaoQQXSxTGZ9T4vVYkSn7zjohXDxJd99zF15TPEMAVTG+cE/5cZU+XchNzHQQvVgdVxB
         Er/KyCW/Si/CMes0s4+HeRQeQ1yZFxhvNiqkHolABmtMdM++aPktm+gg3UyrNyjFKxQi
         bOhTXIuYW9bv06032tBVHzLgjahc+JgYZ5uPjxgMpdihwas1BT+AbgfHth/qs4aDi+hi
         cFcMkXpNsDWo9LGTrEAAtmuvd4jJgc5eR4DLErSUuTYhki+CoEQwOtFZK79gfKVisc2U
         ihiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhSiepeUHOfSoghtXMW/KUB4m1vUAw6Ju/gNeLTP7l4=;
        b=rHhYlNWEhDIvQ4GeVovmgabm0YMykTef2v1ERI4V1xSaRn67/NP7CFFH+Ja5YiRha+
         DTLPmxRk+V6iJE8HXd1WtoXsqOFMQb95c8eXHoiC9M9vaXLLdJnR8dYJHcW/cfe0PNnx
         s4P/Vh75mvQP5I/QnmHmAKP9Jue+4Z7gbObZq1OKyobAnmR8Wwx3HabHAFxPI6miLLWz
         4F8GfJmMG4PqWA1WrDQ/NmfPfA1/tKLgfAqEzqBuytofnpHqA2UmEkPJ/m+B/MHo2LhJ
         iFjmkcw69MLhEy3vTUCH/p0kkVnbv+9QTzs7O4zRngklAsIDc39tdM+DVwBOrJ505Vh7
         eD7w==
X-Gm-Message-State: AKS2vOyAKatp/i8nz42hJdBmR9ogO56HebJFAYe2sOpk3kuVwqwMmaGM
        p5bBE8ov/JgSRAiB
X-Received: by 10.101.88.130 with SMTP id d2mr9735137pgu.58.1498245193054;
        Fri, 23 Jun 2017 12:13:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1530:f035:a8be:c887])
        by smtp.gmail.com with ESMTPSA id n71sm12230691pfg.46.2017.06.23.12.13.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 12:13:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        philipoakley@iee.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] builtin/fetch: factor submodule recurse parsing out to submodule config
Date:   Fri, 23 Jun 2017 12:13:00 -0700
Message-Id: <20170623191302.16053-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623191302.16053-1-sbeller@google.com>
References: <20170623191302.16053-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Later we want to access this parsing in builtin/pull as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c    | 18 ++----------------
 submodule-config.c | 22 ++++++++++++++++++++++
 submodule-config.h |  3 +++
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 100248c5af..9d58dc0a8a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -53,20 +53,6 @@ static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
 
-static int option_parse_recurse_submodules(const struct option *opt,
-				   const char *arg, int unset)
-{
-	if (unset) {
-		recurse_submodules = RECURSE_SUBMODULES_OFF;
-	} else {
-		if (arg)
-			recurse_submodules = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
-		else
-			recurse_submodules = RECURSE_SUBMODULES_ON;
-	}
-	return 0;
-}
-
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "fetch.prune")) {
@@ -115,9 +101,9 @@ static struct option builtin_fetch_options[] = {
 		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
-	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
+	{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
-		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
+		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
diff --git a/submodule-config.c b/submodule-config.c
index 4f58491ddb..265d036095 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -2,6 +2,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "strbuf.h"
+#include "parse-options.h"
 
 /*
  * submodule cache lookup structure
@@ -234,6 +235,27 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_fetch_recurse(opt, arg, 1);
 }
 
+int option_fetch_parse_recurse_submodules(const struct option *opt,
+					  const char *arg, int unset)
+{
+	int *v;
+
+	if (!opt->value)
+		return -1;
+
+	v = opt->value;
+
+	if (unset) {
+		*v = RECURSE_SUBMODULES_OFF;
+	} else {
+		if (arg)
+			*v = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
+		else
+			*v = RECURSE_SUBMODULES_ON;
+	}
+	return 0;
+}
+
 static int parse_update_recurse(const char *opt, const char *arg,
 				int die_on_error)
 {
diff --git a/submodule-config.h b/submodule-config.h
index d434ecdb45..1076a68653 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -23,6 +23,9 @@ struct submodule {
 };
 
 extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+struct option;
+extern int option_fetch_parse_recurse_submodules(const struct option *opt,
+						 const char *arg, int unset);
 extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_submodule_config_option(const char *var, const char *value);
-- 
2.12.2.575.gb14f27f917

