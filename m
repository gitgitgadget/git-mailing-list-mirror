From: Dana How <danahow@gmail.com>
Subject: [PATCH 2/5] git-repack --max-pack-size: new file statics and code
 restructuring
Date: Tue, 01 May 2007 17:05:30 -0700
Message-ID: <4637D5CA.6000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 02:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj2Ll-0007wo-Hp
	for gcvg-git@gmane.org; Wed, 02 May 2007 02:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbXEBAFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 20:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946106AbXEBAFg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 20:05:36 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:42697 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946105AbXEBAFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 20:05:34 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2379450nzf
        for <git@vger.kernel.org>; Tue, 01 May 2007 17:05:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=XokqPDaJ9Kir7qYDwl8vrt9MK61X8HVZVO2HRfTvdJNi3QHxFVU18OPMz/9FXPjLiyTZPcE1WUxQg/CnjoWJnZcCrPPd4JbAab0rYViMdzGZQAgeUQ76lqYj7NmtE0ulJgRB+AykI698SjgjfdUY87rvbMC2SB/u9TFvKkGYHB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=aZ/ryUal54i1ps4A6NLeV+Ui1AEgR60/JV2PSgS7BkG0CALumsoMB3VSgUpeawzqIPQ9eXZZ9qRA4PqZ0IgKeQ91ClM7i32XXSq/cP6RxzzPMxUJXuykjO9n/s34Q41ue0q0NtlBdiHBy1lRwXJ75ZeqUYGSxb4PMNSAFsT7zUc=
Received: by 10.64.249.18 with SMTP id w18mr126883qbh.1178064334032;
        Tue, 01 May 2007 17:05:34 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 12sm482873nzn.2007.05.01.17.05.32;
        Tue, 01 May 2007 17:05:32 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45995>


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
index b827627..bc45ca6 100644
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
@@ -559,7 +562,11 @@ static off_t write_one(struct sha1file *f,
 	return offset + size;
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
@@ -603,7 +610,32 @@ static off_t write_pack_file(void)
 		die("wrote %u objects while expecting %u", written, nr_result);
 	sha1close(f, pack_file_sha1, 1);
 
-	return last_obj_offset;
+	if (!pack_to_stdout) {
+		unsigned char object_list_sha1[20];
+		mode_t mode = umask(0);
+
+		umask(mode);
+		mode = 0444 & ~mode;
+
+		write_index_file(last_obj_offset, object_list_sha1);
+		snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
+			 base_name, sha1_to_hex(object_list_sha1));
+		if (adjust_perm(pack_tmp_name, mode))
+			die("unable to make temporary pack file readable: %s",
+			    strerror(errno));
+		if (rename(pack_tmp_name, tmpname))
+			die("unable to rename temporary pack file: %s",
+			    strerror(errno));
+		snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
+			 base_name, sha1_to_hex(object_list_sha1));
+		if (adjust_perm(idx_tmp_name, mode))
+			die("unable to make temporary index file readable: %s",
+			    strerror(errno));
+		if (rename(idx_tmp_name, tmpname))
+			die("unable to rename temporary index file: %s",
+			    strerror(errno));
+		puts(sha1_to_hex(object_list_sha1));
+	}
 }
 
 static int sha1_sort(const void *_a, const void *_b)
@@ -1586,8 +1618,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	uint32_t i;
-	off_t last_obj_offset;
-	const char *base_name = NULL;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
 	int rp_ac;
@@ -1738,33 +1768,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
1.5.2.rc0.789.gd951
