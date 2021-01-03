Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BFC433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF2207C9
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbhACVUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:20:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727543AbhACVUT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jan 2021 16:20:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9063B60814;
        Sun,  3 Jan 2021 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609708747;
        bh=5nExuClPgVRxIpg4/j3sI9qUo8mRWkqz68j+JBrODSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SsYWQQMRmzoJYOvuBrhvMx1kOlQOe4ew0s0jVM7JjMCFPQLDR3d+XDQitR6krxTxy
         u0xXs24cBacG76hBjgS3waPgsacChuvfU7CDLhbeIRHmZHpX4EUSaVKA1PXNppYKMF
         +PagScrxcC1St7a1xkFk3UPHiclhrI6vxGYoTptQtnp8y7zwfXwijFyLUNISvCAng6
         FX68aq1vtinuIjvk5TwvO1v2uy/noubQ7xAzATcKvbs45/kCckCYG98fs1ar+ZURMX
         82Bu8pzknIhZ7TMoSTstbmTJMJkO0HLOqZOljQRc+2UJ6R6HOwUj2+zP3AI/c5aPix
         o9A3Hv6Gq4SLYhqCTyDqfbbkuJKGE7Jy9m6mPK2dnSOFL4D/7nFEZmbDV0PQRgKqGk
         uqzWGRf/0ApmoRTrQx4zv2COu7ihgpzhIsiIHqYprt6vf4b4oSNHXAT5fFh7KMUbVp
         iWwyAfA1TvVoAbPButSm20suL4QZMBCqf25+lwjnL4qu/47gEcV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/5] mailmap: use case-sensitive comparisons for local-parts and names
Date:   Sun,  3 Jan 2021 21:18:48 +0000
Message-Id: <20210103211849.2691287-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RFC 5321 is clear that the local-part of an email address (the part
before the at sign) is case sensitive, and this has been the case since
the original RFC 821.  It directs us that "the local-part MUST be
interpreted and assigned semantics only by the host specified in the
domain part of the address."

Since we are not that party, it's not correct for us to compare them
case insensitively.  However, we do still want to compare the domain
parts case insensitively, so let's add a helper that downcases the
domain and then compare byte by byte.

Similarly, it's not possible for us to correctly case-fold text in a
locale-insensitive way, so our handling of personal names has also been
subject to bugs.  Additionally, we've never handled non-ASCII characters
correctly, which means that our previous comparisons really only worked
well for a fraction of the people on the planet.  Since our code wasn't
right and it's basically impossible to compare personal names without
regard to case, let's also switch our matching of names to be byte by
byte.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 mailmap.c          | 27 ++++++++++++++++++++++++---
 t/t4203-mailmap.sh |  4 ++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index d3287b409a..5c52dbb7e0 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -64,7 +64,22 @@ static void free_mailmap_entry(void *p, const char *s)
  */
 static int namemap_cmp(const char *a, const char *b)
 {
-	return strcasecmp(a, b);
+	return strcmp(a, b);
+}
+
+/*
+ * Lowercases the domain (and only the domain) part of an email address.  The
+ * local-part, which is defined by RFC 5321 to be case sensitive, is not
+ * affected.
+ */
+static char *lowercase_email(char *s)
+{
+	char *end = strchrnul(s, '@');
+	while (*end) {
+		*end = tolower(*end);
+		end++;
+	}
+	return s;
 }
 
 static void add_mapping(struct string_list *map,
@@ -74,9 +89,13 @@ static void add_mapping(struct string_list *map,
 	struct mailmap_entry *me;
 	struct string_list_item *item;
 
+	lowercase_email(new_email);
+
 	if (old_email == NULL) {
 		old_email = new_email;
 		new_email = NULL;
+	} else {
+		lowercase_email(old_email);
 	}
 
 	item = string_list_insert(map, old_email);
@@ -300,7 +319,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 	 * real location of the key if one exists.
 	 */
 	while (0 <= --i && i < map->nr) {
-		int cmp = strncasecmp(map->items[i].string, string, len);
+		int cmp = strncmp(map->items[i].string, string, len);
 		if (cmp < 0)
 			/*
 			 * "i" points at a key definitely below the prefix;
@@ -323,6 +342,7 @@ int map_user(struct mailmap *map,
 	     const char **email, size_t *emaillen,
 	     const char **name, size_t *namelen)
 {
+	char *searchable_email = xstrndup(*email, *emaillen);
 	struct string_list_item *item;
 	struct mailmap_entry *me;
 
@@ -330,7 +350,8 @@ int map_user(struct mailmap *map,
 		 (int)*namelen, debug_str(*name),
 		 (int)*emaillen, debug_str(*email));
 
-	item = lookup_prefix(map->mailmap, *email, *emaillen);
+	item = lookup_prefix(map->mailmap, searchable_email, *emaillen);
+	free(searchable_email);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 32e849504c..df4a0e03cc 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -187,7 +187,7 @@ nick1 (1):
 
 EOF
 
-test_expect_failure 'name entry after email entry, case-sensitive local-part' '
+test_expect_success 'name entry after email entry, case-sensitive local-part' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
 	echo "Internal Guy <BUGS@company.xx>" >>internal_mailmap/.mailmap &&
@@ -195,7 +195,7 @@ test_expect_failure 'name entry after email entry, case-sensitive local-part' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'name entry after email entry, case-sensitive personal name' '
+test_expect_success 'name entry after email entry, case-sensitive personal name' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
 	echo "Nick1 <bugs@company.xx> NICK1 <bugs@company.xx>" >internal_mailmap/.mailmap &&
