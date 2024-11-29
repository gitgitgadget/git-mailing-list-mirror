Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38051A3AB1
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918969; cv=none; b=VkJM5hkXYU778E64nRYpyMDa4+6tGjWaDpCX7fQ74tWscD4mz1h/4r64OOx92UMr4wE891Q3Ie3kFPd0H4HFt1lnyzQoM4RvsdZIyZCcmPdzUGihDQwTiNhBlOQ3veuH0HRS8S3KgVk32pactcGqbID3ug+9jjHZj9y3XIlj9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918969; c=relaxed/simple;
	bh=niaOtjv4MPY1aH4RTq75aA+gSM3mtZjRoE5X856sq/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9uIL93VVUtA3HMQ6FPU/rB7L1HhrudI0pOO/f2Utm5rd1uD/QWo88w9Y46lw95IodQ6Wg3J6PNJgW85yifE/EeM0i16qaaExoNksBvyNM0f9xYptDUE6YWzs8m7Zwz/R2pp3Xr5k6AMGqJ0eZGvdEIc2EBlLEPNUsy1QOpYOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pJe+o/6J; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pJe+o/6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732918965; x=1733178165;
	bh=IvYCIatbneQI26HyMid6TjaS3kAfMQI8OkMfTr3Z5Kc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=pJe+o/6JvbrdWMNWvyBChgKP8RHzSQNyNT/qhjxxbhUQRnIcJU3ziPxNt9YDueY3l
	 U6ipzfpWhedQvG06jnqNPUyc4vHHGirpVMgD9WRdXJIX0+nXra+TwC8fVUAT8xVoZE
	 Pb5cuOk3Y/64RprCogEOvaPegHotnEPabATwSguRZ+dxpO4zh2OVEWFNoFTe0OUBt/
	 9jhSbPc/95dykHQw7mDHwBOwTCVaZ1aQblRLgq92MJni4V4XVxeMPXzm4yeYUdMRj0
	 WHeWwR3P81RgVYauqB1YhabUrQbcC+rUy7iHsfOZugA7QQxWMCxA8OsatHUBgDqTzh
	 lwfLtoo3ej2yw==
Date: Fri, 29 Nov 2024 22:22:41 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v6 3/8] worktree: refactor infer_backlink return
Message-ID: <20241129-wt_relative_options-v6-3-44e4e0bec8c3@pm.me>
In-Reply-To: <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 170a0ff4818b41c4770c91a0ed47f6403ff41ade
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


