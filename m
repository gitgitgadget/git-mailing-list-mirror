Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE11DE4DA
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027320; cv=none; b=bHwKTrgT9yDtBakDp8h1LXTkMUDicsBPaIxdWriuzXqtjT6woZMNglE/Rp87Pkg3MBNKaIB13pil40mgJ4l2ICVxshNx0dbhYIr2I96pPth2ANahhtgAZHi8eZH9VmjwEzYxxGXIy2JPqAVVPA9RNGmKk2VMrQPO4V/6fO0zQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027320; c=relaxed/simple;
	bh=DeZzuyhEBqLFgJ8gcVT2krzsuOjoDIWjL3ueR3oRDdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvoGUymOuDpw0z8nQM7TMEp+P8Fk597GeLI5LYDv7G1PuM3wEw3WuP5BY95BwmnFGZk7/7tWgxRfNOdvqFj5zNHCny5ei93SeToYm1iudshLcvWb5bNTfp4QrClb/2B5Ft/f7QsV6YCsmEncwaDAEEPB9oqITQXSnEyAtC/5o5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiwTASDK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiwTASDK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D957AC4CEE7;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737027319;
	bh=DeZzuyhEBqLFgJ8gcVT2krzsuOjoDIWjL3ueR3oRDdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OiwTASDKMxyk5anRL+GetFFfbbM99mAmBNPOcB6TWsoSF0C3Ft9QXQLIgaxSjmZaT
	 BBmuNF8bZNKmP014OHEwct0Kj3+fMXrBGOW5bdTdfh7p/q1W8GyUZehMBwvmycdmT1
	 89wXRlryFflXVLNRuZ2+9vaS/4dWz2Nblpco7r5EPj33T7hR1R95//3qzLWXEaWHPU
	 m+ipJQye7+7Q8xYHQqQJZlPRpWtvUseOOU5LlwFJ+TVtGEeQdtJynPrRmdICJ2cBhZ
	 Z4uIjqXlVYGN9X4tsDJj8mef9Ia5nHtcBYzTI0iwtcbGR6hHFWHcsH9Hmg9m/BNMEU
	 6w1/wXs1c3erw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18AFC02183;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
