Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D56C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127EB2226A
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503145AbgLNU2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:28:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56830 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503317AbgLNU1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 15:27:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B1CAA9C9E;
        Mon, 14 Dec 2020 15:27:01 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=uYw5/HbGkNxvemBvndopmIZaE
        Mg=; b=JlQNzFwxi609QguxhNMHJ37wgu3SrzdZgnITM37ijQroDxOAuzGCCnVse
        lvCQC5546vktuQS3n1ywnETKg5fnJnPEIzK6kSp7YW9gWVIsSYUWub2IEl4cCA0d
        lF17L9PkdHgKlnI4w6vRP9/F3b0ipeSilmW3bXv5IDxdMPrNQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=LP3FMQhkNn1G4CV95gM
        T7iiLpoABEGXet62klbDSVFduzEx4dh7Wt93k6QN31O1XqdtnLaSqXGNTRFNry+n
        0gnifJntZ2Jmfxvug5jx+ANF8I5tMwSJMITfMSxsRtihEuaj27BzTyIDRXtjrQ09
        rj5Xvwvri6qh7YNhevul+LAU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FE19A9C9D;
        Mon, 14 Dec 2020 15:27:01 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 990B0A9C9C;
        Mon, 14 Dec 2020 15:27:00 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v7 5/5] pull: display default warning only when non-ff
Date:   Mon, 14 Dec 2020 12:26:47 -0800
Message-Id: <20201214202647.3340193-6-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-rc0-186-g20447144ec
In-Reply-To: <20201214202647.3340193-1-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: B85B8172-3E4A-11EB-B494-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

The current warning tests still pass, but not because of the arguments
or the configuration, but because they are all fast-forward.

We need to test non-fast-forward situations now.

Suggestions-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c               |  7 ++--
 t/t7601-merge-pull-config.sh | 66 +++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1b87ea95eb..e8927fc2ff 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -949,6 +949,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 	struct object_id rebase_fork_point;
 	int autostash;
 	int rebase_unspecified =3D 0;
+	int can_ff;
=20
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1044,7 +1045,9 @@ int cmd_pull(int argc, const char **argv, const cha=
r *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
=20
-	if (rebase_unspecified && !opt_ff) {
+	can_ff =3D get_can_ff(&orig_head, &merge_heads.oid[0]);
+
+	if (rebase_unspecified && !opt_ff && !can_ff) {
 		if (opt_verbosity >=3D 0)
 			show_advice_pull_non_ff();
 	}
@@ -1063,7 +1066,7 @@ int cmd_pull(int argc, const char **argv, const cha=
r *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"))=
;
 		if (!autostash) {
-			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+			if (can_ff) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff =3D "--ff-only";
 				ran_ff =3D 1;
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6774e9d86f..52e8ccc933 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -29,11 +29,8 @@ test_expect_success 'setup' '
=20
 test_expect_success 'pull.rebase not set' '
 	git reset --hard c0 &&
-	git -c color.advice=3Dalways pull . c1 2>err &&
-	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "Pulling without specifying how to reconcile" decoded
-
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
=20
 test_expect_success 'pull.rebase not set and pull.ff=3Dtrue' '
@@ -87,6 +84,65 @@ test_expect_success 'pull.rebase not set and --ff-only=
 given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
=20
+test_expect_success 'pull.rebase not set (not-fast-forward)' '
+	git reset --hard c2 &&
+	git -c color.advice=3Dalways pull . c1 2>err &&
+	test_decode_color <err >decoded &&
+	test_i18ngrep "<YELLOW>hint: " decoded &&
+	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=3Dtrue (not-fast-fo=
rward)' '
+	git reset --hard c2 &&
+	test_config pull.ff true &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=3Dfalse (not-fast-f=
orward)' '
+	git reset --hard c2 &&
+	test_config pull.ff false &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=3Donly (not-fast-fo=
rward)' '
+	git reset --hard c2 &&
+	test_config pull.ff only &&
+	test_must_fail git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --rebase given (not-fast-fo=
rward)' '
+	git reset --hard c2 &&
+	git pull --rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-rebase given (not-fast=
-forward)' '
+	git reset --hard c2 &&
+	git pull --no-rebase . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --ff given (not-fast-forwar=
d)' '
+	git reset --hard c2 &&
+	git pull --ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-ff given (not-fast-for=
ward)' '
+	git reset --hard c2 &&
+	git pull --no-ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --ff-only given (not-fast-f=
orward)' '
+	git reset --hard c2 &&
+	test_must_fail git pull --ff-only . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
--=20
2.30.0-rc0-186-g20447144ec

