Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8857CC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359308AbiELWvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359296AbiELWvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:51:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7B60D86
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:51:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 912941A0439;
        Thu, 12 May 2022 18:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hz3v5neatM+I
        BRKxTjkfXxvdp6cfPbwWgfu1wMhGYPI=; b=Emc5LAfRHaDKKXHqTf9yGrGG5KLz
        dL969j5hjnvopfosgwk+RBLzc5R5bHIYpo0tDZ1Q7xrdLNbZCQwOgoWPMsW7vQ7R
        Q0RH1m5NYGN+quLRh/pMKP3l6mJKb8X0xSo5o0HAIJ8ahMtCr2E2oY5nkzk3uZij
        Lu1RSMWBTPyi71c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89A921A0438;
        Thu, 12 May 2022 18:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 384D71A0437;
        Thu, 12 May 2022 18:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] commit: fix "author_ident" leak
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
Date:   Thu, 12 May 2022 15:51:07 -0700
In-Reply-To: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 16 Feb
 2022 09:21:04 +0100")
Message-ID: <xmqqzgjmcqlg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03A69C62-D246-11EC-9119-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4c28e4ada03 (commit: die before asking to edit the log
message, 2010-12-20), we have been "leaking" the "author_ident" when
prepare_to_commit() fails.  Instead of returning from right there,
introduce an exit status variable and jump to the clean-up label
at the end.

Instead of explicitly releasing the resource with strbuf_release(),
mark the variable with UNLEAK() at the end, together with two other
variables that are already marked as such.  If this were in a
utility function that is called number of times, but these are
different, we should explicitly release resources that grow
proportionally to the size of the problem being solved, but
cmd_commit() is like main() and there is no point in spending extra
cycles to release individual pieces of resource at the end, just
before process exit will clean everything for us for free anyway.

This fixes a leak demonstrated by e.g. "t3505-cherry-pick-empty.sh",
but unfortunately we cannot mark it or other affected tests as passing
now with "TEST_PASSES_SANITIZE_LEAK=3Dtrue" as we'll need to fix many
other memory leaks before doing so.

Incidentally there are two tests that always passes the leak checker
with or without this change.  Mark them as such.

This is based on an earlier patch by =C3=86var, but takes a different
approach that is more maintainable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c                 | 9 ++++++---
 t/t2203-add-intent.sh            | 1 +
 t/t7011-skip-worktree-reading.sh | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b9ed0374e3..4e8b3d3251 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1688,6 +1688,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	struct commit *current_head =3D NULL;
 	struct commit_extra_header *extra =3D NULL;
 	struct strbuf err =3D STRBUF_INIT;
+	int ret =3D 0;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1722,8 +1723,9 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	   running hooks, writing the trees, and interacting with the user.  */
 	if (!prepare_to_commit(index_file, prefix,
 			       current_head, &s, &author_ident)) {
+		ret =3D 1;
 		rollback_index_files();
-		return 1;
+		goto cleanup;
 	}
=20
 	/* Determine parents */
@@ -1821,7 +1823,6 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
-	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
=20
 	if (update_head_with_reflog(current_head, &oid, reflog_msg, &sb,
@@ -1862,7 +1863,9 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
=20
 	apply_autostash(git_path_merge_autostash(the_repository));
=20
+cleanup:
+	UNLEAK(author_ident);
 	UNLEAK(err);
 	UNLEAK(sb);
-	return 0;
+	return ret;
 }
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index db7ca55998..ebf58db2d1 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Intent to add'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'intent to add' '
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-rea=
ding.sh
index 1761a2b1b9..4adac5acd5 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'skip-worktree bit test'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 cat >expect.full <<EOF
--=20
2.36.1-338-g1c7f76a54c

