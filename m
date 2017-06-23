Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90F620831
	for <e@80x24.org>; Fri, 23 Jun 2017 19:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbdFWTNQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:13:16 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36838 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754777AbdFWTNP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:13:15 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so27401956pfl.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VTcwQ/rzMMq4sWRHB4O3wWw646XifFlY/NDRvrL4/Yk=;
        b=h9q6bw3x8KSz9nn6Cd9a+WSCSO5XKriO0xbmIAn1u71kNOf84Adq0EH5QkT3zX85LB
         +awNVXVNbs5eeOiPcQ1AkLfAqB4vfDB8iz7/0HAK3cqojFKY9Nz0SDL4bGZZz3+rpYa9
         4KHcTNrkJ81fJKsftR5ukHh3clW6yOzShp1HfJcMpbqj1SyfOwhakY+cwXwo5NqTTqLm
         lUICRaUeS+X0p1LexEKTHHTu2VnXO9usvSVqA/QHkj7vF0W7Eo0Hg1Xz8iSrQY99ubIr
         soeTIXl0eeA/w9AWw4RFOTwj396z0NfzL0MSQJeF7m9/96/JW0PqjFRrRbnJa/HSasbG
         0Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VTcwQ/rzMMq4sWRHB4O3wWw646XifFlY/NDRvrL4/Yk=;
        b=Ke3SXPpWH6q8oiRuagboOv5aB8C2n7vrShpnQhCPgYjwuGYJZdVE/eTIbTY8s2jDQe
         9rSBDuf2MDNZ5s2vMKCxieo0j+uYkVT6Vf8ONViFujaNNFTy3VhghhPm9m2MxVv+sHe9
         Z0ZeaaXsTebyiWojqTtZ80Us7dUD0/de1Xx9AlXvwK67NuVTY7bBJvwENo5y9U+JTlHQ
         uzqCp7L6vAnEprfcQzmOU/3JMEC8cDMjcoFCMMxmQqOEDdUk2E+yXpbCqe4k9uWaCFeN
         8HrjpfbpMxhw0/jbm0ydjguqMxcm1hIMUo3N9HLC1k9JYohQRowfh5xZPKGTZW195v96
         0lvw==
X-Gm-Message-State: AKS2vOzn6ONPZPkIeYciCHXHZWUSUBF947wGvTlBd2AxJbu9A5lT6d2e
        wraz7lI1Cc4UMFj+
X-Received: by 10.84.229.6 with SMTP id b6mr10511377plk.247.1498245194281;
        Fri, 23 Jun 2017 12:13:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1530:f035:a8be:c887])
        by smtp.gmail.com with ESMTPSA id x3sm12759094pgx.29.2017.06.23.12.13.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 12:13:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        philipoakley@iee.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] builtin/fetch: parse recurse-submodules-default at default options parsing
Date:   Fri, 23 Jun 2017 12:13:01 -0700
Message-Id: <20170623191302.16053-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623191302.16053-1-sbeller@google.com>
References: <20170623191302.16053-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of just storing the string and then later calling our own
parsing function 'parse_fetch_recurse_submodules_arg', make use of the
function callback 'option_fetch_parse_recurse_submodules' that was
introduced in the last patch. Also move all submodule recursing variables
in one spot at the top of the file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9d58dc0a8a..3cca568173 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -36,7 +36,7 @@ static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
-static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int progress = -1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_children = -1;
 static enum transport_family family;
@@ -48,7 +48,8 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
-static const char *recurse_submodules_default;
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules_default = RECURSE_SUBMODULES_DEFAULT;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
@@ -123,9 +124,11 @@ static struct option builtin_fetch_options[] = {
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
-	{ OPTION_STRING, 0, "recurse-submodules-default",
-		   &recurse_submodules_default, NULL,
-		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
+	{ OPTION_CALLBACK, 0, "recurse-submodules-default",
+		   &recurse_submodules_default, N_("on-demand"),
+		   N_("default for recursive fetching of submodules "
+		      "(lower priority than config files)"),
+		   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules },
 	OPT_BOOL(0, "update-shallow", &update_shallow,
 		 N_("accept refs that update .git/shallow")),
 	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
@@ -1333,10 +1336,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		deepen = 1;
 
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		if (recurse_submodules_default) {
-			int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
-			set_config_fetch_recurse_submodules(arg);
-		}
+		if (recurse_submodules_default != RECURSE_SUBMODULES_DEFAULT)
+			set_config_fetch_recurse_submodules(recurse_submodules_default);
 		gitmodules_config();
 		git_config(submodule_config, NULL);
 	}
-- 
2.12.2.575.gb14f27f917

