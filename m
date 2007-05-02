From: Dana How <danahow@gmail.com>
Subject: [PATCH 4/5] git-repack --max-pack-size: split packs as asked by write_{object,one}
Date: Tue, 01 May 2007 17:07:31 -0700
Message-ID: <4637D643.8070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 02:08:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj2Ny-00012L-D3
	for gcvg-git@gmane.org; Wed, 02 May 2007 02:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946135AbXEBAHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 20:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946143AbXEBAHg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 20:07:36 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:38592 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946135AbXEBAHe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 20:07:34 -0400
Received: by py-out-1112.google.com with SMTP id a29so1697296pyi
        for <git@vger.kernel.org>; Tue, 01 May 2007 17:07:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=bTor1tUI2xPv3x0CYTJ3CF2Ulh10jUQR4mmOUHetX7MwWgH3Ewiyo4+qNLGkzBQnMM89XHe0MfOXDxckjIeopFcyLiAonzOGt2xXOnaJ4fXj/Ky2ZaLZHFDLlt8znNRMzQzOiF90DTHZtVjynsgzSQhaccmv2fXZ/1lixfQ5LtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=cuA+et1ASDxuVb+crrA843CaDCpv0v2i3K7ajOZq1zU0/E36lTDbii9XHuUaw0vEaMOC1JQC3vrVNfteVTJz33kx2qlQ82BEbef8sG1Ojc4NBl17MtaOMW0HRk74rj17PcIiuj+tWy+9ZiLS0817hIGCd1z/WgIkaG5STrZjGyo=
Received: by 10.65.219.20 with SMTP id w20mr74544qbq.1178064453986;
        Tue, 01 May 2007 17:07:33 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 10sm491041nzo.2007.05.01.17.07.32;
        Tue, 01 May 2007 17:07:33 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45997>


Rewrite write_pack_file() to break to a new packfile
whenever write_object/write_one request it,  and
correct the header's object count in the previous packfile.
Change write_index_file() to write an index
for just the objects in the most recent packfile.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |  165 +++++++++++++++++++++++++++---------------------
 1 files changed, 93 insertions(+), 72 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index dba5681..a7b19c2 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -637,6 +637,7 @@ static off_t write_one(struct sha1file *f,
 		e->offset = 0;
 		return 0;
 	}
+	written_list[nr_written++] = e;
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
@@ -650,74 +651,102 @@ static int adjust_perm(const char *path, mode_t mode);
 
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
+		nr_remaining -= nr_written;
+	} while (nr_remaining && i < nr_objects);
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
+	for (j = 0; i < nr_objects; i++) {
+		struct object_entry *e = objects + i;
+		j += !e->offset && !e->preferred_base;
 	}
+	if (j)
+		die("wrote %u objects as expected but %u unwritten", written, j);
 }
 
 static int sha1_sort(const void *_a, const void *_b)
@@ -746,18 +775,11 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
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
 
@@ -795,7 +817,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	/* Write the actual SHA1 entries. */
 	list = sorted_by_sha;
-	for (i = 0; i < nr_result; i++) {
+	for (i = 0; i < nr_written; i++) {
 		struct object_entry *entry = *list++;
 		if (index_version < 2) {
 			uint32_t offset = htonl(entry->offset);
@@ -810,7 +832,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the crc32 table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t crc32_val = htonl(entry->crc32);
 			sha1write(f, &crc32_val, 4);
@@ -818,7 +840,7 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 		/* write the 32-bit offset table */
 		list = sorted_by_sha;
-		for (i = 0; i < nr_objects; i++) {
+		for (i = 0; i < nr_written; i++) {
 			struct object_entry *entry = *list++;
 			uint32_t offset = (entry->offset <= index_off32_limit) ?
 				entry->offset : (0x80000000 | nr_large_offset++);
@@ -843,7 +865,6 @@ static void write_index_file(off_t last_obj_offset, unsigned char *sha1)
 
 	sha1write(f, pack_file_sha1, 20);
 	sha1close(f, NULL, 1);
-	free(sorted_by_sha);
 	SHA1_Final(sha1, &ctx);
 }
 
-- 
1.5.2.rc0.789.gd951
