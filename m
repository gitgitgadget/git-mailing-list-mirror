Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68DF1FD99
	for <e@80x24.org>; Sat,  6 Aug 2016 20:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbcHFUVn (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:21:43 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33943 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcHFUVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:21:41 -0400
Received: by mail-pf0-f172.google.com with SMTP id p64so107166903pfb.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:21:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPulgBsI9OYjGt1Z3xOZnaZEP8/M2eCftJNPQETrOHw=;
        b=F37IUDrD1+vBDE26GWsTuvh6vDp2ORg36VA05JyLy4BzVNNFQdPtH8ucsPVYFrRgto
         eySSlxN1qonNUFAq3w1/toAbuNXtyiQrFOuSh7UEW42Ay9gz7CX5d/sMoLyRNXWz5011
         WB2zRM2yMg1SqcCJnVKAa1mFx4Y4FMeX6UGiDLvqnVHAkG8rZy0vNVpzzfGV5pTfWXGw
         lgWMgMOvxwP5tEiNNmTvvDapPZlRHB/mvGeSdn3zVM8myl4pDuVAAF9XbIADnlwoQ9/5
         F624OC84448lJQze2jE36eXn+OxM2JRynv8Z/JCD1UPUjDnIl7oVHyfc3CCwUasjmslJ
         qCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPulgBsI9OYjGt1Z3xOZnaZEP8/M2eCftJNPQETrOHw=;
        b=mUeD34R7s4kgaLgggMvWL83oTcwOI2nRo5OsT2d7OA4UUJRcd/W3aCxrQyw+fGqY+v
         0fNg4N2kzKgCjCnNtn7eggPt4vWXnPTqeBVPx+cYt1bahirkn5tgPlsarJL1mmEqhlDs
         akiZ/d0hanG5YiWxuxEFqB/K8fErOPDqoPkoGyTMK86Iv/akCMtqgHZ1fXh67tVc+UVu
         rV+VHUf+RXF614e4wJi5BgPXcbOq2iTfdTCL1VHEisx0vN6j524FCkUdoaxa9TPuepPK
         9lPmh7Z/T4lVSEsJtyFBin3ZVRZZaCRIIl6EqogAU18e95txc9SStzZXFfMldu3d1+KY
         aSow==
X-Gm-Message-State: AEkooutJQGb87id9Xu/fWSrF33aWYjKQ3qz0TCTJTolzNLZLwmXyjON75c3HrQJHNadPktRD
X-Received: by 10.98.131.8 with SMTP id h8mr140536456pfe.124.1470446619683;
        Fri, 05 Aug 2016 18:23:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id y200sm30666099pfb.13.2016.08.05.18.23.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 18:23:39 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, Jens.Lehmann@web.de
Cc:	git@vger.kernel.org, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/6] submodule--helper update-clone: allow multiple references
Date:	Fri,  5 Aug 2016 18:23:16 -0700
Message-Id: <20160806012318.17968-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160806012318.17968-1-sbeller@google.com>
References: <20160806012318.17968-1-sbeller@google.com>
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

with this change we omit one of the "--reference" arguments when passing
references from the shell script to the helper.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 14 +++++++++-----
 git-submodule.sh            |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f2b19ea..b7710a7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -583,7 +583,7 @@ struct submodule_update_clone {
 	/* configuration parameters which are passed on to the children */
 	int quiet;
 	int recommend_shallow;
-	const char *reference;
+	struct string_list references;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
@@ -599,7 +599,8 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, STRING_LIST_INIT_DUP, \
+	NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
 
@@ -709,8 +710,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
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
 
@@ -829,7 +833,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "reference", &suc.reference, N_("repo"),
+		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
diff --git a/git-submodule.sh b/git-submodule.sh
index c90dc33..3b412f5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -575,7 +575,7 @@ cmd_update()
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-		${reference:+--reference "$reference"} \
+		${reference:+"$reference"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
-- 
2.9.2.572.g9d9644e.dirty

