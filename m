Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A11220133
	for <e@80x24.org>; Mon,  6 Mar 2017 22:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbdCFV67 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:58:59 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33012 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbdCFV64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:58:56 -0500
Received: by mail-pg0-f48.google.com with SMTP id 25so70873439pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+elW3utxHEE0hR3cQUEQqGvEgDb9w4+GTIiQ/iM6PYs=;
        b=QE64LoyPqpoTTJ/qPGTACzkC1lIB9UU6DRmnydRifxXRUtE0G4rZOO7PIN9oq5TDng
         S1EgJoFac5toQtfqukq1Dw4HJOhwSVymyZB1LY4Cu16w+8YqK0Zldc2BnB7M91R4j9HA
         OwbvTaiw4vk++SHInYjr5Fowv8r+h4wuJhVd27uzx0moh/YzOVQSKjb7IBrEXUMmoMf0
         egIw4uxeKWnjru2oborgHVSWhMTwTEHwQhzRBLiIzQhyCESpeoRf/ByfT70kSngKde98
         V1i40gxVFM9ciACk0JpsRWIVrkNXuv2qtIEA13MDi87nGkpOQ01dUJ/hn6JWmULBO8lT
         PVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+elW3utxHEE0hR3cQUEQqGvEgDb9w4+GTIiQ/iM6PYs=;
        b=TFFVbAa81qiLyzNOw+qSxQPyjshzxZmI+HXvv1VFBLbmNL1zyL4FbN4+UujX7DEcr+
         a1Pkvqw1MVeYPRDsdbIbx54AbuulsvTCJcRWRS1Emume97iUNlCvfIepCdP2JnTe9p39
         bVo6DGi0HEZNQjU+CXOfsUZ/iwk/rIbMoBoE8rxQaqJjQKh1sMSGW8BcK4wQEpL1OFrU
         ZbO852mKCJPED8Y2r8Y9rN05JHA0G9MTwZCsAwo29B0MSllq2yAZapbjiYbGOu/EdGxc
         XXMoaK6ikRuIebjkY9xjkoQ9gpEteUrSqv+qWRl2PnVbD2QSlKlin0yQdKFyGen5Zxhp
         kkzQ==
X-Gm-Message-State: AMke39lI434kmmLwfZ6gGVZjprghfj3DXQN14Ys5e8ngsZwbWPyPPi+wzRbbJf6qfbJm3LkI
X-Received: by 10.84.176.100 with SMTP id u91mr29792959plb.112.1488833973658;
        Mon, 06 Mar 2017 12:59:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id e13sm41545306pgf.48.2017.03.06.12.59.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 08/18] update submodules: add submodule config parsing
Date:   Mon,  6 Mar 2017 12:59:09 -0800
Message-Id: <20170306205919.9713-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to b33a15b08 (push: add recurseSubmodules config option,
2015-11-17) and 027771fcb1 (submodule: allow erroneous values for the
fetchRecurseSubmodules option, 2015-08-17), we add submodule-config code
that is later used to parse whether we are interested in updating
submodules.

We need the `die_on_error` parameter to be able to call this parsing
function for the config file as well, which if incorrect lets Git die.

As we're just touching the header file, also mark all functions extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 20 ++++++++++++++++++++
 submodule-config.h | 17 +++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 93453909cf..3e8e380d98 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,6 +234,26 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
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
index 70f19363fd..d434ecdb45 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,16 +22,17 @@ struct submodule {
 	int recommend_shallow;
 };
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_submodule_config_option(const char *var, const char *value);
-const struct submodule *submodule_from_name(const unsigned char *commit_or_tree,
-		const char *name);
-const struct submodule *submodule_from_path(const unsigned char *commit_or_tree,
-		const char *path);
+extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_submodule_config_option(const char *var, const char *value);
+extern const struct submodule *submodule_from_name(
+		const unsigned char *commit_or_tree, const char *name);
+extern const struct submodule *submodule_from_path(
+		const unsigned char *commit_or_tree, const char *path);
 extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev);
-void submodule_free(void);
+extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.12.0.rc1.52.ge239d7e709.dirty

