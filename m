Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E571F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeBIVpB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:45:01 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55066 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752845AbeBIVpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:45:00 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 82c905f1;
        Fri, 9 Feb 2018 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        grym-20170528; bh=z4JryMA4Yf5mjxYj1hGUTjlbfxI=; b=VGBzm7GPWHseQX
        FA+PvgocshmUzHeMzAvOgL+fIPOttBmLwvdXsaeoeDH5tHNEdS4EW5IzFbxDLGlI
        Z/NaPMMrNVd06o1wJWe+vwZMGb/8qny92vSAYWyWZCmF2mXY7CVNvR2Q0UoFMTzK
        oIBRgkBJsL6/pmqaHisXf7pIk+lQk=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 19777d35;
        Fri, 9 Feb 2018 21:44:59 +0000 (UTC)
Received: from localhost (llwynog [local])
        by llwynog (OpenSMTPD) with ESMTPA id e6270f31;
        Fri, 9 Feb 2018 21:44:59 +0000 (UTC)
From:   Leo Gaspard <leo@gaspard.io>
To:     git@vger.kernel.org
Cc:     Joey Hess <id@joeyh.name>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?L=C3=A9o=20Gaspard?= <leo@gaspard.io>
Subject: [PATCH 1/2] fetch: preparations for tweak-fetch hook
Date:   Fri,  9 Feb 2018 22:44:57 +0100
Message-Id: <20180209214458.16135-1-leo@gaspard.io>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <30753d19-d77d-1a1a-ba42-afcd6fbb4223@gaspard.io>
References: <30753d19-d77d-1a1a-ba42-afcd6fbb4223@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Léo Gaspard <leo@gaspard.io>

No behavior changes yet, only some groundwork for the next change.

The refs_result structure combines a status code with a ref map, which
can be NULL even on success. This will be needed when there's a
tweak-fetch hook, because it can filter out all refs, while still
succeeding.

fetch_refs returns a refs_result, so that it can modify the ref_map.

Based-on-patch-by: Joey Hess <joey@kitenet.net>
Signed-off-by: Leo Gaspard <leo@gaspard.io>
---
 builtin/fetch.c | 68 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26fa..76dc05f61 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -34,6 +34,11 @@ enum {
 	TAGS_SET = 2
 };
 
+struct refs_result {
+	struct ref *new_refs;
+	int status;
+};
+
 static int fetch_prune_config = -1; /* unspecified */
 static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
@@ -57,6 +62,18 @@ static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
 
+static int add_existing(const char *refname, const struct object_id *oid,
+			int flag, void *cbdata)
+{
+	struct string_list *list = (struct string_list *)cbdata;
+	struct string_list_item *item = string_list_insert(list, refname);
+	struct object_id *old_oid = xmalloc(sizeof(*old_oid));
+
+	oidcpy(old_oid, oid);
+	item->util = old_oid;
+	return 0;
+}
+
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "fetch.prune")) {
@@ -217,18 +234,6 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
-static int add_existing(const char *refname, const struct object_id *oid,
-			int flag, void *cbdata)
-{
-	struct string_list *list = (struct string_list *)cbdata;
-	struct string_list_item *item = string_list_insert(list, refname);
-	struct object_id *old_oid = xmalloc(sizeof(*old_oid));
-
-	oidcpy(old_oid, oid);
-	item->util = old_oid;
-	return 0;
-}
-
 static int will_fetch(struct ref **head, const unsigned char *sha1)
 {
 	struct ref *rm = *head;
@@ -920,15 +925,20 @@ static int quickfetch(struct ref *ref_map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
-static int fetch_refs(struct transport *transport, struct ref *ref_map)
+static struct refs_result fetch_refs(struct transport *transport,
+		struct ref *ref_map)
 {
-	int ret = quickfetch(ref_map);
-	if (ret)
-		ret = transport_fetch_refs(transport, ref_map);
-	if (!ret)
-		ret |= store_updated_refs(transport->url,
+	struct refs_result ret;
+	ret.status = quickfetch(ref_map);
+	if (ret.status) {
+		ret.status = transport_fetch_refs(transport, ref_map);
+	}
+	if (!ret.status) {
+		ret.new_refs = ref_map;
+		ret.status |= store_updated_refs(transport->url,
 				transport->remote->name,
-				ref_map);
+				ret.new_refs);
+	}
 	transport_unlock_pack(transport);
 	return ret;
 }
@@ -1048,9 +1058,11 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 	return transport;
 }
 
-static void backfill_tags(struct transport *transport, struct ref *ref_map)
+static struct refs_result backfill_tags(struct transport *transport,
+		struct ref *ref_map)
 {
 	int cannot_reuse;
+	struct refs_result res;
 
 	/*
 	 * Once we have set TRANS_OPT_DEEPEN_SINCE, we can't unset it
@@ -1069,12 +1081,14 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	fetch_refs(transport, ref_map);
+	res = fetch_refs(transport, ref_map);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
 		gsecondary = NULL;
 	}
+
+	return res;
 }
 
 static int do_fetch(struct transport *transport,
@@ -1083,6 +1097,7 @@ static int do_fetch(struct transport *transport,
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
 	struct ref *rm;
+	struct refs_result res;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 
@@ -1135,7 +1150,10 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map)) {
+
+	res = fetch_refs(transport, ref_map);
+	ref_map = res.new_refs;
+	if (res.status) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
@@ -1148,8 +1166,10 @@ static int do_fetch(struct transport *transport,
 		struct ref **tail = &ref_map;
 		ref_map = NULL;
 		find_non_local_tags(transport, &ref_map, &tail);
-		if (ref_map)
-			backfill_tags(transport, ref_map);
+		if (ref_map) {
+			res = backfill_tags(transport, ref_map);
+			ref_map = res.new_refs;
+		}
 		free_refs(ref_map);
 	}
 
-- 
2.16.1

