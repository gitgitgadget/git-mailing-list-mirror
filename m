From: Dana How <danahow@gmail.com>
Subject: [PATCH 7/8] git-repack --max-pack-size: split packs as asked by write_object/write_one
Date: Mon, 30 Apr 2007 16:24:17 -0700
Message-ID: <46367AA1.8080009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:24:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifEG-0003R0-Vt
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946885AbXD3XYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946887AbXD3XYV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:24:21 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:43689 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946885AbXD3XYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:24:20 -0400
Received: by py-out-1112.google.com with SMTP id a29so1463472pyi
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:24:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=PAH8gHqsxRj8Zird3KzT/pou/Z/ygcwKRT3GtIxjYeadZ0Gy8EeQQB+t73jcn0hywZXmyoxImesK16RTnM518Eq+iFiS1J+WlKhQQAGh/aqfLODmoh1SFzCR9PJIu+IwTyh3w5dgE2moqmCBLY9v2ySDcA7siuWDIZmSJHB8B2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=kY/wlY3VoTrJGxhgBUTcSypnZpO41suiMX4E5A5IQLUIONSW3y2md7Z5BYnrNzHbxUpXusluJnzRDgiWBWC4RuhDUNAjVP3QSBQb13J/qec/AkgUaXkTUQwjYDcG3QFRlClHsk0O5Apg+YY3jJlSAInUcV0iFgA+vQvc7zzbEDE=
Received: by 10.65.240.17 with SMTP id s17mr1146808qbr.1177975459566;
        Mon, 30 Apr 2007 16:24:19 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 23sm7901051nzn.2007.04.30.16.24.18;
        Mon, 30 Apr 2007 16:24:19 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45898>


Rewrite write_pack_file() to break to a new packfile
whenever write_object/write_one request it,  and
correct the header's object count in the previous packfile.
Change write_index_file() to write an index
for just the objects in the most recent packfile.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |  161 ++++++++++++++++++++++++++----------------------
 1 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b50de05..328b3cb 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -623,6 +623,7 @@ static off_t write_one(struct sha1file *f,
 	size = write_object(f, e, pack_size_limit && nr_written ? pack_size_limit - offset : 0);
 	if (!size)
 		return e->offset = 0;
+	written_list[nr_written++] = e;
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
@@ -631,7 +632,7 @@ static off_t write_one(struct sha1file *f,
 }
 
 static void fixup_header_footer(int pack_fd, unsigned char *pack_file_sha1,
-				char *pack_name, uint32_t object_count)
+				const char *pack_name, uint32_t object_count)
 {
 	static const int buf_sz = 128 * 1024;
 	SHA_CTX c;
@@ -672,74 +673,94 @@ static int adjust_perm(const char *path, mode_t mode);
 
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
-		int fd;
-		snprintf(tmpname, sizeof(tmpname), "tmp_pack_XXXXXX");
-		fd = mkstemp(tmpname);
-		if (fd < 0)
-			die("unable to create %s: %s\n", tmpname, strerror(errno));
-		pack_tmp_name = xstrdup(tmpname);
-		f = sha1fd(fd, pack_tmp_name);
-	}
+	int do_progress = progress >> pack_to_stdout;
 
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
+	do {
+		if (pack_to_stdout) {
+			f = sha1fd(1, "<stdout>");
+		} else {
+			int fd;
+			snprintf(tmpname, sizeof(tmpname), "tmp_pack_XXXXXX");
+			fd = mkstemp(tmpname);
+			if (fd < 0)
+				die("unable to create %s: %s\n", tmpname, strerror(errno));
+			pack_tmp_name = xstrdup(tmpname);
+			f = sha1fd(fd, pack_tmp_name);
+		}
+
+		hdr.hdr_signature = htonl(PACK_SIGNATURE);
+		hdr.hdr_version = htonl(PACK_VERSION);
+		hdr.hdr_entries = htonl(nr_result);
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
+		if (pack_to_stdout || nr_written == nr_result) {
+			sha1close(f, pack_file_sha1, 1);
+		} else {
+			sha1close(f, pack_file_sha1, -1);
+			fixup_header_footer(f->fd, pack_file_sha1, pack_tmp_name, nr_written);
+		}
+
+		if (!pack_to_stdout) {
+			unsigned char object_list_sha1[20];
+			mode_t mode = umask(0);
+
+			umask(mode);
+			mode = 0444 & ~mode;
+
+			write_index_file(last_obj_offset, object_list_sha1);
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
+				 base_name, sha1_to_hex(object_list_sha1));
+			if (adjust_perm(pack_tmp_name, mode))
+				die("unable to make temporary pack file readable: %s",
+				    strerror(errno));
+			if (rename(pack_tmp_name, tmpname))
+				die("unable to rename temporary pack file: %s",
+				    strerror(errno));
+			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
+				 base_name, sha1_to_hex(object_list_sha1));
+			if (adjust_perm(idx_tmp_name, mode))
+				die("unable to make temporary index file readable: %s",
+				    strerror(errno));
+			if (rename(idx_tmp_name, tmpname))
+				die("unable to rename temporary index file: %s",
+				    strerror(errno));
+			puts(sha1_to_hex(object_list_sha1));
+		}
+
+		/* mark written objects as written to previous pack */
+		for (j = 0; j < nr_written; j++) {
+			written_list[j]->offset = (off_t)-1;
+		}
+	} while (i < nr_objects);
+
+	free(written_list);
 	if (do_progress)
 		stop_progress(&progress_state);
