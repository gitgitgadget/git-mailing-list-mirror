Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721092021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030223AbcKOXOe (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:14:34 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34118 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030207AbcKOXOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:14:33 -0500
Received: by mail-pg0-f47.google.com with SMTP id x23so68860995pgx.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xuJW9TjpvtIWnbL3PynLRdxamM2VxyyLyvMmtqAJfC8=;
        b=lKLW6me3OEiuezQ5swjWsyyA4v6tCNzHfeJ+FaKLbwO2SNf2G/ZInZ0r9iqiWeCv8M
         uxV+VXH1/agsPV8rxRRHhqWifMki0XQty3Vrjr/2+cJ8L08ZuOZXOgBJRuQsaKTE7tt2
         hqaoid41aULKV7hOORursdao7+mFL5bC/sWMR7RuSlxC5jM3ZMQLAyThnbe2aVG3VQ6D
         KcknLQkRMPxutppX3SneR7sSR0rs/cKhIDBKu/98JXL6vGZgkSMCl9ieb2F4EFtzJVTu
         JYW4s7EljuDnYGrFnqwIdptcb+lAKB7He14e12S47yqIdQP4S0ewlRgocRCQsFiwjVib
         XnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xuJW9TjpvtIWnbL3PynLRdxamM2VxyyLyvMmtqAJfC8=;
        b=Lnqj/MHAdI1rIQ0bU+7gexPoDTP71OY/ApFjLN9RIWCVStoyhSvRIk4KqJBZ++X0qV
         QA59QDuIESZCEMl4LvM6rpyfywr7ptUhy/3OaQQueNhNraefPOD51G+bJ91wa44CqZmM
         MEw5zCq6m1N4/r1/gbPl2qiIVN6wuhnJT4q6hQ33O9FArthQvdKhoroAXXjxxo8qk90g
         Bbj2rMohx0VuEBD4drPPNVqS10qBvwiM9+1B8dsaj3V75uxLXeY+TyerNosAcLABetIA
         zAI4oiOr6pCGBArOyTF7frbF4qgrPjiigr/ixjbAHm6lDTezYp35N+ZTuzDXIJS+wtv8
         zZ5Q==
X-Gm-Message-State: ABUngvcNvLM3wm2FizTvLIwg73EpCr7m3/Iz/lPDjtURe2+SZGl3/WDtnBJNjPo9Ur77bbV/
X-Received: by 10.99.119.9 with SMTP id s9mr1157433pgc.11.1479251220683;
        Tue, 15 Nov 2016 15:07:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id n24sm23626428pfb.0.2016.11.15.15.07.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/16] update submodules: add submodule config parsing
Date:   Tue, 15 Nov 2016 15:06:40 -0800
Message-Id: <20161115230651.23953-6-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar as in b33a15b08 (push: add recurseSubmodules config option,
2015-11-17) and 027771fcb1 (submodule: allow erroneous values for the
fetchRecurseSubmodules option, 2015-08-17), we add submodule-config code
that is later used to parse whether we are interested in updating
submodules.

We need the `die_on_error` parameter to be able to call this parsing
function for the config file as well, which if incorrect let's Git die.

As we're just touching the header file, also mark all functions extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 22 ++++++++++++++++++++++
 submodule-config.h | 17 +++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 098085b..4b5297e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,6 +234,28 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_fetch_recurse(opt, arg, 1);
 }
 
+static int parse_update_recurse(const char *opt, const char *arg,
+				int die_on_error)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "checkout"))
+			return RECURSE_SUBMODULES_ON;
+		if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		return RECURSE_SUBMODULES_ERROR;
+	}
+}
+
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	return parse_update_recurse(opt, arg, 1);
+}
+
 static int parse_push_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
diff --git a/submodule-config.h b/submodule-config.h
index d05c542..992bfbe 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,13 +22,14 @@ struct submodule {
 	int recommend_shallow;
 };
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_submodule_config_option(const char *var, const char *value);
-const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
-		const char *name);
-const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
-		const char *path);
-void submodule_free(void);
+extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_submodule_config_option(const char *var, const char *value);
+extern const struct submodule *submodule_from_name(
+		const unsigned char *commit_sha1, const char *name);
+extern const struct submodule *submodule_from_path(
+		const unsigned char *commit_sha1, const char *path);
+extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.10.1.469.g00a8914

