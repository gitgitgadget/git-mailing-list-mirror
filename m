Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEADB20193
	for <e@80x24.org>; Mon, 24 Oct 2016 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757501AbcJXSDM (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:03:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35518 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757176AbcJXSDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:03:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so10936290wma.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ydz/V8YCtI36F7ZEWzpqeq1Ptggb3wlckJjOINiceh0=;
        b=MuxVAQrre/SIa6rD7spAuexhYitxGCQ7HEYFgz5eue8j4qMRX3A9zfIe1B3mrZBP1v
         +DkZHAiVreqPAXdpYlchLN0oKPdhSBI3WPUOGsd0zkcL0MxRTRbko1L/Ghzg3H35ufhM
         c4fkRSOx5UOzElVeYOjTrMl5cl3OosQhFYD8KOdlNnVSjx+Fc6A7YZ7r1MP1iJn+Bsp6
         PRGYUc4McEQwgnuFwUHIi8c5WIe0I1QPwpFX2MaChQ0SUuzzbvz4ds8fdxNv2c4EauW2
         x6qDziilMhdB+a+4IkITqLv1SVEmsYr7Xnrba28on+DS45n96iDvtNH7y65Mjd5mzpx3
         DJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ydz/V8YCtI36F7ZEWzpqeq1Ptggb3wlckJjOINiceh0=;
        b=BYw1zwwfQYbTSP7jVJQdckUKHpKYeeDB/KJYF8E9K+piZBJ7f1hFVZ5OYWL9NAJVTb
         tqHugWLBYejGpZWLR4WBFkjJ6WPX0Y+Fo1vl1Rck56N6L2n5eK+PZxqw5fmKslz9wbGZ
         agh9QfG/OKJxln4aIHOSph9+O23rH0YDXFVhv5Vr7PPhulwup1cVPyQ+E+XPDDMuy25C
         WVRb1PiXTfIfyC44FRz7AKc4WQVknOErB7UpCD75hxHGeBXpWKQdwpukxYfKGRpC5g3Z
         AIhdZDhe5zYUwLYu44hliv6tyQL0vkynA3fNiq0JIuAv4tncZhUDaDZbpY7Ag6c//L+4
         6LzQ==
X-Gm-Message-State: ABUngveyW1zyR6AZEzGYPw9y47AqG/hmM0ZruP8wk7m248g0PA892KVRQjJs3bmF5EGGHQ==
X-Received: by 10.28.26.193 with SMTP id a184mr9575936wma.93.1477332183323;
        Mon, 24 Oct 2016 11:03:03 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r72sm16020323wmd.21.2016.10.24.11.03.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 11:03:02 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, e@80x24.org, jnareb@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 1/2] sha1_file: open window into packfiles with CLOEXEC
Date:   Mon, 24 Oct 2016 20:02:59 +0200
Message-Id: <20161024180300.52359-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161024180300.52359-1-larsxschneider@gmail.com>
References: <20161024180300.52359-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

All processes that the Git main process spawns inherit the open file
descriptors of the main process. These leaked file descriptors can
cause problems.

Use the CLOEXEC flag similar to 05d1ed61 to fix the leaked file
descriptors. Since `git_open_noatime` does not describe the function
properly anymore rename it to `git_open`.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 pack-bitmap.c          |  2 +-
 sha1_file.c            | 26 ++++++++++++++++----------
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1e7c2a9..0fd52bd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -720,7 +720,7 @@ static off_t write_reused_pack(struct sha1file *f)
 	if (!is_pack_valid(reuse_packfile))
 		die("packfile is invalid: %s", reuse_packfile->pack_name);
 
-	fd = git_open_noatime(reuse_packfile->pack_name);
+	fd = git_open(reuse_packfile->pack_name);
 	if (fd < 0)
 		die_errno("unable to open packfile for reuse: %s",
 			  reuse_packfile->pack_name);
diff --git a/cache.h b/cache.h
index b7f34b4..419b7a0 100644
--- a/cache.h
+++ b/cache.h
@@ -1125,7 +1125,7 @@ extern int write_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
-extern int git_open_noatime(const char *name);
+extern int git_open(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b949e51..39bcc16 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -266,7 +266,7 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 		return -1;
 
 	idx_name = pack_bitmap_filename(packfile);
-	fd = git_open_noatime(idx_name);
+	fd = git_open(idx_name);
 	free(idx_name);
 
 	if (fd < 0)
diff --git a/sha1_file.c b/sha1_file.c
index 1e41954..93b836b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -370,7 +370,7 @@ void read_info_alternates(const char * relative_base, int depth)
 	int fd;
 
 	path = xstrfmt("%s/info/alternates", relative_base);
-	fd = git_open_noatime(path);
+	fd = git_open(path);
 	free(path);
 	if (fd < 0)
 		return;
@@ -663,7 +663,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = git_open_noatime(path);
+	int fd = git_open(path);
 	struct stat st;
 
 	if (fd < 0)
@@ -1069,7 +1069,7 @@ static int open_packed_git_1(struct packed_git *p)
 	while (pack_max_fds <= pack_open_fds && close_one_pack())
 		; /* nothing */
 
-	p->pack_fd = git_open_noatime(p->pack_name);
+	p->pack_fd = git_open(p->pack_name);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 	pack_open_fds++;
@@ -1586,9 +1586,9 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-int git_open_noatime(const char *name)
+int git_open(const char *name)
 {
-	static int sha1_file_open_flag = O_NOATIME;
+	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
 
 	for (;;) {
 		int fd;
@@ -1598,12 +1598,18 @@ int git_open_noatime(const char *name)
 		if (fd >= 0)
 			return fd;
 
-		/* Might the failure be due to O_NOATIME? */
-		if (errno != ENOENT && sha1_file_open_flag) {
-			sha1_file_open_flag = 0;
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		if (O_CLOEXEC && errno == EINVAL &&
+			(sha1_file_open_flag & O_CLOEXEC)) {
+			sha1_file_open_flag &= ~O_CLOEXEC;
 			continue;
 		}
 
+		/* Might the failure be due to O_NOATIME? */
+		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
+			sha1_file_open_flag &= ~O_NOATIME;
+			continue;
+		}
 		return -1;
 	}
 }
@@ -1632,7 +1638,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	fd = git_open_noatime(sha1_file_name(sha1));
+	fd = git_open(sha1_file_name(sha1));
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
@@ -1640,7 +1646,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
-		fd = git_open_noatime(path);
+		fd = git_open(path);
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)
-- 
2.10.0

