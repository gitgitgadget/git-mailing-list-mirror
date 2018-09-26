Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F861F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeI0Dn1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:43:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54526 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0Dn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:43:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so3749867wmb.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=2m417mPwYRIIe4B2SO8vIw/pMJeQrv0yMqLNvf1mD7g=;
        b=jawPBGc/lWU8w5qseQgG5XG/vPmS3xOGilx2R4F8WM/+hiCHDxFuDtIzhrQDpL/zP1
         QQO5/p+w4vGnvqYTvQG5jOyznhCYG48DgN/N3FO2fqIbeF9cGby3CYWvaTYFGQ2YW9NO
         mCxp/c7pYlX7efEodcuAJa0GEGMo5egQLXOllzMi9Var/b6BbJGBMC3nZVbPThHhyxB2
         zdiZZ9pdEpgQBrODqJUSsmYXRfESJp4Zspa49s6N+/6x7TpCR5SxZiBmjRGXDrRAW7ou
         jF1xiNZN2o16o7mLVCuLRoHkjw85EpYMKVCl5IFz/BNRVL4fn0so1ggiBIZaANQ5EiAM
         5dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=2m417mPwYRIIe4B2SO8vIw/pMJeQrv0yMqLNvf1mD7g=;
        b=moGYMe0TMVoOKorYokroCn/kJ8YmIAbNEbQiaGTbxtu6cK3L7kR4xHpcBlkFuO1SMf
         XRujQLabxIhASTd3sYDq846kX910548+n4M8cwN4lWv3evgyXD8JHCkw/z2SdojWgj2x
         SYx+DUoKd5PaoU9D4wxJtyWFnedzoLCEEaRKW3MTGiFHAVL2yQ+FSweRcrHqzP77VCRi
         WU7iYaZWiZb0yOPskk8d26O2sgAqYl9E9hy6YSNZetlytpOT3uOKHFYuTBlUATAvc5Tr
         DGDATj3vWGu7uNy3p4uWmMqY8oP+zZFn0BJ/WiO17I4JdXyKtbcOO8QrFpE0YA6HdxCG
         iYJQ==
X-Gm-Message-State: ABuFfogoJczxzxkFEYPZ8ypneh1+JmIhVnf7rnEwZL8f1slZwDu7ZFuB
        JxmNiqIKaym3/HijSPtg6Bs2XDBI
X-Google-Smtp-Source: ACcGV626USlyjtkR7tER9LtWJ2Fo3d7Gf+yykLx1jsT7niU3K9xPEyecLNEoUMJFp0xi3AHjL8yC0Q==
X-Received: by 2002:a1c:b4d:: with SMTP id 74-v6mr5384836wml.15.1537997309740;
        Wed, 26 Sep 2018 14:28:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w192-v6sm692118wmf.33.2018.09.26.14.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:28:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] fetch: replace string-list used as a look-up table with a hashmap
Date:   Wed, 26 Sep 2018 14:28:28 -0700
Message-ID: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just to remind ourselves that we talked about getting rid of
   string-list used as look-up tables by replacing them with hashmap
   but haven't seen much effort expended on it.  I think this is my
   first semi-serious use of hashmap, and the code is expected to be
   full of newbie mistakes, inefficiencies and ignorance of idioms;
   pointing out any of which is much appreciated.

 builtin/fetch.c | 116 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a..5d1fd8dd49 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -246,16 +246,73 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
+struct refname_hash_entry {
+	struct hashmap_entry ent; /* must be the first member */
+	struct object_id oid;
+	char refname[FLEX_ARRAY];
+};
+
+static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
+				  const struct refname_hash_entry *e1,
+				  const struct refname_hash_entry *e2,
+				  const void *keydata)
+{
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
+	hashmap_init(map, (hashmap_cmp_fn)refname_hash_entry_cmp, NULL, 0);
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
@@ -271,10 +328,10 @@ static void find_non_local_tags(const struct ref *refs,
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
@@ -286,47 +343,54 @@ static void find_non_local_tags(const struct ref *refs,
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
+	hashmap_free(&remote_refs, 1);
 	string_list_clear(&remote_refs, 0);
 }
 
-- 
2.19.0-271-gfe8321ec05

