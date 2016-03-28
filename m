From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/11] rerere: split conflict ID further
Date: Mon, 28 Mar 2016 15:42:12 -0700
Message-ID: <1459204942-26601-2-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:42:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfrq-0005Di-O1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbcC1Wmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:32 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755466AbcC1Wm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E17404FF9A;
	Mon, 28 Mar 2016 18:42:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=C+Vr
	HavNzrIDJk0KS1bKYHoj2Xc=; b=rGI2agXkBfy/oT7notX/ry44Jm999pNwfNHL
	5lWXDFl4twAfvdJOy44BlYiQLLDo2uQzpKL9/LRx8e7wy2jppg+fTsLCxmhx5Q5a
	+KtZq+B6s+cLZ8FlSrVcRCRSje79ql9ZgMYRHxIv8aN0Il8z4jM1w4HuouRMU1wR
	jCM53H8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BXKoic
	Rhp0nPG5rHot9uVFZEmna8r+x4ajynbcF3/ojPm2c3M6cCjS+wb58+LY6Jgt08fW
	NTK3Y3VJ87fkAV17s4UthCXutAigQoSFsAk8wUJajaqRUuLd/6/PFhuIkLM5Kaq7
	5r+siZVLJINQb1cl8HQknZvzQnaXYnr248mX0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D92F84FF99;
	Mon, 28 Mar 2016 18:42:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4C0734FF98;
	Mon, 28 Mar 2016 18:42:25 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 57B5A2E2-F536-11E5-B90C-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290072>

The plan is to keep assigning the backward compatible conflict ID
based on the hash of the (normalized) text of conflicts, keep using
that conflict ID as the directory name under $GIT_DIR/rr-cache/, but
allow each conflicted path to use a separate "variant" to record
resolutions, i.e. having more than one <preimage,postimage> pairs
under $GIT_DIR/rr-cache/$ID/ directory.  As the first step in that
direction, separate the shared "conflict ID" out of the rerere_id
structure.

The plan is to keep information per $ID in rerere_dir, that can be
shared among rerere_id that is per conflicted path.

When we are done with rerere(), which can be directly called from
other programs like "git apply", "git commit" and "git merge", the
shared rerere_dir structures can be freed entirely, so they are not
reference-counted and they are not freed when we release rerere_id's
that reference them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is designed to be applied to a slightly newer codebase than
   the previous round, and a few removed lines that used to call
   strcpy() in the preimage shows up as using xsnprintf() in the
   patch.  We no longer use a simple string anyway, so the postimages
   are the same between rerolls.

 rerere.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 rerere.h |  3 ++-
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/rerere.c b/rerere.c
index 3d0fa8f..a5d8a06 100644
--- a/rerere.c
+++ b/rerere.c
@@ -8,6 +8,7 @@
 #include "ll-merge.h"
 #include "attr.h"
 #include "pathspec.h"
+#include "sha1-lookup.h"
 
 #define RESOLVED 0
 #define PUNTED 1
@@ -22,6 +23,23 @@ static int rerere_autoupdate;
 
 static char *merge_rr_path;
 
+static int rerere_dir_nr;
+static int rerere_dir_alloc;
+
+static struct rerere_dir {
+	unsigned char sha1[20];
+} **rerere_dir;
+
+static void free_rerere_dirs(void)
+{
+	int i;
+	for (i = 0; i < rerere_dir_nr; i++)
+		free(rerere_dir[i]);
+	free(rerere_dir);
+	rerere_dir_nr = rerere_dir_alloc = 0;
+	rerere_dir = NULL;
+}
+
 static void free_rerere_id(struct string_list_item *item)
 {
 	free(item->util);
@@ -29,7 +47,7 @@ static void free_rerere_id(struct string_list_item *item)
 
 static const char *rerere_id_hex(const struct rerere_id *id)
 {
-	return id->hex;
+	return sha1_to_hex(id->collection->sha1);
 }
 
 const char *rerere_path(const struct rerere_id *id, const char *file)
@@ -40,6 +58,37 @@ const char *rerere_path(const struct rerere_id *id, const char *file)
 	return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
 }
 
+static const unsigned char *rerere_dir_sha1(size_t i, void *table)
+{
+	struct rerere_dir **rr_dir = table;
+	return rr_dir[i]->sha1;
+}
+
+static struct rerere_dir *find_rerere_dir(const char *hex)
+{
+	unsigned char sha1[20];
+	struct rerere_dir *rr_dir;
+	int pos;
+
+	if (get_sha1_hex(hex, sha1))
+		return NULL; /* BUG */
+	pos = sha1_pos(sha1, rerere_dir, rerere_dir_nr, rerere_dir_sha1);
+	if (pos < 0) {
+		rr_dir = xmalloc(sizeof(*rr_dir));
+		hashcpy(rr_dir->sha1, sha1);
+		pos = -1 - pos;
+
+		/* Make sure the array is big enough ... */
+		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
+		/* ... and add it in. */
+		rerere_dir_nr++;
+		memmove(rerere_dir + pos + 1, rerere_dir + pos,
+			(rerere_dir_nr - pos - 1) * sizeof(*rerere_dir));
+		rerere_dir[pos] = rr_dir;
+	}
+	return rerere_dir[pos];
+}
+
 static int has_rerere_resolution(const struct rerere_id *id)
 {
 	struct stat st;
@@ -50,7 +99,7 @@ static int has_rerere_resolution(const struct rerere_id *id)
 static struct rerere_id *new_rerere_id_hex(char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
-	xsnprintf(id->hex, sizeof(id->hex), "%s", hex);
+	id->collection = find_rerere_dir(hex);
 	return id;
 }
 
@@ -810,12 +859,14 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 int rerere(int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int fd;
+	int fd, status;
 
 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	return do_plain_rerere(&merge_rr, fd);
+	status = do_plain_rerere(&merge_rr, fd);
+	free_rerere_dirs();
+	return status;
 }
 
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
@@ -900,7 +951,7 @@ int rerere_forget(struct pathspec *pathspec)
 static struct rerere_id *dirname_to_id(const char *name)
 {
 	static struct rerere_id id;
-	xsnprintf(id.hex, sizeof(id.hex), "%s", name);
+	id.collection = find_rerere_dir(name);
 	return &id;
 }
 
diff --git a/rerere.h b/rerere.h
index ce545d0..faf5a23 100644
--- a/rerere.h
+++ b/rerere.h
@@ -15,8 +15,9 @@ struct pathspec;
  */
 extern void *RERERE_RESOLVED;
 
+struct rerere_dir;
 struct rerere_id {
-	char hex[41];
+	struct rerere_dir *collection;
 };
 
 extern int setup_rerere(struct string_list *, int);
-- 
2.8.0-215-g046a488
