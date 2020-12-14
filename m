Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F19C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904E1221EF
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502964AbgLNU2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:28:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61499 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503316AbgLNU1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 15:27:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABA7B93DD7;
        Mon, 14 Dec 2020 15:27:00 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=oilOWwehxT95ihjLN24qVBjKt
        M0=; b=Cqu+42LtPlqSXOjmJxIyQqhke4ev24mBMwy5wf8BIq8A6YqNR0bB0oHEt
        ASOqWu7/ycopf8Rxuu9YftelmMZLfSpkwy+Gr/5bIgpTxVBIf0xXq4pjTtBz6bPL
        H3UK2mucbExVYLqvtvZNin5E8MRCCRx/HghHeTGez3jCOuMuTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=EI6HwNGCwPzci4AiRqr
        TXS9d3CwQPCFNFLFGf/niHXM6YmLkvyS9sLhthhQnUprVUg7OHJe3/RhR2RlT17S
        qzobQTWqQbry/kIxJCs5Xs8tGK++7SyHEZQV5cQ3Bzcc7VE/rl0/Yx1g9yqIWKwe
        yJcQRbHOCYtIENVLkabSkXfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 510FE93DD6;
        Mon, 14 Dec 2020 15:27:00 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A780093DD5;
        Mon, 14 Dec 2020 15:26:59 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v7 4/5] pull: correct condition to trigger non-ff advice
Date:   Mon, 14 Dec 2020 12:26:46 -0800
Message-Id: <20201214202647.3340193-5-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-rc0-186-g20447144ec
In-Reply-To: <20201214202647.3340193-1-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: B7CBFFAC-3E4A-11EB-B8FA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the advise() call that teaches users how they can choose
between merge and rebase into a helper function.  This revealed that
the caller's logic needs to be further clarified to allow future
actions (like "erroring out" instead of the current "go ahead and
merge anyway") that should happen whether the advice message is
squelched out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 2976b8e5cb..1b87ea95eb 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -925,6 +925,22 @@ static int get_can_ff(struct object_id *orig_head, s=
truct object_id *orig_merge_
 	return ret;
 }
=20
+static void show_advice_pull_non_ff(void)
+{
+	advise(_("Pulling without specifying how to reconcile divergent branche=
s is\n"
+		 "discouraged. You can squelch this message by running one of the foll=
owing\n"
+		 "commands sometime before your next pull:\n"
+		 "\n"
+		 "  git config pull.rebase false  # merge (the default strategy)\n"
+		 "  git config pull.rebase true   # rebase\n"
+		 "  git config pull.ff only       # fast-forward only\n"
+		 "\n"
+		 "You can replace \"git config\" with \"git config --global\" to set a=
 default\n"
+		 "preference for all repositories. You can also pass --rebase, --no-re=
base,\n"
+		 "or --ff-only on the command line to override the configured default =
per\n"
+		 "invocation.\n"));
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -1028,19 +1044,9 @@ int cmd_pull(int argc, const char **argv, const ch=
ar *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
=20
-	if (rebase_unspecified && opt_verbosity >=3D 0 && !opt_ff) {
-		advise(_("Pulling without specifying how to reconcile divergent branch=
es is\n"
-			 "discouraged. You can squelch this message by running one of the fol=
lowing\n"
-			 "commands sometime before your next pull:\n"
-			 "\n"
-			 "  git config pull.rebase false  # merge (the default strategy)\n"
-			 "  git config pull.rebase true   # rebase\n"
-			 "  git config pull.ff only       # fast-forward only\n"
-			 "\n"
-			 "You can replace \"git config\" with \"git config --global\" to set =
a default\n"
-			 "preference for all repositories. You can also pass --rebase, --no-r=
ebase,\n"
-			 "or --ff-only on the command line to override the configured default=
 per\n"
-			 "invocation.\n"));
+	if (rebase_unspecified && !opt_ff) {
+		if (opt_verbosity >=3D 0)
+			show_advice_pull_non_ff();
 	}
=20
 	if (opt_rebase) {
--=20
2.30.0-rc0-186-g20447144ec

