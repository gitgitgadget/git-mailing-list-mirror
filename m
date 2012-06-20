From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH] fast-import: disallow empty branches as parents
Date: Thu, 21 Jun 2012 01:34:01 +0600
Message-ID: <1340220841-753-2-git-send-email-divanorama@gmail.com>
References: <1340220841-753-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 21:33:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQf5-00043I-3a
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab2FTTdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:33:51 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57121 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab2FTTdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:33:50 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so1029780lbb.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4p5s62OSrJOMaVfe57B+jnWC/cLXvFwt77Zeo/K7jFM=;
        b=pFsE4QTgm29u2erDqm8VNpigZSjR9BB8OQTcUkdKo9FX/5TkpOMB73ei1Z/Uj41os7
         G8P9JSVQdh0qVDavXpMZILdvsQZ8jjCbj0bobHg5uEJWmu2aS16GLi8400fLNRok/WBP
         5ARDqYxLpACE3SQhnqzHcP2rxxFBNRN0Oi2IP/nLKPtSvyG3/sbaPlTtiHp1K8/mBY2c
         GHn5jvUJTx6AN50Xrs+BzuZDrWadI7TD0kia02Gam9pLSeIM9UqG9shDJJRuymYkIIuk
         g2ulSPpYnVCXb8PVaGIak/FQmmwb7tNDm5rTz8ukdqLIqUT4oZtFhfDTqUcDwy9Aapcw
         Uzkg==
Received: by 10.152.131.9 with SMTP id oi9mr23492350lab.39.1340220829452;
        Wed, 20 Jun 2012 12:33:49 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id sm7sm41453450lab.5.2012.06.20.12.33.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 12:33:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1340220841-753-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200340>

Empty branches (either new or reset-ed) have null_sha1 in fast-import
internals. These null_sha1 heads can slip to the real commit objects.

- parse_merge() had no check against null_sha1, so add it.
- parse_from() didn't have it too. It doesn't cause null_sha1 to slip
  because for the first parent there is a null_sha1 check. But still
  the input with "from empty_branch" must be rejected, make it so via
  adding the check to parse_from().

There is a special case with "merge branch_itself" command. When the
branch_itself is empty it must clearly be rejected. Though in a
presence of "from ..." command it is not. parse_from() writes the new
first parent sha1 to branch->sha1 as a temporary placeholder, which
parse_merge() then picks up. Though this sha1 might have never been a
tip of the branch_itself at all.

Make parse_from() store the first parent sha1 in a temporary buffer
to fix this special case.

Add some tests for all these fixes.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   49 +++++++++++++++++++++++++++++------------------
 t/t9300-fast-import.sh |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index eed97c8..2e089a8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2540,7 +2540,8 @@ static void file_change_deleteall(struct branch *b)
 	b->num_notes = 0;
 }
 
-static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
+static void parse_from_commit(struct branch *b, unsigned char *sha1,
+						char *buf, unsigned long size)
 {
 	if (!buf || size < 46)
 		die("Not a valid commit: %s", sha1_to_hex(b->sha1));
@@ -2551,29 +2552,31 @@ static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 		b->branch_tree.versions[1].sha1);
 }
 
