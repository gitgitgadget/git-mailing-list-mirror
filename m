From: Dana How <danahow@gmail.com>
Subject: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Tue, 01 May 2007 20:18:05 -0700
Message-ID: <463802ED.1080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 05:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj5MF-00065t-EG
	for gcvg-git@gmane.org; Wed, 02 May 2007 05:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbXEBDSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 23:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbXEBDSP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 23:18:15 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:43357 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbXEBDSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 23:18:09 -0400
Received: by wx-out-0506.google.com with SMTP id h31so535wxd
        for <git@vger.kernel.org>; Tue, 01 May 2007 20:18:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=O3t5Yq4eYjsKh4jL75hGboLMFo7fiFwQdD02Sfh/QcwLfeM3BuLyTka+V9NQ7hLqF6yEecfJpJieK9SdPRwsAfyEZTg/84rHH8ZNj4M0uAUUgNdr1Y4MlglqrdD0bXM1gCZ8djbxKjFbb7uhoZPxn4uTdo2Xm7rzUGaSppuHTKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=TrXTPiLHoZZqZLUhK7y7GayP/8R5Ckik1sVWkTQV2JaDXNApGrYHf1y/NDStDX+GUN3U9JcKqU4WRV//kwomoF4m/SpQqKv6TzwhQ7ZKkSqpcMo5QgyyhDfmBdmlz7L2bPSaIDjEYNTjW7nRQI5aZ1um141Td6VX1yqewxjSk6M=
Received: by 10.70.39.2 with SMTP id m2mr390106wxm.1178075888471;
        Tue, 01 May 2007 20:18:08 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 18sm416382wry.2007.05.01.20.18.06;
        Tue, 01 May 2007 20:18:07 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46001>


Git's object store and packing are optimized for
* Expensive repo to repo bandwidth; and
* Small-ish files
This justifies extensive use of compression.

In a multi-developer *office* with inter-repository
transfers occurring over a 100Mb+ LAN,  there is less
reason to compress files and slow down response times.
Response times suffer even more when large files are involved.
However,  *off-line* pack compression may still be
desirable to reduce storage space.

Consequently,  for such a usage pattern it is useful
to specify different compression levels for loose
objects and packs.  This patch implements a config
variable pack.compression in addition to the existing
core.compression,  meant to be used for repacking.
It also adds --compression=N to pack-objects,
meant for push/pull/fetch,  if different,  or if different
on a per-repository basis.

** THIS PATCH IS UNTESTED AND MEANT FOR DISCUSSION. **
git-repack.sh might also need to be modified,
and how to pass --compression=N during push/pull/fetch
has not been investigated.

This applies on top of the git-repack --max-pack-size patchset.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   56 ++++++++++++++++++++++++++++++++++++------------
 1 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 69fec34..b663c15 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -70,6 +70,7 @@ static uint32_t pack_size_limit;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress progress_state;
+static int pack_compression_level, pack_compression_seen;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -414,6 +415,16 @@ static unsigned long write_object(struct sha1file *f,
 	/* write limit if limited packsize and not first object */
 	unsigned long limit = pack_size_limit && nr_written ?
 				pack_size_limit - write_offset : 0;
+				/* no if no delta */
+	int usable_delta =	!entry->delta ? 0 :
+				/* yes if unlimited packfile */
+				!pack_size_limit ? 1 :
+				/* no if base written to previous pack */
+				entry->delta->offset == (off_t)-1 ? 0 :
+				/* otherwise double-check written to this
+				 * pack,  like we do below
+				 */
+				entry->delta->offset ? 1 : 0;
 
 	if (!pack_to_stdout)
 		crc32_begin(f);
@@ -423,8 +434,7 @@ static unsigned long write_object(struct sha1file *f,
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (obj_type == OBJ_REF_DELTA || obj_type == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
-		to_reuse = !pack_size_limit ||
-			(entry->delta->offset && entry->delta->offset != (off_t)-1);
+		to_reuse = usable_delta;
 				/* ... but pack split may override that */
 	else if (obj_type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
@@ -435,6 +445,10 @@ static unsigned long write_object(struct sha1file *f,
 				 * and we do not need to deltify it.
 				 */
 
+	/* differing core & pack compression when loose object -> must recompress */
+	if (!entry->in_pack && pack_compression_level != zlib_compression_level)
+		to_reuse = 0;
+	else
 	if (!entry->in_pack && !entry->delta) {
 		unsigned char *map;
 		unsigned long mapsize;
@@ -462,16 +476,6 @@ static unsigned long write_object(struct sha1file *f,
 		z_stream stream;
 		unsigned long maxsize;
 		void *out;
-					/* no if no delta */
-		int usable_delta =	!entry->delta ? 0 :
-					/* yes if unlimited packfile */
-					!pack_size_limit ? 1 :
-					/* no if base written to previous pack */
-					entry->delta->offset == (off_t)-1 ? 0 :
-					/* otherwise double-check written to this
-					 * pack,  like we do below
-					 */
-					entry->delta->offset ? 1 : 0;
 		buf = read_sha1_file(entry->sha1, &type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
@@ -493,7 +497,7 @@ static unsigned long write_object(struct sha1file *f,
 		}
 		/* compress the data to store and put compressed length in datalen */
 		memset(&stream, 0, sizeof(stream));
-		deflateInit(&stream, zlib_compression_level);
+		deflateInit(&stream, pack_compression_level);
 		maxsize = deflateBound(&stream, size);
 		out = xmalloc(maxsize);
 		/* Compress it */
@@ -606,7 +610,7 @@ static unsigned long write_object(struct sha1file *f,
 		unuse_pack(&w_curs);
 		reused++;
 	}
-	if (entry->delta)
+	if (usable_delta)
 		written_delta++;
 	written++;
 	if (!pack_to_stdout)
@@ -1622,6 +1626,16 @@ static int git_pack_config(const char *k, const char *v)
 		window = git_config_int(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.compression")) {
+		int level = git_config_int(k, v);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die("bad pack compression level %d", level);
+		pack_compression_level = level;
+		pack_compression_seen = 1;
+		return 0;
+	}
 	return git_default_config(k, v);
 }
 
@@ -1732,6 +1746,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	rp_ac = 2;
 
 	git_config(git_pack_config);
+	if (!pack_compression_seen)
+		pack_compression_level = zlib_compression_level;
 
 	progress = isatty(2);
 	for (i = 1; i < argc; i++) {
@@ -1759,6 +1775,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				usage(pack_usage);
 			continue;
 		}
+		if (!prefixcmp(arg, "--compression=")) {
+			char *end;
+			int level = strtoul(arg+14, &end, 0);
+			if (!arg[14] || *end)
+				usage(pack_usage);
+			if (level == -1)
+				level = Z_DEFAULT_COMPRESSION;
+			else if (level < 0 || level > Z_BEST_COMPRESSION)
+				die("bad pack compression level %d", level);
+			pack_compression_level = level;
+			continue;
+		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
-- 
1.5.2.rc0.787.g0014
