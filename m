Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569C01F454
	for <e@80x24.org>; Fri, 19 Oct 2018 03:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeJSLxG (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 07:53:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39450 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJSLxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 07:53:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so2260494wmd.4
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 20:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PoLPtM6r3pmVbgInJVMWABIxk4xIb0M7P3ygWnxWYM0=;
        b=r99i4gkU7qZtGCyiIFjf9QU0yDcy6AuAQn4bRlHGDPDMGOL7KZdX8FLYbTlDIKJXoY
         lEOBNVcl0cZ6O0bfEYPX2Xo1AKV9YwsY6Z60/YSKVXrk53Tn5n/2EHLhvMbBJDh2ZRs0
         psGhQxUJrWIHtYbytQJkck9/ZhBe8hgTc73PQr3jBmklRZJa0tlxZPT1ehNQbz1F03tQ
         AQfdMfk3Sm+Z7jsBjXbimjH7TU8QJ15ZHQBog+bNRu+xQ9L1HBzSEiYFN0dN05zzVFnX
         0DcylXmmXdoedlGvfaBnMwL3u3a1mD3+QOzt1nFwjNF3WxlNKEF/jYfF4Vshz4mflXr+
         sZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PoLPtM6r3pmVbgInJVMWABIxk4xIb0M7P3ygWnxWYM0=;
        b=S+NDPAsDOGCk8hLE1a07PMUIL0sVeni2ZBoTwylcUmX9KOl77E6fhxKcoE4DxwWAb7
         KCxuRYbpjXssmpCWy2GJZBvOtD49+xDuZTO9DvsSy8ZxERQdf0kLNnOGz6SWC/LR67N/
         kJgtbg5r3ssrttNfqTbxIyVavcJrcc52Y08XPoh9XHq0BPnsYZP+PJuSlonCwc1s9lOk
         P4o5DdUysNjrTa02JYjuA9yUzzs8gA3P+AA2MkJCt/HidPujCZ0w9VH+Q4VsA1qSDZtX
         veZJoP/UEcXMn+QWBe7SFXwHsdp8CitbADjBoS8nzBvQPNXRYzblloHhTj/vnntriGto
         Vn+w==
X-Gm-Message-State: ABuFfojz7X7qiercy9d7L9IlC6iAgbGiRBHRwXJ3UX+Llbe2CahvFoCj
        Q+NI32+75eVbtv1q05u1ug5scDPPsh0=
X-Google-Smtp-Source: ACcGV616baK8wbsDo5GTaQ3A65EbBakGc4HgxyqQoAQ2sxWETDNDhUzV62OaiijHtCEiPLLsNWoj6A==
X-Received: by 2002:a1c:1183:: with SMTP id 125-v6mr2989265wmr.103.1539920932594;
        Thu, 18 Oct 2018 20:48:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19011546wrd.24.2018.10.18.20.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 20:48:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3] fetch: replace string-list used as a look-up table with a hashmap
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
        <20180927053418.GB14178@sigill.intra.peff.net>
        <xmqq5zyn91ku.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Oct 2018 12:48:50 +0900
In-Reply-To: <xmqq5zyn91ku.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 29 Sep 2018 19:11:13 -0700")
Message-ID: <xmqqy3au1tr1.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In find_non_local_tags() helper function (used to implement the
"follow tags"), we use string_list_has_string() on two string lists
as a way to see if a refname has already been processed, etc.

All this code predates more modern in-core lookup API like hashmap;
replace them with two hashmaps and one string list---the hashmaps
are used for look-ups and the string list is to keep the order of
items in the returned result stable (which is the only single thing
hashmap does worse than lookups on string-list).

Similarly, get_ref_map() uses another string-list as a look-up table
for existing refs.  Replace it with a hashmap.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This converts another string-list user in the same file.  For now
   I am done with this topic; I'm willing to fix bugs in this patch,
   but do not intend to spend time killing more string-lists used as
   look-up tables.

 builtin/fetch.c | 152 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 46 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a..0f8e333022 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -223,18 +223,6 @@ static void add_merge_config(struct ref **head,
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
@@ -246,16 +234,76 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
+struct refname_hash_entry {
+	struct hashmap_entry ent; /* must be the first member */
+	struct object_id oid;
+	char refname[FLEX_ARRAY];
+};
+
+static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
+				  const void *e1_,
+				  const void *e2_,
+				  const void *keydata)
+{
+	const struct refname_hash_entry *e1 = e1_;
+	const struct refname_hash_entry *e2 = e2_;
+
+	return strcmp(e1->refname, keydata ? keydata : e2->refname);
+}
+
+static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
+						   const char *refname,
+						   const struct object_id *oid)
+{
+	struct refname_hash_entry *ent;
+	size_t len = strlen(refname);
+
+	FLEX_ALLOC_MEM(ent, refname, refname, len);
+	hashmap_entry_init(ent, memhash(refname, len));
+	oidcpy(&ent->oid, oid);
+	hashmap_add(map, ent);
+	return ent;
+}
+
+static int add_one_refname(const char *refname,
+			   const struct object_id *oid,
+			   int flag, void *cbdata)
+{
+	struct hashmap *refname_map = cbdata;
+
+	(void) refname_hash_add(refname_map, refname, oid);
+	return 0;
+}
+
+static void refname_hash_init(struct hashmap *map)
+{
+	hashmap_init(map, refname_hash_entry_cmp, NULL, 0);
+}
+
+static int refname_hash_exists(struct hashmap *map, const char *refname)
+{
+	struct hashmap_entry key;
+	size_t len = strlen(refname);
+	hashmap_entry_init(&key, memhash(refname, len));
+
+	return !!hashmap_get(map, &key, refname);
+}
+
 static void find_non_local_tags(const struct ref *refs,
 				struct ref **head,
 				struct ref ***tail)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
