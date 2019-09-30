Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF3F1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfI3Bva (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37827 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfI3Bva (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so14998555qtr.4
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgiB40YHaRVet1Sl9BloM9o+wnaTv1b6Qxmf3/gnBVI=;
        b=ToSfrbTEgOhkOg2tinGqYc3vLv5sdaDmnDVrlpJVQHFdiZIBIfEf1yb57hzO/2eHz5
         N4rnHN4Ig1O9qCYR0agidAtmpurCaZZOktmMPqUP1yOsidvlVpUBFCVATtREAnJDQBrD
         ZfHl4HuB7M3JaUAyoEjQtNNe1Ldlco9O1iocZbdCaKB/tIZ3r0Fn50qTF/YfCJc5mKHv
         PuLrmINEHfQe0QfPFAVHbU9R6Y5eQoQGnoaNDplfYLnyztpDRZf63f6oquGn1QYR5+Iu
         Z5tGndsuk2tPoZ4JEHpyAVuXLcsT/bo7UbASYhhYLDFu8hSDrAe3b9Vzx8B/05lk/sOP
         deIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgiB40YHaRVet1Sl9BloM9o+wnaTv1b6Qxmf3/gnBVI=;
        b=Ju6YNeWEM8o/SkUarzOOJnr5zvG2ioKjbK7b2Bs1Xz8UthU0D1c4+x8/QKwBQ4/PWQ
         DjgubfGzSCrF+K95oUqGta8N9BCxqT9o1h95WJRjIQyq7aduMKrIOLangCAENhrMFXyC
         yzsbqV4fmjcBb4JWD5XsySJ8J4pRIyE8OFvo6PDgxOOf5BBMLNtOLs4Uzc/Yo3Cga3tT
         QrDrYmbXbSYnRQo8t94ypmK7AayYwR8ZvBjCskDAEpLVEXv/VJ4LQCaSOShDmFcgyxu7
         ViDI7XEy2Lj9u1jjrnX3AbXrQDy5MMS1egXtv3iBj+VWrQsbxFZX5hxGdR3GEhQeV8SU
         crYQ==
X-Gm-Message-State: APjAAAUhUuc25/lE5zYF0lwklU3qq2FIvF9GxSfLX7zVOnkxvLgyW56T
        7/hyMqjOUstFGe7QfSUGj3BIEdjgxFE=
X-Google-Smtp-Source: APXvYqyV188mKs7XrkpyMjBZeUM7NHgY6Wg859aZT0jdsorRLuSUudPKnrHJ5V7N8JgGCbWYify+DQ==
X-Received: by 2002:ac8:50c:: with SMTP id u12mr22205686qtg.322.1569808288773;
        Sun, 29 Sep 2019 18:51:28 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:28 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 05/11] object-store: allow threaded access to object reading
Date:   Sun, 29 Sep 2019 22:50:51 -0300
Message-Id: <4c5652ab34f0989856aba919ca84b2b091dcad98.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow object reading to be performed by multiple threads protecting it
with an internal lock. The lock usage can be toggled with
enable_obj_read_lock() and disable_obj_read_lock(). Currently, the
functions which can be safely called in parallel are:
read_object_file_extended(), repo_read_object_file(),
read_object_file(), read_object_with_reference(), read_object(),
oid_object_info() and oid_object_info_extended(). It's also possible to
use obj_read_lock() and obj_read_unlock() to protect other sections that
cannot execute in parallel with object reading.

Probably there are many spots in the functions listed above that could
be executed unlocked (and thus, in parallel). But, for now, we are most
interested in allowing parallel access to zlib inflation. This is one of
the sections where object reading spends most of the time and it's
already thread-safe. So, to take advantage of that, the respective lock
is released when calling git_inflate() and re-acquired right after, for
every calling spot in oid_object_info_extended()'s call chain. We may
refine the lock to also exploit other possible parallel spots in the
future, but threaded zlib inflation should already give great speedups
for now.

Note that add_delta_base_cache() was also modified to skip adding
already present entries to the cache. This wasn't possible before, but
now it is since phase I and phase III of unpack_entry() may execute
concurrently.

Another important thing to notice is that the object reading lock only
works in conjunction with the 'struct raw_object_store's replace_mutex.
Otherwise, there would still be racy spots in object reading
functions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 object-store.h | 35 +++++++++++++++++++++++++++++++
 packfile.c     |  7 +++++++
 sha1-file.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index b22e20ad7d..8f63f21ad2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -6,6 +6,7 @@
 #include "list.h"
 #include "sha1-array.h"
 #include "strbuf.h"
+#include "thread-utils.h"
 
 struct object_directory {
 	struct object_directory *next;
@@ -230,6 +231,40 @@ int has_loose_object_nonlocal(const struct object_id *);
 
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
+/*
+ * Enabling the object read lock allows multiple threads to safely call the
+ * following functions in parallel: repo_read_object_file(), read_object_file(),
+ * read_object_file_extended(), read_object_with_reference(), read_object(),
+ * oid_object_info() and oid_object_info_extended().
+ *
+ * obj_read_lock() and obj_read_unlock() may also be used to protect other
+ * section which cannot execute in parallel with object reading. Since the used
+ * lock is a recursive mutex, these sections can even contain calls to object
+ * reading functions. However, beware that in these cases zlib inflation won't
+ * be performed in parallel, losing performance.
+ *
+ * TODO: oid_object_info_extended()'s call stack has a recursive behavior. If
+ * any of its callees end up calling it, this recursive call won't benefit from
+ * parallel inflation.
+ */
+void enable_obj_read_lock(void);
+void disable_obj_read_lock(void);
+
+extern int obj_read_use_lock;
+extern pthread_mutex_t obj_read_mutex;
+
+static inline void obj_read_lock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_lock(&obj_read_mutex);
+}
+
+static inline void obj_read_unlock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_unlock(&obj_read_mutex);
+}
+
 struct object_info {
 	/* Request */
 	enum object_type *typep;
diff --git a/packfile.c b/packfile.c
index 1a7d69fe32..a336972174 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1098,7 +1098,9 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
@@ -1451,6 +1453,9 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
 	struct list_head *lru, *tmp;
 
+	if (get_delta_base_cache_entry(p, base_offset))
+		return;
+
 	delta_base_cached += base_size;
 
 	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
@@ -1580,7 +1585,9 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		if (!stream.avail_out)
 			break; /* the payload is larger than it should be */
 		curpos += stream.next_in - in;
diff --git a/sha1-file.c b/sha1-file.c
index e85f249a5d..b4f2f5cb94 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1148,6 +1148,8 @@ static int unpack_loose_short_header(git_zstream *stream,
 				     unsigned char *map, unsigned long mapsize,
 				     void *buffer, unsigned long bufsiz)
 {
+	int ret;
+
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
 	stream->next_in = map;
@@ -1156,7 +1158,11 @@ static int unpack_loose_short_header(git_zstream *stream,
 	stream->avail_out = bufsiz;
 
 	git_inflate_init(stream);
-	return git_inflate(stream, 0);
+	obj_read_unlock();
+	ret = git_inflate(stream, 0);
+	obj_read_lock();
+
+	return ret;
 }
 
 int unpack_loose_header(git_zstream *stream,
@@ -1201,7 +1207,9 @@ static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map
 	stream->avail_out = bufsiz;
 
 	do {
+		obj_read_unlock();
 		status = git_inflate(stream, 0);
+		obj_read_lock();
 		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
 		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 			return 0;
@@ -1241,8 +1249,11 @@ static void *unpack_loose_rest(git_zstream *stream,
 		 */
 		stream->next_out = buf + bytes;
 		stream->avail_out = size - bytes;
-		while (status == Z_OK)
+		while (status == Z_OK) {
+			obj_read_unlock();
 			status = git_inflate(stream, Z_FINISH);
+			obj_read_lock();
+		}
 	}
 	if (status == Z_STREAM_END && !stream->avail_in) {
 		git_inflate_end(stream);
@@ -1412,10 +1423,32 @@ static int loose_object_info(struct repository *r,
 	return (status < 0) ? status : 0;
 }
 
+int obj_read_use_lock = 0;
+pthread_mutex_t obj_read_mutex;
+
+void enable_obj_read_lock(void)
+{
+	if (obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 1;
+	init_recursive_mutex(&obj_read_mutex);
+}
+
+void disable_obj_read_lock(void)
+{
+	if (!obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 0;
+	pthread_mutex_destroy(&obj_read_mutex);
+}
+
 int fetch_if_missing = 1;
 
-int oid_object_info_extended(struct repository *r, const struct object_id *oid,
-			     struct object_info *oi, unsigned flags)
+static int do_oid_object_info_extended(struct repository *r,
+				       const struct object_id *oid,
+				       struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
@@ -1423,6 +1456,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	const struct object_id *real = oid;
 	int already_retried = 0;
 
+
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(r, oid);
 
@@ -1498,7 +1532,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	rtype = packed_object_info(r, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real->hash);
-		return oid_object_info_extended(r, real, oi, 0);
+		return do_oid_object_info_extended(r, real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1509,6 +1543,17 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	return 0;
 }
 
+int oid_object_info_extended(struct repository *r, const struct object_id *oid,
+			     struct object_info *oi, unsigned flags)
+{
+	int ret;
+	obj_read_lock();
+	ret = do_oid_object_info_extended(r, oid, oi, flags);
+	obj_read_unlock();
+	return ret;
+}
+
+
 /* returns enum object_type or negative */
 int oid_object_info(struct repository *r,
 		    const struct object_id *oid,
@@ -1581,6 +1626,7 @@ void *read_object_file_extended(struct repository *r,
 	if (data)
 		return data;
 
+	obj_read_lock();
 	if (errno && errno != ENOENT)
 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
 
@@ -1596,6 +1642,7 @@ void *read_object_file_extended(struct repository *r,
 	if ((p = has_packed_and_bad(r, repl->hash)) != NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
+	obj_read_unlock();
 
 	return NULL;
 }
-- 
2.23.0

