Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4C81F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 20:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeGDUQ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 16:16:28 -0400
Received: from hel.is.scarlet.be ([193.74.71.26]:27138 "EHLO hel.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeGDUQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 16:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1530735369;
        bh=8HVcYsgnK5w+vz5jsXCogaMFaNVf5qoWChPrIhVAcHc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=pGjut0/zRMhSEQuNgTJcK6uK4W2lkrI1/hRivDL2qpKWs2JjKkbHSn4D2vC6qDnj/
         SLh74KlmAFqN9wtcFCuDem59kMGl4q+Wp6tiFAkYFsyBiwJgqm+9O8j8Ibutu+Db6q
         NqNXy2kRl+PZqxjjTe1Vvo4SDlFs49g+A3TsEPTM=
Received: from localhost.localdomain (ip-213-49-0-206.dsl.scarlet.be [213.49.0.206])
        by hel.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w64KG7jN023063
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 4 Jul 2018 22:16:08 +0200
X-Scarlet: d=1530735368 c=213.49.0.206
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
Subject: [PATCH v2] gc --auto: clear repository before auto packing
Date:   Wed,  4 Jul 2018 22:16:00 +0200
Message-Id: <20180704201600.9908-1-kgybels@infogroep.be>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180630133822.4580-1-kgybels@infogroep.be>
References: <20180630133822.4580-1-kgybels@infogroep.be>
X-DCC-scarlet.be-Metrics: hel 20001; Body=11 Fuz1=11 Fuz2=11
X-Virus-Scanned: clamav-milter 0.98.1-exp at hel
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach gc --auto to clear the repository before auto packing it to
prevent failures when removing files on Windows.

Also teach the test 'fetching with auto-gc does not lock up' to complain
when it is no longer triggering an auto packing of the repository.

Fixes https://github.com/git-for-windows/git/issues/500

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
---

Updated after Duy Nguyen's comments:
- use repo_clear instead of close_all_packs, and add the call in
  gc_before_repack intead of just before executing git repack
- use test_i18ngrep instead of grep in updated test

 builtin/gc.c     | 7 +++++++
 t/t5510-fetch.sh | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..22a6fc4863 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -473,6 +473,13 @@ static int report_last_gc_error(void)
 
 static int gc_before_repack(void)
 {
+	/*
+	 * Shut down everything, we should have all the info we need
+	 * at this point. Leaving some file descriptors open may
+	 * prevent them from being removed on Windows.
+	 */
+	repo_clear(the_repository);
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e402aee6a2..ef599c11cd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -828,10 +828,12 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	test_commit test2 &&
 	(
 		cd auto-gc &&
+		git config fetch.unpackLimit 1 &&
 		git config gc.autoPackLimit 1 &&
 		git config gc.autoDetach false &&
 		GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
-		! grep "Should I try again" fetch.out
+		test_i18ngrep "Auto packing the repository" fetch.out &&
+		test_i18ngrep ! "Should I try again" fetch.out
 	)
 '
 
-- 
2.18.0.windows.1

