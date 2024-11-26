Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DF125DF
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585920; cv=none; b=sVcoGPwLW16x+PjRxipRtBuVZRMtlwJuSnlRrW3ujUhf5VmZKDGU1nGimTMAFYV9/0QSRD1oAQranuZL6MCxTiUN8QtUqFCxvUyI3yvrF1yl2ix/3GYmr0oo60DePNoxt5DnZVZsTj10jFnx3aUxQ4hL5hng6d6FlmFVQvphWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585920; c=relaxed/simple;
	bh=niaOtjv4MPY1aH4RTq75aA+gSM3mtZjRoE5X856sq/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Svne5FAw+V9dxjo5wTFCft/x0FZ86+tTktIB1mDiPPbadcy5xaAWL9Ou8s1nDbZFQ5xCBRNOqXvRB0O70geTt613k2MGRuEJfABbwckh9EH5z04yER6uyvRMTKkAvpXZmvbmvMJ9w6t9aF8xwXmhSKOKyFbP0cqXnP8eVvUJt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BCUFwE2j; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BCUFwE2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732585916; x=1732845116;
	bh=IvYCIatbneQI26HyMid6TjaS3kAfMQI8OkMfTr3Z5Kc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BCUFwE2j6xgSbgm83pqCXM1eMVmY2tCzDk/nH36aJh1izGMAjPXMzXL4YVLoXGVT5
	 UPGZ2z8tkRd2qQvKgmJ+ubPc8se5E2pbQaCIJMZbJx2ckxaVRCQ9rpcwnnEt5Cd9/B
	 BiCMsLhpY73ulZ81rEqxWSovZE0ZLuvgmuLuB0C1SgUVb/612cRA9M6VtFmKzwJSTM
	 vvRa9P7WtyJCDU246gVh3NSqZEvFHLWKbNlyzxwEbcMG3MekBPOVFlqZStNbOykCtH
	 3MY7QbrvEKyd54EnMhqRxJeh6PKpFuF5re7NOJj5Gvtk+t4GOxPtUNQKJ41mrM3z3x
	 4v0ekHpItsgjg==
Date: Tue, 26 Nov 2024 01:51:50 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v5 3/8] worktree: refactor infer_backlink return
Message-ID: <20241125-wt_relative_options-v5-3-356d122ff3db@pm.me>
In-Reply-To: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d85c5afdab61bbc71fb18bf04c563f77b9274179
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The previous round[1] was merged a bit early before reviewer feedback
could be applied. This correctly indents a code block and updates the
`infer_backlink` function to return `-1` on failure and strbuf.len on
success.

[1]: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45=
eb@pm.me

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/worktree.c b/worktree.c
index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..afde5394c8760c328f12aa321be=
3ac5c199cc0f1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -111,9 +111,9 @@ struct worktree *get_linked_worktree(const char *id,
 =09strbuf_strip_suffix(&worktree_path, "/.git");
=20
 =09if (!is_absolute_path(worktree_path.buf)) {
-=09    strbuf_strip_suffix(&path, "gitdir");
-=09    strbuf_addbuf(&path, &worktree_path);
-=09    strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
+=09=09strbuf_strip_suffix(&path, "gitdir");
+=09=09strbuf_addbuf(&path, &worktree_path);
+=09=09strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
 =09}
=20
 =09CALLOC_ARRAY(worktree, 1);
@@ -725,8 +725,10 @@ static int is_main_worktree_path(const char *path)
  * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we ma=
y
  * be able to infer the gitdir by manually reading /path/to/worktree/.git,
  * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
+ *
+ * Returns -1 on failure and strbuf.len on success.
  */
-static int infer_backlink(const char *gitfile, struct strbuf *inferred)
+static ssize_t infer_backlink(const char *gitfile, struct strbuf *inferred=
)
 {
 =09struct strbuf actual =3D STRBUF_INIT;
 =09const char *id;
@@ -747,12 +749,11 @@ static int infer_backlink(const char *gitfile, struct=
 strbuf *inferred)
 =09=09goto error;
=20
 =09strbuf_release(&actual);
-=09return 1;
-
+=09return inferred->len;
 error:
 =09strbuf_release(&actual);
 =09strbuf_reset(inferred); /* clear invalid path */
-=09return 0;
+=09return -1;
 }
=20
 /*

--=20
2.47.0


