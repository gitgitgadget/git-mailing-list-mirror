Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA0C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiC2Vvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiC2Vvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 17:51:37 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA934738F
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 14:49:52 -0700 (PDT)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E2D0C5A3DC;
        Tue, 29 Mar 2022 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1648590591;
        bh=CPomXpIHqKBhTF6pLDNs9s22y3itA/jk84LgRY+Fkc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=c0swXtFgqNWrZJjErmOFrOMwP8GL+G3f/4hmqDlAXlXhLNSDFPs0eoFWXH1V+0iiU
         s98RsBcRIluAisZHFmYW4tEB7SQq6cGkANGbOLL+BeMGsAn9XYP+WFmo2SBqskAItz
         sMyg2YighktY/d72ARgm+ykqvO4CTOfkoEXCnkc8qJSlwD2Aijd5q1X3L+63Hn5yLA
         FPGl2E62CHqhuJt44BoaY0nbxryaVWHHrt2VJmTVC+/1Trf1xuZmYLvbZ+9ts7r6md
         tDiipwDNXJCs3/AhF5SrcFSArHRr0jj0qcy0XoriEc93SG4+tmyg/9prco4vf+/CQJ
         FIWeOFe9nnnkY5Q0+0vgtR9kR9cr6Cd++q/vsq1U8oHQyCWe8bt/1+YmA+L/ihcc8t
         2dr7H5OEM7nez0/Bt/rPdP+0slKH25N6jn72k64zw3IYjfPlpzl+A7rxTUlC9BTPsZ
         CbRWOh2v2BM3R5RtzBprVRs6bxHi1ITfa8FiSWB2oK8yf5ZqQP0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] builtin/stash: factor out revision parsing into a function
Date:   Tue, 29 Mar 2022 21:49:39 +0000
Message-Id: <20220329214941.2018609-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220329214941.2018609-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
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
