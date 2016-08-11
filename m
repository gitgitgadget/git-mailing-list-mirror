Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB4920193
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbcHKXOV (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:21 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36761 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbcHKXOT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id pp5so2703474pac.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ayp5/M+DhPLBNymuVag1/l7+96vHQxYYLxPwUXWEzho=;
        b=FtaTh/k1FD01s6CAr94Xoo5eVxfAFz3i4soz9XdaHaBQT3+GSD6bVnuK/IgnGoQcUa
         jZV9AubkwTNg22+KkjSlLjCtZ7OqXB+cXpcKW0yQCFGyXyqS39oiFUABNpiVfblloymZ
         ymkgglIYV3fesAXmK4NR9aZj0heqpc2dFhbpPD1wb6BTS3+RjqoUUJiKsI/XFfNVo+u6
         0CkrB2G+ns454TB9DmnM2t3QlWegSmI73zpoNeVAFStnrhFkQzaN9Sx2Xq+icWfHx1he
         psP45iaciicUQxA7/KHjjaJoNbuTq4v5guEQvsE+UnCFSOG//wm8+lyZQmLv3pbWs0FO
         zKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ayp5/M+DhPLBNymuVag1/l7+96vHQxYYLxPwUXWEzho=;
        b=U48qni+DxORo3lTC5osFiyGYTmNe5M3LPFywcgyb2cCWGfZERx8x3/LzNqK+NQvGYn
         O7+/2J1ZmCLyZwT+JHf6F14RnlcX/cG7GUnkZPY8zm4c605aiRZCd47pprkPKemzQsog
         yVkOzZhnm4p6RajX1uZZ9lCOAzOc607V08QEfSfvSBn9/jBuQEvg1frquNZaXrOEsTzq
         i8isEuDu6vu60APhHeK81XA/GHolC/NlGeDMedpnw81bXAYMm88cBi70whzFH95Zx8L+
         3WYqfd5sLqd851KbMJMpnvSEuGs95REpydfb/1mun2JtDZc+U4jwjbSVUs7jgxAr6Wzy
         jTvg==
X-Gm-Message-State: AEkoousAUeIB+E2bem/1tzM+M9Ky/7OLKakl2PeaMwrAFl7PSjihH7RKvDiW6avmmP+2dpV6
X-Received: by 10.66.54.132 with SMTP id j4mr21658177pap.110.1470957258274;
        Thu, 11 Aug 2016 16:14:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id p9sm7740851pfj.3.2016.08.11.16.14.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:17 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/8] submodule--helper update-clone: allow multiple references
Date:	Thu, 11 Aug 2016 16:14:01 -0700
Message-Id: <20160811231405.17318-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
In-Reply-To: <20160811231405.17318-1-sbeller@google.com>
References: <20160811231405.17318-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow the user to pass in multiple references to update_clone.
Currently this is only internal API, but once the shell script is
replaced by a C version, this is needed.

This fixes an API bug between the shell script and the helper.
Currently the helper accepts "--reference" "--reference=foo"
as a OPT_STRING whose value happens to be "--reference=foo", and
then uses

        if (suc->reference)
                argv_array_push(&child->args, suc->reference)

where suc->reference _is_ "--reference=foo" when invoking the
underlying "git clone", it cancels out.

With this change we omit one of the "--reference" arguments when
passing references from the shell script to the helper.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 14 +++++++++-----
 git-submodule.sh            |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index db9270e..a10a777 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -584,7 +584,7 @@ struct submodule_update_clone {
 	/* configuration parameters which are passed on to the children */
 	int quiet;
 	int recommend_shallow;
-	const char *reference;
+	struct string_list references;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
@@ -600,7 +600,8 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, STRING_LIST_INIT_DUP, \
+	NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
 
@@ -710,8 +711,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
 	argv_array_pushl(&child->args, "--url", url, NULL);
-	if (suc->reference)
-		argv_array_push(&child->args, suc->reference);
+	if (suc->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &suc->references)
+			argv_array_pushl(&child->args, "--reference", item->string, NULL);
+	}
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
 
@@ -830,7 +834,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "reference", &suc.reference, N_("repo"),
+		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
diff --git a/git-submodule.sh b/git-submodule.sh
index b57f87d..a1cc71b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -576,7 +576,7 @@ cmd_update()
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-		${reference:+--reference "$reference"} \
+		${reference:+"$reference"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
-- 
2.9.2.737.g4a14654

