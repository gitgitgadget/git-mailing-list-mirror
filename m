Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530A1DE88C
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027320; cv=none; b=fS0SyQrzoaLLrHf/psCRj5fbJPYNYPtRKDna+hkrUQIZ7ED8hXbtfhNx6AMdoobRfXCa25n7n4Om3DfNYx0cASoXOSUZYvm3m++KHMn9MoTS8apkVVcRThgv8M3IeAC6ZEoWL38Y0+/LCDTBaHDiwkBxNHjay9kUeF+qClOyJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027320; c=relaxed/simple;
	bh=nfRLsLy/KZfnpWyvJ1W2OTuFJufJa/rRGAmfgo0Ysoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDqOXiNV9SQ6P/TA6oEstQpVBZeLVkWrDPFM6BE5BZq8stfAya9a/UI2HOmFsXIuiGKCtHNb5CKA6l9eG1TDmBWXU96C+NlpORcR+a5nuIt6+gV9IixwmbW8paOSss5PpWx3jg5ku3H6yV1ARuywfngjfTnKI3VMFtVG+eNssYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPO8O2xx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPO8O2xx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA743C4CEE6;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737027319;
	bh=nfRLsLy/KZfnpWyvJ1W2OTuFJufJa/rRGAmfgo0Ysoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GPO8O2xxqN0sDLLXxxWNfc/noElhE6jMv7LlYhWA+vhIycR0Dkrj2ZtEbt2SPv/EK
	 nLKwclvEDgX6v+tZSGcQNx4n9iDsv2/cTm8TXXtOQiO1S5RpoF3q2u8hczrP9RdzNx
	 DIQ+m2M9aorn/JAdHY9ZCepRToOT656QVa9Sxm1qE3IwhnjAZl5dRprpKVotF1nxcL
	 RrU6drupyejoa2YsF3Vneo7pd0/P9sarQGXIlGg/m66WEW/Y3PlxIZiR5RaoRZPMm3
	 pdmNxxF4t4oG/957hVvl3X7O0zLXFQ+RoAZ8KQjUiQe3SPVPsGqXRiZY4y7VjeUPPD
	 3rAG9nejNCNSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B85C02188;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
From: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 12:35:14 +0100
Subject: [PATCH 2/5] pack-write: pass repository to `index_pack_lockfile()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-kn-the-repo-cleanup-v1-2-a2f4c8e1c4c3@gmail.com>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=4+NcIvb9eGXZWFVkaGz25U3+N7Kc8XV6gLpT89ksQDA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeI7vXhuwr8JrGpb907ky1LbhEAU2s8a0Wn2
 +E4ScLTlPXzmokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniO71AAoJED7VnySO
 Rox/ZT4MAIfr+NVGqktnAehiZKd3Bhh30rRGf9Pjc8iO0DGdMFzzSVH6eKcSIJP3ysA9X2V5So6
 FBvkaam15Bx1IMAYz2rM6ZyHJpeenupILx/ZFWTGbVEjvPNbIiizlKKZWn1ZMXL2u+kWCuSepXp
 fWnpP2GwtnSapNYD9aBTqSaX+NhP0C1SbGkGulsZDm1hLH1TOecGY0TJCm3VsneSVGS/0ivpAyo
 W8AmcnWzf7XiA+I3bcTR9sBbQuVtwn7TVQ42J0ciqCVwuIAG1nE4iFERqYLwk4d0opYzYC8Arjs
 JMKdoHEehrYe6f3EvZG8/6AqOfCAz/t/TcitUUjT4lkT+Ifi6NKQTUF4CsEgAaYW9HpOVetjcHF
 BFViuHMd2SRTiLZNa7z0u3UfC8Ep69WHl/bP+DTWQ9He8crFkSdBEdYVI1XAQGh6fclhUlAxeYx
 AlqgPvUXfVUAcIzC9Mp8YMNsE89Csz2hsBUzPDwI7LEx1n09w/0/JCVPf8N0xzstZGrZ9tcRfZ6
 Fw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F
X-Endpoint-Received: by B4 Relay for karthik.188@gmail.com/default with
 auth_id=276
X-Original-From: Karthik Nayak <karthik.188@gmail.com>
Reply-To: karthik.188@gmail.com

From: Karthik Nayak <karthik.188@gmail.com>

The `index_pack_lockfile()` function uses the global `the_repository`
variable to access the repository. To avoid global variable usage, pass
the repository from the layers above.

Altough the layers above could have access to the hash function
internally, simply pass in `the_hash_algo`. This avoids any
compatibility issues and bubbles up global variable usage to upper
layers which can be eventually resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 2 +-
 fetch-pack.c           | 4 +++-
 pack-write.c           | 6 +++---
 pack.h                 | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56347a79633505efe8dc05acf1583b4c9995eefe..b83abe5d220cefd3707b701409dc5e6b67566599 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2304,7 +2304,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (status)
 			return "index-pack fork failed";
 
-		lockfile = index_pack_lockfile(child.out, NULL);
+		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
 		if (lockfile) {
 			pack_lockfile = register_tempfile(lockfile);
 			free(lockfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index 3a227721ed0935d1f9c40584c57f54043354c032..824f56ecbca11cd9e4da6a3e4c450c6b2e7078ab 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1036,7 +1036,9 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
-		char *pack_lockfile = index_pack_lockfile(cmd.out, &is_well_formed);
+		char *pack_lockfile = index_pack_lockfile(the_repository,
+							  cmd.out,
+							  &is_well_formed);
 
 		if (!is_well_formed)
 			die(_("fetch-pack: invalid index-pack output"));
diff --git a/pack-write.c b/pack-write.c
index fc887850dfb9789132b8642733c6472944dbe32d..0cd75d2e55419362a61cf981fc11117ea7a1d88a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -460,10 +460,10 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(int ip_out, int *is_well_formed)
+char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
 {
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = the_hash_algo->hexsz + 6;
+	const int len = r->hash_algo->hexsz + 6;
 
 	/*
 	 * The first thing we expect from index-pack's output
@@ -480,7 +480,7 @@ char *index_pack_lockfile(int ip_out, int *is_well_formed)
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
-				       repo_get_object_directory(the_repository), name);
+				       repo_get_object_directory(r), name);
 		return NULL;
 	}
 	if (is_well_formed)
diff --git a/pack.h b/pack.h
index 6d9d477adc83e83d9e9175ccf699c100b4c147c6..46d85e5bec787c90af69700fd4b328b1ebf1d606 100644
--- a/pack.h
+++ b/pack.h
@@ -94,7 +94,7 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
-char *index_pack_lockfile(int fd, int *is_well_formed);
+char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
 
 struct ref;
 

-- 
2.47.0


