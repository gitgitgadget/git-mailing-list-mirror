From: Dana How <danahow@gmail.com>
Subject: [PATCH 1/4] git-repack --max-pack-size: new file statics and code
 restructuring
Date: Tue, 08 May 2007 13:02:13 -0700
Message-ID: <4640D745.4060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:02:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVtT-0005FF-Ql
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031910AbXEHUCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031914AbXEHUCV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:02:21 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:7596 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031910AbXEHUCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:02:17 -0400
Received: by py-out-1112.google.com with SMTP id a29so1581356pyi
        for <git@vger.kernel.org>; Tue, 08 May 2007 13:02:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=UbZOYw+OI9F6QgX8IR5PcIfc/Jw41mEEr5YGkkC7FLOa2fVaP1ASIfC7jk48f9x/bNxYf3rFgBsMjzPnG1BPpcPCaDmd26A/jNfa6CeAFy74vK2EPWXWhuGJrDAn3agoqBhCCPpvcmLmQUzL1v2Z2W5lvatGCMAJUYqWmgq5nRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=NOFqp8TYb+jR7Y9xd2qjaQ9TjHDjpnMd4/TecQwnPl+E5Zj9x4p4vcNS1klSCXu/Xsti71Ah2s/udwDMFPd8egMmUKVl7WHyqyONp0EomDi6g9U77r8itbCvvHw/+9laPa6+IkA3G2XD32cTFU5L9RtrhiSsPpQrURPZ2k41FQY=
Received: by 10.35.70.2 with SMTP id x2mr13862850pyk.1178654536751;
        Tue, 08 May 2007 13:02:16 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id a79sm17388733pye.2007.05.08.13.02.14;
        Tue, 08 May 2007 13:02:16 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46613>


Add "pack_size_limit", the limit specified by --max-pack-size,
"written_list", the list of objects written to the current pack,
and "nr_written", the number of objects in written_list.
Put "base_name" at file scope again and add forward declarations.
Move write_index_file() call from cnd_pack_objects() to
write_pack_file() since only the latter will know how
many times to call write_index_file().

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   68 +++++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7bff8ea..d832e2d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -52,7 +52,8 @@ struct object_entry {
  * nice "minimum seek" order.
  */
 static struct object_entry *objects;
-static uint32_t nr_objects, nr_alloc, nr_result;
+static struct object_entry **written_list;
+static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
 static int no_reuse_delta;
@@ -61,9 +62,11 @@ static int incremental;
 static int allow_ofs_delta;
 static const char *pack_tmp_name, *idx_tmp_name;
 static char tmpname[PATH_MAX];
+static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static int window = 10;
+static uint32_t pack_size_limit;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress progress_state;
@@ -565,7 +568,11 @@ static int open_object_dir_tmp(const char *path)
     return mkstemp(tmpname);
 }
 
-static off_t write_pack_file(void)
+/* forward declarations for write_pack_file */
+static void write_index_file(off_t last_obj_offset, unsigned char *sha1);
+static int adjust_perm(const char *path, mode_t mode);
+
+static void write_pack_file(void)
 {
 	uint32_t i;
 	struct sha1file *f;
@@ -607,7 +614,32 @@ static off_t write_pack_file(void)
 		die("wrote %u objects while expecting %u", written, nr_result);
 	sha1close(f, pack_file_sha1, 1);
 
-	return last_obj_offset;
+	if (!pack_to_stdout) {
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
+	}
 }
 
 static int sha1_sort(const void *_a, const void *_b)
@@ -1588,8 +1620,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	uint32_t i;
-	off_t last_obj_offset;
-	const char *base_name = NULL;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
 	int rp_ac;
@@ -1740,33 +1770,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Result has %u objects.\n", nr_result);
 	if (nr_result)
 		prepare_pack(window, depth);
-	last_obj_offset = write_pack_file();
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
+	write_pack_file();
 	if (progress)
 		fprintf(stderr, "Total %u (delta %u), reused %u (delta %u)\n",
 			written, written_delta, reused, reused_delta);
-- 
1.5.2.rc0.787.g0014
