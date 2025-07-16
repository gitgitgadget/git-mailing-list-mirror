Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E41A239A
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673342; cv=none; b=tD79BB40WXg9HSjSdGfdttFOXEhJT/kFzsacBIIcGJdbkQ/HIWza9FMB3xqabbhbPt4e3574i2sEQwXqOPsEgndP+kYj7hmSFOsXZ/5s8Irqqo+ifPcLLyGquxSPouKPaZuYquPIPwlY4+7d/fm9kbB+wfs0XSebziA0HpnJ1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673342; c=relaxed/simple;
	bh=ColuOZcsO84eq6B5/3p4D2txK3AliHS3MNYoxXd4QOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cuu6k7QBuxk4CRYbX9wzdkMVq6kHDSet7+QhUfjI2xf0xx1/0WP3U6XhV9Tzt7FA+uOlmogGghWdE2M/byHJOGrQpi4Hc1NVKEFv82ldqhd6ZnhYQ+/02AYWnEA9ecHyDeHNpywIfgjibfZGGREbtCGaCS2LZzLxZ1391UWg1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=CRze0JAy; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="CRze0JAy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752673337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FnKRVluGf/UAg5yZykcc7XCPWTchZj5f/Va4z3SQdw=;
	b=CRze0JAyq+c0lVKTi8QutJO8Uz9Oj+b8Nw4yEo1h1OP860xgenMhhLHsTMOoOuc4+WQpne
	rPai58butjOCFrbdfJO8N06E+BxZ7Kde2ZK++zuL+mao16a97xM7S7/0ILHzV5AQA37VDM
	hFTnyrRJEEmIpudFr0uiqlmjhxVnSXE=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 6/6] fixup! last-modified: use Bloom filters when available
Date: Wed, 16 Jul 2025 15:42:13 +0200
Message-ID: <20250716134213.1789445-1-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
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
This is a resend because I originally sent it with the wrong In-Reply-To and Cc.

--
Toon

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
