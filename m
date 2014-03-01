From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH] rewrite finish_bulk_checkin() using strbuf
Date: Sat,  1 Mar 2014 12:16:29 +0530
Message-ID: <1393656389-31300-1-git-send-email-faiz.off93@gmail.com>
Cc: Faiz Kotahri <faiz.off93@gmail.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, sunheehnus@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 01 07:47:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJdhj-000816-3n
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 07:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbaCAGrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 01:47:18 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47932 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbaCAGrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 01:47:18 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so1639443pdi.5
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 22:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8aj+D7nevjxju/xW1KnkuxfcOS7LaiwHS/CqR61mDd4=;
        b=A0AvLlPHynwHuOjPhCeC1LySV7mThKyNP/DHNLrC1EIXSODJrews/anKGr7/lzaRoB
         IumuAZPQEC/yZLwfB1pgbi9gtGsHlj89ekJK0roPK6u6grPQkyZywychxQ3cLWo/4C46
         EaJLhTFB0Vbh8rLhMI5lTKm7BKGn6Jqeu0QQeBloj9aER+d+K2gVDO+gCEh5ZVDPd5Dj
         CaPW5D5jWotQxjT67X1fiK7C4VivRutYnxZZGUjm3/3PeViXmZpI/BVNtpi251hq8b1Z
         I7THz0ZuXIT2hbr2vHuMLrpVJDAD0kEElLo5CqSBNSV9/xVdI4W8v5+bd1lYb6pAkzp9
         OrKg==
X-Received: by 10.68.190.200 with SMTP id gs8mr8219310pbc.130.1393656437628;
        Fri, 28 Feb 2014 22:47:17 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id gj9sm12961064pbc.7.2014.02.28.22.47.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Feb 2014 22:47:16 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243046>

From: Faiz Kotahri <faiz.off93@gmail.com>

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
---
Sticking with implementation involving changing the prototype for
pack-write.c:finish_tmp_packfile()
Fixing a small bug in Sun He's implementation which caused a fail in some tests.

 builtin/pack-objects.c |   25 ++++++++++++-------------
 bulk-checkin.c         |    9 ++++++---
 pack-write.c           |   19 ++++++++++---------
 pack.h                 |    3 ++-
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..4b59bba 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -20,6 +20,7 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "pack-bitmap.h"
+#include "strbuf.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-list]"),
@@ -803,8 +804,8 @@ static void write_pack_file(void)
 
 		if (!pack_to_stdout) {
 			struct stat st;
-			char tmpname[PATH_MAX];
-
+			struct strbuf tmpname = STRBUF_INIT;
+			int ini_length;
 			/*
 			 * Packs are runtime accessed in their mtime
 			 * order since newer packs are more likely to contain
@@ -823,26 +824,24 @@ static void write_pack_file(void)
 				utb.modtime = --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
 					warning("failed utime() on %s: %s",
-						tmpname, strerror(errno));
+						pack_tmp_name, strerror(errno));
 			}
 
-			/* Enough space for "-<sha-1>.pack"? */
-			if (sizeof(tmpname) <= strlen(base_name) + 50)
-				die("pack base name '%s' too long", base_name);
-			snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
+			strbuf_addf(&tmpname, "%s-", base_name);
+			ini_length = tmpname.len;
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(sha1);
 				bitmap_writer_build_type_index(written_list, nr_written);
 			}
-
-			finish_tmp_packfile(tmpname, pack_tmp_name,
+			
+			finish_tmp_packfile(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, sha1);
 
 			if (write_bitmap_index) {
-				char *end_of_name_prefix = strrchr(tmpname, 0);
-				sprintf(end_of_name_prefix, "%s.bitmap", sha1_to_hex(sha1));
+				strbuf_remove(&tmpname, ini_length, tmpname.len - ini_length);
+				strbuf_addf(&tmpname, "%s.bitmap", sha1_to_hex(sha1));
 
 				stop_progress(&progress_state);
 
@@ -851,10 +850,10 @@ static void write_pack_file(void)
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
 				bitmap_writer_build(&to_pack);
 				bitmap_writer_finish(written_list, nr_written,
-						     tmpname, write_bitmap_options);
+						     tmpname.buf, write_bitmap_options);
 				write_bitmap_index = 0;
 			}
-
+			strbuf_release(&tmpname);
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 118c625..248454c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -4,6 +4,7 @@
 #include "bulk-checkin.h"
 #include "csum-file.h"
 #include "pack.h"
+#include "strbuf.h"
 
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 
@@ -23,7 +24,7 @@ static struct bulk_checkin_state {
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	unsigned char sha1[20];
-	char packname[PATH_MAX];
+	struct strbuf packname = STRBUF_INIT;
 	int i;
 
 	if (!state->f)
@@ -43,16 +44,18 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		close(fd);
 	}
 
-	sprintf(packname, "%s/pack/pack-", get_object_directory());
-	finish_tmp_packfile(packname, state->pack_tmp_name,
+	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
+	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, sha1);
+	
 	for (i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
 clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
+	strbuf_release(&packname);
 
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git();
diff --git a/pack-write.c b/pack-write.c
index 9b8308b..60f5734 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "strbuf.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -336,7 +337,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 	return sha1fd(fd, *pack_tmp_name);
 }
 
-void finish_tmp_packfile(char *name_buffer,
+void finish_tmp_packfile(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
@@ -344,7 +345,7 @@ void finish_tmp_packfile(char *name_buffer,
 			 unsigned char sha1[])
 {
 	const char *idx_tmp_name;
-	char *end_of_name_prefix = strrchr(name_buffer, 0);
+	int ini_length = name_buffer->len;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -354,17 +355,17 @@ void finish_tmp_packfile(char *name_buffer,
 	if (adjust_shared_perm(idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
-	sprintf(end_of_name_prefix, "%s.pack", sha1_to_hex(sha1));
-	free_pack_by_name(name_buffer);
+	strbuf_addf(name_buffer, "%s.pack", sha1_to_hex(sha1));
+	free_pack_by_name(name_buffer->buf);
 
-	if (rename(pack_tmp_name, name_buffer))
+	if (rename(pack_tmp_name, name_buffer->buf))
 		die_errno("unable to rename temporary pack file");
 
-	sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
-	if (rename(idx_tmp_name, name_buffer))
+	strbuf_remove(name_buffer, ini_length, name_buffer->len - ini_length);
+	strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
+	
+	if (rename(idx_tmp_name, name_buffer->buf))
 		die_errno("unable to rename temporary index file");
 
-	*end_of_name_prefix = '\0';
-
 	free((void *)idx_tmp_name);
 }
diff --git a/pack.h b/pack.h
index 12d9516..0afe8d1 100644
--- a/pack.h
+++ b/pack.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 #include "csum-file.h"
+#include "strbuf.h"
 
 /*
  * Packed object header
@@ -91,6 +92,6 @@ extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned ch
 extern int read_pack_header(int fd, struct pack_header *);
 
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
-extern void finish_tmp_packfile(char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
 #endif
-- 
1.7.9.5
