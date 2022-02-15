Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4600C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbiBORYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbiBORYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:06 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CAD3AD7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:56 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z20-20020aa791d4000000b004bd024eaf19so14386137pfa.16
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xlGaBHHWVtlrI2fnEJ7RzLe0w2FXgQlueRLhihQyHLA=;
        b=e2yc/bsFFhkMVLGTtyxDNMnt0fAuriaL3yorpDPiEU2GL5Q0/uL0X2u0ldr4Y78u9e
         TLmiMnEKdTWRjtBgyTxYHBwtXe9GMVUOIvUtHzd2fnEA/LETo83net1aGK5U2ZZUMIvi
         lRPNBpJxieVPIWA5nVAUYKJGVUB6o4cC8QfcToIIzhxroNzJ2+mmQCpKvaTVQBaobRTQ
         X8hnK2xLsDeuZxMaoB3BPlKsDPi4jgfRhhztZbQnLuxOwI1Vu48GTeQPDYl2zRdKuCdv
         ssRdwGJjxdr0XDFMo26VxPqlM6vD0eXhw95vxa742HFKbaI07OLXt8sYlDuAT0dzMlj5
         bIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xlGaBHHWVtlrI2fnEJ7RzLe0w2FXgQlueRLhihQyHLA=;
        b=BpT1FQRwbW4e9+2VoCpaBgy8tAZnJzGC1LcQ8Bt9+gTfkLZGxpSjOrX8Vl52tlKi5b
         ARNorxJCW3fKFN+pdG3eFgCPAUS2aNHklveT3s9pEmPqB15hifdnSY5zuYe5x5AN08KK
         M+T2qSpN5rMW+q8oJuf3hu7AVbdK6HdsxI0Zya2hp8n9KYgdWZNvTZNRxFwV0vwtRLgw
         xQF2nNB623kEHUjojIo1owV6KartlyQ2EuNmvwCjNyBRcgEYukILDpNDcXhD5dTPKnEs
         4fPYy1kWE5tdhOGDEnOlEAT//Ctbz9SZzjSsQvuQCxi7vja3BbI/WDCta4qPiWjwbjjZ
         7mJw==
X-Gm-Message-State: AOAM530MBx3cYH14VUCAKwI5uA2mSTVNDKCDrMubuDuhffrZXbwT4R2a
        iaNeUiSC7Xv6FuHZ8l/onf7K3vc24y79StfoSJ2aaBTMnDEEsjyGaDxkoVuYgjf3rU/tNSAtTK4
        zNY+WE5uPe4OPvHoW3ahv5MN8RQWTlLzliALkvA1PCWn0zZ8yU7Uun7JZGX56j74=
X-Google-Smtp-Source: ABdhPJyLZRZp0w4x8YDfsW0Do0ZIlwJnryTtTj1z6P1GWe51hz2UnXu99dz9PL0qKs3Da38ba7J7yTE91KiJaQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c409:: with SMTP id
 k9mr5140928plk.91.1644945835774; Tue, 15 Feb 2022 09:23:55 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:13 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 4/9] submodule: inline submodule_commits() into caller
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When collecting the string_list of changed submodule names, the new
submodules commits are stored in the string_list_item.util as an
oid_array. A subsequent commit will replace the oid_array with a struct
that has more information.

Prepare for this change by inlining submodule_commits() (which inserts
into the string_list and initializes the string_list_item.util) into its
only caller so that the code is easier to refactor later.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7032dcabb8..7fdf7793fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -782,19 +782,6 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	return submodule_from_path(the_repository, null_oid(), ce->name);
 }
 
-static struct oid_array *submodule_commits(struct string_list *submodules,
-					   const char *name)
-{
-	struct string_list_item *item;
-
-	item = string_list_insert(submodules, name);
-	if (item->util)
-		return (struct oid_array *) item->util;
-
-	/* NEEDSWORK: should we have oid_array_init()? */
-	item->util = xcalloc(1, sizeof(struct oid_array));
-	return (struct oid_array *) item->util;
-}
 
 struct collect_changed_submodules_cb_data {
 	struct repository *repo;
@@ -830,9 +817,9 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct oid_array *commits;
 		const struct submodule *submodule;
 		const char *name;
+		struct string_list_item *item;
 
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
@@ -859,8 +846,11 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!name)
 			continue;
 
-		commits = submodule_commits(changed, name);
-		oid_array_append(commits, &p->two->oid);
+		item = string_list_insert(changed, name);
+		if (!item->util)
+			/* NEEDSWORK: should we have oid_array_init()? */
+			item->util = xcalloc(1, sizeof(struct oid_array));
+		oid_array_append(item->util, &p->two->oid);
 	}
 }
 
-- 
2.33.GIT

