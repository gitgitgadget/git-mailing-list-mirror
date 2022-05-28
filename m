Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21BBC433F5
	for <git@archiver.kernel.org>; Sat, 28 May 2022 23:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiE1XLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 19:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiE1XLc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 19:11:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3609126AE7
        for <git@vger.kernel.org>; Sat, 28 May 2022 16:11:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40A2D119628;
        Sat, 28 May 2022 19:11:30 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=/c1joYImmU8XlwWa/4KD3aEi4
        yT/h17zSCZ+KV8d/tQ=; b=oDP+gIGCYXmC7dtTFmt9tm0s9IeO8T4jnqA1x2Eme
        8V4c/yA2JHHMuqe1m46jR+4L323YQCEHjWB1V0VAk/GH+f8kif/OBWYGFlSY4eox
        fbzNSrwyrG4tCF3qwT+72e0lds0yvj9BllvcSOjfZOQZlTBQWkgm09CppClrmI4C
        XY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38D08119627;
        Sat, 28 May 2022 19:11:30 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D14C119626;
        Sat, 28 May 2022 19:11:29 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6+ 3/7] scalar: validate the optional enlistment argument
Date:   Sat, 28 May 2022 16:11:14 -0700
Message-Id: <20220528231118.3504387-4-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-385-g60203f3fdb
In-Reply-To: <20220528231118.3504387-1-gitster@pobox.com>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 81AF286C-DEDB-11EC-8342-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `scalar` command needs a Scalar enlistment for many subcommands, and
looks in the current directory for such an enlistment (traversing the
parent directories until it finds one).

These is subcommands can also be called with an optional argument
specifying the enlistment. Here, too, we traverse parent directories as
needed, until we find an enlistment.

However, if the specified directory does not even exist, or is not a
directory, we should stop right there, with an error message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/scalar/scalar.c          | 6 ++++--
 contrib/scalar/t/t9099-scalar.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 58ca0e56f1..6d58c7a698 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -43,9 +43,11 @@ static void setup_enlistment_directory(int argc, const=
 char **argv,
 		usage_with_options(usagestr, options);
=20
 	/* find the worktree, determine its corresponding root */
-	if (argc =3D=3D 1)
+	if (argc =3D=3D 1) {
 		strbuf_add_absolute_path(&path, argv[0]);
-	else if (strbuf_getcwd(&path) < 0)
+		if (!is_directory(path.buf))
+			die(_("'%s' does not exist"), path.buf);
+	} else if (strbuf_getcwd(&path) < 0)
 		die(_("need a working directory"));
=20
 	strbuf_trim_trailing_dir_sep(&path);
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-sc=
alar.sh
index 89781568f4..bb42354a8b 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -93,4 +93,9 @@ test_expect_success 'scalar supports -c/-C' '
 	test true =3D "$(git -C sub config core.preloadIndex)"
 '
=20
+test_expect_success '`scalar [...] <dir>` errors out when dir is missing=
' '
+	! scalar run config cloned 2>err &&
+	grep "cloned. does not exist" err
+'
+
 test_done
--=20
2.36.1-385-g60203f3fdb

