Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B001F954
	for <e@80x24.org>; Fri, 17 Aug 2018 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeHQMT4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 08:19:56 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:40890 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbeHQMT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 08:19:56 -0400
Received: from localhost.localdomain (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 48FBA335D8F;
        Fri, 17 Aug 2018 09:17:17 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH] gpg-interface.c: Fix potentially freeing NULL values
Date:   Fri, 17 Aug 2018 11:17:10 +0200
Message-Id: <20180817091710.1767-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix signature_check_clear() to free only values that are non-NULL.  This
especially applies to 'key' and 'signer' members that can be NULL during
normal operations, depending on exact GnuPG output.  While at it, also
allow other members to be NULL to make the function easier to use,
even if there is no real need to account for that right now.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 gpg-interface.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 35c25106a..9aedaf464 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -15,9 +15,14 @@ static const char *gpg_program = "gpg";
 void signature_check_clear(struct signature_check *sigc)
 {
-	FREE_AND_NULL(sigc->payload);
-	FREE_AND_NULL(sigc->gpg_output);
-	FREE_AND_NULL(sigc->gpg_status);
-	FREE_AND_NULL(sigc->signer);
-	FREE_AND_NULL(sigc->key);
+	if (sigc->payload)
+		FREE_AND_NULL(sigc->payload);
+	if (sigc->gpg_output)
+		FREE_AND_NULL(sigc->gpg_output);
+	if (sigc->gpg_status)
+		FREE_AND_NULL(sigc->gpg_status);
+	if (sigc->signer)
+		FREE_AND_NULL(sigc->signer);
+	if (sigc->key)
+		FREE_AND_NULL(sigc->key);
 }
 
-- 
2.18.0

