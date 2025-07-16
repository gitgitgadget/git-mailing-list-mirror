Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC781C8626
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672973; cv=none; b=LW5OEwiQvuX5SbgAXLCWxCt1l1Vyx9XARWUnOobykVBJspZfOn0giIi/jNc1xOadaW9+4j4IzTR/ABjkPfQQ5ZGA3YcwkAfyFDnZR7KR3fsqncDrPlU4wPWFqBAoFz/ntwEzzqO5lrhSu+E528pGl6Cud7J0GgaqDzfhS1lEFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672973; c=relaxed/simple;
	bh=K2exWgsUjioIhOsYuL+/fHg/D21x2q6sU4hqf9J9RF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUpdNfKVi9ey79ZYWFMrJY+RTdJPBj6o6gNsqrcWtZgOd/PT3LCSSI4dhaa/IJaC0tpNVEwO0JZwIPl1SI4Dm8bY4QxG+tHB6jp/y6nnYZ67/VztlGWFukrP0tR3AVxHYmms0igziKVmxXSRCcZy7c7SN21AM/GSXMmzzXADs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=bhGvhxe8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="bhGvhxe8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752672969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnuXOGETbXio5r3kdHf9izEo9p6wBiRHAmPOx+IaZhs=;
	b=bhGvhxe8WfaYo2y6YO4LtbsKE00EAGaiucVWyDtiPp4UhxQibul7On4su0MePy6pQ1q3FO
	Eb8Jr4ZV67WX0NODw4dcW6E8TtQtBGBpBCZimswcU2jK0Fw7S68I52L8zQ0/oURK0prMzy
	pYDOm4+xsYUQxptAdaqGfXbeE71J7Ew=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH v5 6/6] fixup! last-modified: use Bloom filters when available
Date: Wed, 16 Jul 2025 15:35:18 +0200
Message-ID: <20250716133518.1788126-6-toon@iotcl.com>
In-Reply-To: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make changes compatible with the ongoing work in the bloom filter
optimizations for multiple pathspec elements.

[1]: https://lore.kernel.org/git/20250712093517.17907-1-yldhome2d2@gmail.com/

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 71c66e8782..7cc57f9ada 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -49,7 +49,7 @@ static void last_modified_release(struct last_modified *lm)
 	struct last_modified_entry *ent;
 
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
-		clear_bloom_key(&ent->key);
+		bloom_key_clear(&ent->key);
 
 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
 	release_revisions(&lm->rev);
@@ -79,7 +79,7 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
 		if (lm->rev.bloom_filter_settings)
-			fill_bloom_key(path, strlen(path), &ent->key,
+			bloom_key_fill(&ent->key, path, strlen(path),
 				       lm->rev.bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
@@ -140,7 +140,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 		data->callback(path, data->commit, data->callback_data);
 
 	hashmap_remove(data->paths, &ent->hashent, path);
-	clear_bloom_key(&ent->key);
+	bloom_key_clear(&ent->key);
 	free(ent);
 }
 
-- 
2.50.1.327.g047016eb4a

