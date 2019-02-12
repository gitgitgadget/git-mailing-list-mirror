Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166431F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBLBX0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34260 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfBLBXV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:21 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 50D0360898;
        Tue, 12 Feb 2019 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934599;
        bh=xY01/f579AhsVZN/bnBj89/b9ShunR77xSLUR7h63b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PrkBM3bmEihV+o0AzY1NLMgs24iANEWXjo/YYSjZmWL+J4eew4FPmfz/wYyOkjliV
         OeUI7C6L5cof8wGxDkoOlZnpgyRIm0U4wzRQZfzdIjL9Ij6AuPNZetjaXin2Qiqy/k
         QIAgQoUuIVMi37maIEKP+UjKBdFzxsQlKFI3Py/zFysEnruuVALATGnFKt0Sp0HAHN
         fFEAcZLG943RahruRtNfDCdY7Rb11dTR9tyxj5AU9USzlyfFCL+af8ZVltMCI9g8Zi
         FM92BIqfQRbx26uQ9U/wtEo15tqAKMEvhQaaGtc3RBmjM1x9V902txuMCxzxbtgvaz
         FYtpZ/st/f1aBwLzekJFYqV1Tu+wPB95HN/ZYgDgp5INYSUTe0PqpSoL9Ut3Cvm31N
         G0idCndVZeuknA3IlqP0zHXZ/v71ruXBVWUmsdfuWzoEYCpRjR9ckv3QzrJJkGmRF2
         Rfyh8cVILENKavncFbEPRgUr45niIsYlEqjX9vqjl+EbcfuWMpH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 06/31] submodule: avoid hard-coded constants
Date:   Tue, 12 Feb 2019 01:22:31 +0000
Message-Id: <20190212012256.1005924-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using hard-coded 40-based constants, express these values in
terms of the_hash_algo and GIT_MAX_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 merge-recursive.c | 2 +-
 submodule.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4851825aeb..b8bd5d4f8d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1122,7 +1122,7 @@ static int find_first_merges(struct repository *repo,
 	struct commit *commit;
 	int contains_another;
 
-	char merged_revision[42];
+	char merged_revision[GIT_MAX_HEXSZ + 2];
 	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
 				   "--all", merged_revision, NULL };
 	struct rev_info revs;
diff --git a/submodule.c b/submodule.c
index 934ecfa294..0e2faaa41b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -990,7 +990,7 @@ static int submodule_needs_pushing(struct repository *r,
 		if (start_command(&cp))
 			die("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s",
 					path);
-		if (strbuf_read(&buf, cp.out, 41))
+		if (strbuf_read(&buf, cp.out, the_hash_algo->hexsz + 1))
 			needs_pushing = 1;
 		finish_command(&cp);
 		close(cp.out);