- done:
 	if (written != nr_result)
 		die("wrote %u objects while expecting %u", written, nr_result);
-	sha1close(f, pack_file_sha1, 1);
-
-	if (!pack_to_stdout) {
-		unsigned char object_list_sha1[20];
-		mode_t mode = umask(0);
-
-		umask(mode);
-		mode = 0444 & ~mode;
-
-		write_index_file(last_obj_offset, object_list_sha1);
-		snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
-			 base_name, sha1_to_hex(object_list_sha1));
-		if (adjust_perm(pack_tmp_name, mode))
-			die("unable to make temporary pack file readable: %s",
-			    strerror(errno));
-		if (rename(pack_tmp_name, tmpname))
-			die("unable to rename temporary pack file: %s",
-			    strerror(errno));
-		snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
-			 base_name, sha1_to_hex(object_list_sha1));
-		if (adjust_perm(idx_tmp_name, mode))
-			die("unable to make temporary index file readable: %s",
-			    strerror(errno));
-		if (rename(idx_tmp_name, tmpname))
-			die("unable to rename temporary index file: %s",
-			    strerror(errno));
-		puts(sha1_to_hex(object_list_sha1));
-	}
 }
 
 static int sha1_sort(const void *_a, const void *_b)
@@ -768,18 +789,11 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
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
 
@@ -817,7 +831,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	/* Write the actual SHA1 entries. */
 	list = sorted_by_sha;
-	for (i = 0; i < nr_result; i++) {
+	for (i = 0; i < nr_written; i++) {
 		struct object_entry *entry = *list++;
 		if (index_version < 2) {
 			uint32_t offset = htonl(entry->offset);
@@ -832,7 +846,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the crc32 table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t crc32_val = htonl(entry->crc32);
 			sha1write(f, &crc32_val, 4);
@@ -840,7 +854,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the 32-bit offset table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t offset = (entry->offset <= index_off32_limit) ?
 				entry->offset : (0x80000000 | nr_large_offset++);
@@ -865,7 +879,6 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	sha1write(f, pack_file_sha1, 20);
 	sha1close(f, NULL, 1);
-	free(sorted_by_sha);
 	SHA1_Final(sha1, &ctx);
 }
 
-- 
1.5.2.rc0.766.gba60-dirty
