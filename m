Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3280AC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF69B22D50
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbhAWTyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:54:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54865 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWTyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:54:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8126211963D;
        Sat, 23 Jan 2021 14:53:39 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ylicHoVi4kM2XHszt0qxKhhGp
        tE=; b=yIkr8GcPyVysupPIZvO/cpgup5wtZzVeVyqxiLeeb4g4Z5lNkTfoLvc+b
        GgHuLAgG/TQibDVxehyK3MmsKa6JVQqow474PIsURUMXAu8OoeFoVZ59QrCM3QVi
        Qjr+M0nt4+nQlQw+z2GBv6/gPVPgaaqC3yAYrzFmnKAz2ds2k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=B5r5gD9gEOSBqzKQ1nh
        JYkWWm7kcof5GvZ7aNq6QoT3uKLXVlS1UkF+2mlmlD+454pRhIA9hop9MXCG0ZOY
        shCQVwYGn7MMV4Rete+yY0TyW0hg6akpl5GNPCONXZzEzyKfLgNekj5/6z86YmFX
        5frEgRqtZFMcVywDioKjI7q4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A62C11963C;
        Sat, 23 Jan 2021 14:53:39 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C673C11963B;
        Sat, 23 Jan 2021 14:53:36 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     gitgitgadget@gmail.com, ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH v7 2/3] ls_files.c: consolidate two for loops into one
Date:   Sat, 23 Jan 2021 11:53:33 -0800
Message-Id: <20210123195334.2970374-2-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-491-g302c625a7b
In-Reply-To: <20210123195334.2970374-1-gitster@pobox.com>
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
 <20210123195334.2970374-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: AE835894-5DB4-11EB-B5DE-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

This will make it easier to show only one entry per filename in the
next step.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
[jc: corrected the log message]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 63 ++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index ce6f6ad00e..e94d724aff 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -312,49 +312,40 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
 		if (show_killed)
 			show_killed_files(repo->index, dir);
 	}
-	if (show_cached || show_stage) {
-		for (i =3D 0; i < repo->index->cache_nr; i++) {
-			const struct cache_entry *ce =3D repo->index->cache[i];
=20
-			construct_fullname(&fullname, repo, ce);
+	if (!(show_cached || show_stage || show_deleted || show_modified))
+		return;
+	for (i =3D 0; i < repo->index->cache_nr; i++) {
+		const struct cache_entry *ce =3D repo->index->cache[i];
+		struct stat st;
+		int stat_err;
=20
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, repo->index, fullname.buf, ce))
-				continue;
-			if (show_unmerged && !ce_stage(ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
+		construct_fullname(&fullname, repo, ce);
+
+		if ((dir->flags & DIR_SHOW_IGNORED) &&
+			!ce_excluded(dir, repo->index, fullname.buf, ce))
+			continue;
+		if (ce->ce_flags & CE_UPDATE)
+			continue;
+		if ((show_cached || show_stage) &&
+		    (!show_unmerged || ce_stage(ce)))
 			show_ce(repo, dir, ce, fullname.buf,
 				ce_stage(ce) ? tag_unmerged :
 				(ce_skip_worktree(ce) ? tag_skip_worktree :
 				 tag_cached));
-		}
-	}
-	if (show_deleted || show_modified) {
-		for (i =3D 0; i < repo->index->cache_nr; i++) {
-			const struct cache_entry *ce =3D repo->index->cache[i];
-			struct stat st;
-			int stat_err;
-
-			construct_fullname(&fullname, repo, ce);
=20
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, repo->index, fullname.buf, ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			if (ce_skip_worktree(ce))
-				continue;
-			stat_err =3D lstat(fullname.buf, &st);
-			if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR))
-				error_errno("cannot lstat '%s'", fullname.buf);
-			if (stat_err && show_deleted)
-				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified &&
-			    (stat_err || ie_modified(repo->index, ce, &st, 0)))
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
-		}
+		if (!(show_deleted || show_modified))
+			continue;
+		if (ce_skip_worktree(ce))
+			continue;
+		stat_err =3D lstat(fullname.buf, &st);
+		if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR))
+			error_errno("cannot lstat '%s'", fullname.buf);
+		if (stat_err && show_deleted)
+			show_ce(repo, dir, ce, fullname.buf, tag_removed);
+		if (show_modified &&
+		    (stat_err || ie_modified(repo->index, ce, &st, 0)))
+			show_ce(repo, dir, ce, fullname.buf, tag_modified);
 	}
=20
 	strbuf_release(&fullname);
--=20
2.30.0-491-g302c625a7b

