Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074F4C4167B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 01:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0422AAD
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 01:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392076AbgLMBKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 20:10:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgLMBKc (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Dec 2020 20:10:32 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BED706076A
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607821761;
        bh=mKrcfvk5jwZjyDEa2A9uahrPMOl3GKXiBzrEbzCuobE=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=LhwWzAWnvyhS1hfo058pdXnljUF2BveRhKozKmGB1+byfDLT6Kx6ysbgtgP8zkog0
         IvTiseICeG/8AeKMb5mmNU819FBcDnv2AI/GKXrU+siOsaCX6cUI1740p3GDjbfb7m
         K5gXyZDIG+GlhP9n5NyYVT6s+DAZnys9KW7/lKaQDpMAWzzEDqUMqKxUH7qdxEBUbn
         nHlZwDXXNW+rDSiGe+BQcOJAFWbRxgQXO5bpVe3EDndU923B0c97evtPYPBW6G+HeI
         7uPofrsi0sPupjJtrXAFgYtf5mmyl1YjQAQBXAT9bKF1lUszMFSRM7NGW3H2zp/Z0J
         GBBPsjgI0Q720eofV5SIXBSmR/NkYgjfXhRE5tkO/xUUOYzdK83ef9RCx7FkoG4lxX
         OT4vakOTY4Z6N7OjBDyv6nIvMXfZPOTfHNDx1/hTAjz5mSDVFvYsZI6Zq/ZA9hM71D
         t1Q2wUQQKTi7ouzvzvUcVs8HnaOB4bTQvcmPUdZzvbfTKWti/MI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 1/1] mailmap: support hashed entries in mailmaps
Date:   Sun, 13 Dec 2020 01:05:39 +0000
Message-Id: <20201213010539.544101-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201213010539.544101-1-sandals@crustytoothpaste.net>
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many people, through the course of their lives, will change either a
name or an email address.  For this reason, we have the mailmap, to map
from a user's former name or email address to their current, canonical
forms.  Normally, this works well as it is.

However, sometimes people change a name or an email address and wish to
wholly disassociate themselves from that former name or email address.
For example, a person may have left a company which engaged in a deeply
unethical act with which the person does not want to be associated, or
they may have changed their name to disassociate themselves from an
abusive family or partner.  In such a case, using the former name or
address in any way may be undesirable and the person may wish to replace
it as completely as possible.

For projects which wish to support this, introduce hashed forms into the
mailmap.  These forms, which start with "@sha256:" followed by a SHA-256
hash of the entry, can be used in place of the form used in the commit
field.  This form is intentionally designed to be unlikely to conflict
with legitimate use cases.  For example, this is not a valid email
address according to RFC 5322.  In the unlikely event that a user has
put such a form into the actual commit as their name, we will accept it.

While the form of the data is designed to accept multiple hash
algorithms, we intentionally do not support SHA-1.  There is little
reason to support such a weak algorithm in new use cases and no
backwards compatibility to consider.  Moreover, SHA-256 is faster than
the SHA1DC implementation we use, so this not only improves performance,
but simplifies the current implementation somewhat as well.

Note that it is, of course, possible to perform a lookup on all commit
objects to determine the actual entry which matches the hashed form of
the data.  However, a project for which this feature is valuable may
simply insert entries for many contributors in order to make discovery
of "interesting" entries significantly less convenient.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 mailmap.c          | 39 +++++++++++++++++++++++++++++++++++++--
 t/t4203-mailmap.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 962fd86d6d..09d0ad7ca4 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -313,6 +313,41 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 	return NULL;
 }
 
+/*
+ * Convert an email or name into a hashed form for comparison.  The hashed form
+ * will be created in the form
+ * @sha256:c68b7a430ac8dee9676ec77a387194e23f234d024e03d844050cf6c01775c8f6,
+ * which would be the hashed form for "doe@example.com".
+ */
+static char *hashed_form(struct strbuf *buf, const struct git_hash_algo *algop, const char *key, size_t keylen)
+{
+	git_hash_ctx ctx;
+	unsigned char hashbuf[GIT_MAX_RAWSZ];
+	char hexbuf[GIT_MAX_HEXSZ + 1];
+
+	algop->init_fn(&ctx);
+	algop->update_fn(&ctx, key, keylen);
+	algop->final_fn(hashbuf, &ctx);
+	hash_to_hex_algop_r(hexbuf, hashbuf, algop);
+
+	strbuf_addf(buf, "@%s:%s", algop->name, hexbuf);
+	return buf->buf;
+}
+
+static struct string_list_item *lookup_one(struct string_list *map,
+					   const char *string, size_t len)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item = lookup_prefix(map, string, len);
+	if (item)
+		return item;
+
+	hashed_form(&buf, &hash_algos[GIT_HASH_SHA256], string, len);
+	item = lookup_prefix(map, buf.buf, buf.len);
+	strbuf_release(&buf);
+	return item;
+}
+
 int map_user(struct string_list *map,
 	     const char **email, size_t *emaillen,
 	     const char **name, size_t *namelen)
@@ -324,7 +359,7 @@ int map_user(struct string_list *map,
 		 (int)*namelen, debug_str(*name),
 		 (int)*emaillen, debug_str(*email));
 
-	item = lookup_prefix(map, *email, *emaillen);
+	item = lookup_one(map, *email, *emaillen);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
@@ -334,7 +369,7 @@ int map_user(struct string_list *map,
 			 * simple entry.
 			 */
 			struct string_list_item *subitem;
-			subitem = lookup_prefix(&me->namemap, *name, *namelen);
+			subitem = lookup_one(&me->namemap, *name, *namelen);
 			if (subitem)
 				item = subitem;
 		}
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 586c3a86b1..794133ba5d 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -62,6 +62,41 @@ test_expect_success 'check-mailmap --stdin arguments' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hashed mailmap' '
+	test_config mailmap.file ./hashed &&
+	hashed_author_name="@sha256:$(printf "$GIT_AUTHOR_NAME" | test-tool sha256)" &&
+	hashed_author_email="@sha256:$(printf "$GIT_AUTHOR_EMAIL" | test-tool sha256)" &&
+	cat >expect <<-EOF &&
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+
+	cat >hashed <<-EOF &&
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$GIT_AUTHOR_EMAIL>
+	EOF
+	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual &&
+
+	cat >hashed <<-EOF &&
+	Wrong <wrong@example.org> $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$GIT_AUTHOR_EMAIL>
+	EOF
+	# Check that we prefer literal matches over hashed names.
+	git check-mailmap  "$hashed_author_name <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual &&
+
+	cat >hashed <<-EOF &&
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$hashed_author_email>
+	EOF
+	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual &&
+
+	cat >hashed <<-EOF &&
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> <$hashed_author_email>
+	EOF
+	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'check-mailmap bogus contact' '
 	test_must_fail git check-mailmap bogus
 '
