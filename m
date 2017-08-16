Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C1D1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbdHPUQy (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:54 -0400
Received: from vie01a-dmta-pe02-2.mx.upcmail.net ([62.179.121.158]:43795 "EHLO
        vie01a-dmta-pe02-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752563AbdHPUQu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:50 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kC-0005Lo-Gh
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:48 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGi1v00a5BuuEg01wGjLk; Wed, 16 Aug 2017 22:16:43 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 5A21545D4512; Wed, 16 Aug 2017 22:16:42 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 08/19] Convert fsck.c & commit.c to size_t
Date:   Wed, 16 Aug 2017 22:16:20 +0200
Message-Id: <1502914591-26215-9-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 builtin/replace.c |  2 +-
 commit.c          | 14 +++++++-------
 commit.h          |  8 ++++----
 fsck.c            | 14 +++++++-------
 fsck.h            |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index f4a85a1..dcd0d1e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -391,7 +391,7 @@ static int create_graft(int argc, const char **argv, int force)
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *buffer;
-	unsigned long size;
+	size_t size;
 
 	if (get_oid(old_ref, &old) < 0)
 		die(_("Not a valid object name: '%s'"), old_ref);
diff --git a/commit.c b/commit.c
index 79decc2..5ebac6a 100644
--- a/commit.c
+++ b/commit.c
@@ -231,19 +231,19 @@ int unregister_shallow(const struct object_id *oid)
 
 struct commit_buffer {
 	void *buffer;
-	unsigned long size;
+	size_t size;
 };
 define_commit_slab(buffer_slab, struct commit_buffer);
 static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
 
-void set_commit_buffer(struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer(struct commit *commit, void *buffer, size_t size)
 {
 	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
 	v->buffer = buffer;
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer(const struct commit *commit, size_t *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (!v) {
@@ -256,7 +256,7 @@ const void *get_cached_commit_buffer(const struct commit *commit, unsigned long
 	return v->buffer;
 }
 
-const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *get_commit_buffer(const struct commit *commit, size_t *sizep)
 {
 	const void *ret = get_cached_commit_buffer(commit, sizep);
 	if (!ret) {
@@ -291,7 +291,7 @@ void free_commit_buffer(struct commit *commit)
 	}
 }
 
-const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
+const void *detach_commit_buffer(struct commit *commit, size_t *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	void *ret;
@@ -1128,7 +1128,7 @@ int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature)
 {
 
-	unsigned long size;
+	size_t size;
 	const char *buffer = get_commit_buffer(commit, &size);
 	int in_signature, saw_signature = -1;
 	const char *line, *tail;
@@ -1284,7 +1284,7 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 						      const char **exclude)
 {
 	struct commit_extra_header *extra = NULL;
-	unsigned long size;
+	size_t size;
 	const char *buffer = get_commit_buffer(commit, &size);
 	extra = read_commit_extra_header_lines(buffer, size, exclude);
 	unuse_commit_buffer(commit, buffer);
diff --git a/commit.h b/commit.h
index 82e966e..fd44de3 100644
--- a/commit.h
+++ b/commit.h
@@ -70,20 +70,20 @@ void parse_commit_or_die(struct commit *item);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct commit *, void *buffer, unsigned long size);
+void set_commit_buffer(struct commit *, void *buffer, size_t size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(const struct commit *, unsigned long *size);
+const void *get_cached_commit_buffer(const struct commit *, size_t *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
  * from disk. The resulting memory should not be modified, and must be given
  * to unuse_commit_buffer when the caller is done.
  */
-const void *get_commit_buffer(const struct commit *, unsigned long *size);
+const void *get_commit_buffer(const struct commit *, size_t *size);
 
 /*
  * Tell the commit subsytem that we are done with a particular commit buffer.
@@ -102,7 +102,7 @@ void free_commit_buffer(struct commit *);
  * Disassociate any cached object buffer from the commit, but do not free it.
  * The buffer (or NULL, if none) is returned.
  */
-const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
+const void *detach_commit_buffer(struct commit *, size_t *sizep);
 
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
diff --git a/fsck.c b/fsck.c
index feca3a8..9039373 100644
--- a/fsck.c
+++ b/fsck.c
@@ -632,18 +632,18 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 	return retval;
 }
 
-static int verify_headers(const void *data, unsigned long size,
+static int verify_headers(const void *data, size_t size,
 			  struct object *obj, struct fsck_options *options)
 {
 	const char *buffer = (const char *)data;
-	unsigned long i;
+	size_t i;
 
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
 			return report(options, obj,
 				FSCK_MSG_NUL_IN_HEADER,
-				"unterminated header: NUL at offset %ld", i);
+				"unterminated header: NUL at offset %" PRIuMAX, (uintmax_t)i);
 		case '\n':
 			if (i + 1 < size && buffer[i + 1] == '\n')
 				return 0;
@@ -708,7 +708,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 }
 
 static int fsck_commit_buffer(struct commit *commit, const char *buffer,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
@@ -786,7 +786,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 }
 
 static int fsck_commit(struct commit *commit, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
 	int ret = fsck_commit_buffer(commit, buffer, size, options);
@@ -890,7 +890,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 }
 
 static int fsck_tag(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	struct object *tagged = tag->tagged;
 
@@ -900,7 +900,7 @@ static int fsck_tag(struct tag *tag, const char *data,
 	return fsck_tag_buffer(tag, data, size, options);
 }
 
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options)
 {
 	if (!obj)
diff --git a/fsck.h b/fsck.h
index 4525510..3de5807 100644
--- a/fsck.h
+++ b/fsck.h
@@ -50,7 +50,7 @@ struct fsck_options {
  */
 int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 /* If NULL is passed for data, we assume the object is local and read it. */
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options);
 
 #endif
-- 
2.1.4

