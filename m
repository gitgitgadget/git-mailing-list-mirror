Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D9CC433E6
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90E720784
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbhACVU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:20:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45782 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727543AbhACVU3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jan 2021 16:20:29 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2807F60815;
        Sun,  3 Jan 2021 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609708748;
        bh=kCe9FJ/gwE+bPsM2vIcOW5M5MbhKot5CavKY6VHqT34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wSPUT8phFMRT+JGvpB0Ao7I1zTDP1mpRJNmoeMjifZLsmbAjX5B5Obg5ALdS3wo3b
         3vMfArkUwJfc3WsdDT92sVHfxCGDCbZ7OJd12SYX2WFP9RvnenkC19Nhes6/QUvSSd
         5BckdQBAEebF28cQU9+iv5FiGpUElMgECmDQkH0PGDMLrNGS8oVS3DA9//M3oB59cS
         mfqAhW/KTsMjXx9/I36GxDKXIszRzxuRhJCBqW3pMIFW1HI3IumrRTOUWUfwu/B1hI
         QT7HIOtfO7bR1wETAfGZJ2qIooARQexAbfmw97mmVZyoE+J9dqeNSttfS0R1dwAmGU
         6ZwbCMU1vDd7NXsajfAOvOm7XRnxv/CDWA+Dl3+GY+Yz7m2/OZrKvamRiaXCWl61Ll
         U3TQqhkjiv689FDdgC9fBnWlSvREi5hm5IVGYWKg/mElQ8HX8jic+Wbrxf6eF5BOg1
         vW+xTpfO3BGpFps5HFSujMiEIVL+PFyEePgbHIubhmhxzNgW7g3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
Date:   Sun,  3 Jan 2021 21:18:49 +0000
Message-Id: <20210103211849.2691287-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
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
For example, a person may transition from one gender to another,
changing their name, or they may have changed their name to disassociate
themselves from an abusive family or partner.  In such a case, using the
former name or address in any way may be undesirable and the person may
wish to replace it as completely as possible.

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
the data.  However, this is an improvement over the status quo.

The performance of this patch with no hashed entries is very similar to
the performance without this patch.  Considering a git log command to
look up author and committer information on 981,680 commits in the Linux
kernel history, either with an unhashed mailmap or a mailmap with all
old values hashed:

                                   Shortest  Longest  Average  Change
  Git 2.30                         7.876     8.297    8.143
  This patch, unhashed             7.923     8.484    8.237    + 1.15%
  This patch, hashed               14.510    14.783   14.672   +80.17%
  This patch, hashed, unoptimized  15.425    16.318   15.901   +95.27%

Thus, the average performance after this patch is within normal
variation of the pre-patch performance.  It's unlikely that users will
notice the difference in practice, even on much larger
repositories, unless they're using the new feature.

To minimize the performance impact of the hashing process, we maintain a
reference count of each mailmap entry and when we encounter an entry we
must hash, we insert the same object under the unhashed key as well.  We
also keep a count of the number of hashed entries.  This means we must
hash an object at most once and once we've seen all the hashed objects,
we won't hash any more objects.  Times without this optimization are
listed above in the unoptimized entry.

This has the potential to cause a performance problem as we insert items
into a sorted list, but changing the implementation to use a khash map
instead does not result in a significantly faster implementation,
despite the improved insertion speed.  Performance in the unhashed case
is slightly worse, so this approach was not adopted since it provides
few benefits.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/mailmap.txt | 28 +++++++++++
 mailmap.c                 | 99 ++++++++++++++++++++++++++++++++++-----
 mailmap.h                 |  2 +
 t/t4203-mailmap.sh        | 35 ++++++++++++++
 4 files changed, 152 insertions(+), 12 deletions(-)

diff --git a/Documentation/mailmap.txt b/Documentation/mailmap.txt
index 4a8c276529..b21194bf3e 100644
--- a/Documentation/mailmap.txt
+++ b/Documentation/mailmap.txt
@@ -73,3 +73,31 @@ Santa Claus <santa.claus@northpole.xx> <me@company.xx>
 
 Use hash '#' for comments that are either on their own line, or after
 the email address.
