Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF88A20441
	for <e@80x24.org>; Tue, 25 Oct 2016 18:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbcJYSRV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:17:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55696 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753519AbcJYSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:17:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECCC248126;
        Tue, 25 Oct 2016 14:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=7SBl
        60H4pFqxc/DbjNGY6X3fSPo=; b=CGoeWqxoosZGYSDxGwfpE4hyRFBHrAgJZQqD
        0juvbe09BgsydAOgRwv3BxLhj5rOhkBMwzxmc81CL2LTtXadfPyruM4PdXgQmExR
        etJlQz0eSuaRDx+wYWcU+b68S06R7xCVh+MWrQqeT7vP1RK7epJ7SAXmyX0IHwXW
        9XE4SO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        NirnUsDLzuH8YI+y3vcix7R5FOMKhmCFguxGdIpvMSIjbkOtrZG/BmHBvHpU7oiY
        6F/9kIUwCtUwpQch8aLu4cfap3Rh/HIQhxz9EWQgI9Pux6lLyvYbzMJsbZwHiFpA
        aBiQvchq7xL0qE0RqavUGyT6q+0r3uV2iDs1VLKLEsQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E55FC48125;
        Tue, 25 Oct 2016 14:16:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 457E64811F;
        Tue, 25 Oct 2016 14:16:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/3] sha1_file: rename git_open_noatime() to git_open()
Date:   Tue, 25 Oct 2016 11:16:19 -0700
Message-Id: <20161025181621.4201-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-777-gd068e6bde7
In-Reply-To: <20161025181621.4201-1-gitster@pobox.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
X-Pobox-Relay-ID: 252F7B50-9ADF-11E6-8EDB-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

This function is meant to be used when reading from files in the
object store, and the original objective was to avoid smudging atime
of loose object files too often, hence its name.  Because we'll be
extending its role in the next commit to also arrange the file
descriptors they return auto-closed in the child processes, rename
it to lose "noatime" part that is too specific.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a pure-rename step suggested by Dscho.

 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 pack-bitmap.c          |  2 +-
 sha1_file.c            | 12 ++++++------
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1e7c2a98a5..0fd52bd6b4 100644
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
index 0dc39a998c..a902ca1f8e 100644
--- a/cache.h
+++ b/cache.h
@@ -1122,7 +1122,7 @@ extern int write_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
-extern int git_open_noatime(const char *name);
+extern int git_open(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b949e51716..39bcc16846 100644
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
index 266152de36..5d2bcd3ed1 100644
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
@@ -1559,7 +1559,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-int git_open_noatime(const char *name)
+int git_open(const char *name)
 {
 	static int sha1_file_open_flag = O_NOATIME;
 
@@ -1605,7 +1605,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	fd = git_open_noatime(sha1_file_name(sha1));
+	fd = git_open(sha1_file_name(sha1));
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
@@ -1613,7 +1613,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
-		fd = git_open_noatime(path);
+		fd = git_open(path);
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)
-- 
2.10.1-777-gd068e6bde7