From: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 12:35:15 +0100
Subject: [PATCH 3/5] pack-write: pass hash_algo to `write_idx_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-kn-the-repo-cleanup-v1-3-a2f4c8e1c4c3@gmail.com>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7342;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=lgH6WSk//9YmVZiDA9JT771GFfmm1Z/I3oTlK5JxM7M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeI7vWfKA0RDW6FFbQZbZFenubzf2jJdmem+
 81DuVNryjoZUokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniO71AAoJED7VnySO
 Rox/+RML/39AJtLVnEACAS6DrDZ/InCd3MzRssFCmyWdIp+9m4P+kos1WU+5nll5k6+XsV/mmFN
 a5K2+2aalhtpbSE4SH6c+v/juiTN4wNF/36KF+CXA7g4KBzRPQd/GvsKFBLmnbk/JDABhRAxEom
 G9gkdVxy8QBGHWpmwkU7Mm6cKwE1QoQTf7/y7eeUtPLiU6zQ6lskm1s8QLqUg+4w0+sIP5dDQWf
 gBGTT8m6Rl50N5ZHhY94BdUTzLiXrO4ehHGIs7BuLBUO/QMUyWufBqJyjR7TMy2i14k8Tat9ZS7
 AVJ1XIf10AmMCKBcTSpKzLkLM18aGwGER5hL7WNHUDNMeeBFjdyzdhBpH6XLJkIax/n5oH2pJ5w
 8/ol/JqGfRw8lQOaiOy2NghZDOnGfpDbkz7Go2qSxMNe4CUnfvui8ECsnGrAbgzSf65z+caN/Lh
 BKxlglbn6cXOc0771+0RxBFxowARMFc9phKON/+8d3RPw92+BFlmBcachYHj2QmQcSoI30hg4L3
 sU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F
X-Endpoint-Received: by B4 Relay for karthik.188@gmail.com/default with
 auth_id=276
X-Original-From: Karthik Nayak <karthik.188@gmail.com>
Reply-To: karthik.188@gmail.com

From: Karthik Nayak <karthik.188@gmail.com>

The `write_idx_file()` function uses the global `the_hash_algo` variable
to access the repository's hash function. To avoid global variable
usage, pass the hash function from the layers above.

Altough the layers above could have access to the hash function
internally, simply pass in `the_hash_algo`. This avoids any
compatibility issues and bubbles up global variable usage to upper
layers which can be eventually resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c  |  4 ++--
 builtin/index-pack.c   |  3 ++-
 builtin/pack-objects.c |  7 ++++---
 bulk-checkin.c         |  5 +++--
 pack-write.c           | 14 ++++++++------
 pack.h                 | 10 ++++++++--
 6 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 6baf2b1b71e2443a7987a41e0cd246076682bf58..c4bc52f93c011f34bd7f98c8e9d74a33cf9783bd 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -798,8 +798,8 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
-				 pack_data->hash);
+	tmpfile = write_idx_file(the_hash_algo, NULL, idx, object_count,
+				 &pack_idx_opts, pack_data->hash);
 	free(idx);
 	return tmpfile;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6c5e3483f4fe67fb2e26132c55b1f8395d60c11f..d73699653a2227f8ecfee2c0f51cd680093ac764 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2096,7 +2096,8 @@ int cmd_index_pack(int argc,
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_hash);
+	curr_index = write_idx_file(the_hash_algo, index_name, idx_objects,
+				    nr_objects, &opts, pack_hash);
 	if (rev_index)
 		curr_rev_index = write_rev_file(rev_index_name, idx_objects,
 						nr_objects, pack_hash,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ffc62930b68c9b4152057572ede216381a4b0991..7b2dacda514c29f5393b604f15d379abb81546c0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1369,9 +1369,10 @@ static void write_pack_file(void)
 			if (cruft)
 				pack_idx_opts.flags |= WRITE_MTIMES;
 
-			stage_tmp_packfiles(&tmpname, pack_tmp_name,
-					    written_list, nr_written,
-					    &to_pack, &pack_idx_opts, hash,
+			stage_tmp_packfiles(the_hash_algo, &tmpname,
+					    pack_tmp_name, written_list,
+					    nr_written, &to_pack,
+					    &pack_idx_opts, hash,
 					    &idx_tmp_name);
 
 			if (write_bitmap_index) {
diff --git a/bulk-checkin.c b/bulk-checkin.c
index c4b085f57f74fb8b998576ac9d84fed9e01ed0ed..0d49889bfbb233d58fc094f5e2c2d2433dad9851 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -44,8 +44,9 @@ static void finish_tmp_packfile(struct strbuf *basename,
 {
 	char *idx_tmp_name = NULL;
 
-	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
-			    NULL, pack_idx_opts, hash, &idx_tmp_name);
+	stage_tmp_packfiles(the_hash_algo, basename, pack_tmp_name,
+			    written_list, nr_written, NULL, pack_idx_opts, hash,
+			    &idx_tmp_name);
 	rename_tmp_packfile_idx(basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
diff --git a/pack-write.c b/pack-write.c
index 0cd75d2e55419362a61cf981fc11117ea7a1d88a..f344e78a9ec20cea9812a5eaffc72ae0b7e7424d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -56,7 +56,8 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
  * The *sha1 contains the pack content SHA1 hash.
  * The objects array passed in will be sorted by SHA1 on exit.
  */
-const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
+const char *write_idx_file(const struct git_hash_algo *hash_algo,
+			   const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
 			   const unsigned char *sha1)
 {
@@ -130,7 +131,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		struct pack_idx_entry *obj = *list++;
 		if (index_version < 2)
 			hashwrite_be32(f, obj->offset);
-		hashwrite(f, obj->oid.hash, the_hash_algo->rawsz);
+		hashwrite(f, obj->oid.hash, hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
@@ -172,7 +173,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		}
 	}
 
-	hashwrite(f, sha1, the_hash_algo->rawsz);
+	hashwrite(f, sha1, hash_algo->rawsz);
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
 			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
@@ -546,7 +547,8 @@ void rename_tmp_packfile_idx(struct strbuf *name_buffer,
 	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
 }
 
-void stage_tmp_packfiles(struct strbuf *name_buffer,
+void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
@@ -561,8 +563,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
 
-	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
-					       pack_idx_opts, hash);
+	*idx_tmp_name = (char *)write_idx_file(hash_algo, NULL, written_list,
+					       nr_written, pack_idx_opts, hash);
 	if (adjust_shared_perm(*idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
diff --git a/pack.h b/pack.h
index 46d85e5bec787c90af69700fd4b328b1ebf1d606..c650fdbe2dcde8055ad0efe55646338cd0f81df5 100644
--- a/pack.h
+++ b/pack.h
@@ -86,7 +86,12 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
-const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
+const char *write_idx_file(const struct git_hash_algo *hash_algo,
+			   const char *index_name,
+			   struct pack_idx_entry **objects,
+			   int nr_objects,
+			   const struct pack_idx_option *,
+			   const unsigned char *sha1);
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
@@ -119,7 +124,8 @@ int read_pack_header(int fd, struct pack_header *);
 struct packing_data;
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void stage_tmp_packfiles(struct strbuf *name_buffer,
+void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,

-- 
2.47.0


