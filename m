From: Dana How <danahow@gmail.com>
Subject: [PATCH 3/4] git-repack --max-pack-size: split packs as asked by write_{object,one}()
Date: Tue, 08 May 2007 13:04:20 -0700
Message-ID: <4640D7C4.8020907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVvS-0005rY-QN
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031912AbXEHUE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031918AbXEHUE2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:04:28 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:9878 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031912AbXEHUEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:04:24 -0400
Received: by py-out-1112.google.com with SMTP id a29so1581901pyi
        for <git@vger.kernel.org>; Tue, 08 May 2007 13:04:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=gSgrv1tIPJtBUJkUywQXvU5amz3GR13Tc7VwnEo+sClFvPfSBqo6WvCWx7KZnQQ35jOH/rmJJH5gN4hwIAxZ6+9feURygkmfGoBM7suyyOcKdv+4tZwKQ3Ivh/5D38Tytq/yEj3BhTqILGvKdrvZPh0nvCW0/ICySVoaqO7EMJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=OTKinDTntYv2XMFYBPFhUj8XFR07yaMRpWxjZAUjFB+ZUXLguRPX4yK2fl5pTtDeA71cji9NCr202ygmWL2RO/SKBK5mGeAY9Jq2OYXMEasnQWdQuFjiHUOOdls3KIw3nyuI+9aROdttQbLVUNciLSsqd6XticXCmjcVQYczm0A=
Received: by 10.35.43.10 with SMTP id v10mr13833341pyj.1178654663366;
        Tue, 08 May 2007 13:04:23 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id v15sm9259678pyh.2007.05.08.13.04.21;
        Tue, 08 May 2007 13:04:22 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46615>


Rewrite write_pack_file() to break to a new packfile
whenever write_object/write_one request it,  and
correct the header's object count in the previous packfile.
Change write_index_file() to write an index
for just the objects in the most recent packfile.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |  120 ++++++++++++++++++++++++++++-------------------
 1 files changed, 71 insertions(+), 49 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index fbff8fa..2932b88 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -636,6 +636,7 @@ static off_t write_one(struct sha1file *f,
 		e->offset = 0;
 		return 0;
 	}
