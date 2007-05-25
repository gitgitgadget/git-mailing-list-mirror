From: Dana How <danahow@gmail.com>
Subject: [PATCH v2] Enhance unpack-objects for live repo and large objects
Date: Fri, 25 May 2007 14:40:24 -0700
Message-ID: <465757C8.4000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 23:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrhWW-00069G-5N
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854AbXEYVk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758409AbXEYVk3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:40:29 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:60286 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758367AbXEYVk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:40:28 -0400
Received: by nz-out-0506.google.com with SMTP id n1so439733nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 14:40:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=bRwwWc9UWa91VYrqFuuLRGX6buxF6Kwm86vgZz32d5VLMNz3oiabFKurlkRddh5J3lOD8y/QJIuRfqnNdGDE/4WyF/IeTHEMucOPljkbOAo1o7TbQ2jmnAy/p84kLjHHEJf5ZFkk9KaQTATN6usraQOQIcyZ+nODf9Xm/g3SIsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=H0bCBDixkuhFo4o3Ohx7rghOP73KQqr+wYLbr0ceLfCUkrMHD6zW1wjIEZ3Xo26EKS5FlJvanQ/hgMVqNsPbMU2ARo9DZ74wX91kUyagp20pMjrOLTf2gDhybY+VnvF95rYBTSARJ1Ail5QK7jia9/lb1/ixjm+YvtX5I6H51Ks=
Received: by 10.114.153.18 with SMTP id a18mr1659955wae.1180129227586;
        Fri, 25 May 2007 14:40:27 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id m27sm3648807pof.2007.05.25.14.40.25;
        Fri, 25 May 2007 14:40:26 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48422>


Nicolas Pitre wrote:
> I wouldn't mind a _separate_ tool that would load a pack index,
> determine object sizes from it, and then extract big objects to write
> them as loose objects ...

Add two new options to git-unpack-objects:

--force:: Loose objects will be created even if they
already exist in the repository packed.

--min-blob-size=<n>::  Unpacking is only done for objects
larger than or equal to n kB (uncompressed size).

Passes the tests in "t" and tested on big objects.
Based on "next" but should apply to "master" as well.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Documentation/git-unpack-objects.txt |   23 +++++++++++++++++++----
 builtin-unpack-objects.c             |   29 +++++++++++++++++++++++++++--
 cache.h                              |    2 ++
 sha1_file.c                          |   16 ++++++++++++----
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index ff6184b..3df2641 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,7 +8,7 @@ git-unpack-objects - Unpack objects from a packed archive
 
 SYNOPSIS
 --------
-'git-unpack-objects' [-n] [-q] [-r] <pack-file
+'git-unpack-objects' [-n] [-q] [-r] [-f] [--min-blob-size=N] <pack-file
 
 
 DESCRIPTION
@@ -17,9 +17,12 @@ Read a packed archive (.pack) from the standard input, expanding
 the objects contained within and writing them into the repository in
 "loose" (one object per file) format.
 
-Objects that already exist in the repository will *not* be unpacked
-from the pack-file.  Therefore, nothing will be unpacked if you use
-this command on a pack-file that exists within the target repository.
+By default,  objects that already exist in the repository will *not*
+be unpacked from the pack-file.  Therefore, nothing will be unpacked
+if you use this command on a pack-file that exists within the target
+repository,  unless you specify -f.  If an object already exists
+unpacked in the repository,  it will not be replaced with the copy
+from the pack,  with or without -f.
 
 Please see the `git-repack` documentation for options to generate
 new packs and replace existing ones.
@@ -40,6 +43,18 @@ OPTIONS
 	and make the best effort to recover as many objects as
 	possible.
 
+-f::
+	Allow loose objects to be created in the same repository that
+	contains the packfile.
+
+--min-blob-size=<n>::
+	Smallest loose object to create,  expressed in kB.
+	Blobs smaller than this will not be unpacked.  Default is 0.
+	If you specify this option with a deltified source packfile,
+	the source packfile should reside in the current repository
+	so delta bases too small to unpack are still accessible,  and
+	therefore -f will be needed for anything to be written.
+
 
 Author
 ------
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index a6ff62f..b8ee7b5 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -10,13 +10,16 @@
 #include "progress.h"
 
 static int dry_run, quiet, recover, has_errors;
-static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
+static const char unpack_usage[] =
+"git-unpack-objects [-n] [-q] [-r] [-f] [--min-blob-size=N] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static SHA_CTX ctx;
+static int force = 0;
+uint32_t min_blob_size;
 
 /*
  * Make sure at least "min" bytes are available in the buffer, and
@@ -131,7 +134,18 @@ static void added_object(unsigned nr, enum object_type type,
 static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
-	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
+	/*
+	 * We never need to write it when it's too small.
+	 * Otherwise,  without -f,  we write it only when
+	 * it does not exist in the repository in any form.
+	 * Finally,  with -f,  we write it only when it does
+	 * not exist in the local repository as a loose object.
+	 * In all cases we fill in obj_list[nr].sha1 .
+	 */
+	if (size < min_blob_size)
+		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
+	else if (write_sha1_file_maybe(buf, size, typename(type),
+				       force, obj_list[nr].sha1) < 0)
 		die("failed to write object");
 	added_object(nr, type, buf, size);
 }
@@ -361,6 +375,17 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				recover = 1;
 				continue;
 			}
+			if (!strcmp(arg, "-f")) {
+				force = 1;
+				continue;
+			}
+			if (!prefixcmp(arg, "--min-blob-size=")) {
+				char *end;
+				min_blob_size = strtoul(arg+16, &end, 0) * 1024;
+				if (!arg[16] || *end)
+					usage(unpack_usage);
+				continue;
+			}
 			if (!prefixcmp(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
diff --git a/cache.h b/cache.h
index ec85d93..4994d03 100644
--- a/cache.h
+++ b/cache.h
@@ -343,6 +343,8 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int write_sha1_file_maybe(void *buf, unsigned long len, const char *type,
+				 int dup_ok, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
diff --git a/sha1_file.c b/sha1_file.c
index 12d2ef2..e4c3288 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1979,7 +1979,8 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 	return 0;
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file_maybe(void *buf, unsigned long len, const char *type,
+			  int dup_ok, unsigned char *returnsha1)
 {
 	int size, ret;
 	unsigned char *compressed;
@@ -1990,14 +1991,15 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	char hdr[32];
 	int fd, hdrlen;
 
-	/* Normally if we have it in the pack then we do not bother writing
-	 * it out into .git/objects/??/?{38} file.
+	/* Normally if in a pack (or any where else) then we do not write
+	 * it out into .git/objects/??/?{38} file,  but with dup_ok != 0
+	 * we only avoid over-writing a loose blob in the local repo.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	filename = sha1_file_name(sha1);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
+	if (!dup_ok && has_sha1_file(sha1))
 		return 0;
 	fd = open(filename, O_RDONLY);
 	if (fd >= 0) {
@@ -2062,6 +2064,12 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	return move_temp_to_file(tmpfile, filename);
 }
 
+int write_sha1_file(void *buf, unsigned long len, const char *type,
+		    unsigned char *returnsha1)
+{
+	return write_sha1_file_maybe(buf, len, type, 0, returnsha1);
+}
+
 /*
  * We need to unpack and recompress the object for writing
  * it out to a different file.
-- 
1.5.2.762.gd8c6-dirty
