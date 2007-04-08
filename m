From: Dana How <danahow@gmail.com>
Subject: [PATCH 7/8] git-repack --max-pack-size: split packs as asked by write_object/write_one
Date: Sun, 08 Apr 2007 16:26:07 -0700
Message-ID: <46197A0F.2090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:26:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hagly-0008Dc-Og
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXDHX0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbXDHX0L
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:26:11 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:2754 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXDHX0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:26:10 -0400
Received: by py-out-1112.google.com with SMTP id a29so897386pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:26:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=UUM/QHouQ7AqPtTEuBhcT9PU9ut7KZLRK0N1ZqP45sVWEd41VcpMVdkSw6X0FVoOmLrk+v6vEN/ltAsTp4qekaLQvspLXcqDtAi+KzFflEgrCcEH727GTtmWqoa6T22eEVi6kZdlGNOC4+cVjjBjvCLN9pkv20Lb51z5NAoNkXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=HpKcco+mux8RkVsshzGCn8gBJl/zFkL4G4RWlu0dpyej3cj73ISHpxfIe8ukMQHtwD2PSmXl9ArvumYwGJdr/v6Vk/7Jsr4Nsuc1QX0xSApPHTgGxHUG6wAtp5kG1MYFB13IssPimtrfVTUrBI9BauoBw5g2xPxyS+SzJiJBnxM=
Received: by 10.35.39.13 with SMTP id r13mr10140538pyj.1176074769496;
        Sun, 08 Apr 2007 16:26:09 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 17sm6873913nzo.2007.04.08.16.26.08;
        Sun, 08 Apr 2007 16:26:08 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44017>


Rewrite write_pack_file() to break to a new packfile
whenever write_object/write_one request it,  and
correct the header's object count in the previous packfile.
Change write_index_file() to write an index
for just the objects in the most recent packfile.

Signed-off-by: Dana How <how@deathvalley.cswitch.com>
---
 builtin-pack-objects.c |  126 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 89 insertions(+), 37 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a088f2e..d750c4b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -572,6 +572,7 @@ static off_t write_one(struct sha1file *f,
 	result = write_object(f, e, offset_limit && nr_written ? offset_limit - offset : 0);
 	if (!result)
 		return result;
+	written_list[nr_written++] = e;
 	e->offset = offset;
 	return offset + result;
 }
