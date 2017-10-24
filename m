Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435611FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbdJXSyC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:22463 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdJXSx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:53:58 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B59EC84593;
        Tue, 24 Oct 2017 14:53:57 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 23B7484597;
        Tue, 24 Oct 2017 14:53:57 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 01/13] dir: allow exclusions from blob in addition to file
Date:   Tue, 24 Oct 2017 18:53:20 +0000
Message-Id: <20171024185332.57261-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Refactor add_excludes() to separate the reading of the
exclude file into a buffer and the parsing of the buffer
into exclude_list items.

Add add_excludes_from_blob_to_list() to allow an exclude
file be specified with an OID.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 dir.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 dir.h |  3 +++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 1d17b80..d848f2b 100644
--- a/dir.c
+++ b/dir.c
@@ -739,6 +739,10 @@ static void invalidate_directory(struct untracked_cache *uc,
 		dir->dirs[i]->recurse = 0;
 }
 
+static int add_excludes_from_buffer(char *buf, size_t size,
+				    const char *base, int baselen,
+				    struct exclude_list *el);
+
 /*
  * Given a file with name "fname", read it (either from disk, or from
  * an index if 'istate' is non-null), parse it and store the
@@ -754,9 +758,9 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			struct sha1_stat *sha1_stat)
 {
 	struct stat st;
-	int fd, i, lineno = 1;
+	int fd;
 	size_t size = 0;
-	char *buf, *entry;
+	char *buf;
 
 	fd = open(fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0) {
@@ -813,6 +817,17 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		}
 	}
 
+	add_excludes_from_buffer(buf, size, base, baselen, el);
+	return 0;
+}
+
+static int add_excludes_from_buffer(char *buf, size_t size,
+				    const char *base, int baselen,
+				    struct exclude_list *el)
+{
+	int i, lineno = 1;
+	char *entry;
+
 	el->filebuf = buf;
 
 	if (skip_utf8_bom(&buf, size))
@@ -841,6 +856,38 @@ int add_excludes_from_file_to_list(const char *fname, const char *base,
 	return add_excludes(fname, base, baselen, el, istate, NULL);
 }
 
+int add_excludes_from_blob_to_list(
+	struct object_id *oid,
+	const char *base, int baselen,
+	struct exclude_list *el)
+{
+	char *buf;
+	unsigned long size;
+	enum object_type type;
+
+	buf = read_sha1_file(oid->hash, &type, &size);
+	if (!buf)
+		return -1;
+
+	if (type != OBJ_BLOB) {
+		free(buf);
+		return -1;
+	}
+
+	if (size == 0) {
+		free(buf);
+		return 0;
+	}
+
+	if (buf[size - 1] != '\n') {
+		buf = xrealloc(buf, st_add(size, 1));
+		buf[size++] = '\n';
+	}
+
+	add_excludes_from_buffer(buf, size, base, baselen, el);
+	return 0;
+}
+
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
diff --git a/dir.h b/dir.h
index e371705..1bcf391 100644
--- a/dir.h
+++ b/dir.h
@@ -256,6 +256,9 @@ extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
 					  struct exclude_list *el, struct  index_state *istate);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
+extern int add_excludes_from_blob_to_list(struct object_id *oid,
+					  const char *base, int baselen,
+					  struct exclude_list *el);
 extern void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
-- 
2.9.3

