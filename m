Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B7420372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbdJOWIC (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55138 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751655AbdJOWH5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 16A3260461;
        Sun, 15 Oct 2017 22:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105275;
        bh=GLCkjvmy5gTMkurTNskq0yiD7jqLVWVFtR43jIso8Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bc3VeHOGyYlg5f0gGz1t5z+9zKKFOvj1tMC3Kb/6pq/OmRCkNLq2JoWFz8ogRr8bg
         wKcSSK3MfviAbVINc2Rlz2XYn4P3AqNrt/LjxOMwhkkfIjsqeoesHQNgB8GUlPRSGV
         ChldpqAI+sfmC5RsabDgM+YYjQ7P1xJfmhhuk1DtjJ4p27W7WRQ1IXR/SSBkoEikfG
         40dMqavq8VzeEEw2VqcjmzZjGG+wUVQHseyYQNiIHMYp+WHNU2yaaBshbrXDPbXBfn
         OPzUQy9RAZ39MEFzHTqMWOemTrTbJuZtqGPG4ThMDM1dS8r/jzkEEcBGhbOli1r9bO
         5ZTzHeqhlHWejpguqUbVvzQSrMwVU+2RXBnAdzQM1aqKPX5vLCU6ql4gA18qSO07cY
         URi71sveKJgrC8xT7u0hcDiXXH3RwX31yGkPhHHYOl/GoiJmhhY+H2ga/l1dk+1wJ3
         wJfhVEiAGWKFez5Ok1DzTcbHnx5YlX4JKrU1jaCGGlgs417Txdi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 18/25] sha1_file: convert index_path and index_fd to struct object_id
Date:   Sun, 15 Oct 2017 22:07:05 +0000
Message-Id: <20171015220712.97308-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
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
index 10c3a0083d..cd910b2103 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1664,7 +1664,7 @@ static void check_tag(const void *buf, size_t size)
 		die("corrupt tag");
 }
 
-static int index_mem(unsigned char *sha1, void *buf, size_t size,
+static int index_mem(struct object_id *oid, void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
@@ -1695,15 +1695,15 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
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
@@ -1718,22 +1718,22 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 
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
@@ -1742,14 +1742,14 @@ static int index_pipe(unsigned char *sha1, int fd, enum object_type type,
 
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
 		ssize_t read_result = read_in_full(fd, buf, size);
@@ -1760,11 +1760,11 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
 			ret = error("short read while indexing %s",
 				    path ? path : "<unknown>");
 		else
-			ret = index_mem(sha1, buf, size, type, path, flags);
+			ret = index_mem(oid, buf, size, type, path, flags);
 		free(buf);
 	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, type, path, flags);
+		ret = index_mem(oid, buf, size, type, path, flags);
 		munmap(buf, size);
 	}
 	return ret;
@@ -1802,12 +1802,12 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
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
2.15.0.rc0.271.g36b669edcc