@@ -628,52 +629,103 @@ static void write_index_file(void);
 
 static void write_pack_file(void)
 {
-	uint32_t i;
+	uint32_t i, j;
 	struct sha1file *f;
 	off_t offset;
 	struct pack_header hdr;
 	unsigned last_percent = 999;
-	int do_progress = progress;
+	int do_progress = progress >> !base_name;
+	char oldname[PATH_MAX];
+	int pack_fd;
+	SHA_CTX ctx;
 
-	if (!base_name) {
-		f = sha1fd(1, "<stdout>");
-		do_progress >>= 1;
-	}
-	else
-		f = sha1create("%s-%s.%s", base_name,
-			       sha1_to_hex(object_list_sha1), "pack");
 	if (do_progress)
 		fprintf(stderr, "Writing %u objects.\n", nr_result);
+	written_list = xmalloc(nr_objects * sizeof(struct object_entry *));
 
-	hdr.hdr_signature = htonl(PACK_SIGNATURE);
-	hdr.hdr_version = htonl(PACK_VERSION);
-	hdr.hdr_entries = htonl(nr_result);
-	sha1write(f, &hdr, sizeof(hdr));
-	offset = sizeof(hdr);
-	if (!nr_result)
-		goto done;
-	for (i = 0; i < nr_objects; i++) {
-		offset = write_one(f, objects + i, offset);
-		if (do_progress) {
-			unsigned percent = written * 100 / nr_result;
-			if (progress_update || percent != last_percent) {
-				fprintf(stderr, "%4u%% (%u/%u) done\r",
-					percent, written, nr_result);
-				progress_update = 0;
-				last_percent = percent;
+	for (i = 0; i < nr_objects;) {
+		if (!base_name) {
+			f = sha1fd(pack_fd = 1, "<stdout>");
+		}
+		else {
+			int len = snprintf(oldname, sizeof oldname, "%s-XXXXXX", base_name);
+			if (len >= PATH_MAX)
+				die("excessive pathname length for initial packfile name");
+			pack_fd = mkstemp(oldname);
+			if (pack_fd < 0)
+				die("can't create %s: %s", oldname, strerror(errno));
+			f = sha1fd(pack_fd, oldname);
+		}
+
+		hdr.hdr_signature = htonl(PACK_SIGNATURE);
+		hdr.hdr_version = htonl(PACK_VERSION);
+		hdr.hdr_entries = htonl(nr_result);
+		sha1write(f, &hdr, sizeof(hdr));
+		offset = sizeof(hdr);
+		nr_written = 0;
+		for (; i < nr_objects; i++) {
+			off_t offset_one = write_one(f, objects + i, offset);
+			if (!offset_one)
+				break;
+			offset = offset_one;
+			if (do_progress) {
+				unsigned percent = written * 100 / nr_result;
+				if (progress_update || percent != last_percent) {
+					fprintf(stderr, "%4u%% (%u/%u) done\r",
+						percent, written, nr_result);
+					progress_update = 0;
+					last_percent = percent;
+				}
 			}
 		}
+
+		/*
+		 * Did we write the wrong # entries in the header?
+		 * If so, rewrite it like in fast-import (gackk).
+		 */
+		if ( !base_name || nr_written == nr_result ) {
+			sha1close(f, pack_file_sha1, 1);
+		} else {
+			sha1close(f, pack_file_sha1, -1);
+			fixup_header_footer(pack_fd, pack_file_sha1, oldname, nr_written);
+		}
+
+		/*
+		 * compute object_list_sha1 of sorted sha's we just wrote out;
+		 * we also mark these objects as written
+		 */
+		current_sort = sha1_sort;
+		qsort(written_list, nr_written, sizeof(struct object_entry *), sort_comparator);
+		SHA1_Init(&ctx);
+		for (j = 0; j < nr_written; j++) {
+			struct object_entry *entry = written_list[j];
+			entry->prev_pack = 1;
+			SHA1_Update(&ctx, entry->sha1, 20);
+		}
+		SHA1_Final(object_list_sha1, &ctx);
+		/*
+		 * now we can rename the pack correctly and write the index file
+		 */
+		if (base_name) {
+			char newname[PATH_MAX];
+			int len = snprintf(newname, sizeof newname, "%s-%s.%s",
+						base_name, sha1_to_hex(object_list_sha1), "pack");
+			if (len >= PATH_MAX)
+				die("excessive pathname length for final packfile name");
+			if (rename(oldname, newname) < 0)
+				die("could not rename the pack file");
+		}
+		if (!pack_to_stdout) {
+			write_index_file();
+			puts(sha1_to_hex(object_list_sha1));
+		}
 	}
-	if (do_progress)
+
+	free(written_list);
+	if (nr_result && do_progress)
 		fputc('\n', stderr);
- done:
 	if (written != nr_result)
 		die("wrote %u objects while expecting %u", written, nr_result);
-	sha1close(f, pack_file_sha1, 1);
-	if (!pack_to_stdout) {
-		write_index_file();
-		puts(sha1_to_hex(object_list_sha1));
-	}
 }
 
 static void write_index_file(void)
@@ -681,8 +733,8 @@ static void write_index_file(void)
 	uint32_t i;
 	struct sha1file *f = sha1create("%s-%s.%s", base_name,
 					sha1_to_hex(object_list_sha1), "idx");
-	struct object_entry **list = sorted_by_sha;
-	struct object_entry **last = list + nr_result;
+	struct object_entry **list = written_list;
+	struct object_entry **last = list + nr_written;
 	uint32_t array[256];
 
 	/*
@@ -698,7 +750,7 @@ static void write_index_file(void)
 				break;
 			next++;
 		}
-		array[i] = htonl(next - sorted_by_sha);
+		array[i] = htonl(next - written_list);
 		list = next;
 	}
 	sha1write(f, array, 256 * 4);
@@ -706,8 +758,8 @@ static void write_index_file(void)
 	/*
 	 * Write the actual SHA1 entries..
 	 */
-	list = sorted_by_sha;
-	for (i = 0; i < nr_result; i++) {
+	list = written_list;
+	for (i = 0; i < nr_written; i++) {
 		struct object_entry *entry = *list++;
 		uint32_t offset = htonl(entry->offset);
 		sha1write(f, &offset, 4);
-- 
1.5.1.89.g8abf0
