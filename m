Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F43B1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbcHOVxt (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:49 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33340 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbcHOVxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:48 -0400
Received: by mail-pf0-f177.google.com with SMTP id y134so20360267pfg.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9HyeeC24pd1iz6fE3UGtRt6Zlp8NTaAmMdSNk/pehI=;
        b=LMY3sYdiUdGnzWrXsYe0M3AX6RrK3n3mYx+gfyjn9ibMBAp7rNu4+SKn2h3v9LSkhX
         LhbJgpICE8sQXN72AX90Mp2Hl3439LsFtEhcT3qsW+KA3hg4ATxXPvvatQ6N/5FDAgZW
         o8/pkK9SlupXc6z459X0ofGfWJMiGP4IBvDL5YregLdZI/bjBoYldNpLwgDWYVVOTEkZ
         DWo6BCG/I5XiAn1vgQxUY6l8pujPFSs8+ziy65Dl63eyrJoOJ5GpwCPC1b57HKYJMe5O
         HAiJW2JdWzrk1+HSN66SJlkVtzsW9q6juQbyQb1GLOErfyVICELbSE+Ba2jBfcUZ4wns
         TyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X9HyeeC24pd1iz6fE3UGtRt6Zlp8NTaAmMdSNk/pehI=;
        b=HnFzaycrsWZmZbu2odhapyTqj99xcZSERjVhHvjGbcVM0fZzjfw8CcnpzKrW6FQ1Oj
         hJ8igwQSLR0VzXKI1oPWXoQEmvoAR8b7UkIl8hsU1DT0+ofa8dK7QLGhuelvZYoTtDAs
         jhKD7IAWQH2mslyFfLtbXq3RlGl7owMmqs0XAqoKCxbhT1l/5KEGOgQKJYDBHMyH01gd
         EiS8Y5N+g7nYJk9IQEYIaPMnU+NUQU1hLGaz+B5KJ45VkU+A+Fq3tSb7XZdFKz7YaBCN
         71HCTqcSr9iD1/feY3gj2P4K1rDfhy/cEOgaiAKWOP0jvSUlIKRwgGxXlKYAy4CDdt/C
         jijQ==
X-Gm-Message-State: AEkooutnEgGntxVBDzHiABXRizvnoYxC8v61F/dwIzHdfegvOlYlq0LUmB0P29DkI+/lTm8D
X-Received: by 10.98.102.79 with SMTP id a76mr57942793pfc.75.1471298026987;
        Mon, 15 Aug 2016 14:53:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id e72sm33673280pfb.49.2016.08.15.14.53.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:46 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 4/8] submodule--helper update-clone: allow multiple references
Date:	Mon, 15 Aug 2016 14:53:23 -0700
Message-Id: <20160815215327.15682-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815215327.15682-1-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com>
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
2.9.2.730.g525ad04.dirty

