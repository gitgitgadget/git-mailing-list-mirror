From: Dana How <danahow@gmail.com>
Subject: [PATCH 2/8] git-repack --max-pack-size: code restructuring
Date: Mon, 30 Apr 2007 16:19:06 -0700
Message-ID: <4636796A.5070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:19:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hif9G-0001aD-NC
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423768AbXD3XTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423775AbXD3XTL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:19:11 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:40024 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423768AbXD3XTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:19:08 -0400
Received: by py-out-1112.google.com with SMTP id a29so1462735pyi
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:19:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=HOqLLZqSJq8aGvq58/intVC3aRD7cvkIQvtavP3T1yHuFu68pmW6oUy3+SYuh7dV+Wrw0Kij+PiS9HenOAb4Rctmv4ASaMYFgplgg4rJqJK/8CLDiiZmECVmKi+VFsdXmPygWT5NMx144/stsHEinMeCEa2ZABPzRovFC9wVoUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=LXVxPcrlEAh+PKq6u9qBsrRdkx5DwmkNc24r7xmBKBkARGLuoTwuV1eoOOBdx1FYNnH0RYeQgixppn1PdBLKGKQw5V5vQ4t94RwBkuU80ktOoeV0zZC0eUxWq41J2GxaPnQqvbnIQ+DfcE0SpANWH2rJScE5JopHSZZ58Ykv0zg=
Received: by 10.35.45.1 with SMTP id x1mr12205606pyj.1177975148255;
        Mon, 30 Apr 2007 16:19:08 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 15sm23044179nzp.2007.04.30.16.19.07;
        Mon, 30 Apr 2007 16:19:07 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45891>


Move write_index_file() call from cnd_pack_objects() to
write_pack_file() since only the latter will know how
many times to call write_index_file().  Add forward
declarations and make "base_name" file scope again.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   64 ++++++++++++++++++++++++-----------------------
 1 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ac2c15e..bc45ca6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -62,6 +62,7 @@ static int incremental;
 static int allow_ofs_delta;
 static const char *pack_tmp_name, *idx_tmp_name;
 static char tmpname[PATH_MAX];
+static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static int window = 10;
@@ -561,7 +562,11 @@ static off_t write_one(struct sha1file *f,
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
@@ -605,7 +610,32 @@ static off_t write_pack_file(void)
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
@@ -1588,8 +1618,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	uint32_t i;
-	off_t last_obj_offset;
-	const char *base_name = NULL;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
 	int rp_ac;
@@ -1740,33 +1768,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
1.5.2.rc0.766.gba60-dirty
