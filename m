Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68D3201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755223AbdEKWEh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:04:37 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35126 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdEKWEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:35 -0400
Received: by mail-pg0-f52.google.com with SMTP id q125so1337322pgq.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fSWIdfyxOaHrnyx/mECz6iAonPDgUEGr12viLLvYFJY=;
        b=C+jNPEPUmgLuLsklWopwxmcB81EU+s8RcrBo09Ogn/05vW6Tg51E8rX3oNq2XLfHMI
         ege8p6CrDiQo3TsK+PmutEiFhptx/8lugVrumTnKxLgWr008ubQvUo3l5ukEMVo0S+Qp
         bz9qlT5c8cRsXaDVQYA/RqC/00iVQkAlj5Ga7MzikjIsyZpnq3hWxWBB+8VYsxnqU6tP
         1cBIsshhDBgHh6mqfH5xz8MdM1dGu/O6w5OwwwIuKktXulx883Ld24n/lSBkuat4+EdO
         LK9vDFwGcpL53iCo0NyYkgv72pmc45r2TZ9+wFUPO5CTi8JuvOQFNN3lGNVS+MTHesQr
         5XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fSWIdfyxOaHrnyx/mECz6iAonPDgUEGr12viLLvYFJY=;
        b=M7svSret5p9hqMMzp+/AG/9TCA4m/c8QOkFJUwudZoxzNNATf/lpgvUHhxPBHXJoH5
         BS5kHH1xUfLuHzftNt925GwBImH+YtNCpI/zbqkpFmw5Xho5CdE9qKf0HXFNFtMSsFdl
         C/B1w4wLbTy7FAzKp1V5SeGMI6I4j/0JyMXZtaNGvdvaA8+DZvZicffRLAg9IZ0fFWoj
         IPii60loDQGOsam8GpV7+FohQw+cdL8F1mpDB/i37WgahDc4+XqH1BGsVtTSl7+7fhlX
         twkDEtM6xB4GoOLC+z1cVtgErbDSH4H9AwBL0WGTfhDm++lEDuYfY2sLAzDBjBWLB+ee
         5Snw==
X-Gm-Message-State: AODbwcB+EQ+7VriFEijTGdIuFkHQssMhan7n5rnQ3kwxQDmm+tV9ux4d
        R0pOeudCAoeUG3cp
X-Received: by 10.84.222.129 with SMTP id x1mr939204pls.144.1494540274487;
        Thu, 11 May 2017 15:04:34 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s68sm1873335pgc.5.2017.05.11.15.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:04:33 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 2/6] submodule: add die_in_unpopulated_submodule function
Date:   Thu, 11 May 2017 15:04:23 -0700
Message-Id: <20170511220427.192627-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170511220427.192627-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170511220427.192627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git add' is the only command which dies when launched from an
unpopulated submodule (the place-holder directory for a submodule which
hasn't been checked out).  This is triggered implicitly by passing the
PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag to 'parse_pathspec()'.

Instead make this desire more explicit by creating a function
'die_in_unpopulated_submodule()' which dies if the provided 'prefix' has
a leading path component which matches a submodule in the the index.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c                    |  3 +++
 pathspec.c                       | 29 -----------------------------
 submodule.c                      | 30 ++++++++++++++++++++++++++++++
 submodule.h                      |  2 ++
 t/t6134-pathspec-in-submodule.sh |  6 +-----
 5 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9f53f020d..ec58e3679 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "bulk-checkin.h"
 #include "argv-array.h"
+#include "submodule.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -379,6 +380,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
+	die_in_unpopulated_submodule(&the_index, prefix);
+
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
diff --git a/pathspec.c b/pathspec.c
index 904cfb739..9b7634c5a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -424,27 +424,6 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 	}
 }
 
-static void die_inside_submodule_path(struct pathspec_item *item)
-{
-	int i;
-
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		int ce_len = ce_namelen(ce);
-
-		if (!S_ISGITLINK(ce->ce_mode))
-			continue;
-
-		if (item->len < ce_len ||
-		    !(item->match[ce_len] == '/' || item->match[ce_len] == '\0') ||
-		    memcmp(ce->name, item->match, ce_len))
-			continue;
-
-		die(_("Pathspec '%s' is in submodule '%.*s'"),
-		    item->original, ce_len, ce->name);
-	}
-}
-
 /*
  * Perform the initialization of a pathspec_item based on a pathspec element.
  */
@@ -547,14 +526,6 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	/* sanity checks, pathspec matchers assume these are sane */
 	if (item->nowildcard_len > item->len ||
 	    item->prefix         > item->len) {
-		/*
-		 * This case can be triggered by the user pointing us to a
-		 * pathspec inside a submodule, which is an input error.
-		 * Detect that here and complain, but fallback in the
-		 * non-submodule case to a BUG, as we have no idea what
-		 * would trigger that.
-		 */
-		die_inside_submodule_path(item);
 		die ("BUG: error initializing pathspec_item");
 	}
 }
diff --git a/submodule.c b/submodule.c
index d3299e29c..885663c42 100644
--- a/submodule.c
+++ b/submodule.c
@@ -282,6 +282,36 @@ int is_submodule_populated_gently(const char *path, int *return_error_code)
 	return ret;
 }
 
+/*
+ * Dies if the provided 'prefix' corresponds to an unpopulated submodule
+ */
+void die_in_unpopulated_submodule(const struct index_state *istate,
+				  const char *prefix)
+{
+	int i, prefixlen;
+
+	if (!prefix)
+		return;
+
+	prefixlen = strlen(prefix);
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		int ce_len = ce_namelen(ce);
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+		if (prefixlen <= ce_len)
+			continue;
+		if (strncmp(ce->name, prefix, ce_len))
+			continue;
+		if (prefix[ce_len] != '/')
+			continue;
+
+		die(_("in unpopulated submodule '%s'"), ce->name);
+	}
+}
+
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
diff --git a/submodule.h b/submodule.h
index 1277480ad..d11b4da40 100644
--- a/submodule.h
+++ b/submodule.h
@@ -49,6 +49,8 @@ extern int is_submodule_initialized(const char *path);
  * Otherwise the return error code is the same as of resolve_gitdir_gently.
  */
 extern int is_submodule_populated_gently(const char *path, int *return_error_code);
+extern void die_in_unpopulated_submodule(const struct index_state *istate,
+					 const char *prefix);
 extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index fd401ca60..0f1cb49ce 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -24,13 +24,9 @@ test_expect_success 'error message for path inside submodule' '
 	test_cmp expect actual
 '
 
-cat <<EOF >expect
-fatal: Pathspec '.' is in submodule 'sub'
-EOF
-
 test_expect_success 'error message for path inside submodule from within submodule' '
 	test_must_fail git -C sub add . 2>actual &&
-	test_cmp expect actual
+	test_i18ngrep "in unpopulated submodule" actual
 '
 
 test_done
-- 
2.13.0.rc2.291.g57267f2277-goog

