Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE4C2021E
	for <e@80x24.org>; Mon, 31 Oct 2016 22:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945767AbcJaWiz (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 18:38:55 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33503 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945727AbcJaWiy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 18:38:54 -0400
Received: by mail-pf0-f173.google.com with SMTP id d2so8587768pfd.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GcNR2tgBRLu52lUCaaXv9MC5jV/rXB3ITQU5Ob2XIEQ=;
        b=lR2tqiP9non1U2LIqoEEYqizv1dmCIAjvF+KBxMoUCZjKWQ9+zlaP1jcldNKqTrnT7
         2p3AFhigJVwgAA6OgwX5eTKNkYQwAjBu4LSoHtboWWKbF5LeectYOpJeZMCF4v9ZC3NC
         /TfX01RJWRN7VNym4bEKmJsu/JcgOf319YnC3Cm0oGR4p55qXn0RP4LArplmS0uVouCa
         aFKtkbSl7MKsLuA+U78Sgk2wsUN/8+u8G7BIIvLhH0Yc2jcnbKKahpk1Ndrcu10fi5JM
         GYoMST0mECNkDRrOQKoy6nLfWxmWtzaoqAjye29quxH3zHCNCvVoqgilhwdWSksfL4IT
         slyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GcNR2tgBRLu52lUCaaXv9MC5jV/rXB3ITQU5Ob2XIEQ=;
        b=RB6xiD5LKNCGh7XIH5eqjjxvE6qcMCShIFeO2ZTaCeTK3mxBnNSQdaWBLW9v9D2mJw
         Sad9+qmLxSwVnIJlsz8MVXiVK/cedUGBBHjA7+GKSQoMxyvDvjZTavTU/e9RCDVxxzWu
         mUcMf+ZdYkGFjR8ksKgbiJHlgoB7v+8jU2W20dslOAFQeOnAN9U62XSrt2MRY00rwxhz
         UfMSFQFbNcsB0tS9yobVbmzMGC+JYeMO+e55VL2D3i1Rz0pYX4DTrS7NNuCv65Ig38p/
         7YFC4bEk4g7IU9qWLYrHvnmSZCi89depY938DqYkOMMK1crndxotTkTYWF70bf9stask
         NLog==
X-Gm-Message-State: ABUngvf6ZTzEAs/NjFjZcwPThtzyRDvZrHIo2fYjqJgiNTYUSYrVXcsTUn+Q6mbUCL4UkV/5
X-Received: by 10.99.184.25 with SMTP id p25mr44438748pge.120.1477953533543;
        Mon, 31 Oct 2016 15:38:53 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id uh10sm37847280pab.5.2016.10.31.15.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 15:38:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, sbeller@google.com
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 2/6] submodules: load gitmodules file from commit sha1
Date:   Mon, 31 Oct 2016 15:38:12 -0700
Message-Id: <1477953496-103596-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1477953496-103596-1-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach submodules to load a '.gitmodules' file from a commit sha1.  This
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
index ff4e7b2..19dfbd4 100644
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
index bd039ca..9a24ac8 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
 extern int is_submodule_initialized(const char *path);
 extern int is_submodule_checked_out(const char *path);
 int parse_submodule_update_strategy(const char *value,
-- 
2.8.0.rc3.226.g39d4020

