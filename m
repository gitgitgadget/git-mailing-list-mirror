Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFBD1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbdEITSb (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:31 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33554 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEITS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:29 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so4574288pfh.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=COr4eRoSYaIqmcOLu9dSA/EF/M0/umcDv0bxvAxw4vw=;
        b=PG5uhz6F6H0PsjKNmYWLKNOS12y1r/XEl1f7GK1YB9QZd++qMK1YFxDCB7acjuiwkn
         HxBWzDt4/qHNWYxV+sCfGBOc55xse3L2YIbpAhO/b6Hz8AqZgpxNy7XzXgBRDmDQ5Fcm
         5mFgW5zSslBwM9CcCjmhL/k44SXqySGlp9APU4UqHskFA+72nwaYe1dAddX7ItBtMS/J
         g1uM+3EESy4RfJP1fFCLGZ6QUvrTr/bFHkw+hUXZ6JsC4GgiPtoN4Liby3Wi1hWHU/rC
         eniE0rqYjFeszojeAeNIw19HsFSFNdUYdk2sPt9bjnAuR+mQis4hP+Nj5tL4blyU1E2e
         KxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=COr4eRoSYaIqmcOLu9dSA/EF/M0/umcDv0bxvAxw4vw=;
        b=M+OV9gDXr3DiXRQ1nTRrrJZcPuxdT+ZV7hpF24oM7I5L7SgMjTspcgF4QUEjuyyB59
         dOIFbcakge/GzW/AeOC+4OYBCR/eOZL9xGk3J1vKiNnRGZQs9tr+Lq2KchSmY6eVxnNf
         uQwyIpEVHQ0jm/KJbtRzhF1Qwr8chS314d6rKZLsYY7/DNW6zcFAPFt9Zlpge/6aDvfr
         t0zDgMh4LzDXMJiDJ6Smj3DEUdCH5IwArpvH8zRaM1QRNTarDrtaMbzyGt2gm7vpxzoS
         73J0JVHxK04nkczfDoVoZqJujcodz+ebHrHj5gsmRobbib9xri6zoCXmGFiCfnSCWlfs
         zImw==
X-Gm-Message-State: AODbwcApjgE0WQrFs+Xn183+6x5Aw8W/3Gzxx+oYTL+f2kd/DhlSzeF/
        gQxWwjFpkpv0u7WHMFTBXQ==
X-Received: by 10.99.107.198 with SMTP id g189mr1902135pgc.162.1494357508428;
        Tue, 09 May 2017 12:18:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/8] pathspec: change PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
Date:   Tue,  9 May 2017 12:18:00 -0700
Message-Id: <20170509191805.176266-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's confusing to have two different 'strip submodule slash' flags which
do subtly different things.  Both
PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE and
PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP will accomplish the same task of
striping a slash from a pathspec which matches a submodule entry in the
index.  The only difference is that
PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE will perform additional checks
and die if a pathspec has a leading path component which corresponds to
a submodule.  This additional functionality should be split out into its
own flag.

To this end, rename the PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag to
PATHSPEC_SUBMODULE_LEADING_PATH and change its behavior to only die if a
path descends into a submodule.  In addition add the
PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag to callers which relied on the
old slash stripping functionality.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c          |  3 ++-
 builtin/check-ignore.c |  3 ++-
 pathspec.c             | 32 ++++++++++++++++----------------
 pathspec.h             |  9 +++------
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ec58e3679..2aa9aeab9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -389,7 +389,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE,
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
+		       PATHSPEC_SUBMODULE_LEADING_PATH,
 		       prefix, argv);
 
 	if (add_new_files) {
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 1d73d3ca3..73237b2b1 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -87,7 +87,8 @@ static int check_ignore(struct dir_struct *dir,
 	parse_pathspec(&pathspec,
 		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
 		       PATHSPEC_SYMLINK_LEADING_PATH |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE |
+		       PATHSPEC_SUBMODULE_LEADING_PATH |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
 		       PATHSPEC_KEEP_ORDER,
 		       prefix, argv);
 
diff --git a/pathspec.c b/pathspec.c
index e37256c3b..f37d5769d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -398,29 +398,29 @@ static void strip_submodule_slash_cheap(struct pathspec_item *item)
 	}
 }
 
-static void strip_submodule_slash_expensive(struct pathspec_item *item)
+static void die_path_inside_submodule(const struct pathspec_item *item,
+				      const struct index_state *istate)
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 		int ce_len = ce_namelen(ce);
 
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (item->len <= ce_len || item->match[ce_len] != '/' ||
-		    memcmp(ce->name, item->match, ce_len))
+		if (item->len <= ce_len)
+			continue;
+		if (item->match[ce_len] != '/')
+			continue;
+		if (strncmp(ce->name, item->match, ce_len))
+			continue;
+		if (item->len == ce_len + 1)
 			continue;
 
-		if (item->len == ce_len + 1) {
-			/* strip trailing slash */
-			item->len--;
-			item->match[item->len] = '\0';
-		} else {
-			die(_("Pathspec '%s' is in submodule '%.*s'"),
-			    item->original, ce_len, ce->name);
-		}
+		die(_("Pathspec '%s' is in submodule '%.*s'"),
+		    item->original, ce_len, ce->name);
 	}
 }
 
@@ -499,9 +499,6 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
 		strip_submodule_slash_cheap(item);
 
-	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
-		strip_submodule_slash_expensive(item);
-
 	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
 	} else {
@@ -639,6 +636,9 @@ void parse_pathspec(struct pathspec *pathspec,
 			die(_("pathspec '%s' is beyond a symbolic link"), entry);
 		}
 
+		if (flags & PATHSPEC_SUBMODULE_LEADING_PATH)
+			die_path_inside_submodule(item + i, &the_index);
+
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard = 1;
 		pathspec->magic |= item[i].magic;
diff --git a/pathspec.h b/pathspec.h
index 55e976972..93a819cbf 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -63,13 +63,10 @@ struct pathspec {
 /* die if a symlink is part of the given path's directory */
 #define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
 /*
- * This is like a combination of ..LEADING_PATH and .._SLASH_CHEAP
- * (but not the same): it strips the trailing slash if the given path
- * is a gitlink but also checks and dies if gitlink is part of the
- * leading path (i.e. the given path goes beyond a submodule). It's
- * safer than _SLASH_CHEAP and also more expensive.
+ * Checks and dies if gitlink is part of the leading path
+ * (i.e. the given path goes beyond a submodule).
  */
-#define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
+#define PATHSPEC_SUBMODULE_LEADING_PATH (1<<5)
 #define PATHSPEC_PREFIX_ORIGIN (1<<6)
 #define PATHSPEC_KEEP_ORDER (1<<7)
 /*
-- 
2.13.0.rc2.291.g57267f2277-goog