-	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
+	struct hashmap existing_refs;
+	struct hashmap remote_refs;
+	struct string_list remote_refs_list = STRING_LIST_INIT_NODUP;
+	struct string_list_item *remote_ref_item;
 	const struct ref *ref;
-	struct string_list_item *item = NULL;
+	struct refname_hash_entry *item = NULL;
 
-	for_each_ref(add_existing, &existing_refs);
+	refname_hash_init(&existing_refs);
+	refname_hash_init(&remote_refs);
+
+	for_each_ref(add_one_refname, &existing_refs);
 	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -271,10 +319,10 @@ static void find_non_local_tags(const struct ref *refs,
 			    !has_object_file_with_flags(&ref->old_oid,
 							OBJECT_INFO_QUICK) &&
 			    !will_fetch(head, ref->old_oid.hash) &&
-			    !has_sha1_file_with_flags(item->util,
+			    !has_sha1_file_with_flags(item->oid.hash,
 						      OBJECT_INFO_QUICK) &&
-			    !will_fetch(head, item->util))
-				item->util = NULL;
+			    !will_fetch(head, item->oid.hash))
+				oidclr(&item->oid);
 			item = NULL;
 			continue;
 		}
@@ -286,48 +334,55 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
-		    !will_fetch(head, item->util))
-			item->util = NULL;
+		    !has_sha1_file_with_flags(item->oid.hash, OBJECT_INFO_QUICK) &&
+		    !will_fetch(head, item->oid.hash))
+			oidclr(&item->oid);
 
 		item = NULL;
 
 		/* skip duplicates and refs that we already have */
-		if (string_list_has_string(&remote_refs, ref->name) ||
-		    string_list_has_string(&existing_refs, ref->name))
+		if (refname_hash_exists(&remote_refs, ref->name) ||
+		    refname_hash_exists(&existing_refs, ref->name))
 			continue;
 
-		item = string_list_insert(&remote_refs, ref->name);
-		item->util = (void *)&ref->old_oid;
+		item = refname_hash_add(&remote_refs, ref->name, &ref->old_oid);
+		string_list_insert(&remote_refs_list, ref->name);
 	}
-	string_list_clear(&existing_refs, 1);
+	hashmap_free(&existing_refs, 1);
 
 	/*
 	 * We may have a final lightweight tag that needs to be
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
-	    !will_fetch(head, item->util))
-		item->util = NULL;
+	    !has_sha1_file_with_flags(item->oid.hash, OBJECT_INFO_QUICK) &&
+	    !will_fetch(head, item->oid.hash))
+		oidclr(&item->oid);
 
 	/*
-	 * For all the tags in the remote_refs string list,
+	 * For all the tags in the remote_refs_list,
 	 * add them to the list of refs to be fetched
 	 */
-	for_each_string_list_item(item, &remote_refs) {
+	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
+		const char *refname = remote_ref_item->string;
+		struct hashmap_entry key;
+
+		hashmap_entry_init(&key, memhash(refname, strlen(refname)));
+		item = hashmap_get(&remote_refs, &key, refname);
+		if (!item)
+			continue; /* can this happen??? */
+
 		/* Unless we have already decided to ignore this item... */
-		if (item->util)
-		{
-			struct ref *rm = alloc_ref(item->string);
-			rm->peer_ref = alloc_ref(item->string);
-			oidcpy(&rm->old_oid, item->util);
+		if (!is_null_oid(&item->oid)) {
+			struct ref *rm = alloc_ref(item->refname);
+			rm->peer_ref = alloc_ref(item->refname);
+			oidcpy(&rm->old_oid, &item->oid);
 			**tail = rm;
 			*tail = &rm->next;
 		}
 	}
-
-	string_list_clear(&remote_refs, 0);
+	hashmap_free(&remote_refs, 1);
+	string_list_clear(&remote_refs_list, 0);
 }
 
 static struct ref *get_ref_map(struct remote *remote,
@@ -343,7 +398,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
+	struct hashmap existing_refs;
 
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
@@ -437,19 +492,24 @@ static struct ref *get_ref_map(struct remote *remote,
 
 	ref_map = ref_remove_duplicates(ref_map);
 
-	for_each_ref(add_existing, &existing_refs);
+	refname_hash_init(&existing_refs);
+	for_each_ref(add_one_refname, &existing_refs);
+
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->peer_ref) {
-			struct string_list_item *peer_item =
-				string_list_lookup(&existing_refs,
-						   rm->peer_ref->name);
+			struct hashmap_entry key;
+			const char *refname = rm->peer_ref->name;
+			struct refname_hash_entry *peer_item;
+
+			hashmap_entry_init(&key, memhash(refname, strlen(refname)));
+			peer_item = hashmap_get(&existing_refs, &key, refname);
 			if (peer_item) {
-				struct object_id *old_oid = peer_item->util;
+				struct object_id *old_oid = &peer_item->oid;
 				oidcpy(&rm->peer_ref->old_oid, old_oid);
 			}
 		}
 	}
-	string_list_clear(&existing_refs, 1);
+	hashmap_free(&existing_refs, 1);
 
 	return ref_map;
 }
-- 
2.19.1-450-ga4b8ab5363

