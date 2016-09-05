Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3D820705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbcIEVLS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:11:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34739 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933158AbcIEVLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:11:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id w12so5851901wmf.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ND015OwYXqlpsINd1eqnBTBEWfb21HG45yqWXUbLzME=;
        b=KmOHasRTyE1N6wy7Wm97QzvsnBdK3ioHXO8ys5rFmbZnJJQz5BH391XgMaeZQ2Y1Db
         mp0xKhyL8P4/9dcUS5Wgc7aomf6B3ZJHrorphrf+a2k2sv2ew83SKoK0Ak3f62BNIcsL
         BgSNS449Z61YtWoorbU0HurBMi02+92BW5Vq0A5mzo0dSSRDp6mUilJF47vZXH0LsBJq
         TeU8MrQmWofY1rnPxWE3Xmdunu5jJaiXos0+n6IGnIJ1kYJ0SctSIQi1BXqDpwkWtPq2
         NJKQnPfhT3acY5hVT7kxjDZ4OzlvVJi2eI5rVELwLnMYD9/IhEgrwzhPq4m0jtmri/xa
         JVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ND015OwYXqlpsINd1eqnBTBEWfb21HG45yqWXUbLzME=;
        b=EMSLte33Ueh1TwpWpBZBcXMHVEqFmyG7u1Mb/5zNE126Mz5MSEtckkTFtt6HiYsdb/
         Lj9iVb08o8YyTw0+3atrEvtGeYBK9LqmFEyTTlcvuVmujb1C6hU5RUDbVM+zpl76eaJn
         OE1NCPMZJyI797NhIIyGhqbjH2ZJ3dFXUvxCkzWx/nAK1R+F7H4EIHefx4r412maBeZA
         Di9hqkU+iwGFvr4YmgXEHwRgrosyPWY7J0d8PuuppMfIlO1pmA5NAPae/6IeNbp6c6Zp
         z6IDiB5gJvT/TWzTcmRIEwhHHH2xnVo7uQNiU83jaVukotltk9nErhZVmh1oq7aVyO6u
         u6FQ==
X-Gm-Message-State: AE9vXwPZ/6sma24FIXEmtINh/5eri7y9PfDI2sVUd6GTcjJcmmzsEpwXngqBJu/6NuDulQ==
X-Received: by 10.28.35.76 with SMTP id j73mr14920946wmj.18.1473109875384;
        Mon, 05 Sep 2016 14:11:15 -0700 (PDT)
Received: from far1pr3662.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id r4sm29555818wjs.13.2016.09.05.14.11.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 14:11:14 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, Johannes.Schindelin@gmx.de,
        e@80x24.org, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 1/2] sha1_file: open window into packfiles with CLOEXEC
Date:   Mon,  5 Sep 2016 23:11:10 +0200
Message-Id: <20160905211111.72956-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160905211111.72956-1-larsxschneider@gmail.com>
References: <20160905211111.72956-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

All processes that the Git main process spawns inherit the open file
descriptors of the main process. These leaked file descriptors can
cause problems.

Use the CLOEXEC flag similar to 05d1ed61 to fix the leaked file
descriptors.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 pack-bitmap.c          |  2 +-
 sha1_file.c            | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4a63398..a2b1fb6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -718,7 +718,7 @@ static off_t write_reused_pack(struct sha1file *f)
 	if (!is_pack_valid(reuse_packfile))
 		die("packfile is invalid: %s", reuse_packfile->pack_name);
 
-	fd = git_open_noatime(reuse_packfile->pack_name);
+	fd = git_open_noatime_cloexec(reuse_packfile->pack_name);
 	if (fd < 0)
 		die_errno("unable to open packfile for reuse: %s",
 			  reuse_packfile->pack_name);
diff --git a/cache.h b/cache.h
index b780a91..ae79747 100644
--- a/cache.h
+++ b/cache.h
@@ -1089,7 +1089,7 @@ extern int write_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
-extern int git_open_noatime(const char *name);
+extern int git_open_noatime_cloexec(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b949e51..1b39e5d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -266,7 +266,7 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 		return -1;
 
 	idx_name = pack_bitmap_filename(packfile);
-	fd = git_open_noatime(idx_name);
+	fd = git_open_noatime_cloexec(idx_name);
 	free(idx_name);
 
 	if (fd < 0)
diff --git a/sha1_file.c b/sha1_file.c
index 3045aea..c1701dc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -356,7 +356,7 @@ void read_info_alternates(const char * relative_base, int depth)
 	int fd;
 
 	path = xstrfmt("%s/info/alternates", relative_base);
-	fd = git_open_noatime(path);
+	fd = git_open_noatime_cloexec(path);
 	free(path);
 	if (fd < 0)
 		return;
@@ -550,7 +550,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = git_open_noatime(path);
+	int fd = git_open_noatime_cloexec(path);
 	struct stat st;
 
 	if (fd < 0)
@@ -956,7 +956,7 @@ static int open_packed_git_1(struct packed_git *p)
 	while (pack_max_fds <= pack_open_fds && close_one_pack())
 		; /* nothing */
 
-	p->pack_fd = git_open_noatime(p->pack_name);
+	p->pack_fd = git_open_noatime_cloexec(p->pack_name);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 	pack_open_fds++;
@@ -1459,9 +1459,9 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-int git_open_noatime(const char *name)
+int git_open_noatime_cloexec(const char *name)
 {
-	static int sha1_file_open_flag = O_NOATIME;
+	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
 
 	for (;;) {
 		int fd;
@@ -1505,7 +1505,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	fd = git_open_noatime(sha1_file_name(sha1));
+	fd = git_open_noatime_cloexec(sha1_file_name(sha1));
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
@@ -1513,7 +1513,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		fill_sha1_path(alt->name, sha1);
-		fd = git_open_noatime(alt->base);
+		fd = git_open_noatime_cloexec(alt->base);
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)
-- 
2.10.0

