Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C1146D45
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 04:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435925; cv=none; b=G+xLWhaEryftz0l5LM0wxVd1XZUwl/HDyjLgadJ8EBt68SgQwaGIYtkmPU4l7a6h/EufDv5JxOeh/o3t34fUj/Kuw3NoyhLATh5brPnwUx1W1ye+axa4K7IoawApLb3ryGvjMs5jE2Bsc8FEhU+pySAYx4eAHOf7l2w8Z/OdaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435925; c=relaxed/simple;
	bh=/Se9OEAa8Z5ULWhKCgQOxmzssQTQloBNxRN/a/DiHvE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7NUo8i3mmlpPymKZcJj0q5+uhnfG9dGKH9220LqRcMYMYMIC/5HUE6FsOORgoGivubIoTptex2hZ/i5uLOuxDUhsC5J2j4dy7nERVnMvfNXFeaSIrXn7AK/BY/b+zuRV4Qj2YfK5oBsBi9VR9qaLIwODJH9v2kSHrZ9UFZJGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KVBti3M9; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KVBti3M9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730435916; x=1730695116;
	bh=I4JVVGWtkHbLhQbETsc5Fv8E4IGvq+MC12C3u0SKQBk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KVBti3M9tQTZ++29xi5Em30EHz16jLjHMMdyBntR4uq2SmPk0sXd4/Ga8j+XrkrbW
	 YnKi9nlvaw+ySckQ7Lc2gs4nC5aCpKaizNbU9DjOqhLzW8TYYbEEqdXNbqBkJYsNoh
	 oBBwpwKvysFPIuQxjobFZyR6hqLiE0/0SwlZOmeXHLvKnPmj8Ui0XGIZe+p01m5o3h
	 mJj1m7N0IvZcfPGC4KvN0fZP12vx8sSnxCk/Znk8k8pGevuoZ+uREBlptFymtrPaER
	 +fFImoHA4POwhP2A+gvGAHphWGFP3fTfEo2C0v041W7dHlVKCgOZfixmAzFmHdUajW
	 RrlyqtJLxDuTA==
Date: Fri, 01 Nov 2024 04:38:32 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v4 3/8] worktree: refactor infer_backlink return
Message-ID: <20241031-wt_relative_options-v4-3-07a3dc0f02a3@pm.me>
In-Reply-To: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 5db6c801399f7fdf4af234d942ea99845ec99f65
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
 worktree.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/worktree.c b/worktree.c
index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..9346d51c438cbd029e9e57591ed=
d8c9f30cc7638 100644
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
@@ -725,12 +725,15 @@ static int is_main_worktree_path(const char *path)
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
=20
+=09strbuf_reset(inferred);
 =09if (strbuf_read_file(&actual, gitfile, 0) < 0)
 =09=09goto error;
 =09if (!starts_with(actual.buf, "gitdir:"))
@@ -741,18 +744,16 @@ static int infer_backlink(const char *gitfile, struct=
 strbuf *inferred)
 =09id++; /* advance past '/' to point at <id> */
 =09if (!*id)
 =09=09goto error;
-=09strbuf_reset(inferred);
 =09strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
 =09if (!is_directory(inferred->buf))
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


