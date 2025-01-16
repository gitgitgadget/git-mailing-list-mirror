Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B31DE88B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027320; cv=none; b=NtSK8rr7lyarSUe5hYThv/QpKkf8HG3hm8EUNqYv0Dlo4/W69IS5VWpU3zYkrK9PvabA7RgPD7edLm16jnBFCP2NvhHnopYV/lAS/NW3hT4ui5FJ+nKSyMnO09t/e63RtELEclF3sv+QjZZdvlE3cKAnyJT62AFLTk90VPzt3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027320; c=relaxed/simple;
	bh=e5QNhCCtivCRVUGSra1bkuTY7szUKnqwHCZi9KbKo+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRh4M6p8bqiSpBCDtluJBdxmt2ZZXzPUlPIRWiRTXkleU0DpYBSYcilB+8SOyvNZVXw6NPFTkykFtOOpNPIsK/5hv8dI5xiZZpK0l3Vh41ydwLfyHefmMknSM5kG2+AOqkGFg4SVlaHnGsI3C0eRZmu51oZoT8uhI+WhkwXtjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekZeFesV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekZeFesV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A72B4C4CEE4;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737027319;
	bh=e5QNhCCtivCRVUGSra1bkuTY7szUKnqwHCZi9KbKo+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ekZeFesVXYRp/2YMdAicsefCywFDmeKV7f9m+296z+5/Zh9YRduYK28LnXTXsP+wd
	 C9ib+xLysIOKauKfPZPHjxyFxggIntTN5qKaLq3OUfDnqPHtOAC6s2tUr0T62MTMMK
	 hDHC/54W8LpyNu4lwA+vZs1mRRQQodZBPkOTfDtPUkktGSunCK8dkw/VGMzPuuoJ8b
	 vgzLPQpy1PFFj3JOIBTkZ7qyAEBWiM7ce2N7hjICwmELhGoHUlsstfZdfiIJpH6o5t
	 5OK2mdNO0mSWMRu+PiImEyOan19Zza1AoSSPf03BW9GIUgWLX9V1y7YBWmwLPP5vFS
	 e0q5jNqYeJ30Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BC2C02183;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
