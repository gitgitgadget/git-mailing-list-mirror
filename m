Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A5C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeGLTP5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:15:57 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:41612 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeGLTP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:15:57 -0400
Received: by mail-qk0-f201.google.com with SMTP id 123-v6so33740771qkg.8
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=0QVnongDshtf2uJLWUSTR83RrBMhUkraMgX9I3TbIck=;
        b=YbSq5yC9lizbG0hKOFQOzy9ruEvUl1WVv1QBwBe6GxYg90dhjgn4TvkqlhFhpARM4F
         CzWaUnrIdKSei+4mbrcHxXZk8Qf8zqDKtnqPb44mWyCz7AfStQ7Kh1LGR57zkZy13TZq
         uF2Xj7S8CVwtwK/PoTlmwf8M82jhOunOaqd85VADoaoIUXt8H9ktZJwdGkCBsrjYrG+X
         EeNDma/bLwLhFdbbkFLmpa2PLAunYWeV2ZKhhWtah1BbW8kt2hM637XYz3moRRDhAfrD
         3UQa828600GT3mSjx9l0bQPRTvESt9/ZatoDqNRroSfbgHOuzAsgS9kwO2v9lPKvjXjz
         7v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=0QVnongDshtf2uJLWUSTR83RrBMhUkraMgX9I3TbIck=;
        b=tZHT3XNMvoljpcxW/di4L1RypgTToDvSFNGCudmJv3eekt72l5zMYiUaHNW7nirRW9
         +4o6UXNvPm6oi2zgQSfBMcKNPX5CQo83rDN0gsrX7ioXaaE5DDzd6AgCYbKVGoZVgVOT
         MnKpOKCzH832FAD5KTG38qu9b7hMh+maP9KMmnCwaaS2WcBNlVSBcl6sXu3LgH/Ny8jf
         fVAC9L08FT5f03Mx/Sc4XWSCA9GTAhyFGmK9hsQsh3zGsbQX4tdf+CQeft06x68DwRMK
         QMj97FYK6c1vLMc0Bz26KGfoVpr3UcmDcfb3sw8kJ2fCEdLQ8edxktuUJfcDI7WMgMMK
         cgHg==
X-Gm-Message-State: AOUpUlGf2Wfkqpm1kJlMeU2kSt1IOC6DNG92d7AYKvyX3M4pFET2TYQD
        AZypddIO7J5kG/KMAOyMvAJcxmRAYv7K
X-Google-Smtp-Source: AAOMgpd7+wYNVrbAlMk5+490WOz3PUQRkDrFJ4MpSMMPmZvlJysGpCw/49SeFAuL2RsMZDS0SggsY7mdGDQ+
MIME-Version: 1.0
X-Received: by 2002:a37:aa4e:: with SMTP id t75-v6mr1953452qke.2.1531422305271;
 Thu, 12 Jul 2018 12:05:05 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:04:56 -0700
Message-Id: <20180712190456.29337-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] RFC: submodule-config: introduce trust level
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, ao2@ao2.it, hvoigt@hvoigt.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The series merged at 614ea03a71e (Merge branch
'bw/submodule-config-cleanup', 2017-08-26) went to great length to make it
explicit to the caller where a value came from, as that would help the
caller to be careful to decide which values to take from where, i.e. be
careful about security implications.

In practice we always want to stack the settings starting with the
.gitmodules file as a base and then put the config on top of it.
So let's manage the security aspects impolitely in the submodule-config
machinery directly where we implement its parsing as there is a good
place to reason about the trust that we need to put into a parsed value.

This patch implements the trust level that is passed to the parsing,'
currently we only pass in the 'in_repo' level of trust, which is the
.gitmodules file.

Follow up patches could add other sources that populate the submodule
config again.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This is on top of ao/config-from-gitmodules.

 submodule-config.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 77421a49719..09eab9f00e0 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -21,6 +21,11 @@ struct submodule_cache {
 	unsigned gitmodules_read:1;
 };
 
+enum submodule_config_trust_level {
+	in_repo = 1,
+	configured_by_user = 2
+};
+
 /*
  * thin wrapper struct needed to insert 'struct submodule' entries to
  * the hashmap
@@ -387,12 +392,14 @@ struct parse_config_parameter {
 	struct submodule_cache *cache;
 	const struct object_id *treeish_name;
 	const struct object_id *gitmodules_oid;
+	enum submodule_config_trust_level source;
 	int overwrite;
 };
 
 static int parse_config(const char *var, const char *value, void *data)
 {
 	struct parse_config_parameter *me = data;
+	enum submodule_config_trust_level source = me->source;
 	struct submodule *submodule;
 	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
 	int ret = 0;
@@ -406,6 +413,7 @@ static int parse_config(const char *var, const char *value, void *data)
 					     name.buf);
 
 	if (!strcmp(item.buf, "path")) {
+		/* all sources allowed */
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path)
@@ -419,6 +427,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			cache_put_path(me->cache, submodule);
 		}
 	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+		/* all sources allowed */
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_oid(me->gitmodules_oid);
 		if (!me->overwrite &&
@@ -430,6 +439,7 @@ static int parse_config(const char *var, const char *value, void *data)
 								var, value,
 								die_on_error);
 	} else if (!strcmp(item.buf, "ignore")) {
+		/* all sources allowed */
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore)
@@ -446,6 +456,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->ignore = xstrdup(value);
 		}
 	} else if (!strcmp(item.buf, "url")) {
+		/* all sources allowed */
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url) {
@@ -456,16 +467,27 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->url = xstrdup(value);
 		}
 	} else if (!strcmp(item.buf, "update")) {
+		struct submodule_update_strategy st;
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite &&
 			 submodule->update_strategy.type != SM_UPDATE_UNSPECIFIED)
 			warn_multiple_config(me->treeish_name, submodule->name,
 					     "update");
-		else if (parse_submodule_update_strategy(value,
-			 &submodule->update_strategy) < 0)
-				die(_("invalid value for %s"), var);
+		else if (parse_submodule_update_strategy(value, &st) < 0)
+			die(_("invalid value for %s"), var);
+		else if (source <= in_repo) {
+			if (st.type == SM_UPDATE_COMMAND) {
+				submodule->update_strategy.type = st.type;
+				submodule->update_strategy.command = \
+				"!echo Not trusting command in submodule.<name>.update";
+			} else {
+				submodule->update_strategy.type = st.type;
+				submodule->update_strategy.command = st.command;
+			}
+		}
 	} else if (!strcmp(item.buf, "shallow")) {
+		/* all sources allowed */
 		if (!me->overwrite && submodule->recommend_shallow != -1)
 			warn_multiple_config(me->treeish_name, submodule->name,
 					     "shallow");
@@ -473,6 +495,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->recommend_shallow =
 				git_config_bool(var, value);
 	} else if (!strcmp(item.buf, "branch")) {
+		/* all sources allowed */
 		if (!me->overwrite && submodule->branch)
 			warn_multiple_config(me->treeish_name, submodule->name,
 					     "branch");
@@ -560,6 +583,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.treeish_name = treeish_name;
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
+	parameter.source = in_repo;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
 			config, config_size, &parameter);
 	strbuf_release(&rev);
@@ -617,6 +641,7 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 	parameter.treeish_name = NULL;
 	parameter.gitmodules_oid = &null_oid;
 	parameter.overwrite = 1;
+	parameter.source = in_repo;
 
 	return parse_config(var, value, &parameter);
 }
-- 
2.18.0.203.gfac676dfb9-goog

