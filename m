Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88CE320193
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbcHIEI0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:26 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34866 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbcHIEIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:24 -0400
Received: by mail-pf0-f177.google.com with SMTP id x72so673328pfd.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LRiGIRzoBwP6xtil9+ppRqCESrO1jlUvZ3BiCEVmo1k=;
        b=khDxG73XJKFhH7gv96ZZuc+cxOByQa2G2TlrONjj2rNuA3xudMwzTmVtr4HNH03G2Y
         3vBGuEdbMoWmMJtRBzOtKCC9Jj3oBt6YUOsWCkmhVLQSZ4cJDKYnxBet8VGX90Dn1RwM
         gDwfz8LTDODEHwsmIs57u7p5i950lGYxyhB3nYYSNcGGppSkopigkeJWXfUF8xt8zJxL
         QHFwwDfQfT/3MUqdq4/D7B10folJae3dEZRmlLQEx85fR27hHxHK3Q+N11r0eWDkiVY3
         bueXkA3fg0xlDqN/r8pZPQ/HEmFRdmXia7WiiEiB3ywzddSXNHk+Rqzh6nbI6r286qrS
         FcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LRiGIRzoBwP6xtil9+ppRqCESrO1jlUvZ3BiCEVmo1k=;
        b=Ja3SbsiO5XNdEkfDzsqidT3d9/TwYxvjyUZ8s7oWCS+3UZzzXEzN/nX02SX3eogbA2
         e83qCKQWlCTcHLoQgN8HpG0LrDwKEj3uLkv184fZBZpzZLCbjKXW4EoF++sZx8txbGF4
         CV8nFZYWeBY+MeEPo3S2AiiHRJ8epXvfFQSCCRlLKhH4iQXL/B5IlerVFnLAsM68iGo2
         2AGws/2eHEdQ+SgFRHmXA+r/zTtGJ4uS+TPpCQDGU5rtS7R/9f/fyEThj18BzxWCYnBs
         bnpNDRk7o900xO8L+BB6vMoUIirhiY85TxlAkSR5qVxLpJij2KY9ih0p+ATsnhHGPhjW
         6NIQ==
X-Gm-Message-State: AEkoouvWZyIafTG0zxlR5clIN/jzLuWWaWOVKYPISt8SesJ6Q02uYIvrQ7CACH6WbtET8a3m
X-Received: by 10.98.47.132 with SMTP id v126mr169612085pfv.152.1470715703773;
        Mon, 08 Aug 2016 21:08:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id yp10sm51632934pab.25.2016.08.08.21.08.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:23 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/9] submodule--helper update-clone: allow multiple references
Date:	Mon,  8 Aug 2016 21:08:04 -0700
Message-Id: <20160809040811.21408-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
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
index ce9b3e9..7096848 100644
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
2.9.2.583.gd6329be.dirty

