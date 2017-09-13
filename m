Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A12A20286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbdIMRQh (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:37 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62784 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751054AbdIMRQe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:34 -0400
X-AuditID: 1207440e-bf9ff70000007085-ce-59b967f06a4c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.8E.28805.0F769B95; Wed, 13 Sep 2017 13:16:32 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiT001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:30 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/20] read_packed_refs(): use mmap to read the `packed-refs` file
Date:   Wed, 13 Sep 2017 19:15:59 +0200
Message-Id: <67c4bf861beb095a63e8db72f1d37d6bfac39cd0.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqPshfWekQeNkU4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoEro+HkS8aChxIV/yfcYWlg/CzcxcjJISFgIvGtcztT
        FyMXh5DADiaJtQtns0I4J5kk5p++xwxSxSagK7Gop5kJxBYRUJOY2HaIBaSIWeApk8TOk3dZ
        QRLCAkESl17+YAexWQRUJfbdPQRm8wpESazdM4UVYp28xLkHt8GGcgpYSGzc8YQRxBYSMJdo
        nLOTcQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYISHGt4Oxfb3M
        IUYBDkYlHl4Lm52RQqyJZcWVuYcYJTmYlER59+oChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
        BkUB5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIaHBwCvWtWX2CUYsnLz0tV
        kuD9mwY0RLAoNT21Ii0zpwShlImDE2QRD9CiCyA1vMUFibnFmekQ+VOMuhwdN+/+YRICGyQl
        zvs3FahIAKQoozQPbg4sZbxiFAd6UZj3GMgoHmC6gZv0CmgJE9CSM6d3gCwpSURISTUwCtr9
        PB/7w4fZ/sy7bZ8PNJjEtB89+XgBS1RiHZ9cwM9Hlxt3S5zZIZ7f5jzxu87HeqnZ3pq39IJi
        0qemL0wWu7jHWveJ2fTXwqef21k/nFvOezWGd0UfrwJjyYrDIiv2pdcW/L95f+Erxh+vyt7a
        rbKcenLNGrOgvffnrpE4EafQmOiiqaB/X4mlOCPRUIu5qDgRAANJbkj0AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's still done in a pretty stupid way, involving more data copying
than necessary. That will improve in future commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5c50c223ef..154abbd83a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -215,8 +215,12 @@ static NORETURN void die_invalid_line(const char *path,
  */
 static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 {
-	FILE *f;
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
+	int fd;
+	struct stat st;
+	size_t size;
+	char *buf;
+	const char *pos, *eol, *eof;
 	struct ref_entry *last = NULL;
 	struct strbuf line = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
@@ -227,8 +231,8 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	packed_refs->cache = create_ref_cache(NULL, NULL);
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 
-	f = fopen(refs->path, "r");
-	if (!f) {
+	fd = open(refs->path, O_RDONLY);
+	if (fd < 0) {
 		if (errno == ENOENT) {
 			/*
 			 * This is OK; it just means that no
@@ -241,16 +245,27 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		}
 	}
 
-	stat_validity_update(&packed_refs->validity, fileno(f));
+	stat_validity_update(&packed_refs->validity, fd);
+
+	if (fstat(fd, &st) < 0)
+		die_errno("couldn't stat %s", refs->path);
+
+	size = xsize_t(st.st_size);
+	buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	pos = buf;
+	eof = buf + size;
 
 	dir = get_ref_dir(packed_refs->cache->root);
-	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
+	while (pos < eof) {
 		struct object_id oid;
 		const char *refname;
 		const char *traits;
 
-		if (!line.len || line.buf[line.len - 1] != '\n')
-			die_unterminated_line(refs->path, line.buf, line.len);
+		eol = memchr(pos, '\n', eof - pos);
+		if (!eol)
+			die_unterminated_line(refs->path, pos, eof - pos);
+
+		strbuf_add(&line, pos, eol + 1 - pos);
 
 		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
@@ -258,7 +273,7 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			else if (strstr(traits, " peeled "))
 				peeled = PEELED_TAGS;
 			/* perhaps other traits later as well */
-			continue;
+			goto next_line;
 		}
 
 		refname = parse_ref_line(&line, &oid);
@@ -291,11 +306,18 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		} else {
 			die_invalid_line(refs->path, line.buf, line.len);
 		}
+
+	next_line:
+		/* The "+ 1" is for the LF character. */
+		pos = eol + 1;
+		strbuf_reset(&line);
 	}
 
-	fclose(f);
-	strbuf_release(&line);
+	if (munmap(buf, size))
+		die_errno("error ummapping packed-refs file");
+	close(fd);
 
+	strbuf_release(&line);
 	return packed_refs;
 }
 
-- 
2.14.1

