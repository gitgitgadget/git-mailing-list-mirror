Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536C21F744
	for <e@80x24.org>; Sun, 10 Jul 2016 10:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbcGJKqu (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 06:46:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33788 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcGJKqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 06:46:48 -0400
Received: by mail-lf0-f66.google.com with SMTP id f93so112775lfi.0
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 03:46:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Si12nZcOmn6a8sGX0WszlqNBRJ5sTG5GLOp1JIEpsSE=;
        b=L73Yow//hZzuzczFDZc7z6zA/u8bt6iRIZSnvHAK9/WFDMt9clIVMq5q+0SR1La/Lm
         mCfu9mqU9osAVvrmj0g4H9Kb/MMXm+x+auJSvTAaghtRNPESGCW01VgGd5Gflo19RWSf
         h19pYrzSGbwu6um70wRnSmeTGz+BsKqkoTIp1GyTtw/JZvVVpZPftm4iyaJzXwEjInZt
         kw49V/nK8A5DgFJFvZVxhW5q5tayAw0W+0LJ9tCw7fv6ND784N9L2s55DKCp1k8uICHd
         6nDIxT2vbPQiGLljAKHXbQN/Prlmp3GgSxj0VP2P7AxqpIL+Di4j3Gyj3jLhE5zdaAfk
         5AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Si12nZcOmn6a8sGX0WszlqNBRJ5sTG5GLOp1JIEpsSE=;
        b=L7eLLfjreDzLVYCvFE5LWrMz0pg8YFa7rmah02bkEL8OyCPLsfuBPkTWDWprPBTE4b
         C2VMDcg2rIvicDOJxi1LzO/Xl7Z0FWw41kJdwo/5P61k4b+HWelQWTF90p8MHhcSon8t
         br2EUaKii5Qkjnk100xDLeNnUoo2LWeJSVDz6z2fcwm6keE7oydP0QxxJHdBA7GpysSu
         E5VUhHF9R9ThBR1bzF8xO+I13X2dREO6/5A66AF5mXb0lI1Kdi9RiGUFRlnuffOahNRp
         1W3qoghXYOwNofzJpDGbdL/6LAVYOzLQMrD3OcDDzFbwUAqPTekxgRkbfTcgNPgWxrfo
         18nw==
X-Gm-Message-State: ALyK8tK28W+KG2uCfT69bmpTFG2mIa8hJrzxpR9N1ld6tm2KcmxWqLd9bzLJ8ClW3XuevA==
X-Received: by 10.25.80.136 with SMTP id e130mr4177780lfb.115.1468147606646;
        Sun, 10 Jul 2016 03:46:46 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id j12sm10146883lfb.37.2016.07.10.03.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Jul 2016 03:46:45 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/5] fsck: use streaming interface for large blobs in pack
Date:	Sun, 10 Jul 2016 12:45:55 +0200
Message-Id: <20160710104555.27478-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For blobs, we want to make sure the on-disk data is not corrupted
(i.e. can be inflated and produce the expected SHA-1). Blob content is
opaque, there's nothing else inside to check for.

For really large blobs, we may want to avoid unpacking the entire blob
in memory, just to check whether it produces the same SHA-1. On 32-bit
systems, we may not have enough virtual address space for such memory
allocation. And even on 64-bit where it's not a problem, allocating a
lot more memory could result in kicking other parts of systems to swap
file, generating lots of I/O and slowing everything down.

For this particular operation, not unpacking the blob and letting
check_sha1_signature, which supports streaming interface, do the job
is sufficient. check_sha1_signature() is not shown in the diff,
unfortunately. But if will be called when "data_valid && !data" is
false.

We will call the callback function "fn" with NULL as "data". The only
callback of this function is fsck_obj_buffer(), which does not touch
"data" at all if it's a blob.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-check.c | 15 +++++++++++++--
 pack.h       |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 1da89a4..0777766 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -105,6 +105,8 @@ static int verify_packfile(struct packed_git *p,
 		void *data;
 		enum object_type type;
 		unsigned long size;
+		off_t curpos;
+		int data_valid = 0;
 
 		if (p->index_version > 1) {
 			off_t offset = entries[i].offset;
@@ -116,8 +118,17 @@ static int verify_packfile(struct packed_git *p,
 					    sha1_to_hex(entries[i].sha1),
 					    p->pack_name, (uintmax_t)offset);
 		}
-		data = unpack_entry(p, entries[i].offset, &type, &size);
-		if (!data)
+
+		curpos = entries[i].offset;
+		type = unpack_object_header(p, w_curs, &curpos, &size);
+		unuse_pack(w_curs);
+
+		if (type != OBJ_BLOB || size < big_file_threshold) {
+			data = unpack_entry(p, entries[i].offset, &type, &size);
+			data_valid = 1;
+		}
+
+		if (data_valid && !data)
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    sha1_to_hex(entries[i].sha1), p->pack_name,
 				    (uintmax_t)entries[i].offset);
diff --git a/pack.h b/pack.h
index 3223f5a..0e77429 100644
--- a/pack.h
+++ b/pack.h
@@ -74,6 +74,7 @@ struct pack_idx_entry {
 
 
 struct progress;
+/* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const unsigned char*, enum object_type, unsigned long, void*, int*);
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
-- 
2.8.2.537.g0965dd9