+	written_list[nr_written++] = e;
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
@@ -655,47 +656,57 @@ static int adjust_perm(const char *path, mode_t mode);
 
 static void write_pack_file(void)
 {
-	uint32_t i;
+	uint32_t i = 0, j;
 	struct sha1file *f;
-	off_t offset, last_obj_offset = 0;
+	off_t offset, offset_one, last_obj_offset = 0;
 	struct pack_header hdr;
-	int do_progress = progress;
-
-	if (pack_to_stdout) {
-		f = sha1fd(1, "<stdout>");
-		do_progress >>= 1;
-	} else {
-		int fd = open_object_dir_tmp("tmp_pack_XXXXXX");
-		if (fd < 0)
-			die("unable to create %s: %s\n", tmpname, strerror(errno));
-		pack_tmp_name = xstrdup(tmpname);
-		f = sha1fd(fd, pack_tmp_name);
-	}
+	int do_progress = progress >> pack_to_stdout;
+	uint32_t nr_remaining = nr_result;
 
 	if (do_progress)
 		start_progress(&progress_state, "Writing %u objects...", "", nr_result);
+	written_list = xmalloc(nr_objects * sizeof(struct object_entry *));
 
-	hdr.hdr_signature = htonl(PACK_SIGNATURE);
-	hdr.hdr_version = htonl(PACK_VERSION);
-	hdr.hdr_entries = htonl(nr_result);
-	sha1write(f, &hdr, sizeof(hdr));
-	offset = sizeof(hdr);
-	if (!nr_result)
-		goto done;
-	for (i = 0; i < nr_objects; i++) {
-		last_obj_offset = offset;
-		offset = write_one(f, objects + i, offset);
-		if (do_progress)
-			display_progress(&progress_state, written);
-	}
-	if (do_progress)
-		stop_progress(&progress_state);
- done:
-	if (written != nr_result)
-		die("wrote %u objects while expecting %u", written, nr_result);
-	sha1close(f, pack_file_sha1, 1);
+	do {
+		if (pack_to_stdout) {
+			f = sha1fd(1, "<stdout>");
+		} else {
+			int fd = open_object_dir_tmp("tmp_pack_XXXXXX");
+			if (fd < 0)
+				die("unable to create %s: %s\n", tmpname, strerror(errno));
+			pack_tmp_name = xstrdup(tmpname);
+			f = sha1fd(fd, pack_tmp_name);
+		}
 
-	if (!pack_to_stdout) {
+		hdr.hdr_signature = htonl(PACK_SIGNATURE);
+		hdr.hdr_version = htonl(PACK_VERSION);
+		hdr.hdr_entries = htonl(nr_remaining);
+		sha1write(f, &hdr, sizeof(hdr));
+		offset = sizeof(hdr);
+		nr_written = 0;
+		for (; i < nr_objects; i++) {
+			last_obj_offset = offset;
+			offset_one = write_one(f, objects + i, offset);
+			if (!offset_one)
+				break;
+			offset = offset_one;
+			if (do_progress)
+				display_progress(&progress_state, written);
+		}
+
+		/*
+		 * Did we write the wrong # entries in the header?
+		 * If so, rewrite it like in fast-import
+		 */
+		if (pack_to_stdout || nr_written == nr_remaining) {
+			sha1close(f, pack_file_sha1, 1);
+		} else {
+			sha1close(f, pack_file_sha1, 0);
+			fixup_pack_header_footer(f->fd, pack_file_sha1, pack_tmp_name, nr_written);
+			close(f->fd);
+		}
+
+		if (!pack_to_stdout) {
 			unsigned char object_list_sha1[20];
 			mode_t mode = umask(0);
 
@@ -720,7 +731,26 @@ static void write_pack_file(void)
 				die("unable to rename temporary index file: %s",
 				    strerror(errno));
 			puts(sha1_to_hex(object_list_sha1));
+		}
+
+		/* mark written objects as written to previous pack */
+		for (j = 0; j < nr_written; j++) {
+			written_list[j]->offset = (off_t)-1;
+		}
+		nr_remaining -= nr_written;
+	} while (nr_remaining && i < nr_objects);
+
+	free(written_list);
+	if (do_progress)
+		stop_progress(&progress_state);
+	if (written != nr_result)
+		die("wrote %u objects while expecting %u", written, nr_result);
+	for (j = 0; i < nr_objects; i++) {
+		struct object_entry *e = objects + i;
+		j += !e->offset && !e->preferred_base;
 	}
+	if (j)
+		die("wrote %u objects as expected but %u unwritten", written, j);
 }
 
 static int sha1_sort(const void *_a, const void *_b)
@@ -747,18 +777,11 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 	idx_tmp_name = xstrdup(tmpname);
 	f = sha1fd(fd, idx_tmp_name);
 
-	if (nr_result) {
-		uint32_t j = 0;
-		sorted_by_sha =
-			xcalloc(nr_result, sizeof(struct object_entry *));
-		for (i = 0; i < nr_objects; i++)
-			if (!objects[i].preferred_base)
-				sorted_by_sha[j++] = objects + i;
-		if (j != nr_result)
-			die("listed %u objects while expecting %u", j, nr_result);
-		qsort(sorted_by_sha, nr_result, sizeof(*sorted_by_sha), sha1_sort);
+	if (nr_written) {
+		sorted_by_sha = written_list;
+		qsort(sorted_by_sha, nr_written, sizeof(*sorted_by_sha), sha1_sort);
 		list = sorted_by_sha;
-		last = sorted_by_sha + nr_result;
+		last = sorted_by_sha + nr_written;
 	} else
 		sorted_by_sha = list = last = NULL;
 
@@ -796,7 +819,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	/* Write the actual SHA1 entries. */
 	list = sorted_by_sha;
-	for (i = 0; i < nr_result; i++) {
+	for (i = 0; i < nr_written; i++) {
 		struct object_entry *entry = *list++;
 		if (index_version < 2) {
 			uint32_t offset = htonl(entry->offset);
@@ -811,7 +834,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the crc32 table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t crc32_val = htonl(entry->crc32);
 			sha1write(f, &crc32_val, 4);
@@ -819,7 +842,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the 32-bit offset table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t offset = (entry->offset <= index_off32_limit) ?
 				entry->offset : (0x80000000 | nr_large_offset++);
@@ -844,7 +867,6 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	sha1write(f, pack_file_sha1, 20);
 	sha1close(f, NULL, 1);
-	free(sorted_by_sha);
 	SHA1_Final(sha1, &ctx);
 }
 
-- 
1.5.2.rc0.787.g0014
