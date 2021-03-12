Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43BCC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 03:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78D064F78
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 03:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCLDBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 22:01:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58464 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCLDBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 22:01:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4532EBF768;
        Thu, 11 Mar 2021 22:01:12 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=yKP64XlU704jsFPEPY9LhjxfN
        z0=; b=VmjX744vi9qSgxw04Gh2G4HEhzhp88CaJkRL6OceUStV64cfBt3q9oqqY
        c7eh3KyG6fgQ+358xaX8OpWgnRwPV55EOKNUdWFr4oQ/vbTiM8pkijkDIsZmeibV
        N40pJxKPb1JhH2jLtq9qUFpUDFIvR/ATLDkoyVx8nXZtTqQyG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=ORpfNJETDT0QBy+9vx2
        LzwbdXQdBJdSBhgQPB41sqthaa9qJTh5ccbAA53uaS8e8Q6tCs2U+qOz8YxDdA5S
        ZxN+mj7eO0MaNfRTBmv4BfOWl87E1nB378JjUJChTMLgQCEV4q4PQ4MtVmFei2Qv
        Hrsa5QbyCH71pogOqjIfBjM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D8A4BF767;
        Thu, 11 Mar 2021 22:01:12 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5A2BBF766;
        Thu, 11 Mar 2021 22:01:11 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] sequencer.c: make commit_post_rewrite() take two object names
Date:   Thu, 11 Mar 2021 19:01:06 -0800
Message-Id: <20210312030107.1849942-2-gitster@pobox.com>
X-Mailer: git-send-email 2.31.0-rc2-175-g3820f1c72e
In-Reply-To: <20210312030107.1849942-1-gitster@pobox.com>
References: <xmqq8s6tcuxc.fsf@gitster.g>
 <20210312030107.1849942-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 337F3CD0-82DF-11EB-8DD0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper function is to copy notes between two commits by taking
the original one and a new one that is supposed to be a rewrite of
the original one.  It somehow takes "struct commit *" for the former
but "struct object_id *" for the latter, but what it does does not
need access to the in-core commit object.

Change the function to take two "struct object_id *" instead.

As we require "struct object_id *" for the original commit now,
the comment on the old "struct commit *" that must be non-NULL
which made taking the address of its object.oid member safe no
longer is relevant to this function (it is the caller's concern
now), so remove it.  Two callers we have are of course safe, and
there is no reason to call this "as we rewrote A to B, please copy
notes on A to B, too" helper if the caller knows A is NULL, so
the comment would have very little value even if it were kept.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 6 +++---
 sequencer.c      | 9 ++++-----
 sequencer.h      | 2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7..f2fbef053e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1702,9 +1702,9 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
-	if (amend && !no_post_rewrite) {
-		commit_post_rewrite(the_repository, current_head, &oid);
-	}
+	if (amend && !no_post_rewrite)
+		commit_post_rewrite(the_repository, &current_head->object.oid, &oid);
+
 	if (!quiet) {
 		unsigned int flags =3D 0;
=20
diff --git a/sequencer.c b/sequencer.c
index d2332d3e17..92a4871997 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1175,18 +1175,17 @@ static int run_rewrite_hook(const struct object_i=
d *oldoid,
 }
=20
 void commit_post_rewrite(struct repository *r,
-			 const struct commit *old_head,
+			 const struct object_id *old_head,
 			 const struct object_id *new_head)
 {
 	struct notes_rewrite_cfg *cfg;
=20
 	cfg =3D init_copy_notes_for_rewrite("amend");
 	if (cfg) {
-		/* we are amending, so old_head is not NULL */
-		copy_note_for_rewrite(cfg, &old_head->object.oid, new_head);
+		copy_note_for_rewrite(cfg, old_head, new_head);
 		finish_copy_notes_for_rewrite(r, cfg, "Notes added by 'git commit --am=
end'");
 	}
-	run_rewrite_hook(&old_head->object.oid, new_head);
+	run_rewrite_hook(old_head, new_head);
 }
=20
 static int run_prepare_commit_msg_hook(struct repository *r,
@@ -1538,7 +1537,7 @@ static int try_to_commit(struct repository *r,
=20
 	run_commit_hook(0, r->index_file, "post-commit", NULL);
 	if (flags & AMEND_MSG)
-		commit_post_rewrite(r, current_head, oid);
+		commit_post_rewrite(r, &current_head->object.oid, oid);
=20
 out:
 	free_commit_extra_headers(extra);
diff --git a/sequencer.h b/sequencer.h
index f8b2e4ab85..79eed55c4b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -192,7 +192,7 @@ int update_head_with_reflog(const struct commit *old_=
head,
 			    const char *action, const struct strbuf *msg,
 			    struct strbuf *err);
 void commit_post_rewrite(struct repository *r,
-			 const struct commit *current_head,
+			 const struct object_id *old_head,
 			 const struct object_id *new_head);
=20
 void create_autostash(struct repository *r, const char *path,
--=20
2.31.0-rc2-175-g3820f1c72e

