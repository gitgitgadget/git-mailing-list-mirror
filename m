Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84E1DE894
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027320; cv=none; b=q/4wQkXUR5a/bHxIVRwUeWAg+A+1IhmbcRU9LLdtpGwAUJpwrQNTqhyb9ew6mnVU8XGyIAAPhmuPHouzJiMiw3AaDPUiLw3Yhb6XRQVKcWOaKUxc0taJBesif4geXDtAP9Ub9XR9IE8yMjMSGmzhKNinVTIS5FITSCkUjpDqk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027320; c=relaxed/simple;
	bh=08xOZ4nX4Wpqds9TqEXj6xlVC4MVtJYbFfwe+V2yQOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SO2Ekjk5+1Ic4q7yjBhZFcSP8c5Yy8fmMl4g/xKhyHW7YaogkWS+yKstzpxKDXdh6Nhyo/SoQrXJX7N13XowuoeqKR4y/etQCE4hylx5Y3IoX7sZbMr70NkwqSM347GTcFHvPktv02d1STj+6ci+LZ1HDYloAb1QrJszyi3R+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZvTfJQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZvTfJQL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 058D8C4CEE2;
	Thu, 16 Jan 2025 11:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737027320;
	bh=08xOZ4nX4Wpqds9TqEXj6xlVC4MVtJYbFfwe+V2yQOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CZvTfJQLDZgOmgpn74oKJsLFdm4LGwtZJ+yHJBpqmL2UGv6pcORIMfx5LxSFbhQ43
	 bftbfPUFQiRku/ZbB1NAq3OfmayGiLpa5SmSYYebQ3HyvPcp1KV6asHQP5Rk4KBNmI
	 OrMQIPuipTbGFbjHnjzf2X09hssj0ZHMmPhg+g0qBamaYDNqN1wW3OI1mnHWP3e343
	 VuDVqFGo2m9RbTrw8ffuEkUpbHSq6dksTLtdKAt/qj9vdRcY7Vs64qbUUmIbTwqwkc
	 58YqyBcMHxUjjJthinDx/+HJCP4ehcET3N7XqilgBTamMGz9bh+S39vczel6tN43Xo
	 C57kbnN3LdAVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C4C02180;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
From: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 12:35:17 +0100
Subject: [PATCH 5/5] pack-write: pass hash_algo to `write_rev_*()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-kn-the-repo-cleanup-v1-5-a2f4c8e1c4c3@gmail.com>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=9apsR1GBlegQZhItb+8Q0LgeChaYi1HyTHkcGvoZGi8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeI7vUQov1ESSA2Ouu5Qn6GmWVnU1BTp16lf
 nN9cCE5ZZWX9YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniO71AAoJED7VnySO
 Rox/8bcL/jliaQT0LoddbUaadjRZMYklcT9H9GiZzGrsnoPblf9l0Y4ompHH2qY6FUuqPiNr4p5
 r8iHxsAPRsg3fsQoT3cwokR52jcCZ/qfmiYIv9vFNVfuofXuzkpHQ0H0O2G8TVA7XU2gtHBZUpb
 njLo4v3kniTP75iqJ4R7ZwFvDssFatq9OfXHtb6ug75WOlck/DjzEFj4E0tZscoaPo+o9SmAO5b
 LvYSKJaGcMuoeEI7/+rk3zoiw8PWO3/3ELVFVaO7p9d0wmFDewiuzTi/U7hZhF830NM7CcAdqoD
 NCwE71dVo/PnRglkGhe+bnN++pY6sxqgn6iTatKdK9lsGSWJvZj+xBsKudnGoVHP841g+PtEubJ
 wesJ4BQ1HP+F6tJqu+8oM93GeKa2JChdUvFF0i0/ggf8/NAUNa4tGWfV7/vLr49qVepIwsckS/H
 NFMeCN2F4VzqgrPckGbRvHsPFhFO6bC9zBvI1aDcGVNiC+KKGgY3cNF/hQAvVfHnnjwIwG3kH38
 Ak=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F
X-Endpoint-Received: by B4 Relay for karthik.188@gmail.com/default with
 auth_id=276
X-Original-From: Karthik Nayak <karthik.188@gmail.com>
Reply-To: karthik.188@gmail.com

From: Karthik Nayak <karthik.188@gmail.com>

The `write_rev_*()` functions use the global `the_hash_algo` variable to
access the repository's hash function. Pass the hash from down as we've
added made them available in the previous few commits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 pack-write.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 09ecbcdb069cc9b0383295798ceb49cbdc632b64..a2faeb1895e41f4c17281380478f1f2cabcc6f24 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
@@ -211,9 +209,10 @@ static void write_rev_index_positions(struct hashfile *f,
 		hashwrite_be32(f, pack_order[i]);
 }
 
-static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
+static void write_rev_trailer(const struct git_hash_algo *hash_algo,
+			      struct hashfile *f, const unsigned char *hash)
 {
-	hashwrite(f, hash, the_hash_algo->rawsz);
+	hashwrite(f, hash, hash_algo->rawsz);
 }
 
 char *write_rev_file(const struct git_hash_algo *hash_algo,
@@ -286,7 +285,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 	write_rev_header(hash_algo, f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
-	write_rev_trailer(f, hash);
+	write_rev_trailer(hash_algo, f, hash);
 
 	if (adjust_shared_perm(path) < 0)
 		die(_("failed to make %s readable"), path);
@@ -298,11 +297,12 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 	return path;
 }
 
-static void write_mtimes_header(struct hashfile *f)
+static void write_mtimes_header(const struct git_hash_algo *hash_algo,
+				struct hashfile *f)
 {
 	hashwrite_be32(f, MTIMES_SIGNATURE);
 	hashwrite_be32(f, MTIMES_VERSION);
-	hashwrite_be32(f, oid_version(the_hash_algo));
+	hashwrite_be32(f, oid_version(hash_algo));
 }
 
 /*
@@ -322,12 +322,14 @@ static void write_mtimes_objects(struct hashfile *f,
 	}
 }
 
-static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
+static void write_mtimes_trailer(const struct git_hash_algo *hash_algo,
+				 struct hashfile *f, const unsigned char *hash)
 {
-	hashwrite(f, hash, the_hash_algo->rawsz);
+	hashwrite(f, hash, hash_algo->rawsz);
 }
 
-static char *write_mtimes_file(struct packing_data *to_pack,
+static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
+			       struct packing_data *to_pack,
 			       struct pack_idx_entry **objects,
 			       uint32_t nr_objects,
 			       const unsigned char *hash)
@@ -344,9 +346,9 @@ static char *write_mtimes_file(struct packing_data *to_pack,
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(fd, mtimes_name);
 
-	write_mtimes_header(f);
+	write_mtimes_header(hash_algo, f);
 	write_mtimes_objects(f, to_pack, objects, nr_objects);
-	write_mtimes_trailer(f, hash);
+	write_mtimes_trailer(hash_algo, f, hash);
 
 	if (adjust_shared_perm(mtimes_name) < 0)
 		die(_("failed to make %s readable"), mtimes_name);
@@ -575,8 +577,8 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 				      hash, pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
-						    nr_written,
+		mtimes_tmp_name = write_mtimes_file(hash_algo, to_pack,
+						    written_list, nr_written,
 						    hash);
 	}
 

-- 
2.47.0


