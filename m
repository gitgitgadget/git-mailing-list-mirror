Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B822027C
	for <e@80x24.org>; Sun, 16 Jul 2017 12:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdGPMRz (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 08:17:55 -0400
Received: from mout.web.de ([212.227.15.14]:61880 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdGPMRy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 08:17:54 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsQDw-1ddPXH0w48-011xHl; Sun, 16
 Jul 2017 14:17:39 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] dir: support platforms that require aligned reads
Message-ID: <d3db2984-f238-7166-affa-f1f7df566404@web.de>
Date:   Sun, 16 Jul 2017 14:17:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:X3Y7yRINmD5ydgJAME3xa4TPLvshA8CUziDE+NZFz++zal0oqe2
 8Bjve+VQgKtIaiC0w2c8U+nv0FFOXjxwNBzTJGnjTWe0br9ezgKYJYT3aXwNymcNqeWsTaE
 8VfkKTWGVMuXr6MS7HuNS0VpKxfo1UursMcq0Jwt2RPU0JDmS1CAwB+G1UijkhHLHlCt7Jc
 5yAuV/QdiFo1Zgg8yDNUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rA999hIVzpw=:XzdUXywSWtowcJ4h1MGxVr
 pPoYFGFVfhOSTTkgs/1xxV8pjuchwI/IukfiziQdQLOCU+Mo73CTSWs/ovFtJ1onU7pyg1w12
 2lfeL4TQrStB1BUR+zhawMo/wpeh8NiwqQ7J6uvAtWn0Q05e5RmkkMQy8JqJObV4uz8c0XIn+
 A77EZNq3GTwqFqX8Cnl3E7DJVuBlrJ7498zjBXHDyqrD5dAm7Jq7ocqJOn6t3buNiHNtdDtSa
 hJ26K2qVpcIFhlmW4oi63OduVfjH+rfhPT2j9mAh7l3MalCw7T5hJZvtkuhqA0FY+jd0d5Dod
 UzbQ9SvBotWUyQR261GuK4eiOp5qXqeBNcpPpuF2NjQ4Dz2l+kU5zdQfKay+WITRWRjmwnc/G
 jnPzVWP8U+xcBF/1Gv8gBqig++Cc88FEaptURRn+965zpOjwFOYUN1fT0+1hgVKlYamh5Iig2
 nzXjOZrUidDvMCZ1sPKgrP6WlFc7c8fGp45LDwbE9rfd+hB6GeosrxqT1+bgLZMCV4lxAA8av
 3u38w8LgD1OWoFv+kI7rAMwUi3Gk9WOJn8lL7YTdi5JY10NDzfAghI9foOqY/2/BlOWORArDC
 p6tGkpa4LAqaeS2S8qgcth0Giy/XNbZBMJTPsCjFKu6J6fPfQUFhqtFDHXCFXmOQJ/7zovD6c
 +uj04Ckr7ojRwrfDvMlE89zgMI9aDa7fA1DV0Sa4fH83m01U2yRRGdaf+N4+pp5XLK4zXGxTV
 9mJdnKVUhqvGAT6lK+zS5r848+2bagIAZBa2YNFEcpLGRpZ0r+edOg7rp4YjdPjeE9RbfIFid
 Y5aqr5BI7RN2R5Qx5uZzycOwDWLKEqPM2xgD69i3Dq+qAMl2w4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The untracked cache is stored on disk by concatenating its memory
structures without any padding.  Consequently some of the structs are
not aligned at a particular boundary when the whole extension is read
back in one go.  That's only OK on platforms without strict alignment
requirements, or for byte-aligned data like strings or hash values.

Decode struct ondisk_untracked_cache carefully from the extension
blob by using explicit pointer arithmetic with offsets, avoiding
alignment issues.  Use char pointers for passing stat_data objects to
stat_data_from_disk(), and use memcpy(3) in that function to  get the
contents into a properly aligned struct, then perform the byte-order
adjustment in place there.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Side note: The OS name is not enough for determining the layout of
struct ondisk_untracked_cache.  Different platforms can have
different int sizes and padding.  Adding the machine type could
help, but that would be a breaking change.  At that point we would
be better off defining a machine-independent format, no?

 dir.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index ae6f5c9636..1c55dc3e36 100644
--- a/dir.c
+++ b/dir.c
@@ -2398,7 +2398,8 @@ struct ondisk_untracked_cache {
 	char exclude_per_dir[FLEX_ARRAY];
 };
 
-#define ouc_size(len) (offsetof(struct ondisk_untracked_cache, exclude_per_dir) + len + 1)
+#define ouc_offset(x) offsetof(struct ondisk_untracked_cache, x)
+#define ouc_size(len) (ouc_offset(exclude_per_dir) + len + 1)
 
 struct write_data {
 	int index;	   /* number of written untracked_cache_dir */
@@ -2560,17 +2561,18 @@ struct read_data {
 	const unsigned char *end;
 };
 
-static void stat_data_from_disk(struct stat_data *to, const struct stat_data *from)
+static void stat_data_from_disk(struct stat_data *to, const unsigned char *data)
 {
-	to->sd_ctime.sec  = get_be32(&from->sd_ctime.sec);
-	to->sd_ctime.nsec = get_be32(&from->sd_ctime.nsec);
-	to->sd_mtime.sec  = get_be32(&from->sd_mtime.sec);
-	to->sd_mtime.nsec = get_be32(&from->sd_mtime.nsec);
-	to->sd_dev	  = get_be32(&from->sd_dev);
-	to->sd_ino	  = get_be32(&from->sd_ino);
-	to->sd_uid	  = get_be32(&from->sd_uid);
-	to->sd_gid	  = get_be32(&from->sd_gid);
-	to->sd_size	  = get_be32(&from->sd_size);
+	memcpy(to, data, sizeof(*to));
+	to->sd_ctime.sec  = ntohl(to->sd_ctime.sec);
+	to->sd_ctime.nsec = ntohl(to->sd_ctime.nsec);
+	to->sd_mtime.sec  = ntohl(to->sd_mtime.sec);
+	to->sd_mtime.nsec = ntohl(to->sd_mtime.nsec);
+	to->sd_dev	  = ntohl(to->sd_dev);
+	to->sd_ino	  = ntohl(to->sd_ino);
+	to->sd_uid	  = ntohl(to->sd_uid);
+	to->sd_gid	  = ntohl(to->sd_gid);
+	to->sd_size	  = ntohl(to->sd_size);
 }
 
 static int read_one_dir(struct untracked_cache_dir **untracked_,
@@ -2645,7 +2647,7 @@ static void read_stat(size_t pos, void *cb)
 		rd->data = rd->end + 1;
 		return;
 	}
-	stat_data_from_disk(&ud->stat_data, (struct stat_data *)rd->data);
+	stat_data_from_disk(&ud->stat_data, rd->data);
 	rd->data += sizeof(struct stat_data);
 	ud->valid = 1;
 }
@@ -2663,22 +2665,22 @@ static void read_sha1(size_t pos, void *cb)
 }
 
 static void load_sha1_stat(struct sha1_stat *sha1_stat,
-			   const struct stat_data *stat,
+			   const unsigned char *data,
 			   const unsigned char *sha1)
 {
-	stat_data_from_disk(&sha1_stat->stat, stat);
+	stat_data_from_disk(&sha1_stat->stat, data);
 	hashcpy(sha1_stat->sha1, sha1);
 	sha1_stat->valid = 1;
 }
 
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
 {
-	const struct ondisk_untracked_cache *ouc;
 	struct untracked_cache *uc;
 	struct read_data rd;
 	const unsigned char *next = data, *end = (const unsigned char *)data + sz;
 	const char *ident;
 	int ident_len, len;
+	const char *exclude_per_dir;
 
 	if (sz <= 1 || end[-1] != '\0')
 		return NULL;
@@ -2690,21 +2692,23 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	ident = (const char *)next;
 	next += ident_len;
 
-	ouc = (const struct ondisk_untracked_cache *)next;
 	if (next + ouc_size(0) > end)
 		return NULL;
 
 	uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
-	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
-		       ouc->info_exclude_sha1);
-	load_sha1_stat(&uc->ss_excludes_file, &ouc->excludes_file_stat,
-		       ouc->excludes_file_sha1);
-	uc->dir_flags = get_be32(&ouc->dir_flags);
-	uc->exclude_per_dir = xstrdup(ouc->exclude_per_dir);
+	load_sha1_stat(&uc->ss_info_exclude,
+		       next + ouc_offset(info_exclude_stat),
+		       next + ouc_offset(info_exclude_sha1));
+	load_sha1_stat(&uc->ss_excludes_file,
+		       next + ouc_offset(excludes_file_stat),
+		       next + ouc_offset(excludes_file_sha1));
+	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
+	exclude_per_dir = (const char *)next + ouc_offset(exclude_per_dir);
+	uc->exclude_per_dir = xstrdup(exclude_per_dir);
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
-	next += ouc_size(strlen(ouc->exclude_per_dir));
+	next += ouc_size(strlen(exclude_per_dir));
 	if (next >= end)
 		goto done2;
 
-- 
2.13.3
