Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D7C4332F
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 22:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiDGWK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiDGWKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:24 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14EFD02
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:54:00 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id F337B5A3EF;
        Thu,  7 Apr 2022 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649368440;
        bh=GdN4t1Nz5HD/v1HvYj0+FKY9QXq91HQKGVBU/wwyg7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=B1i422pQXAWZ/hAbIBn8aGcKT71p/3cgrY+ShBllXPVkE8SSlNXX0zPKorPeOVIdC
         ZgZ6Sy8iqRVcETZDdDZZJ7tUaFZ44osFI+gmX71jMn+wIiDAwJXEGmN8UKILcOcQbz
         uFEMMLsWK8ebW8X/uQCTgkXYKbP3+KbDnxuadSlTud9KhCMZFT0FDUxGu3xshz4/XN
         bfFL3tsQdwIn+2EFJdhxNQMD4DmMvGd/rjdQLClt2hXYK58/EVPKaMB6pyF+FSGzW8
         sqJeNg07FWlQz/rBNuiNymbPAsGhymWRIv2r8jaE+Ib4WUoMeA+tTo5+5Lj2+XrDUh
         ELLiFgH0QCA5QarqdXzNMePSQW6ZxD3/Bbz8cPr1KYHKORyXb696ISzxj3PVYdxGiv
         RVN1MHO/W06cyVcMDinZnbsqOnMCxxW+dpJM8eVHMQHXq6KE8azrdI7AYiTnSkutSk
         lMT3LzyHxj9jo+YHURgBpCS6Pvr6CdY7MMDutJqAphQdwsJAYKs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/4] builtin/stash: factor out revision parsing into a function
Date:   Thu,  7 Apr 2022 21:53:50 +0000
Message-Id: <20220407215352.3491567-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220407215352.3491567-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We allow several special forms of stash names in this code.  In the
future, we'll want to allow these same forms without parsing a stash
commit, so let's refactor this code out into a function for reuse.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/stash.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 5897febfbe..b677739bcd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -130,6 +130,25 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
 		die(_("'%s' is not a stash-like commit"), revision);
 }
 
+static int parse_revision(struct strbuf *revision, const char *commit, int quiet)
+{
+	strbuf_reset(revision);
+	if (!commit) {
+		if (!ref_exists(ref_stash)) {
+			if (!quiet)
+				fprintf_ln(stderr, _("No stash entries found."));
+			return -1;
+		}
+
+		strbuf_addf(revision, "%s@{0}", ref_stash);
+	} else if (strspn(commit, "0123456789") == strlen(commit)) {
+		strbuf_addf(revision, "%s@{%s}", ref_stash, commit);
+	} else {
+		strbuf_addstr(revision, commit);
+	}
+	return 0;
+}
+
 static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 {
 	int ret;
@@ -158,18 +177,9 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 		commit = argv[0];
 
 	strbuf_init(&info->revision, 0);
-	if (!commit) {
-		if (!ref_exists(ref_stash)) {
-			free_stash_info(info);
-			fprintf_ln(stderr, _("No stash entries found."));
-			return -1;
-		}
-
-		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
-	} else if (strspn(commit, "0123456789") == strlen(commit)) {
-		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
-	} else {
-		strbuf_addstr(&info->revision, commit);
+	if (parse_revision(&info->revision, commit, 0)) {
+		free_stash_info(info);
+		return -1;
 	}
 
 	revision = info->revision.buf;
