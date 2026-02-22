Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90A3590B9
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771785446; cv=none; b=mYIwqWHppnNCxzUns83oFj0WyZzL+rn3F4yqhrn8ope70RNFjbxB1wimM2/E8NRzMXPjwn8dSzOFjDBSiXdGlWtiQg3u2ohpuMnK3WadtGY4oX46/1OuP7wqB7Bnyjh/96eaCP/yljiEn9xBEllOg/ea7qZAeSJyvFwFGJgzt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771785446; c=relaxed/simple;
	bh=anewnvvY64RzoQns5FOapegb7y7kwrGp39moAECPvsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUImDW8qv9uQi7/PGhmvDJcg80qp087ODhI7FBycCD44PXi4C6jrjPscClNAgd6AgzbMnsFpAa+AATBR/Vt/iEuNGkcY9DmC+yWU0xdIxoudK4xoWHcbj6qZDSFe+3MNRW6ch73Xin8i75lyBSgG1rrLPMCF0VGfHDIxggGarZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HH4r4Odl; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HH4r4Odl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1771785438;
	bh=anewnvvY64RzoQns5FOapegb7y7kwrGp39moAECPvsY=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HH4r4OdlIK1sotBW1MkE6Z5hD8CgjSCVE2SJ6iau+aUjqhCQ/7AvPgtbci4+WjaT5
	 2LuA1WZRj5R3B7opMx0QY7g3hjpP14oLGNqDitNl6ofYWpAAZB6i62k+hPLmH13WSq
	 fXd25QnrpVs1SYF93RGSY5T8+eX9YZBTcu2OpZkKToALBDMkNcG3gqOVjF398g2iAF
	 RRyirmpEefzmeo+CjVw/n5k9GTy6Sqc2qx82+lEfMMAGrUHqwh8AuFtBiGpeKbo5G+
	 gvUWh/cJtOqMb1ErNXjqZSjhG0+8WUXsZfnVouLJkSX+uvjEXvQAQ0smnjc1fd7GAx
	 uCI+PJ/GZFP8BXXDB/tBd5z/BUOX9CXIgTWjYtYkP37LAsCV5sgkwpfU1KgTz88iMC
	 pvWAHyx5S4/vwBLyVWwejVSVkjdeur2ssxMOYiX+MkmVFSLc5/WUyGeaAZm+SSB6w7
	 2tftaHEnWiov55qdPnJoifTsEpjCH/kIGpEaaxTJHZYMUQk2iRz
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b212:146a:138c:fd27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 27F4720083;
	Sun, 22 Feb 2026 18:37:18 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] fsck: do not loop infinitely when processing packs
Date: Sun, 22 Feb 2026 18:37:10 +0000
Message-ID: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we iterate over our packfiles in the fsck code, we do so twice.
The first time, we count the number of objects in all of the packs
together and later on, we iterate a second time, processing each pack
and verifying its integrity.

This would normally work fine, but if we have two packs and we're
processing the second, the verification process will open the pack to
read from it, which will place it at the beginning of the most recently
used list.  Since this same list is used for iteration, the pack we most
recently processed before this will then be behind the current pack in
the linked list, so when we next process the list, we will go back to
the first pack again and then loop forever.  This also makes our
progress indicator loop up to many thousands of percent, which is not
only nonsensical, but a clear indication that something has gone wrong.

Solve this by skipping our MRU updates when we're iterating over
packfiles, which avoids the reordering that causes problems.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I realize that t1050 may seem like a bizarre place to put this test.
However, I was debugging my sha256-interop branch and why the final test
calling `git fsck` was failing, so I placed a `git fsck` earlier in the
test to double-check and discovered the problem.  Since we already have
a natural testcase here, I thought I'd just place the test where we
already know it will trigger the problem.

 packfile.h       | 16 ++++++++++++++--
 t/t1050-large.sh |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/packfile.h b/packfile.h
index acc5c55ad5..086d98c1a0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -183,6 +183,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 struct repo_for_each_pack_data {
 	struct odb_source *source;
 	struct packfile_list_entry *entry;
+	struct repository *repo;
 };
 
 static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct repository *repo)
@@ -191,8 +192,13 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
 
 	odb_prepare_alternates(repo->objects);
 
+	data.repo = repo;
+
 	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
+		struct packfile_list_entry *entry;
+
+		source->packfiles->skip_mru_updates = true;
+		entry = packfile_store_get_packs(source->packfiles);
 		if (!entry)
 			continue;
 		data.source = source;
@@ -212,7 +218,10 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 		return;
 
 	for (source = data->source->next; source; source = source->next) {
-		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
+		struct packfile_list_entry *entry;
+
+		source->packfiles->skip_mru_updates = true;
+		entry = packfile_store_get_packs(source->packfiles);
 		if (!entry)
 			continue;
 		data->source = source;
@@ -220,6 +229,9 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 		return;
 	}
 
+	for (struct odb_source *source = data->repo->objects->sources; source; source = source->next)
+		source->packfiles->skip_mru_updates = false;
+
 	data->source = NULL;
 	data->entry = NULL;
 }
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 5be273611a..75e75e627c 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -160,6 +160,10 @@ test_expect_success 'hash-object' '
 	git hash-object large1
 '
 
+test_expect_success 'fsck does not loop forever' '
+	git fsck
+'
+
 test_expect_success 'cat-file a large file' '
 	git cat-file blob :large1 >/dev/null
 '
