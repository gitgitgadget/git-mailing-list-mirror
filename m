Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48D91F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeFERwI (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:52:08 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:48947 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeFERwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:05 -0400
Received: by mail-ua0-f201.google.com with SMTP id l31-v6so1072349uae.15
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=KLvs/l68n4y5UY7G5/xN+DvuennJiQc23TexAsCu9io=;
        b=ft2JnV6cUmlxYjxbCixd6DmMkWa6KnTz/dB4TJlAwNbKARvP/NfbuEab3JgzmFagiM
         H/zqFKCnXsZGNYm/SadTBNzJY8ps3Q51cglVbISXW8yciTA8rR0Pirs2moOmFyIAXJo4
         /ZiDqNjGa6BYGoCqXFZP371U/y3U6VkH5CPJmzT9e12oz8hmfy10EatWj09wK1hJrH+N
         N3zgRx4bA9gYPykBj4psm6mm7ymoyYv1CqnbT3ecm3GYhWK+qMr35ptBQErP3k2se1xB
         jeu1leLAIrzP4BoHocptJZw8qOk0ptZzQfMdXRJqKiqLrXyp4tx8J2ttG5CgZrhNJB0u
         mqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=KLvs/l68n4y5UY7G5/xN+DvuennJiQc23TexAsCu9io=;
        b=pVYk1E6hjpSnaAw/FrCXc0nhRVRmd2pdD40k3VmeUCoq1xGVOaPXtLirsuaz1j42rQ
         Q/G5vu6FmNZ8E+urgDpn7638rf6ZHGiAMz92WyHZoLov3tG7jmlYO/mcdWRY/fQNB1DE
         6sR7nrddysyjHU9bO93jJtiqJqWXOKmYd8A0xEZvQtv19vHT2/ECX+zqi4aS8ePdZbwx
         3EJr2eC5gcvR1Yc1QmNROvVckiDe/+ECkik8pu7MWTagAwuMbT++O2vmLU28w0bTP+CS
         sqSfctMCTmisC3GTxA6dvF1uKUR6i9hG4PVTn9HARH4vPM3yea05tvHJYMNVoQEgERjN
         chrQ==
X-Gm-Message-State: ALKqPwfgQrNVwsF4nsT0rFRwfTTowSLkoJI0BN51CYVF0M8ecfJPYkiP
        Wj9axc4jk//DCiFf4c+ldKxipl+ph7N1gkMaA044Usvwf/uP+SsvEOGJh3tPK9xEc2juaOS5Yfw
        EMLM3Ju7FCZbK17l52RqYpYbfd8YYy3uQpaxyoNxO7GMowAEt3FYFJWoYyQ==
X-Google-Smtp-Source: ADUXVKL9XI6grsCO6Bw1ViqShnVufEvg1r7VHHh85HAIXtYLLh99nUYG+9zbWjseIrM7EHfw0LV0cStQDr8=
MIME-Version: 1.0
X-Received: by 2002:ab0:5123:: with SMTP id e32-v6mr11609575uaa.98.1528221124440;
 Tue, 05 Jun 2018 10:52:04 -0700 (PDT)
Date:   Tue,  5 Jun 2018 10:51:40 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180605175144.4225-5-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH 4/8] fetch: refactor the population of peer ref OIDs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Populate peer ref OIDs in get_ref_map instead of do_fetch. Besides
tightening scopes of variables in the code, this also prepares for
get_ref_map being able to be called multiple times within do_fetch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..545635448 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -351,6 +351,7 @@ static struct ref *get_ref_map(struct transport *transport,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	const struct ref *remote_refs;
 
 	if (rs->nr)
@@ -458,7 +459,23 @@ static struct ref *get_ref_map(struct transport *transport,
 		tail = &rm->next;
 	}
 
-	return ref_remove_duplicates(ref_map);
+	ref_map = ref_remove_duplicates(ref_map);
+
+	for_each_ref(add_existing, &existing_refs);
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref) {
+			struct string_list_item *peer_item =
+				string_list_lookup(&existing_refs,
+						   rm->peer_ref->name);
+			if (peer_item) {
+				struct object_id *old_oid = peer_item->util;
+				oidcpy(&rm->peer_ref->old_oid, old_oid);
+			}
+		}
+	}
+	string_list_clear(&existing_refs, 1);
+
+	return ref_map;
 }
 
 #define STORE_REF_ERROR_OTHER 1
@@ -1110,14 +1127,10 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
-	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 
-	for_each_ref(add_existing, &existing_refs);
-
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
 			tags = TAGS_SET;
@@ -1136,18 +1149,6 @@ static int do_fetch(struct transport *transport,
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref) {
-			struct string_list_item *peer_item =
-				string_list_lookup(&existing_refs,
-						   rm->peer_ref->name);
-			if (peer_item) {
-				struct object_id *old_oid = peer_item->util;
-				oidcpy(&rm->peer_ref->old_oid, old_oid);
-			}
-		}
-	}
-
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
@@ -1183,7 +1184,6 @@ static int do_fetch(struct transport *transport,
 	}
 
  cleanup:
-	string_list_clear(&existing_refs, 1);
 	return retcode;
 }
 
-- 
2.17.1.1185.g55be947832-goog

