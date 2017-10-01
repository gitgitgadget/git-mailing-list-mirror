Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8507320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbdJAWJL (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54188 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752114AbdJAWJG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B23B60DB9;
        Sun,  1 Oct 2017 22:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895744;
        bh=PYrTM79015LL0UlyeZolPkc0cCqIuK1izeJ+Ucw6n38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djdZeooaBS9VX3J55jpI/9stTocXbNP+1u9QezlTdUl76rQHR7/jmG76+HsqR/YGZ
         T9OepZ1MMnf8dxmgaEEbzPm7HZmDo7JL3vFDdj5KYb4iNuV4dlC2p7dTSG6m+lEdxi
         z7ErEpZIZ/e+6VE8cOKKJop68ngPRLKPdlCDrUjGo9R8H6Gmpav3WtgGUZCY+LY6ni
         lkxhdnzHd/6VipxJJXRwMM0OHFdb+coG2IwiDLJZljC0hu1mUCAgTAc+/sVLvcC49o
         I6GosJFNA+rV+aeF0xbjQq1T6kiJHIPdx4rtXW288EwidFxXoRJ6qq4EMufky4mB+O
         Ztb4137i3wUcQfGwdMYXlVA5AbdD/Ps2lxP3hQmEK2JtpeS1fCx+cofEoDAHECYT3e
         FWRN4atL9Uazxt+I1qT59w4zmifrRfaIp7OmJ3LLlHyxjjWsLQ1AOQAuvKxGmzyA7p
         /jb+BEHjFy2Of7Hd+M4Hs9DgQC/QFXmWHfBUcrjMB8cKZJGV/IH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 17/24] sha1_file: convert index_path and index_fd to struct object_id
Date:   Sun,  1 Oct 2017 22:08:24 +0000
Message-Id: <20171001220831.214705-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert these two functions and the functions that underlie them to take
pointers to struct object_id.  This is a prerequisite to convert
resolve_gitlink_ref.  Fix a stray tab in the middle of the index_mem
call in index_pipe by converting it to a space.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_file.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5a2014811f..793fd2d194 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1660,7 +1660,7 @@ static void check_tag(const void *buf, size_t size)
 		die("corrupt tag");
 }
 
-static int index_mem(unsigned char *sha1, void *buf, size_t size,
+static int index_mem(struct object_id *oid, void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
@@ -1691,15 +1691,15 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), sha1);
+		ret = write_sha1_file(buf, size, typename(type), oid->hash);
 	else
-		ret = hash_sha1_file(buf, size, typename(type), sha1);
+		ret = hash_sha1_file(buf, size, typename(type), oid->hash);
 	if (re_allocated)
 		free(buf);
 	return ret;
 }
 
-static int index_stream_convert_blob(unsigned char *sha1, int fd,
+static int index_stream_convert_blob(struct object_id *oid, int fd,
 				     const char *path, unsigned flags)
 {
 	int ret;
@@ -1714,22 +1714,22 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 
 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-				      sha1);
+				      oid->hash);
 	else
 		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-				     sha1);
+				     oid->hash);
 	strbuf_release(&sbuf);
 	return ret;
 }
 
-static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
+static int index_pipe(struct object_id *oid, int fd, enum object_type type,
 		      const char *path, unsigned flags)
 {
 	struct strbuf sbuf = STRBUF_INIT;
 	int ret;
 
 	if (strbuf_read(&sbuf, fd, 4096) >= 0)
-		ret = index_mem(sha1, sbuf.buf, sbuf.len, type,	path, flags);
+		ret = index_mem(oid, sbuf.buf, sbuf.len, type, path, flags);
 	else
 		ret = -1;
 	strbuf_release(&sbuf);
@@ -1738,24 +1738,24 @@ static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
 
 #define SMALL_FILE_SIZE (32*1024)
 
-static int index_core(unsigned char *sha1, int fd, size_t size,
+static int index_core(struct object_id *oid, int fd, size_t size,
 		      enum object_type type, const char *path,
 		      unsigned flags)
 {
 	int ret;
 
 	if (!size) {
-		ret = index_mem(sha1, "", size, type, path, flags);
+		ret = index_mem(oid, "", size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
-			ret = index_mem(sha1, buf, size, type, path, flags);
+			ret = index_mem(oid, buf, size, type, path, flags);
 		else
 			ret = error_errno("short read");
 		free(buf);
 	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, type, path, flags);
+		ret = index_mem(oid, buf, size, type, path, flags);
 		munmap(buf, size);
 	}
 	return ret;
@@ -1793,12 +1793,12 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
 	 * die() for large files.
 	 */
 	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(path))
-		ret = index_stream_convert_blob(oid->hash, fd, path, flags);
+		ret = index_stream_convert_blob(oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
-		ret = index_pipe(oid->hash, fd, type, path, flags);
+		ret = index_pipe(oid, fd, type, path, flags);
 	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
 		 (path && would_convert_to_git(&the_index, path)))
-		ret = index_core(oid->hash, fd, xsize_t(st->st_size), type, path,
+		ret = index_core(oid, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
 		ret = index_stream(oid, fd, xsize_t(st->st_size), type, path,
-- 
2.14.2.822.g60be5d43e6

