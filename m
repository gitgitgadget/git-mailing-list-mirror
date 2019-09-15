Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023E31F463
	for <e@80x24.org>; Sun, 15 Sep 2019 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfIOVSM (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 17:18:12 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43880 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOVSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 17:18:11 -0400
Received: by mail-pf1-f201.google.com with SMTP id i187so25916643pfc.10
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B+jbNfNDEn8WNuC1kmwwIo0As6Y02BCnOkRJaf2GPgU=;
        b=uDKVCfs8wzt1IBIUPtGacoRA4sEGcAoWglqHQX/SOxfdT6wMRAUNbTZ2kqCCuML4l4
         VPQSREWoRvIcxlErkh4sTld/iXhCHuVPlk5clfMmncnyxTV4ObzJGWlf0p6OTQ/h2kfE
         slyMjqPHl0ZSCP2diZCB/QvH5Vl5ZFs4g34CuCMm5wh4DRpsA6v62SuAKtmKPWlu4szI
         JM7HaltvG2Duh5JFpJRj6hfGwB5Vyn4rFLVsGLXAD9hsOp6Jy/cxsIEjci8z2QROyR7F
         c5rV4Ofi0ZU+jswPk7+fVjCzYi1F03VYT0VdKPQEsgNjy38TRPuVDRauWuj6uvwE9ow3
         R2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B+jbNfNDEn8WNuC1kmwwIo0As6Y02BCnOkRJaf2GPgU=;
        b=oeqnQK6+a5sc6TsF40RzQorhTfGuBVJLymTWSPJUowHYFoSJ+j2pcKYmENrBDMJeKY
         GiLhmPUdD4CGq9KbV3xLUtiD/4clhXVrw0u9eG0/UDtT0iq8gVQLC80S7/3xPZrge3B2
         9Yriy9IpMXOmzqMbfFjpuZHS4VwhwNAqTPh5SLiKI3FmnT0ZR+i/a9yUcfYlU8CaTv6d
         IUGd8AnStIiryYUym9Bu08Ji8LkJfuCs8lsqhqb/Vytw6FIOyEuosq4yPmc/CClt0IFq
         XDUgVG1M4/brNMryVD6CBW1tc+Iaq1Xa4tCfPax4uZzfDOaXqF0YjxETEIyfNbmYlHZE
         J5iw==
X-Gm-Message-State: APjAAAX5hdKinYAl0gWY63a/J3J/t9LP8Tc1g2IeZ8F0FNWrnUmehJGF
        PIE13VrwIOb6VO4jzV9dM5G8VMDV0EWCOo8vFoU5zEULH4oE/C6RxYM2nGhEunOtzshi8JFo01F
        AFuMrifKs+1ZZ32asIcoRtqxyq4tJ382mLVs4gKd2mBfSatuX6ZBGeN0/Qj3HakAG7NgAtqDJBg
        ==
X-Google-Smtp-Source: APXvYqwysX0CikywjwAt6kFgVJ2RpPqI6qEU58p8Co13l8cL7lHGqDdpzxECuQsWxKm6yfxmxteu3/cZICKao6wXDBQ=
X-Received: by 2002:a63:ed08:: with SMTP id d8mr2441700pgi.239.1568582290544;
 Sun, 15 Sep 2019 14:18:10 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:18:02 -0700
In-Reply-To: <20190915211802.207715-1-masayasuzuki@google.com>
Message-Id: <20190915211802.207715-2-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20190915211802.207715-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH 1/1] fetch: Cache the want OIDs for faster lookup
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During git-fetch, the client checks if the advertised tags' OIDs are
already in the fetch request's want OID set. This check is done in a
linear scan. For a repository that has a lot of refs, repeating this
scan takes 15+ minutes. In order to speed this up, create a oid_set for
other refs' OIDs.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 builtin/fetch.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 54d6b01892..51a276dfaa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-store.h"
+#include "oidset.h"
 #include "commit.h"
 #include "builtin.h"
 #include "string-list.h"
@@ -243,15 +244,13 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
-static int will_fetch(struct ref **head, const unsigned char *sha1)
+static void create_fetch_oidset(struct ref **head, struct oidset *out)
 {
 	struct ref *rm = *head;
 	while (rm) {
-		if (hasheq(rm->old_oid.hash, sha1))
-			return 1;
+		oidset_insert(out, &rm->old_oid);
 		rm = rm->next;
 	}
-	return 0;
 }
 
 struct refname_hash_entry {
@@ -317,6 +316,7 @@ static void find_non_local_tags(const struct ref *refs,
 {
 	struct hashmap existing_refs;
 	struct hashmap remote_refs;
+	struct oidset fetch_oids = OIDSET_INIT;
 	struct string_list remote_refs_list = STRING_LIST_INIT_NODUP;
 	struct string_list_item *remote_ref_item;
 	const struct ref *ref;
@@ -324,6 +324,7 @@ static void find_non_local_tags(const struct ref *refs,
 
 	refname_hash_init(&existing_refs);
 	refname_hash_init(&remote_refs);
+	create_fetch_oidset(head, &fetch_oids);
 
 	for_each_ref(add_one_refname, &existing_refs);
 	for (ref = refs; ref; ref = ref->next) {
@@ -340,9 +341,9 @@ static void find_non_local_tags(const struct ref *refs,
 			if (item &&
 			    !has_object_file_with_flags(&ref->old_oid,
 							OBJECT_INFO_QUICK) &&
-			    !will_fetch(head, ref->old_oid.hash) &&
+			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
 			    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
-			    !will_fetch(head, item->oid.hash))
+			    !oidset_contains(&fetch_oids, &item->oid))
 				clear_item(item);
 			item = NULL;
 			continue;
@@ -356,7 +357,7 @@ static void find_non_local_tags(const struct ref *refs,
 		 */
 		if (item &&
 		    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
-		    !will_fetch(head, item->oid.hash))
+		    !oidset_contains(&fetch_oids, &item->oid))
 			clear_item(item);
 
 		item = NULL;
@@ -377,7 +378,7 @@ static void find_non_local_tags(const struct ref *refs,
 	 */
 	if (item &&
 	    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
-	    !will_fetch(head, item->oid.hash))
+	    !oidset_contains(&fetch_oids, &item->oid))
 		clear_item(item);
 
 	/*
@@ -404,6 +405,7 @@ static void find_non_local_tags(const struct ref *refs,
 	}
 	hashmap_free(&remote_refs, 1);
 	string_list_clear(&remote_refs_list, 0);
+	oidset_clear(&fetch_oids);
 }
 
 static struct ref *get_ref_map(struct remote *remote,
-- 
2.23.0.237.gc6a4ce50a0-goog

