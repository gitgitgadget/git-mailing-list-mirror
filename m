Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00231F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935852AbeFMVjm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:39:42 -0400
Received: from mail-ot0-f202.google.com ([74.125.82.202]:55498 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935828AbeFMVjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:39:39 -0400
Received: by mail-ot0-f202.google.com with SMTP id b1-v6so2318725otf.22
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=D5TEdWp5XgqDAPBTKV+BnzmJCAsrNQ+8UTXNhNhD+kc=;
        b=j1zLz463FphBnCL4zEzCjZQ5O1Ys0W8QhvTG4lGyJrXPcjn88caBEJ22PfQkDme0lV
         34YVPibSnrVstjenCpvWWlm1A54TRa9D0NjihMtPIL25O7Cbb5aE6/ND/HRKPxReD6T/
         VtyADeznRr82N16dhTGDEUyasIkY1ADIJnxF2NUfRpWt7edzWX+BPH+eiz9UVqtarmoZ
         sZZDu0Rw6Q0Ie7+P3aM0RgT4+VVs3hvr7lTR0jUSmZ1ugNoxivUtQtPHmcPfbXhuYBLv
         qDx686T2lw0DZJKVHKT2y4eyU5w6eH6aw2IHlS0//RCUUh2qnGScC3Df6EquKYVdaWMe
         luqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=D5TEdWp5XgqDAPBTKV+BnzmJCAsrNQ+8UTXNhNhD+kc=;
        b=lJpxbT21TjukkQUH8EyqMuq/BayJBQHdvYuV69RdOdPOzeuX6sRPJRYmr4Wf9IQH2t
         ev8yK02lQ+fOtpf6y1V7BIaW7eFrEIx+ADcTdeoTbFYRYHhXr6/kI7q1DZHrzPDvUdE0
         jHY5qQFLgabAdhzy0Q8GpbE42ZfYHxPMEgcbX7bB6bX3+Mx0KOaOyFjuI24SXymN6E6Y
         EMjpCH86exiIBFxq4zvDOIHF0WmLqzudvsDP1xcCtRKV74qV4hXqXxKnp7JYeMxjZwP8
         lDR4sPoZSj7pt9MXHqWP2wXZFrDoHG9WdGYJBEZyiNUWOcEs+mw7mSRmm9Y34FelK/hX
         fK/w==
X-Gm-Message-State: APt69E2cFZjkAVWNrVyGIGXlSC2hVUu+HW2TixiVZoZKzmpwedmmuXRI
        ZrkkEbpiK6UeupHsggG+QqvE3XytUEzizNuCIV7zlsqWmokJIUjce8BTlNfhixxxrcEfAlmUqjc
        EbNwwp8FvVGwVYLEHM6OCZ9CWE0xH6z0iE9+9DEoCHSDbwUi6hP05p2P3uA==
X-Google-Smtp-Source: ADUXVKI5/CZSxG2a/r7ccy78Dmk4AAA7usT3YEm113bDLJvwaHIkDARV80ThQ/+Ws1iiPVFCMlle3f54On4=
MIME-Version: 1.0
X-Received: by 2002:a9d:3565:: with SMTP id l34-v6mr3137208ote.101.1528925978945;
 Wed, 13 Jun 2018 14:39:38 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:39:21 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com>
Message-Id: <20180613213925.10560-5-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH v2 4/8] fetch: refactor the population of peer ref OIDs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Brandon Williams <bmwill@google.com>
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
2.18.0.rc1.242.g61856ae69a-goog

