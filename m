Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5FEC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D828922D2B
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAWTyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:54:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62304 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWTyR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:54:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A4FAAFAA8;
        Sat, 23 Jan 2021 14:53:35 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=VC76cQcnidGrzNFXuqMVW3l3z
        Uw=; b=MoLkl5MWJiNY1FZGQrdTiOcSFfatQyZyWTBhAE+3iz2ZgGEpGCbSqP17h
        s0bTaAr26RwQiDUfctDbxPfr7jwuHkBXsxDjm1OhUA+nHCLRagE7JmfBsSQU6RPJ
        1/v8yIg1Higvn2d29H6VNu1ys8cGUe6pNaYNZK3FEnj9d2m9Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=JuEUPEbwUFmolnkVqtB
        Ppz+JmPjScnsIu6MJWmSh5l23vWkMRG45/KHQAiJydkQNu5Zx8szpFzdFDW91ol8
        4rFFzZr1549ELEyHzzZ8iUCkd0ruvBfnoRlnydUG3XaowqFSWrHglONJq3CjXLWR
        bYCBZjLPw4wrnNPhHtAAFNfs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7024AAFAA6;
        Sat, 23 Jan 2021 14:53:35 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC60FAFAA5;
        Sat, 23 Jan 2021 14:53:34 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     gitgitgadget@gmail.com, ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH v7 1/3] ls_files.c: bugfix for --deleted and --modified
Date:   Sat, 23 Jan 2021 11:53:32 -0800
Message-Id: <20210123195334.2970374-1-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-491-g302c625a7b
In-Reply-To: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: AD5FF9F4-5DB4-11EB-B9DA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

This situation may occur in the original code: lstat() failed
but we use `&st` to feed ie_modified() later.

Therefore, we can directly execute show_ce without the judgment of
ie_modified() when lstat() has failed.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
[jc: fixed misindented code]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b8..ce6f6ad00e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -335,7 +335,7 @@ static void show_files(struct repository *repo, struc=
t dir_struct *dir)
 		for (i =3D 0; i < repo->index->cache_nr; i++) {
 			const struct cache_entry *ce =3D repo->index->cache[i];
 			struct stat st;
-			int err;
+			int stat_err;
=20
 			construct_fullname(&fullname, repo, ce);
=20
@@ -346,10 +346,13 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
 				continue;
 			if (ce_skip_worktree(ce))
 				continue;
-			err =3D lstat(fullname.buf, &st);
-			if (show_deleted && err)
+			stat_err =3D lstat(fullname.buf, &st);
+			if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR))
+				error_errno("cannot lstat '%s'", fullname.buf);
+			if (stat_err && show_deleted)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
+			if (show_modified &&
+			    (stat_err || ie_modified(repo->index, ce, &st, 0)))
 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
--=20
2.30.0-491-g302c625a7b

