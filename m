Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CB2EB87D
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595815; cv=none; b=EG0IwxXlxqNV2krUElChXTOI1purj9X73OCDeGrpLrJTk5te6DCkAFtPtkid2+V19FYaMg5fX9yCl00vgX274Htmh5j/uoFIrjPTU+nUPBJk5eAH0lKPqO+mkGvs+FEdnB2NThRbWbgKZTGVNfgCRuOqS4pALRNTUCLORS9IHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595815; c=relaxed/simple;
	bh=JTtFpWWgCaFV/6aeyNuw01+Lm8MQQixoMh4l/0uX+EM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bf8EgxM3o9dVgNERKPWzvdy4s5tdY4G7riqAkwwZ26wso24b9i/hU7/I4YpNuINNUrekTBim/5KjmLjgowPhFLnVnNE+1tWS+eAd3plkE3ueu1UuDegq/fBofSCB7LTmd7/0+kQFnYpkkLHQO7QJ7/R79X4fLpn1HxO45JNCvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=byth3rIZ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="byth3rIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595808; x=1767200608; i=l.s.r@web.de;
	bh=fQT/XzmROKHJQgDx4BF49U1amoLmm8MzPtVQrAV5178=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=byth3rIZaNo9/976z0phk+rArbQmhAD5YTIpY4QeIwAej8G0Lko3XHAXvSiNOKxi
	 BZ2U2vOBnx+lD0V1/ZEiwUTYEewtWKNdSDFcFj+iaIWyJLFQg//StIwxF9Sdw/ca6
	 jzzYYE83MRBJdk3FpvAT0Cjj9l9dKkLOqZAvSGiUEMwah9AyhmbqmW1kRePf/2wOY
	 7PNVI6mP56MwRTaGsAI99D0mI5ZEBz9GefcqG9nH+Z/UXXH+eFA8KjHgI01PrucEJ
	 xxS1uy9mvwFgcfPKQ/nJjiTc1qg60l67kkuCiVRcuDdD4Qms3ZF3sZMiSIwD1vqi9
	 YAPgBFGvq1NGX4wUnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MJWoe-1vEiSm2y9w-00LRKV for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:28
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 03/14] midx: use commit_stack
Date: Wed, 24 Dec 2025 18:03:16 +0100
Message-ID: <20251224170327.68049-4-l.s.r@web.de>
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
X-Provags-ID: V03:K1:YFH2Z/e32UY3MYKXY+0Hugrg6hycgkb+W/mht5nLFp0/jsk8eka
 sGuU/GaywsFuE2h7WF8MxfvWfbfwxH1Pm43IUteQBNrjcUV4WDMzyBVqPyEihUcLZWB4/j+
 SEujc4OtqeLS99APfnjlvHgs4GhHncD8Ht/Q4cc/nh2h/mnF9tmiiCvUtt7lz/hc55KzNK6
 aSoj9IZrsBHkDsHO1Iszg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wy2RfKhgt18=;EzEiOLGqlxxmt9yF9RAm1tMHSzv
 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
 oY80DeaypSOAr3iC/uJXSFz8+k=

Simplify collection commits in a callback function by passing it a
commit_stack pointer all the way from the caller, instead of using
separate variables for array and item count and a bunch of intermediate
members in struct bitmap_commit_cb.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 midx-write.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index e3e9be6d03..b4a82d6ba5 100644
=2D-- a/midx-write.c
+++ b/midx-write.c
@@ -723,9 +723,7 @@ static int add_ref_to_pending(const struct reference *=
ref, void *cb_data)
 }
=20
 struct bitmap_commit_cb {
-	struct commit **commits;
-	size_t commits_nr, commits_alloc;
-
+	struct commit_stack *commits;
 	struct write_midx_context *ctx;
 };
=20
@@ -745,8 +743,7 @@ static void bitmap_show_commit(struct commit *commit, =
void *_data)
 	if (pos < 0)
 		return;
=20
-	ALLOC_GROW(data->commits, data->commits_nr + 1, data->commits_alloc);
-	data->commits[data->commits_nr++] =3D commit;
+	commit_stack_push(data->commits, commit);
 }
=20
 static int read_refs_snapshot(const char *refs_snapshot,
@@ -784,17 +781,15 @@ static int read_refs_snapshot(const char *refs_snaps=
hot,
 	return 0;
 }
=20
-static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_com=
mits_nr_p,
-						    const char *refs_snapshot,
-						    struct write_midx_context *ctx)
+static void find_commits_for_midx_bitmap(struct commit_stack *commits,
+					 const char *refs_snapshot,
+					 struct write_midx_context *ctx)
 {
 	struct rev_info revs;
-	struct bitmap_commit_cb cb =3D {0};
+	struct bitmap_commit_cb cb =3D { .commits =3D commits, .ctx =3D ctx };
=20
 	trace2_region_enter("midx", "find_commits_for_midx_bitmap", ctx->repo);
=20
-	cb.ctx =3D ctx;
-
 	repo_init_revisions(ctx->repo, &revs, NULL);
 	if (refs_snapshot) {
 		read_refs_snapshot(refs_snapshot, &revs);
@@ -823,14 +818,10 @@ static struct commit **find_commits_for_midx_bitmap(=
uint32_t *indexed_commits_nr
 		die(_("revision walk setup failed"));
=20
 	traverse_commit_list(&revs, bitmap_show_commit, NULL, &cb);
-	if (indexed_commits_nr_p)
-		*indexed_commits_nr_p =3D cb.commits_nr;
=20
 	release_revisions(&revs);
=20
 	trace2_region_leave("midx", "find_commits_for_midx_bitmap", ctx->repo);
-
-	return cb.commits;
 }
=20
 static int write_midx_bitmap(struct write_midx_context *ctx,
@@ -1375,15 +1366,14 @@ static int write_midx_internal(struct odb_source *=
source,
=20
 	if (flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
-		struct commit **commits;
-		uint32_t commits_nr;
+		struct commit_stack commits =3D COMMIT_STACK_INIT;
=20
 		if (!ctx.entries_nr)
 			BUG("cannot write a bitmap without any objects");
=20
 		prepare_midx_packing_data(&pdata, &ctx);
=20
-		commits =3D find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, &c=
tx);
+		find_commits_for_midx_bitmap(&commits, refs_snapshot, &ctx);
=20
 		/*
 		 * The previous steps translated the information from
@@ -1394,17 +1384,16 @@ static int write_midx_internal(struct odb_source *=
source,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr =3D 0;
=20
-		if (write_midx_bitmap(&ctx,
-				      midx_hash, &pdata, commits, commits_nr,
-				      flags) < 0) {
+		if (write_midx_bitmap(&ctx, midx_hash, &pdata,
+				      commits.items, commits.nr, flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			clear_packing_data(&pdata);
-			free(commits);
+			commit_stack_clear(&commits);
 			goto cleanup;
 		}
=20
 		clear_packing_data(&pdata);
-		free(commits);
+		commit_stack_clear(&commits);
 	}
 	/*
 	 * NOTE: Do not use ctx.entries beyond this point, since it might
=2D-=20
2.52.0

