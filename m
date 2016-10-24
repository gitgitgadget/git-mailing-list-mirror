Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0961FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757287AbcJXSDF (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:03:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35502 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757173AbcJXSDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:03:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so10936212wma.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aJeoTf/k9yP6x7qDQGKyQt8XxQgDFHh7W4BZaTedUgg=;
        b=xg48sCzfj9nBo+MhRP8jjjU7M/pzrgiOmhM+kUU7bbcYQFtLL7190pSjl0rgXUvv1H
         6YhZIVNkNcm2FTCapmFUdL3IQ+mRIXhzqygIbu4D6TFLzbHIjl1t3fBNjKFejKe6IAil
         X2So5W+NChph8c5BATKWxasnN1sdVqyD7xbHBK3vb6iKPgYjAyxz4akt/S7jj5HGavdK
         p0SV0gwXOmoL39nabWV+z27aHXlH9A0TIXogcuxSCGeygqX9A99H42lYqGq7Fujeafk3
         EwA1uLPqKonzU5AAIGvLHFXdGL3FSHcGXTaBHBpGfI5QVEa/5oi+Y4Obt2JzSqq/zxih
         jX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aJeoTf/k9yP6x7qDQGKyQt8XxQgDFHh7W4BZaTedUgg=;
        b=UjGeOjos7Me+gcNB3aq0e9tDGc0LwfHIRgTLnEYYkTvCFzHiEzRFjemAyuubSCm/PI
         /7NLBhzR2stOILeL6K33BLxZ5ZgmtrE/fIv5bfP2OqEdFuAm5QS813LxFAPd8+8xpkuB
         eFf3OMso/wchX3BpZGCDJNUpb8QOVq9MqbM319vXB9nQ1EGh7IfwoUV43an9ceQk0dzt
         Sw7R2kQnR+roFfU0Wq/RvuNWbTnZ4dhKq5KWWTgywCpS0Gp+8KX66HkRXWrMepioLWlL
         jEUA4nNcXf0/O+0UoQIVOXnVhyEDjdNycXxBzSMVyncv51tmwECMfn9A8H+jaJsWCcI2
         bQ2g==
X-Gm-Message-State: AA6/9RnUyuJU2kIZRFP37vyNVAYNVnahes+84ACDJmJlIYvc6dc2feiRbXRk3ONtiwnZYw==
X-Received: by 10.28.208.71 with SMTP id h68mr15653378wmg.14.1477332182243;
        Mon, 24 Oct 2016 11:03:02 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r72sm16020323wmd.21.2016.10.24.11.03.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 11:03:01 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, e@80x24.org, jnareb@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 0/2] Use CLOEXEC to avoid fd leaks
Date:   Mon, 24 Oct 2016 20:02:58 +0200
Message-Id: <20161024180300.52359-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Use the CLOEXEC flag similar to 05d1ed61 to fix leaked file descriptors.

This mini patch series is necessary to make the "ls/filter-process" topic
work properly for Windows. Right now the topic generates test failures
on Windows as reported by Dscho:
http://public-inbox.org/git/alpine.DEB.2.20.1610211457030.3264@virtualbox/

Patch 1/2 was contemplated by Junio here:
http://public-inbox.org/git/xmqq37lnbbpk.fsf@gitster.mtv.corp.google.com/

Thanks to
    Eric, Jakub, Dscho, and Junio for the review of v1,
Lars



## Changes since v1
 * add fallbacks in case O_CLOEXEC is not available
 * rename 'git_open_noatime_cloexec' to 'git_open' (Eric, Dscho)
 * rebased the topic on `next` to fix a merge conflict


Lars Schneider (2):
  sha1_file: open window into packfiles with CLOEXEC
  read-cache: make sure file handles are not inherited by child
    processes

 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 pack-bitmap.c          |  2 +-
 read-cache.c           |  6 +++++-
 sha1_file.c            | 26 ++++++++++++++++----------
 5 files changed, 24 insertions(+), 14 deletions(-)



## Interdiff (v1..v2)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fdd331..0fd52bd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -720,7 +720,7 @@ static off_t write_reused_pack(struct sha1file *f)
 	if (!is_pack_valid(reuse_packfile))
 		die("packfile is invalid: %s", reuse_packfile->pack_name);

-	fd = git_open_noatime_cloexec(reuse_packfile->pack_name);
+	fd = git_open(reuse_packfile->pack_name);
 	if (fd < 0)
 		die_errno("unable to open packfile for reuse: %s",
 			  reuse_packfile->pack_name);
diff --git a/cache.h b/cache.h
index 0dea548..419b7a0 100644
--- a/cache.h
+++ b/cache.h
@@ -1125,7 +1125,7 @@ extern int write_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
-extern int git_open_noatime_cloexec(const char *name);
+extern int git_open(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1b39e5d..39bcc16 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -266,7 +266,7 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 		return -1;

 	idx_name = pack_bitmap_filename(packfile);
-	fd = git_open_noatime_cloexec(idx_name);
+	fd = git_open(idx_name);
 	free(idx_name);

 	if (fd < 0)
diff --git a/read-cache.c b/read-cache.c
index 200d4fa..b594865 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -158,6 +158,10 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 	int match = -1;
 	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);

+	if (O_CLOEXEC && fd < 0 && errno == EINVAL)
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		fd = open(ce->name, O_RDONLY);
+
 	if (fd >= 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
diff --git a/sha1_file.c b/sha1_file.c
index dbe027b..93b836b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -370,7 +370,7 @@ void read_info_alternates(const char * relative_base, int depth)
 	int fd;

 	path = xstrfmt("%s/info/alternates", relative_base);
-	fd = git_open_noatime_cloexec(path);
+	fd = git_open(path);
 	free(path);
 	if (fd < 0)
 		return;
@@ -663,7 +663,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = git_open_noatime_cloexec(path);
+	int fd = git_open(path);
 	struct stat st;

 	if (fd < 0)
@@ -1069,7 +1069,7 @@ static int open_packed_git_1(struct packed_git *p)
 	while (pack_max_fds <= pack_open_fds && close_one_pack())
 		; /* nothing */

-	p->pack_fd = git_open_noatime_cloexec(p->pack_name);
+	p->pack_fd = git_open(p->pack_name);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 	pack_open_fds++;
@@ -1586,7 +1586,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }

-int git_open_noatime_cloexec(const char *name)
+int git_open(const char *name)
 {
 	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;

@@ -1598,12 +1598,18 @@ int git_open_noatime_cloexec(const char *name)
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

-	fd = git_open_noatime_cloexec(sha1_file_name(sha1));
+	fd = git_open(sha1_file_name(sha1));
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
@@ -1640,7 +1646,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
-		fd = git_open_noatime_cloexec(path);
+		fd = git_open(path);
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)

--
2.10.0

