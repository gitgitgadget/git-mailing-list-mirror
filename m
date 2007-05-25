From: Dana How <danahow@gmail.com>
Subject: [PATCH] Enhance unpack-objects for extracting large objects
Date: Fri, 25 May 2007 01:20:07 -0700
Message-ID: <46569C37.5000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 10:20:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrV2J-0001DY-9U
	for gcvg-git@gmane.org; Fri, 25 May 2007 10:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760296AbXEYIUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 04:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760282AbXEYIUX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 04:20:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:61764 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760213AbXEYIUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 04:20:16 -0400
Received: by nz-out-0506.google.com with SMTP id n1so271148nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 01:20:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=rT2HjHpsgqmmoA//qWHDS56ZEBzV6/AUhOcl/e9Z5ZF9K/maZzcoawmugh8l2DcumdpKkAUOwyu50WyeVS6GHJRpYL1sMd/IWEca0CLFS5LbFUCqVIPfYJAKEF47L5e5z6iy84Qx6Z3mHFMnda4NSJ13IlE4+i1le0/eab9tRKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=o/ZNvaiyQtzBctiW+A1+IS1Zy63U8UzS99Al+QhSl7ZPK6pOv9ddhVO42uSTKW5WJpvzOv8IJKkHKzP4ojSEXRMJ38ReDuaXy0ySW8N5Y525uBqv2Li1nWyjulx6V/0n7g/+PEBp8+1pf/1hCTEfCxqtRNqYeD+5k5nEloayZKg=
Received: by 10.114.195.19 with SMTP id s19mr1395171waf.1180081215291;
        Fri, 25 May 2007 01:20:15 -0700 (PDT)
Received: from ?192.168.5.23? ( [64.186.171.227])
        by mx.google.com with ESMTP id y11sm2453491pod.2007.05.25.01.20.11;
        Fri, 25 May 2007 01:20:13 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48344>


Nicolas Pitre wrote:
> I wouldn't mind a _separate_ tool that would load a pack index,
> determine object sizes from it, and then extract big objects to write
> them as loose objects ...

Below we add two new options to git-unpack-objects:

--min-blob-size=<n>::  Unpacking is only done for objects
larger than or equal to n kB (uncompressed size by Junio).

--force::  Loose objects will be created even if they
already exist in the repository packed.  This is an option
I've wanted before for other reasons.

This passes the tests in "t" but has not yet been used on my large repos.
Based on "next" but should apply to "master" as well.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Documentation/git-unpack-objects.txt |   17 +++++++++++++----
 builtin-unpack-objects.c             |   20 ++++++++++++++++++--
 cache.h                              |    2 ++
 sha1_file.c                          |   11 +++++++++--
 4 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index ff6184b..4513d8d 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,7 +8,7 @@ git-unpack-objects - Unpack objects from a packed archive
 
 SYNOPSIS
 --------
-'git-unpack-objects' [-n] [-q] [-r] <pack-file
+'git-unpack-objects' [-n] [-q] [-r] [--force] [--min-blob-size=N] <pack-file
 
 
 DESCRIPTION
@@ -17,9 +17,10 @@ Read a packed archive (.pack) from the standard input, expanding
 the objects contained within and writing them into the repository in
 "loose" (one object per file) format.
 
-Objects that already exist in the repository will *not* be unpacked
-from the pack-file.  Therefore, nothing will be unpacked if you use
-this command on a pack-file that exists within the target repository.
+By default,  objects that already exist in the repository will *not*
+be unpacked from the pack-file.  Therefore, nothing will be unpacked
+if you use this command on a pack-file that exists within the target
+repository,  unless you specify --force.
 
 Please see the `git-repack` documentation for options to generate
 new packs and replace existing ones.
@@ -40,6 +41,14 @@ OPTIONS
 	and make the best effort to recover as many objects as
 	possible.
 
+--force::
+	Allow loose objects to be created in the same repository that
+	contains the packfile.
+
+--min-blob-size=<n>::
+	Smallest loose object to create,  expressed in kB.
+	Blobs smaller than this will not be unpacked.  Default is 0.
+
 
 Author
 ------
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index a6ff62f..a42bf0d 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -10,13 +10,16 @@
 #include "progress.h"
 
 static int dry_run, quiet, recover, has_errors;
-static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
+static const char unpack_usage[] =
+"git-unpack-objects [-n] [-q] [-r] [--force] [--min-blob-size=N] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static SHA_CTX ctx;
+static int force = 0;
+uint32_t min_blob_size;
 
 /*
  * Make sure at least "min" bytes are available in the buffer, and
@@ -131,7 +134,9 @@ static void added_object(unsigned nr, enum object_type type,
 static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
-	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
+	int force2 = size < min_blob_size ? -1 : force;
+	if (write_sha1_file_maybe(buf, size, typename(type),
+				  force2, obj_list[nr].sha1) < 0)
 		die("failed to write object");
 	added_object(nr, type, buf, size);
 }
@@ -361,6 +366,17 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				recover = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--force")) {
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
index ec85d93..d0c3030 100644
--- a/cache.h
+++ b/cache.h
@@ -343,6 +343,8 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int write_sha1_file_maybe(void *buf, unsigned long len, const char *type,
+				 int ignore, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
diff --git a/sha1_file.c b/sha1_file.c
index 12d2ef2..68b8db8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1979,7 +1979,8 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 	return 0;
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+int write_sha1_file_maybe(void *buf, unsigned long len, const char *type,
+			  int ignore, unsigned char *returnsha1)
 {
 	int size, ret;
 	unsigned char *compressed;
@@ -1997,7 +1998,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	filename = sha1_file_name(sha1);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
+	if (ignore < 0 || !ignore && has_sha1_file(sha1))
 		return 0;
 	fd = open(filename, O_RDONLY);
 	if (fd >= 0) {
@@ -2062,6 +2063,12 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
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
