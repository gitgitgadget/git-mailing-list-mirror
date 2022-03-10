Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB3C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbiCJRg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiCJRgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6D518A783
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:35:22 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7BAA65A106;
        Thu, 10 Mar 2022 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646933721;
        bh=ffTBjIq2TATxaKesvFVM7WoW68LWkYhRoAEgMcYi+mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FC/KZ+GtWuyl04ff4aEoGV6bzVaszmF2pJERru6ZKwLVNTMdV8rz/7QxpFo1q/6XQ
         PlVLz2miqH+2EfqF0JeZa1sxsgfPzeSvURd+iYSZYiAuJWprqioJpHyNbAlZSfq2E/
         3c8bwOjW77hjgRl0G2E6hBBVfoarN3zILVrEd7gX0pVKkrWp5Mg8in9UBf1/f2H1+Y
         Cqrqkug3B5gEhFy1+tYK4KDYNyZBUjFlVPaEg9px1U7DKjAYkgd9u2Q6YvQ7tt92tR
         xLm29a3UvN8NazwkCM4QYINdELeKeg/bZyBfp1CIbJ4jXEIc2S/8BOPbxnGbH6xtei
         zWXTVpyRRmoCD67joQcS6vddRxNt3TRrTuO6KtoO85BahUjjeTMgtJwLVj88l4KYkY
         dfCnaVPZ+6N+dGuy5WWFVfT7A9Qxik33rygygcS1bnAkJk9qtqIw0Z3BJtCxUilW2w
         /VBrJyrY8vKvuUEkSOk/nw2W8g03Sabd8nHPG3VYuszGWckFQK6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/6] builtin/stash: factor out generic function to look up stash info
Date:   Thu, 10 Mar 2022 17:32:31 +0000
Message-Id: <20220310173236.4165310-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a function called get_stash_info that looks up this data based
on a set of command-line arguments and produces diagnostics to the user
on failure.  While this is helpful in the existing use cases, we'd like
to make use of this logic in a more programmatic way in the future.

Split out much of the function into a function which can be used
internally and which knows how to suppress these error messages with a
quiet parameter.  Wire up the rest of the function to call this internal
function to preserve the existing behavior.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/stash.c | 50 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 5897febfbe..2aa06cc91d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -130,38 +130,21 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
 		die(_("'%s' is not a stash-like commit"), revision);
 }
 
-static int get_stash_info(struct stash_info *info, int argc, const char **argv)
+static int get_stash_info_1(struct stash_info *info, const char *commit, int quiet)
 {
 	int ret;
 	char *end_of_rev;
 	char *expanded_ref;
 	const char *revision;
-	const char *commit = NULL;
 	struct object_id dummy;
 	struct strbuf symbolic = STRBUF_INIT;
 
-	if (argc > 1) {
-		int i;
-		struct strbuf refs_msg = STRBUF_INIT;
-
-		for (i = 0; i < argc; i++)
-			strbuf_addf(&refs_msg, " '%s'", argv[i]);
-
-		fprintf_ln(stderr, _("Too many revisions specified:%s"),
-			   refs_msg.buf);
-		strbuf_release(&refs_msg);
-
-		return -1;
-	}
-
-	if (argc == 1)
-		commit = argv[0];
-
 	strbuf_init(&info->revision, 0);
 	if (!commit) {
 		if (!ref_exists(ref_stash)) {
 			free_stash_info(info);
-			fprintf_ln(stderr, _("No stash entries found."));
+			if (!quiet)
+				fprintf_ln(stderr, _("No stash entries found."));
 			return -1;
 		}
 
@@ -175,7 +158,8 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	revision = info->revision.buf;
 
 	if (get_oid(revision, &info->w_commit)) {
-		error(_("%s is not a valid reference"), revision);
+		if (!quiet)
+			error(_("%s is not a valid reference"), revision);
 		free_stash_info(info);
 		return -1;
 	}
@@ -204,6 +188,30 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	return !(ret == 0 || ret == 1);
 }
 
+static int get_stash_info(struct stash_info *info, int argc, const char **argv)
+{
+	const char *commit = NULL;
+
+	if (argc > 1) {
+		int i;
+		struct strbuf refs_msg = STRBUF_INIT;
+
+		for (i = 0; i < argc; i++)
+			strbuf_addf(&refs_msg, " '%s'", argv[i]);
+
+		fprintf_ln(stderr, _("Too many revisions specified:%s"),
+			   refs_msg.buf);
+		strbuf_release(&refs_msg);
+
+		return -1;
+	}
+
+	if (argc == 1)
+		commit = argv[0];
+
+	return get_stash_info_1(info, commit, 0);
+}
+
 static int do_clear_stash(void)
 {
 	struct object_id obj;
