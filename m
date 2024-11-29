Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7992C18C
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919886; cv=none; b=JyD0styweLH97NQfViq0MpZF29ByoZN6kBSMvz0sULVYt8E8b5W1yQHAlAV6LxkxWHi88u8r9GIlGLgF3Nh2+rGiTYcXAu6nJSHLxT2BV4Jpgy49fZVZyTVoOz7TI88c4LficRfUqLCJZ2zi+AWjgNh/GPQ2cfHRAPR+JSRjvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919886; c=relaxed/simple;
	bh=B7yvsjPNXNoywY1zU+QmwNFbdu92ulkFLxCE6vynUC0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSaLL0JscOJzXzA4GG+TROx4qO06uXMWyj/zdtFsZy5SIHK+4QQ7L5Zcivp8PZ9+b0fgEBs/ODMF2zFh3bAirP6Yox8ljGt55g5zNvPwYVPp8BszvUdCsGEFUaz0l7iFJtl3VnaPkz3qV+xh4xeO8+EI16TsXm+df7X7SBYCxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=r1rJdNxB; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="r1rJdNxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732919882; x=1733179082;
	bh=zWeNkm7Zp2ZvlD6HD/Bhwwm7R8pxWL267YdcOUQZSnU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=r1rJdNxB71fWXWQmIrYgsG+dDbdv74/0D59g6n5KUwRpd11SRfRb5o4oG9Ln//KqE
	 NQFNrvjanPrRbr0ANqF1rTMA8Sb+89ltWMVhB0ZUvdMOci7/iiqnfagheU/VKwMV2G
	 XSgyO22fjSRL0ci4USFuwgZTaOQmIoKsi/WUKkYgDpErzZfHUMzpBe1WPaFYdSb0e2
	 NR4ng2EKGiEJ3sCsYpXlQtfxPkpRyxlr2SBR6RbxaFyH3egxh307sVDL5b4ptEBjat
	 LZzhWFmCruSnEvESPAxpy4n8EsR06s8rVB9yRWIn5PEvtr2Mit8PSoKt2MKaOWUrsR
	 HHo5+B1RO0qlg==
Date: Fri, 29 Nov 2024 22:37:58 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: shejialuo <shejialuo@gmail.com>, Junio C Hamano <gitster@pobox.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 3/3] worktree: add id to `worktree list` output
Message-ID: <20241129-wt_unique_ids-v2-3-ff444e9e625a@pm.me>
In-Reply-To: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 7234c624f9f512ed7427214b01fbcfa99afa271e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The worktree id is relatively hidden from the user, however, there may
be times where a user or script needs to determine the worktree id for a
linked worktree (e.g., to manually operate on some refs). While the id
is stored in the worktree `.git` file, it would be nice if there was an
easier method of obtaining it. This teaches Git to output the worktree id
(for linked worktrees) in the `worktree list` verbose and porcelain modes.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/git-worktree.txt | 12 +++++++++++-
 builtin/worktree.c             |  5 +++++
 t/t2402-worktree-list.sh       | 16 ++++++++++------
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index e0604b043361828f94b58f676a5ed4f15b116348..2bd8118852a97251fc1081d19ea=
9756428d190f4 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -428,16 +428,21 @@ $ git worktree list
=20
 For these annotations, a reason might also be available and this can be
 seen using the verbose mode. The annotation is then moved to the next line
-indented followed by the additional information.
+indented followed by the additional information. In verbose mode, the work=
tree
+id is also shown on the next line if available.
=20
 ------------
 $ git worktree list --verbose
 /path/to/linked-worktree              abcd1234 [master]
+=09id: linked-worktree-12345678
 /path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
+=09id: locked-worktree-no-reason-89765464
 /path/to/locked-worktree-with-reason  1234abcd (brancha)
 =09locked: worktree path is mounted on a portable device
+=09id: locked-worktree-with-reason-41564654
 /path/to/prunable-worktree            5678abc1 (detached HEAD)
 =09prunable: gitdir file points to non-existent location
+=09id: prunable-worktree-98454651
 ------------
=20
 Note that the annotation is moved to the next line if the additional
@@ -461,24 +466,29 @@ worktree /path/to/bare-source
 bare
=20
 worktree /path/to/linked-worktree
+id linked-worktree-12345678
 HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
 branch refs/heads/master
=20
 worktree /path/to/other-linked-worktree
+id other-linked-worktree-879456466
 HEAD 1234abc1234abc1234abc1234abc1234abc1234a
 detached
=20
 worktree /path/to/linked-worktree-locked-no-reason
+id locked-worktree-no-reason-89765464
 HEAD 5678abc5678abc5678abc5678abc5678abc5678c
 branch refs/heads/locked-no-reason
 locked
=20
 worktree /path/to/linked-worktree-locked-with-reason
+id locked-worktree-with-reason-41564654
 HEAD 3456def3456def3456def3456def3456def3456b
 branch refs/heads/locked-with-reason
 locked reason why is locked
=20
 worktree /path/to/linked-worktree-prunable
