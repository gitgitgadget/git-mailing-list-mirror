Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9E01F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGIUiF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:38:05 -0400
Received: from hel.is.scarlet.be ([193.74.71.26]:51141 "EHLO hel.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932938AbeGIUiB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1531168655;
        bh=zd+ZeznGUllf1jky40Mohy9JxkT3QnAthYGHm6SdDmM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=qMNbU1h+a5YWZ0VhgtbjQMcgpL/VIWdeKwZt/acqXn/6oZsEd44O4dCy9ovTiHNkm
         jH6nPLmEBfX8I88VSTCwSos/xKscbxhoH+LAI6xN1FZhvAdmt5kdv7JSsgOUmJG4WV
         pDLGWBcJCypCe5x2GFT7ROgQ/1zwaF9oRq56nhPg=
Received: from localhost.localdomain (ip-62-235-173-141.dsl.scarlet.be [62.235.173.141])
        by hel.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w69KbYU4009908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Jul 2018 22:37:35 +0200
X-Scarlet: d=1531168655 c=62.235.173.141
From:   Kim Gybels <kgybels@infogroep.be>
To:     git@vger.kernel.org
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Adam Borowski <kilobyte@angband.pl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3] gc --auto: release pack files before auto packing
Date:   Mon,  9 Jul 2018 22:37:27 +0200
Message-Id: <20180709203727.8236-1-kgybels@infogroep.be>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180704201600.9908-1-kgybels@infogroep.be>
References: <20180704201600.9908-1-kgybels@infogroep.be>
X-DCC-scarlet.be-Metrics: hel 20002; Body=10 Fuz1=10 Fuz2=10
X-Virus-Scanned: clamav-milter 0.98.1-exp at hel
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach gc --auto to release pack files before auto packing the repository
to prevent failures when removing them.

Also teach the test 'fetching with auto-gc does not lock up' to complain
when it is no longer triggering an auto packing of the repository.

Fixes https://github.com/git-for-windows/git/issues/500

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---

Changes since v2:
- revert fix back to v1: use close_all_packs instead of repo_clear
- use test_i18ngrep only for translated string

 builtin/gc.c     | 1 +
 t/t5510-fetch.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..63b62ab57c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -612,6 +612,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		return -1;
 
 	if (!repository_format_precious_objects) {
+		close_all_packs(the_repository->objects);
 		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
 			return error(FAILED_RUN, repack.argv[0]);
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e402aee6a2..6f1450eb69 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -828,9 +828,11 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	test_commit test2 &&
 	(
 		cd auto-gc &&
+		git config fetch.unpackLimit 1 &&
 		git config gc.autoPackLimit 1 &&
 		git config gc.autoDetach false &&
 		GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
+		test_i18ngrep "Auto packing the repository" fetch.out &&
 		! grep "Should I try again" fetch.out
 	)
 '
-- 
2.18.0.windows.1

