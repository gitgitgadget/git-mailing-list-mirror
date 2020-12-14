Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF48C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3732C21D42
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503192AbgLNU15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:27:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59105 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503226AbgLNU1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 15:27:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ACEC10D1C4;
        Mon, 14 Dec 2020 15:26:56 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=sV14A2od3IZ9n4ja+1tpapWNe
        hY=; b=lbLSsXZ8udY6hypNF8gX+4RMsKFhMgoqs85XZGbgbaQm0izcEWZmcX5kN
        386i7WgUr5BsqgO2kBELjVK7awpiZPe3nAQu0dqxrdCBOk2SszYkqKCnSAS1xZj2
        gL7UJv5s3btv4ZqsIeHz6rIzhfx6UPCwTVIBBTrfWjgy4mSYL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=TE/LmJ5eOZQhSUuAYG9
        kd8mZQ/vdEkm5DlKL7aSmRRQvWcyQ1WehsCbwEO3yTfoNoWf+n7eFAf5fYYaUEWY
        8Pe4fvpES2FGnM0OTO4JFHbVGqlf9T0hvGzk+hbrCSh3uPqxHh8mSW41TCh+Y4XJ
        xJ8HIVLnm70CIz3vTiurmszg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C46A10D1C3;
        Mon, 14 Dec 2020 15:26:56 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5AAA10D1BF;
        Mon, 14 Dec 2020 15:26:53 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v7 2/5] pull: give the advice for choosing rebase/merge much later
Date:   Mon, 14 Dec 2020 12:26:44 -0800
Message-Id: <20201214202647.3340193-3-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-rc0-186-g20447144ec
In-Reply-To: <20201214202647.3340193-1-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: B436ED2A-3E4A-11EB-A5F9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

Eventually we want to be omit the advice when we can fast-forward
in which case there is no reason to require the user to choose
between rebase or merge.

In order to do so, we need to delay giving the advice up to the
point where we can check if we can fast-forward or not.

Additionally, config_get_rebase() was probably never its true home.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 03e6d53243..ff8e3ce137 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,6 +27,8 @@
 #include "commit-reach.h"
 #include "sequencer.h"
=20
+static int default_mode;
+
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value=
 is
@@ -344,20 +346,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
=20
-	if (opt_verbosity >=3D 0 && !opt_ff) {
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
-	}
+	default_mode =3D 1;
=20
 	return REBASE_FALSE;
 }
@@ -1040,6 +1029,21 @@ int cmd_pull(int argc, const char **argv, const ch=
ar *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
=20
+	if (default_mode && opt_verbosity >=3D 0 && !opt_ff) {
+		advise(_("Pulling without specifying how to reconcile divergent branch=
es is\n"
+			 "discouraged. You can squelch this message by running one of the fol=
lowing\n"
+			 "commands sometime before your next pull:\n"
+			 "\n"
+			 "  git config pull.rebase false  # merge (the default strategy)\n"
+			 "  git config pull.rebase true   # rebase\n"
+			 "  git config pull.ff only       # fast-forward only\n"
+			 "\n"
+			 "You can replace \"git config\" with \"git config --global\" to set =
a default\n"
+			 "preference for all repositories. You can also pass --rebase, --no-r=
ebase,\n"
+			 "or --ff-only on the command line to override the configured default=
 per\n"
+			 "invocation.\n"));
+	}
+
 	if (opt_rebase) {
 		int ret =3D 0;
 		int ran_ff =3D 0;
--=20
2.30.0-rc0-186-g20447144ec