-static void parse_from_existing(struct branch *b)
+static void parse_from_existing(struct branch *b, unsigned char *sha1)
 {
-	if (is_null_sha1(b->sha1)) {
+	if (is_null_sha1(sha1)) {
 		hashclr(b->branch_tree.versions[0].sha1);
 		hashclr(b->branch_tree.versions[1].sha1);
 	} else {
 		unsigned long size;
 		char *buf;
 
-		buf = read_object_with_reference(b->sha1,
-			commit_type, &size, b->sha1);
-		parse_from_commit(b, buf, size);
+		buf = read_object_with_reference(sha1,
+			commit_type, &size, sha1);
+		parse_from_commit(b, sha1, buf, size);
 		free(buf);
 	}
 }
 
-static int parse_from(struct branch *b)
+static int parse_from(struct branch *b, unsigned char *sha1out)
 {
 	const char *from;
 	struct branch *s;
 
-	if (prefixcmp(command_buf.buf, "from "))
+	if (prefixcmp(command_buf.buf, "from ")) {
+		hashclr(sha1out);
 		return 0;
+	}
 
 	if (b->branch_tree.tree) {
 		release_tree_content_recursive(b->branch_tree.tree);
@@ -2586,7 +2589,10 @@ static int parse_from(struct branch *b)
 		die("Can't create a branch from itself: %s", b->name);
 	else if (s) {
 		unsigned char *t = s->branch_tree.versions[1].sha1;
-		hashcpy(b->sha1, s->sha1);
+		if (is_null_sha1(s->sha1))
+			die("Can't create a branch from an empty branch:"
+				" %s from %s", b->name, s->name);
+		hashcpy(sha1out, s->sha1);
 		hashcpy(b->branch_tree.versions[0].sha1, t);
 		hashcpy(b->branch_tree.versions[1].sha1, t);
 	} else if (*from == ':') {
@@ -2594,16 +2600,16 @@ static int parse_from(struct branch *b)
 		struct object_entry *oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
-		hashcpy(b->sha1, oe->idx.sha1);
+		hashcpy(sha1out, oe->idx.sha1);
 		if (oe->pack_id != MAX_PACK_ID) {
 			unsigned long size;
 			char *buf = gfi_unpack_entry(oe, &size);
-			parse_from_commit(b, buf, size);
+			parse_from_commit(b, sha1out, buf, size);
 			free(buf);
 		} else
-			parse_from_existing(b);
-	} else if (!get_sha1(from, b->sha1))
-		parse_from_existing(b);
+			parse_from_existing(b, sha1out);
+	} else if (!get_sha1(from, sha1out))
+		parse_from_existing(b, sha1out);
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
 
@@ -2622,9 +2628,11 @@ static struct hash_list *parse_merge(unsigned int *count)
 		from = strchr(command_buf.buf, ' ') + 1;
 		n = xmalloc(sizeof(*n));
 		s = lookup_branch(from);
-		if (s)
+		if (s) {
+			if (is_null_sha1(s->sha1))
+				die("Can't merge empty branch: %s", s->name);
 			hashcpy(n->sha1, s->sha1);
-		else if (*from == ':') {
+		} else if (*from == ':') {
 			uintmax_t idnum = parse_mark_ref_eol(from);
 			struct object_entry *oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
@@ -2656,6 +2664,7 @@ static void parse_new_commit(void)
 {
 	static struct strbuf msg = STRBUF_INIT;
 	struct branch *b;
+	unsigned char sha1[20];
 	char *sp;
 	char *author = NULL;
 	char *committer = NULL;
@@ -2683,7 +2692,7 @@ static void parse_new_commit(void)
 		die("Expected committer but didn't get one");
 	parse_data(&msg, 0, NULL);
 	read_next_command();
-	parse_from(b);
+	parse_from(b, sha1);
 	merge_list = parse_merge(&merge_count);
 
 	/* ensure the branch is active/loaded */
@@ -2730,7 +2739,9 @@ static void parse_new_commit(void)
 	strbuf_reset(&new_data);
 	strbuf_addf(&new_data, "tree %s\n",
 		sha1_to_hex(b->branch_tree.versions[1].sha1));
-	if (!is_null_sha1(b->sha1))
+	if (!is_null_sha1(sha1))
+		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(sha1));
+	else if (!is_null_sha1(b->sha1))
 		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
 	while (merge_list) {
 		struct hash_list *next = merge_list->next;
@@ -2855,7 +2866,7 @@ static void parse_reset_branch(void)
 	else
 		b = new_branch(sp);
 	read_next_command();
-	parse_from(b);
+	parse_from(b, b->sha1);
 	if (command_buf.len > 0)
 		unread_command_buf = 1;
 }
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2aa1824..5f25c01 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2895,6 +2895,54 @@ test_expect_success 'S: merge with garbage after mark must fail' '
 	test_i18ngrep "after mark" err
 '
 
+test_expect_success 'S: empty branch as merge parent must fail' '
+	test_must_fail git fast-import <<-EOF 2>err &&
+	commit refs/heads/chicken
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	I am the chicken.
+	COMMIT
+	merge refs/heads/chicken
+	EOF
+	cat err &&
+	test_must_fail git rev-parse --verify refs/heads/chicken^
+'
+
+test_expect_success 'S: empty branch as merge parent must fail (2)' '
+	test_must_fail git fast-import <<-EOF 2>err &&
+	commit refs/heads/egg1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	I am the egg N1.
+	COMMIT
+
+	commit refs/heads/egg2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	I am the egg N2.
+	COMMIT
+	from refs/heads/egg1
+	merge refs/heads/egg2
+	EOF
+	cat err &&
+	test_must_fail git rev-parse --verify refs/heads/egg2^2
+'
+
+test_expect_success 'S: empty branch as a parent must fail ' '
+	test_must_fail git fast-import <<-EOF 2>err &&
+	reset refs/heads/egg3
+
+	commit refs/heads/egg4
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	I am the egg N4.
+	COMMIT
+	from refs/heads/egg3
+	EOF
+	cat err &&
+	test_must_fail git rev-parse --verify refs/heads/egg4^2
+'
+
 #
 # tag, from markref
 #
-- 
1.7.3.4
