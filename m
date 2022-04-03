Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B62C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 18:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359748AbiDCSYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359739AbiDCSYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 14:24:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C5344CF
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 11:22:55 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8FB545A3E9;
        Sun,  3 Apr 2022 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649010174;
        bh=CPomXpIHqKBhTF6pLDNs9s22y3itA/jk84LgRY+Fkc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kjc8503oKXrUPX6w8STLIp9YGAdHKfjShWUnQVb/f2H6cyvLajKAByJCUNOB36T/1
         4MEU/mQjrU7Df4KMW1NT9ESXqYiQ3BQmO95tXx6d8a0gfhqbf6BY1NUMVEsI5WQJm5
         lVDO8czM7a6IuC/+ZVHycTA3CTJNEUhwzJ97mLaHdL9VEPy+fhlCK72JKGqfu22Ng4
         tT7/KHpNoUvtTjlScZ0tfXYEMh/LeCZ65HT91K7tSPDhmyYaxcMyT+NqAFrwq54YMO
         V9KI4CUS/MIuU5BGaNuHo4ZOKa2Ydx6saHCTRHtRUGSpm1iCVCMfexsbn1swPKVr9/
         FO0lZ5RS9YqKDUM0MhSPBEQsQJ8CXzcrdku6b4MhUe3Kd7wFXcboB1+nmXnBn2NSwE
         9ZeCepOFFya0IJFR9/vccCIQ5cmorBdtouN3eKb5ZpllKpplP2T2zpLJ89sMafgd8q
         i9TX3tI+WLZsfo0m2CzM8IgQf3bF8VXjuSfs+jXavCYIN13X7WT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/4] builtin/stash: factor out revision parsing into a function
Date:   Sun,  3 Apr 2022 18:22:48 +0000
Message-Id: <20220403182250.904933-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220403182250.904933-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
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
 builtin/stash.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 5897febfbe..4c281a5781 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -130,6 +130,24 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
 		die(_("'%s' is not a stash-like commit"), revision);
 }
 
+static int parse_revision(struct strbuf *revision, const char *commit, int quiet)
+{
+	strbuf_init(revision, 0);
+	if (!commit) {
+		if (!ref_exists(ref_stash)) {
+			fprintf_ln(stderr, _("No stash entries found."));
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
@@ -157,19 +175,9 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	if (argc == 1)
 		commit = argv[0];
 
-	strbuf_init(&info->revision, 0);
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