+id prunable-worktree-98454651
 HEAD 1233def1234def1234def1234def1234def1234b
 detached
 prunable gitdir file points to non-existent location
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 36235546b492803707707ff208b13fe777bff1b4..fca8a9cda51643e434b5f8905e3=
2e537c6b4418b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -944,6 +944,8 @@ static void show_worktree_porcelain(struct worktree *wt=
, int line_terminator)
 =09const char *reason;
=20
 =09printf("worktree %s%c", wt->path, line_terminator);
+=09if (!is_main_worktree(wt))
+=09=09printf("id %s%c", wt->id, line_terminator);
 =09if (wt->is_bare)
 =09=09printf("bare%c", line_terminator);
 =09else {
@@ -1009,6 +1011,9 @@ static void show_worktree(struct worktree *wt, int pa=
th_maxlen, int abbrev_len)
 =09else if (reason)
 =09=09strbuf_addstr(&sb, " prunable");
=20
+=09if (verbose && !is_main_worktree(wt))
+=09=09strbuf_addf(&sb, "\n\tid: %s", wt->id);
+
 =09printf("%s\n", sb.buf);
 =09strbuf_release(&sb);
 }
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 780daa6cd6351f8fa9434619cc212aade8f01420..502d35cabb837121d178937673b=
580cd767d17aa 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -56,8 +56,9 @@ test_expect_success '"list" all worktrees --porcelain' '
 =09echo "branch $(git symbolic-ref HEAD)" >>expect &&
 =09echo >>expect &&
 =09test_when_finished "rm -rf here actual expect && git worktree prune" &&
-=09git worktree add --detach here main &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D123 git worktree add --detach here main &&
 =09echo "worktree $(git -C here rev-parse --show-toplevel)" >>expect &&
+=09echo "id here-123" >>expect &&
 =09echo "HEAD $(git rev-parse HEAD)" >>expect &&
 =09echo "detached" >>expect &&
 =09echo >>expect &&
@@ -71,9 +72,10 @@ test_expect_success '"list" all worktrees --porcelain -z=
' '
 =09printf "worktree %sQHEAD %sQbranch %sQQ" \
 =09=09"$(git rev-parse --show-toplevel)" \
 =09=09$(git rev-parse HEAD --symbolic-full-name HEAD) >expect &&
-=09git worktree add --detach here main &&
-=09printf "worktree %sQHEAD %sQdetachedQQ" \
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree add --detach here main &&
+=09printf "worktree %sQid %sQHEAD %sQdetachedQQ" \
 =09=09"$(git -C here rev-parse --show-toplevel)" \
+=09=09"here-456" \
 =09=09"$(git rev-parse HEAD)" >>expect &&
 =09git worktree list --porcelain -z >_actual &&
 =09nul_to_q <_actual >actual &&
@@ -166,16 +168,17 @@ test_expect_success '"list" --verbose and --porcelain=
 mutually exclusive' '
 test_expect_success '"list" all worktrees --verbose with locked' '
 =09test_when_finished "rm -rf locked1 locked2 out actual expect && git wor=
ktree prune" &&
 =09git worktree add locked1 --detach &&
-=09git worktree add locked2 --detach &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git worktree add locked2 --detach &&
 =09git worktree lock locked1 &&
 =09test_when_finished "git worktree unlock locked1" &&
 =09git worktree lock locked2 --reason "with reason" &&
 =09test_when_finished "git worktree unlock locked2" &&
 =09echo "$(git -C locked2 rev-parse --show-toplevel) $(git rev-parse --sho=
rt HEAD) (detached HEAD)" >expect &&
 =09printf "\tlocked: with reason\n" >>expect &&
+=09printf "\tid: locked2-456\n" >>expect &&
 =09git worktree list --verbose >out &&
 =09grep "/locked1  *[0-9a-f].* locked$" out &&
-=09sed -n "s/  */ /g;/\/locked2  *[0-9a-f].*$/,/locked: .*$/p" <out >actua=
l &&
+=09sed -n "s/  */ /g;/\/locked2  *[0-9a-f].*$/,/id: .*$/p" <out >actual &&
 =09test_cmp actual expect
 '
=20
@@ -211,11 +214,12 @@ test_expect_success '"list" all worktrees from bare m=
ain' '
=20
 test_expect_success '"list" all worktrees --porcelain from bare main' '
 =09test_when_finished "rm -rf there actual expect && git -C bare1 worktree=
 prune" &&
-=09git -C bare1 worktree add --detach ../there main &&
+=09GIT_TEST_WORKTREE_SUFFIX=3D456 git -C bare1 worktree add --detach ../th=
ere main &&
 =09echo "worktree $(pwd)/bare1" >expect &&
 =09echo "bare" >>expect &&
 =09echo >>expect &&
 =09echo "worktree $(git -C there rev-parse --show-toplevel)" >>expect &&
+=09echo "id there-456" >>expect &&
 =09echo "HEAD $(git -C there rev-parse HEAD)" >>expect &&
 =09echo "detached" >>expect &&
 =09echo >>expect &&

--=20
2.47.0


