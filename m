From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH v2] finish_tmp_packfile():use strbuf for pathname construction
Date: Sun,  2 Mar 2014 10:29:35 +0800
Message-ID: <1393727375-2899-1-git-send-email-sunheehnus@gmail.com>
Cc: Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 03:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwBj-0002IP-On
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbaCBCbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 21:31:01 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40432 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbaCBCbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:31:01 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so2391278pab.20
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=P6ychvGz7NNABg/5BUQVtclypAKU4UyyhpQQbh6Bkj8=;
        b=S1CD5h8smNLF/XFKVzOqvZp7IsyFSUlatvBMP/ogw7y1ILkLUJW1DIjRttqh6kwTnV
         6TpfGzT6iG0+DAG0m5+1HNz6/20HSGLMR8RCnvXv4Imp/CeAny8pYsn6AtbGrwiR54S+
         S5QRbZYmWor8OWtQ/mWMXWiA1jTYAVunqQ+3FuG0ctqq+Y5CAr7+aPvYJpzTY6BJM1sv
         brz/GoIRg7aPnLPSTb1xAiCp3iUcFYnkb9gUaDJYIsuZlnVOH+CvycNnvK8piqx64g2q
         4kH+pO74fAQ2Ds8Y3eWIEaICaEC9SUPYtKdsM0eo1rPf0jNwIiBv2ehtFEo+HI5yRgaL
         JrWQ==
X-Received: by 10.68.190.228 with SMTP id gt4mr12222392pbc.94.1393727460353;
        Sat, 01 Mar 2014 18:31:00 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id ac5sm20881910pbc.37.2014.03.01.18.30.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Mar 2014 18:30:59 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243118>

Signed-off-by: Sun He <sunheehnus@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This patch has assumed that you have already fix the bug of
tmpname in builtin/pack-objects.c:write_pack_file() warning()


 builtin/pack-objects.c | 15 ++++++---------
 bulk-checkin.c         |  8 +++++---
 pack-write.c           | 18 ++++++++++--------
 pack.h                 |  2 +-
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..099d6ed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -803,7 +803,7 @@ static void write_pack_file(void)
 
 		if (!pack_to_stdout) {
 			struct stat st;
-			char tmpname[PATH_MAX];
+			struct strbuf tmpname = STRBUF_INIT;
 
 			/*
 			 * Packs are runtime accessed in their mtime
@@ -826,23 +826,19 @@ static void write_pack_file(void)
 						tmpname, strerror(errno));
 			}
 
-			/* Enough space for "-<sha-1>.pack"? */
-			if (sizeof(tmpname) <= strlen(base_name) + 50)
-				die("pack base name '%s' too long", base_name);
-			snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
+			strbuf_addf(&tmpname, "%s-", base_name);
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(sha1);
 				bitmap_writer_build_type_index(written_list, nr_written);
 			}
 
-			finish_tmp_packfile(tmpname, pack_tmp_name,
+			finish_tmp_packfile(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, sha1);
 
 			if (write_bitmap_index) {
-				char *end_of_name_prefix = strrchr(tmpname, 0);
-				sprintf(end_of_name_prefix, "%s.bitmap", sha1_to_hex(sha1));
+				strbuf_addf(&tmpname, "%s.bitmap" ,sha1_to_hex(sha1));
 
 				stop_progress(&progress_state);
 
@@ -851,10 +847,11 @@ static void write_pack_file(void)
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
 				bitmap_writer_build(&to_pack);
 				bitmap_writer_finish(written_list, nr_written,
-						     tmpname, write_bitmap_options);
+						     tmpname.buf, write_bitmap_options);
 				write_bitmap_index = 0;
 			}
 
+			strbuf_release(&tmpname);
 			free(pack_tmp_name);
 			puts(sha1_to_hex(sha1));
 		}
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 118c625..98e651c 100644
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
@@ -43,8 +44,8 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		close(fd);
 	}
 
-	sprintf(packname, "%s/pack/pack-", get_object_directory());
-	finish_tmp_packfile(packname, state->pack_tmp_name,
+	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
+	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, sha1);
 	for (i = 0; i < state->nr_written; i++)
@@ -54,6 +55,7 @@ clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
 
+	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git();
 }
diff --git a/pack-write.c b/pack-write.c
index 9b8308b..9ccf804 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -336,7 +336,7 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
 	return sha1fd(fd, *pack_tmp_name);
 }
 
-void finish_tmp_packfile(char *name_buffer,
+void finish_tmp_packfile(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
@@ -344,7 +344,7 @@ void finish_tmp_packfile(char *name_buffer,
 			 unsigned char sha1[])
 {
 	const char *idx_tmp_name;
-	char *end_of_name_prefix = strrchr(name_buffer, 0);
+	int basename_len = name_buffer->len;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -354,17 +354,19 @@ void finish_tmp_packfile(char *name_buffer,
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
+	strbuf_setlen(name_buffer, basename_len);
+
+	strbuf_addf(name_buffer, "%s.idx", sha1_to_hex(sha1));
+	if (rename(idx_tmp_name, name_buffer->buf))
 		die_errno("unable to rename temporary index file");
 
-	*end_of_name_prefix = '\0';
+	strbuf_setlen(name_buffer, basename_len);
 
 	free((void *)idx_tmp_name);
 }
diff --git a/pack.h b/pack.h
index 12d9516..3223f5a 100644
--- a/pack.h
+++ b/pack.h
@@ -91,6 +91,6 @@ extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned ch
 extern int read_pack_header(int fd, struct pack_header *);
 
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
-extern void finish_tmp_packfile(char *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
 #endif
-- 
1.9.0.138.g2de3478.dirty