+
+In addition to specifying a former name or email literally, it is also possible
+to specify it in a hashed form, which consists of the string `@sha256:`,
+followed by an all-lowercase SHA-256 hash of the entry in hexadecimal.  For
+example, to take the example above, instead of specifying the replacement for
+"Some Dude" as such, you could specify one of these lines:
+
+------------
+Some Dude <some@dude.xx> nick1 <@sha256:bee4fdd8c5e2e85009c8ae231d5a395adb24d5a597f2b75489926460680b8ce1>
+Some Dude <some@dude.xx> @sha256:56030827e2765e8878c94c4cc43f5410b22f3b8c2b1ef8f631ac3953f8299279 <bugs@company.xx>
+Some Dude <some@dude.xx> @sha256:56030827e2765e8878c94c4cc43f5410b22f3b8c2b1ef8f631ac3953f8299279 <@sha256:bee4fdd8c5e2e85009c8ae231d5a395adb24d5a597f2b75489926460680b8ce1>
+------------
+
+These hash is a hash of the literal name or email without any trailing newlines.
+For example, you can compute the values above like so, using the Perl `shasum`
+command (or a similar command of your choice):
+
+------------
+$ printf '%s' bugs@company.xx | shasum -a 256
+bee4fdd8c5e2e85009c8ae231d5a395adb24d5a597f2b75489926460680b8ce1  -
+------------
+
+SHA-1 is not accepted as a hash algorithm in mailmaps.
+
+Using the hashed form may be desirable to obscure one's former name or email,
+but be aware that it is just obfuscation: it's still possible for someone with
+access to the repository to iterate through all authors and committers and map
+the hashed values to unhashed ones.
diff --git a/mailmap.c b/mailmap.c
index 5c52dbb7e0..ed401bb1e4 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -18,6 +18,8 @@ const char *git_mailmap_blob;
 struct mailmap_info {
 	char *name;
 	char *email;
+
+	unsigned refcount;
 };
 
 struct mailmap_entry {
@@ -25,6 +27,10 @@ struct mailmap_entry {
 	char *name;
 	char *email;
 
+	unsigned refcount;
+	unsigned hashed_count;
+	unsigned hashed_seen;
+
 	/* name and email for the complex mail and name matching case */
 	struct string_list namemap;
 };
@@ -32,6 +38,9 @@ struct mailmap_entry {
 static void free_mailmap_info(void *p, const char *s)
 {
 	struct mailmap_info *mi = (struct mailmap_info *)p;
+	if (--mi->refcount)
+		return;
+
 	debug_mm("mailmap: -- complex: '%s' -> '%s' <%s>\n",
 		 s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
@@ -41,6 +50,9 @@ static void free_mailmap_info(void *p, const char *s)
 static void free_mailmap_entry(void *p, const char *s)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
+	if (--me->refcount)
+		return;
+
 	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n",
 		 s, me->namemap.nr);
 	debug_mm("mailmap: - simple: '%s' <%s>\n",
@@ -82,10 +94,17 @@ static char *lowercase_email(char *s)
 	return s;
 }
 
-static void add_mapping(struct string_list *map,
+static int is_hashed(const char *s)
+{
+	const char *prefix = "@sha256:";
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
+static void add_mapping(struct mailmap *mailmap,
 			char *new_name, char *new_email,
 			char *old_name, char *old_email)
 {
+	struct string_list *map = mailmap->mailmap;
 	struct mailmap_entry *me;
 	struct string_list_item *item;
 
@@ -95,7 +114,10 @@ static void add_mapping(struct string_list *map,
 		old_email = new_email;
 		new_email = NULL;
 	} else {
-		lowercase_email(old_email);
+		if (is_hashed(old_email))
+			mailmap->hashed_count++;
+		else
+			lowercase_email(old_email);
 	}
 
 	item = string_list_insert(map, old_email);
@@ -105,6 +127,7 @@ static void add_mapping(struct string_list *map,
 		me = xcalloc(1, sizeof(struct mailmap_entry));
 		me->namemap.strdup_strings = 1;
 		me->namemap.cmp = namemap_cmp;
+		me->refcount = 1;
 		item->util = me;
 	}
 
@@ -125,6 +148,9 @@ static void add_mapping(struct string_list *map,
 		debug_mm("mailmap: adding (complex) entry for '%s'\n", old_email);
 		mi->name = xstrdup_or_null(new_name);
 		mi->email = xstrdup_or_null(new_email);
+		mi->refcount = 1;
+		if (is_hashed(old_name))
+			me->hashed_count++;
 		string_list_insert(&me->namemap, old_name)->util = mi;
 	}
 
@@ -162,7 +188,7 @@ static char *parse_name_and_email(char *buffer, char **name,
 	return (*right == '\0' ? NULL : right);
 }
 
-static void read_mailmap_line(struct string_list *map, char *buffer,
+static void read_mailmap_line(struct mailmap *map, char *buffer,
 			      char **repo_abbrev)
 {
 	char *name1 = NULL, *email1 = NULL, *name2 = NULL, *email2 = NULL;
@@ -194,7 +220,7 @@ static void read_mailmap_line(struct string_list *map, char *buffer,
 		add_mapping(map, name1, email1, name2, email2);
 }
 
-static int read_mailmap_file(struct string_list *map, const char *filename,
+static int read_mailmap_file(struct mailmap *map, const char *filename,
 			     char **repo_abbrev)
 {
 	char buffer[1024];
@@ -216,7 +242,7 @@ static int read_mailmap_file(struct string_list *map, const char *filename,
 	return 0;
 }
 
-static void read_mailmap_string(struct string_list *map, char *buf,
+static void read_mailmap_string(struct mailmap *map, char *buf,
 				char **repo_abbrev)
 {
 	while (*buf) {
@@ -230,7 +256,7 @@ static void read_mailmap_string(struct string_list *map, char *buf,
 	}
 }
 
-static int read_mailmap_blob(struct string_list *map,
+static int read_mailmap_blob(struct mailmap *map,
 			     const char *name,
 			     char **repo_abbrev)
 {
@@ -269,10 +295,10 @@ int read_mailmap(struct mailmap *mailmap, char **repo_abbrev)
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
 
-	err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
+	err |= read_mailmap_file(mailmap, ".mailmap", repo_abbrev);
 	if (startup_info->have_repository)
-		err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
-	err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
+		err |= read_mailmap_blob(mailmap, git_mailmap_blob, repo_abbrev);
+	err |= read_mailmap_file(mailmap, git_mailmap_file, repo_abbrev);
 	return err;
 }
 
@@ -282,7 +308,7 @@ void clear_mailmap(struct mailmap *mailmap)
 	debug_mm("mailmap: clearing %d entries...\n", map->nr);
 	map->strdup_strings = 1;
 	string_list_clear_func(map, free_mailmap_entry);
-	string_list_clear(map, 1);
+	string_list_clear(map, 0);
 	free(map);
 	debug_mm("mailmap: cleared\n");
 }
@@ -338,6 +364,55 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
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
+					   const char *string, size_t len,
+					   unsigned hashed_count,
+					   unsigned *hashed_seen)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item = lookup_prefix(map, string, len);
+	if (item || !hashed_count || hashed_count == *hashed_seen)
+		return item;
+
+	hashed_form(&buf, &hash_algos[GIT_HASH_SHA256], string, len);
+	item = lookup_prefix(map, buf.buf, buf.len);
+	if (item) {
+		struct mailmap_info *mi = (struct mailmap_info *)item->util;
+		char *s = xstrndup(string, len);
+		map->strdup_strings = 0;
+		item = string_list_insert(map, s);
+		map->strdup_strings = 1;
+		if (!item->util) {
+			item->util = mi;
+			mi->refcount++;
+			(*hashed_seen)++;
+		}
+	}
+	strbuf_release(&buf);
+	return item;
+}
+
 int map_user(struct mailmap *map,
 	     const char **email, size_t *emaillen,
 	     const char **name, size_t *namelen)
@@ -350,7 +425,7 @@ int map_user(struct mailmap *map,
 		 (int)*namelen, debug_str(*name),
 		 (int)*emaillen, debug_str(*email));
 
-	item = lookup_prefix(map->mailmap, searchable_email, *emaillen);
+	item = lookup_one(map->mailmap, searchable_email, *emaillen, map->hashed_count, &map->hashed_seen);
 	free(searchable_email);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
@@ -361,7 +436,7 @@ int map_user(struct mailmap *map,
 			 * simple entry.
 			 */
 			struct string_list_item *subitem;
-			subitem = lookup_prefix(&me->namemap, *name, *namelen);
+			subitem = lookup_one(&me->namemap, *name, *namelen, me->hashed_count, &me->hashed_seen);
 			if (subitem)
 				item = subitem;
 		}
diff --git a/mailmap.h b/mailmap.h
index 4cdce3b064..69f8be5705 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -5,6 +5,8 @@
 
 struct mailmap {
 	struct string_list *mailmap;
+	unsigned hashed_count;
+	unsigned hashed_seen;
 };
 
 int read_mailmap(struct mailmap *map, char **repo_abbrev);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index df4a0e03cc..004b4a3d40 100755
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
+	git check-mailmap "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual &&
+
+	cat >hashed <<-EOF &&
+	Wrong <wrong@example.org> $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$GIT_AUTHOR_EMAIL>
+	EOF
+	# Check that we prefer literal matches over hashed names.
+	git check-mailmap "$hashed_author_name <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual &&
+
+	cat >hashed <<-EOF &&
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$hashed_author_email>
+	EOF
+	git check-mailmap "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual &&
+
+	cat >hashed <<-EOF &&
+	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> <$hashed_author_email>
+	EOF
+	git check-mailmap "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'check-mailmap bogus contact' '
 	test_must_fail git check-mailmap bogus
 '
