Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80BD20798
	for <e@80x24.org>; Fri, 11 Nov 2016 23:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937863AbcKKXvf (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 18:51:35 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32916 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933709AbcKKXve (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 18:51:34 -0500
Received: by mail-pf0-f172.google.com with SMTP id d2so14215148pfd.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/IT5Ac+yvGgSA/i8P7uoRqoVK1Y957kVHQYraF7wq4=;
        b=W9SS1sIIOWgYj5RmGG8G+reGp115UI0QKb328ewnEOWIs5VtfTk4oVhqtad7wCsS7B
         UBS8rTW+BS2y2NY0fubJtNrI1+tgvo/UN0HDPod4GcB+OYOmUtGNcAVw4i1RLStr5D/4
         pXMR65alhj8hlhnKOz4/FbDfZeZRzBlb9tYSFZ4rGEsAmnYGA7a35THjlr71gtxvwuGD
         X63K4ZFSlogsnJ/5I/y3bIiGDEgzkwu4k1aD+P8aKDzffu4HmSFnXjpotisgfziZM3JT
         yDHXEFR/rgrew8lOl7yX2d6SANIp3O4A1goYmWfGwFKYIajXfH8TKSGt/vdnDKaUNx0Q
         SZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/IT5Ac+yvGgSA/i8P7uoRqoVK1Y957kVHQYraF7wq4=;
        b=QQC+sNf1SNngRluHeUBN7KF9PD6JyyQSoLK6BuHW0aN616xn+aHkEc9/l2lBZPljA+
         Fa13Z3ZWuzVib5mfSLG3R1A+cYLdzObH/EufBdh1T9TdnVESq0akLyI1dwSX7M0tS1rK
         IbJ56sXWHXmXTLAAYsM8ljIeXlkaY7EbdfvzGONKe8n46rrDtLUgOJy4Mr4TAa6JayHx
         utaSBJ2NKRy4rp2sAinU8g5wSslMhC4t+or27OINvNipkpA8glY+FNcJFu7XOhT1YKzt
         KXip1N9yz+vMZSM62DbmtLUOZ3ZuHGNKgnRJrn/elWSgwBRfPOsAjWt4lr10gi9XhoJm
         pr1A==
X-Gm-Message-State: ABUngvcvhZkKXlSPioiq9+lof2rt/cc1y4STEsbxJ8dBr87WaCFARZiEi8qDersmcIQnGffe
X-Received: by 10.99.113.13 with SMTP id m13mr21153333pgc.121.1478908293433;
        Fri, 11 Nov 2016 15:51:33 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r74sm17568314pfl.79.2016.11.11.15.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 15:51:32 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v3 2/6] submodules: load gitmodules file from commit sha1
Date:   Fri, 11 Nov 2016 15:51:09 -0800
Message-Id: <1478908273-190166-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478908273-190166-1-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

teach submodules to load a '.gitmodules' file from a commit sha1.  This
enables the population of the submodule_cache to be based on the state
of the '.gitmodules' file from a particular commit.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h            |  2 ++
 config.c           |  8 ++++----
 submodule-config.c |  6 +++---
 submodule-config.h |  3 +++
 submodule.c        | 12 ++++++++++++
 submodule.h        |  1 +
 6 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 1be6526..559a461 100644
--- a/cache.h
+++ b/cache.h
@@ -1690,6 +1690,8 @@ extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
+extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
+				     const unsigned char *sha1, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void git_config(config_fn_t fn, void *);
diff --git a/config.c b/config.c
index 83fdecb..4d78e72 100644
--- a/config.c
+++ b/config.c
@@ -1214,10 +1214,10 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
 	return do_config_from(&top, fn, data);
 }
 
-static int git_config_from_blob_sha1(config_fn_t fn,
-				     const char *name,
-				     const unsigned char *sha1,
-				     void *data)
+int git_config_from_blob_sha1(config_fn_t fn,
+			      const char *name,
+			      const unsigned char *sha1,
+			      void *data)
 {
 	enum object_type type;
 	char *buf;
diff --git a/submodule-config.c b/submodule-config.c
index 098085b..8b9a2ef 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -379,9 +379,9 @@ static int parse_config(const char *var, const char *value, void *data)
 	return ret;
 }
 
-static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
-				      unsigned char *gitmodules_sha1,
-				      struct strbuf *rev)
+int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+			       unsigned char *gitmodules_sha1,
+			       struct strbuf *rev)
 {
 	int ret = 0;
 
diff --git a/submodule-config.h b/submodule-config.h
index d05c542..78584ba 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -29,6 +29,9 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
+extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
+				      unsigned char *gitmodules_sha1,
+				      struct strbuf *rev);
 void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index f5107f0..062e58b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -198,6 +198,18 @@ void gitmodules_config(void)
 	}
 }
 
+void gitmodules_config_sha1(const unsigned char *commit_sha1)
+{
+	struct strbuf rev = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	if (gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
+		git_config_from_blob_sha1(submodule_config, rev.buf,
+					  sha1, NULL);
+	}
+	strbuf_release(&rev);
+}
+
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
diff --git a/submodule.h b/submodule.h
index 6ec5f2f..9203d89 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
 extern int is_submodule_populated(const char *path);
 int parse_submodule_update_strategy(const char *value,
-- 
2.8.0.rc3.226.g39d4020

