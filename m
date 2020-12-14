Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F19C2BB40
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320D122286
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502878AbgLNU2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:28:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50427 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503312AbgLNU1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 15:27:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 526B3A9C96;
        Mon, 14 Dec 2020 15:26:52 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=aIM9HvvFmJETyR6a09BMuhuqm
        Ak=; b=S5VjkUasZR7d//V4VxmgL2qp+JciK8QJuKDwQQkBKs5U5qvFrKXlf/kMf
        aVuVE9tfo+2LCrBrL8Juq0v73Zz0nZPDlwYgNyW0EKt9lNe8CHzCvhJwyHVJbprT
        XDITMtKmNCFoSLmw6Hm9BJ55J1V7YZrYsbn2lOeDIsCCdsq5II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=dMlTwD6qyi4JvinuIFQ
        a0f4JKlRMSGdjBkdT8WkSfiCQzMs+Wnar3lsRXQH2Nv+SFzgq6GpFNO3LX5kEdCH
        zcZrS5VeDKQNNZDqASGpAX1hff9l5w5ji48j3FG672rq9XGjRQl42zmfM0mlFgME
        rNee+X5T3xVYxeMAcC45oRyU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A719A9C95;
        Mon, 14 Dec 2020 15:26:52 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C47B3A9C94;
        Mon, 14 Dec 2020 15:26:51 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v7 1/5] pull: refactor fast-forward check
Date:   Mon, 14 Dec 2020 12:26:43 -0800
Message-Id: <20201214202647.3340193-2-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-rc0-186-g20447144ec
In-Reply-To: <20201214202647.3340193-1-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: B31952C0-3E4A-11EB-8FE5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

We would like to be able to make this check before the decision to
rebase is made in a future step.  Besides, using a separate helper
makes the code easier to follow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index aa56ebcdd0..03e6d53243 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -924,6 +924,20 @@ static int run_rebase(const struct object_id *newbas=
e,
 	return ret;
 }
=20
+static int get_can_ff(struct object_id *orig_head, struct object_id *ori=
g_merge_head)
+{
+	int ret;
+	struct commit_list *list =3D NULL;
+	struct commit *merge_head, *head;
+
+	head =3D lookup_commit_reference(the_repository, orig_head);
+	commit_list_insert(head, &list);
+	merge_head =3D lookup_commit_reference(the_repository, orig_merge_head)=
;
+	ret =3D repo_is_descendant_of(the_repository, merge_head, list);
+	free_commit_list(list);
+	return ret;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -1040,22 +1054,12 @@ int cmd_pull(int argc, const char **argv, const c=
har *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"))=
;
 		if (!autostash) {
-			struct commit_list *list =3D NULL;
-			struct commit *merge_head, *head;
-
-			head =3D lookup_commit_reference(the_repository,
-						       &orig_head);
-			commit_list_insert(head, &list);
-			merge_head =3D lookup_commit_reference(the_repository,
-							     &merge_heads.oid[0]);
-			if (repo_is_descendant_of(the_repository,
-						  merge_head, list)) {
+			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff =3D "--ff-only";
 				ran_ff =3D 1;
 				ret =3D run_merge();
 			}
-			free_commit_list(list);
 		}
 		if (!ran_ff)
 			ret =3D run_rebase(&newbase, &upstream);
--=20
2.30.0-rc0-186-g20447144ec

