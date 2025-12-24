Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7123093AE
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595816; cv=none; b=KLxLjql7zarLZuhj5mPT0a1TcGsk31YTKZ7Vi2iBQtgL1jpsTNQs5BLrLTvWrtvG62mzuo7LVedNQeQ3usZyEPIXtGqaQ5Fi44XHz80+91z4w0XoVwPjxR/rEOZ1sLf2pDGc6AzttA0HSVZqiwSfBoC5mzvzCEHujtUiWxREIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595816; c=relaxed/simple;
	bh=9ym9kEFg7+pfMizEaEfouQaYfU9U/VlIw9Neoyb68Hw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvH6kIBAucuKZF9NfhHVI5W1Qd3JaJqvDz2xeiyejaK2bKE4tUqNoo9SPjH5wswmrDrM6ihN2Se5Ld/AxIIEI/WAWR7/1Ek4nxwdcUCXlNuptyB9++A/FgGkzGsn+5wHa5fqPc+fhMBeuPr8ef/iSuwO3XR5CJysuaPg8jan7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DxKJpMvZ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DxKJpMvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=kbArYbFUXiybwJGV4zA7wVES66U1kj4jf7PXPoxIpCY=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DxKJpMvZxsdMjH6tQFb+M6IrnSeiUerdb5HzI3VBFRf9t6ZvWx3x6TSJCjy/Yj8B
	 znYn298+e84Pxu+01E3jra5C1a8Rq59Cv+Tf9yXHna+V756yKRom6pE7rb9MAhrUw
	 ZEC2GK4udAOu5ljZucOcK26dCo78FWYnA4d5IF9nmkY1mPGVD01t++LaBCIqiGPy9
	 8tpsekEgmPuybe3tCVk9lf36yCCcNKfKiy44H4UOxK6xB0vWJFEa7qh74UGE4mLkk
	 5wPA3NBoSdnqPYj4DO05QbY20KkRbmLwAdF4tgeHUMpUn7J9M/1ve9+4fduavlZkE
	 E5WNjJsPsZDRsWoQKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MVJRb-1vPTxW1O0F-00RB9I for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 10/14] pack-bitmap-write: use commit_stack
Date: Wed, 24 Dec 2025 18:03:23 +0100
Message-ID: <20251224170327.68049-11-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224170327.68049-1-l.s.r@web.de>
References: <20251224170327.68049-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v0RhLM6W4Ng5rTy7/AyPcncsV32y5/beMuGHmcXIFd7GG77tdwx
 FNbyC/uoCi9lsCCTnS6vgoKLvG50ufB8PW42A9OxUuAxpSh24Phhk8K3DUkbSJrOXLV9edD
 HkYggVUR0GwtEuMQrJHQixsmKBn0tEcgz1GI0SZYUe5kfkkmBehaS1GjhX3bFgGM4EnffjA
 CDdKqq2r+rAZhpmXAK/mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zSlSp4k0FqE=;YJm3Nyd93+9PYhUyn2L9K/0JrCP
 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

Use commit_stack instead of open-coding it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pack-bitmap-write.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4404921521..bf73ce5710 100644
=2D-- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -315,8 +315,7 @@ define_commit_slab(bb_data, struct bb_commit);
=20
 struct bitmap_builder {
 	struct bb_data data;
-	struct commit **commits;
-	size_t commits_nr, commits_alloc;
+	struct commit_stack commits;
 };
=20
 static void bitmap_builder_init(struct bitmap_builder *bb,
@@ -329,8 +328,8 @@ static void bitmap_builder_init(struct bitmap_builder =
*bb,
 	struct commit_list *r;
 	unsigned int i, num_maximal =3D 0;
=20
-	memset(bb, 0, sizeof(*bb));
 	init_bb_data(&bb->data);
+	commit_stack_init(&bb->commits);
=20
 	reset_revision_walk();
 	repo_init_revisions(writer->to_pack->repo, &revs, NULL);
@@ -390,8 +389,7 @@ static void bitmap_builder_init(struct bitmap_builder =
*bb,
=20
 		if (c_ent->maximal) {
 			num_maximal++;
-			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
-			bb->commits[bb->commits_nr++] =3D commit;
+			commit_stack_push(&bb->commits, commit);
 		}
=20
 		if (p) {
@@ -438,8 +436,7 @@ static void bitmap_builder_init(struct bitmap_builder =
*bb,
 	}
=20
 	for (r =3D reusable; r; r =3D r->next) {
-		ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
-		bb->commits[bb->commits_nr++] =3D r->item;
+		commit_stack_push(&bb->commits, r->item);
 	}
=20
 	trace2_data_intmax("pack-bitmap-write", writer->repo,
@@ -454,8 +451,7 @@ static void bitmap_builder_init(struct bitmap_builder =
*bb,
 static void bitmap_builder_clear(struct bitmap_builder *bb)
 {
 	deep_clear_bb_data(&bb->data, clear_bb_commit);
-	free(bb->commits);
-	bb->commits_nr =3D bb->commits_alloc =3D 0;
+	commit_stack_clear(&bb->commits);
 }
=20
 static int fill_bitmap_tree(struct bitmap_writer *writer,
@@ -630,8 +626,8 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 		mapping =3D NULL;
=20
 	bitmap_builder_init(&bb, writer, old_bitmap);
-	for (i =3D bb.commits_nr; i > 0; i--) {
-		struct commit *commit =3D bb.commits[i-1];
+	for (i =3D bb.commits.nr; i > 0; i--) {
+		struct commit *commit =3D bb.commits.items[i-1];
 		struct bb_commit *ent =3D bb_data_at(&bb.data, commit);
 		struct commit *child;
 		int reused =3D 0;
=2D-=20
2.52.0