From: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 12:35:13 +0100
Subject: [PATCH 1/5] pack-write: pass hash_algo to
 `fixup_pack_header_footer()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-kn-the-repo-cleanup-v1-1-a2f4c8e1c4c3@gmail.com>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7847;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Q3YTpVPctjeWQ1SI5ZHfabnjeICNZIAxFUmfeObUWxA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeI7vSMmsze+ZrRtdNaSaLr5Yi8zy0rZZGbv
 3ZDeVLV1OaggYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniO70AAoJED7VnySO
 Rox/d8wL/jSKLJ8fiI5hd2W2G59G5HZILUNzEsmRLCRBRTF2n8HINOHA3cKMPw28xDuKEtZlDCE
 GWnvygUrjwhwKJ9uCkjAJ7XhvUbjcu1fE8DVk7UmufSmY2r+o02KcCJXJnEUpXkwdufcPg14KvA
 PIZGBmZZqVYYgPgdLnQcn43Yt/vsQOVfiEpVze38x8ovGbx0DraC8poQ7RCyEzvH9WUBBDbcrmZ
 iwMVyoJUyjRGXdWGDtD5GKMyVhyEWC/ndPhJryWPFaRB7NL1qPTqmHfsyoyeXXzZUFHUBwh/qwy
 K8oa1jhkJad5qflcgOFbRQgzJbe9gWZ4gHvxQmvIgvooD8jpTRgiOq/3i0WzC3u5wzJhz5WhRIa
 JZwvJIUmhq2Ss71UXZAD0vlQCvBCXyty0Q0wdYpZXJP7JWtnV5iUh2my3X/Md+UPB9yjmwRs3Pj
 sxXSluCW0vF49I94Bnvkummm4xFoAanEWtpZ4D8Ae9xTd8LV2L13GKkIKLwMHdMtGEGZHgi8UK5
 rI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F
X-Endpoint-Received: by B4 Relay for karthik.188@gmail.com/default with
 auth_id=276
X-Original-From: Karthik Nayak <karthik.188@gmail.com>
Reply-To: karthik.188@gmail.com

From: Karthik Nayak <karthik.188@gmail.com>

The `fixup_pack_header_footer()` function uses the global
`the_hash_algo` variable to access the repository's hash function. To
avoid global variable usage, pass the hash function from the layers
above.

Altough the layers above could have access to the hash function
internally, simply pass in `the_hash_algo`. This avoids any
compatibility issues and bubbles up global variable usage to upper
layers which can be eventually resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c  |  7 ++++---
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  5 +++--
 bulk-checkin.c         |  2 +-
 pack-write.c           | 28 ++++++++++++++--------------
 pack.h                 |  4 +++-
 6 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa..6baf2b1b71e2443a7987a41e0cd246076682bf58 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -878,9 +878,10 @@ static void end_packfile(void)
 
 		close_pack_windows(pack_data);
 		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
-					 pack_data->pack_name, object_count,
-					 cur_pack_oid.hash, pack_size);
+		fixup_pack_header_footer(the_hash_algo, pack_data->pack_fd,
+					 pack_data->hash, pack_data->pack_name,
+					 object_count, cur_pack_oid.hash,
+					 pack_size);
 
 		if (object_count <= unpack_limit) {
 			if (!loosen_small_pack(pack_data)) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0bef61c57232e198ba539cd44ec301d26dcb0eb8..6c5e3483f4fe67fb2e26132c55b1f8395d60c11f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1390,7 +1390,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		strbuf_release(&msg);
 		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
 		hashcpy(read_hash, pack_hash, the_repository->hash_algo);
-		fixup_pack_header_footer(output_fd, pack_hash,
+		fixup_pack_header_footer(the_hash_algo, output_fd, pack_hash,
 					 curr_pack, nr_objects,
 					 read_hash, consumed_bytes-the_hash_algo->rawsz);
 		if (!hasheq(read_hash, tail_hash, the_repository->hash_algo))
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d51c021d99d9f470c04b7ec52565ab2f4c1c19ae..ffc62930b68c9b4152057572ede216381a4b0991 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1319,8 +1319,9 @@ static void write_pack_file(void)
 			 */
 
 			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
-			fixup_pack_header_footer(fd, hash, pack_tmp_name,
-						 nr_written, hash, offset);
+			fixup_pack_header_footer(the_hash_algo, fd, hash,
+						 pack_tmp_name, nr_written,
+						 hash, offset);
 			close(fd);
 			if (write_bitmap_index) {
 				if (write_bitmap_index != WRITE_BITMAP_QUIET)
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 5044cb7fa083d692a3797e2491c27b61ec44c69c..c4b085f57f74fb8b998576ac9d84fed9e01ed0ed 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -70,7 +70,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
 		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
+		fixup_pack_header_footer(the_hash_algo, fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
 		close(fd);
diff --git a/pack-write.c b/pack-write.c
index 98a8c0e7853d7b46b5ce9a9672e0249ff051b5f9..fc887850dfb9789132b8642733c6472944dbe32d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -380,7 +380,8 @@ off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
  * partial_pack_sha1 can refer to the same buffer if the caller is not
  * interested in the resulting SHA1 of pack data above partial_pack_offset.
  */
-void fixup_pack_header_footer(int pack_fd,
+void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
+			 int pack_fd,
 			 unsigned char *new_pack_hash,
 			 const char *pack_name,
 			 uint32_t object_count,
@@ -393,8 +394,8 @@ void fixup_pack_header_footer(int pack_fd,
 	char *buf;
 	ssize_t read_result;
 
-	the_hash_algo->init_fn(&old_hash_ctx);
-	the_hash_algo->init_fn(&new_hash_ctx);
+	hash_algo->init_fn(&old_hash_ctx);
+	hash_algo->init_fn(&new_hash_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
@@ -406,9 +407,9 @@ void fixup_pack_header_footer(int pack_fd,
 			  pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	the_hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
+	hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
-	the_hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
+	hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
 	partial_pack_offset -= sizeof(hdr);
 
@@ -423,7 +424,7 @@ void fixup_pack_header_footer(int pack_fd,
 			break;
 		if (n < 0)
 			die_errno("Failed to checksum '%s'", pack_name);
-		the_hash_algo->update_fn(&new_hash_ctx, buf, n);
+		hash_algo->update_fn(&new_hash_ctx, buf, n);
 
 		aligned_sz -= n;
 		if (!aligned_sz)
@@ -432,13 +433,12 @@ void fixup_pack_header_footer(int pack_fd,
 		if (!partial_pack_hash)
 			continue;
 
-		the_hash_algo->update_fn(&old_hash_ctx, buf, n);
+		hash_algo->update_fn(&old_hash_ctx, buf, n);
 		partial_pack_offset -= n;
 		if (partial_pack_offset == 0) {
 			unsigned char hash[GIT_MAX_RAWSZ];
-			the_hash_algo->final_fn(hash, &old_hash_ctx);
-			if (!hasheq(hash, partial_pack_hash,
-				    the_repository->hash_algo))
+			hash_algo->final_fn(hash, &old_hash_ctx);
+			if (!hasheq(hash, partial_pack_hash, hash_algo))
 				die("Unexpected checksum for %s "
 				    "(disk corruption?)", pack_name);
 			/*
@@ -446,7 +446,7 @@ void fixup_pack_header_footer(int pack_fd,
 			 * pack, which also means making partial_pack_offset
 			 * big enough not to matter anymore.
 			 */
-			the_hash_algo->init_fn(&old_hash_ctx);
+			hash_algo->init_fn(&old_hash_ctx);
 			partial_pack_offset = ~partial_pack_offset;
 			partial_pack_offset -= MSB(partial_pack_offset, 1);
 		}
@@ -454,9 +454,9 @@ void fixup_pack_header_footer(int pack_fd,
 	free(buf);
 
 	if (partial_pack_hash)
-		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
-	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
-	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
+		hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
+	hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
+	write_or_die(pack_fd, new_pack_hash, hash_algo->rawsz);
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
diff --git a/pack.h b/pack.h
index a8da0406299bf267205256aaa8efb215f2ff73be..6d9d477adc83e83d9e9175ccf699c100b4c147c6 100644
--- a/pack.h
+++ b/pack.h
@@ -91,7 +91,9 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offs
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
 off_t write_pack_header(struct hashfile *f, uint32_t);
-void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
+void fixup_pack_header_footer(const struct git_hash_algo *, int,
+			      unsigned char *, const char *, uint32_t,
+			      unsigned char *, off_t);
 char *index_pack_lockfile(int fd, int *is_well_formed);
 
 struct ref;

-- 
2.47.0


