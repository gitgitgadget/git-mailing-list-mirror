From: Dana How <danahow@gmail.com>
Subject: [PATCH v2] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 19:41:15 -0700
Message-ID: <4653A9CB.8070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 04:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqgn9-0001Nf-K6
	for gcvg-git@gmane.org; Wed, 23 May 2007 04:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbXEWClY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 22:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756906AbXEWClY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 22:41:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:48595 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242AbXEWClW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 22:41:22 -0400
Received: by wr-out-0506.google.com with SMTP id 76so56419wra
        for <git@vger.kernel.org>; Tue, 22 May 2007 19:41:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=JkMKUA4q6B9wpShOQezmSI2za8FubRb/ecDtdCVoiCaf7H3GUZbgDB5gfwhZjLTZARzvjB5cel816+WnPhxE53hGfJcnO/qk8+5yn+o/IvxJgo8TjXZHIArUT6xCsJZKVjAMRYsa2Q40UMPjeSKiMePWk+DtGDO+GdU6jEHQ5bY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=iFhsPMiot2gHo/J4YJL5OBeNlrOWKDTzdEi1PuAQVauJ2Laa2+fI+M8gVi9i/gNl/nh6CNcWHkCrYUTMydpNNVbkRWNr+BHEmLzSIIMnwMwIHRGieYDRN6hbeweqjZbeLruAnyyfq2vOrYeTSBVyx/xIaibIOfiKQT1iPmEqVzc=
Received: by 10.115.89.1 with SMTP id r1mr65063wal.1179888080191;
        Tue, 22 May 2007 19:41:20 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id n22sm520829pof.2007.05.22.19.41.17;
        Tue, 22 May 2007 19:41:17 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48138>


git stores data in loose blobs or in packfiles.  The former has
essentially now become an exception mechanism,  to store unusually
*young* blobs.  Here we re-use all this "exception" machinery to
store unusually *large* blobs as well.

This patch implements the following:
1. git pack-objects takes a new --max-blob-size=N flag,  with the
   effect that only blobs less than N KB are written to the
   packfiles(s).  If an already packed blob violates this limit
   (perhaps these are fast-import packs or max-blob-size was
   reduced),  a new loose object is made as needed so data is not lost.
2. git repack inspects repack.maxblobsize .  If set,  its
   value is passed to git pack-objects on the command line.
   --max-blob-size=N is also accepted by git repack.
3. No other git pack-objects caller uses this feature or sees any change.

During pack *creation* this avoids copying & deltifying megablobs.
Therefore,  for 100GB repositories,  git repack can run in hours
for the first time after git fast-import,  and in minutes thereafter.
You can still include megablobs in your packs thus:
 % git-repack -a [-d]	{with repack.maxblobsize = 256}
 % git-repack --max-blob-size=0 [--max-pack-size=2047]
The first step creates a tight packfile and index with all metadata
and reasonable blob data,  and the second collects the megablobs,
which could be enhanced with .keep file manipulation,  etc.

During pack *use* this feature helps tighten access to heavily-used
metadata since it can't be separated by large blobs,  and allows all
such metadata to be accessed through the smallest number of index files.
Megablobs are accessible with some overhead as loose objects,
which can be corrected with a second packing step as shown above
at the cost of more index files and packing time.

Documentation has been updated and operation with pack-object's
--stdout is prevented.  This patch is based on "next".

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Documentation/config.txt           |    5 ++++
 Documentation/git-pack-objects.txt |    6 +++++
 Documentation/git-repack.txt       |   10 ++++++++
 builtin-pack-objects.c             |   41 +++++++++++++++++++++++++++++++----
 cache.h                            |    2 +
 git-repack.sh                      |    9 +++++++-
 sha1_file.c                        |   17 +++++++++++++-
 7 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 179cb17..70fd3b1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -599,6 +599,11 @@ remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See gitlink:git-remote[1].
 
+repack.maxblobsize::
+	Prevent gitlink:git-repack[1] from including blobs larger than
+	the specified number in kB,  unless overridden by --max-blob-size=N switch.
+	Defaults to zero which means no maximum size is in effect.
+
 repack.usedeltabaseoffset::
 	Allow gitlink:git-repack[1] to create packs that uses
 	delta-base offset.  Defaults to false.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index cfe127a..ebd36b9 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,12 @@ base-name::
 	times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--max-blob-size=<n>::
+	Maximum size of included blobs, expressed in kB.
+	If specified,  affected blobs only existing in packfiles
+	may be written out as new loose objects to prevent their loss.
+	The default is unlimited.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 2847c9b..7daa697 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -65,6 +65,12 @@ OPTIONS
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--max-blob-size=<n>::
+	Maximum size of included blobs, expressed in kB.
+	If specified,  affected blobs only existing in packfiles
+	may be written out as new loose objects to prevent their loss.
+	The default is unlimited.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
@@ -84,6 +90,10 @@ be able to read (this includes repositories from which packs can
 be copied out over http or rsync, and people who obtained packs
 that way can try to use older git with it).
 
+The configuration variable `repack.MaxBlobSize` provides the
+default for the --max-blob-size option if set.  The latter
+takes precedence.
+
 
 Author
 ------
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 19b0aa1..38e2a2b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -17,7 +17,7 @@
 
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
-	[--local] [--incremental] [--window=N] [--depth=N] \n\
+	[--local] [--incremental] [--window=N] [--depth=N] [--max-blob-size=N]\n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
 	[--stdout | base-name] [<ref-list | <object-list]";
@@ -75,6 +75,7 @@ static int num_preferred_base;
 static struct progress progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static uint32_t max_blob_size;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -371,8 +372,6 @@ static unsigned long write_object(struct sha1file *f,
 				pack_size_limit - write_offset : 0;
 				/* no if no delta */
 	int usable_delta =	!entry->delta ? 0 :
-				/* yes if unlimited packfile */
-				!pack_size_limit ? 1 :
 				/* no if base written to previous pack */
 				entry->delta->offset == (off_t)-1 ? 0 :
 				/* otherwise double-check written to this
@@ -408,7 +407,7 @@ static unsigned long write_object(struct sha1file *f,
 		buf = read_sha1_file(entry->sha1, &type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
-		if (size != entry->size)
+		if (size != entry->size && type == obj_type)
 			die("object %s size inconsistency (%lu vs %lu)",
 			    sha1_to_hex(entry->sha1), size, entry->size);
 		if (usable_delta) {
@@ -564,6 +563,25 @@ static off_t write_one(struct sha1file *f,
 			return 0;
 	}
 
+	/* refuse to include megablobs */
+	if (max_blob_size && e->size >= max_blob_size) {
+		if (e->in_pack) {
+			/* rewrite as loose object so git-repack doesn't lose data */
+			void *buf;
+			enum object_type type;
+			unsigned long size;
+			buf = read_sha1_file(e->sha1, &type, &size);
+			if (!buf)
+				die("unable to read %s", sha1_to_hex(e->sha1));
+			if (write_sha1_file_ignore_packs(buf, size, typename(type), NULL) < 0)
+				die("failed to write object");
+			free(buf);
+		}
+		e->offset = (off_t)-1;	/* might eject a reused delta base if mbs decreases */
+		written++;
+		return offset;
+	}
+
 	e->offset = offset;
 	size = write_object(f, e, offset);
 	if (!size) {
@@ -1422,13 +1440,16 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
+	src_size = src_entry->size;
+	/* prevent use if later dropped from packfile */
+	if (max_blob_size && (trg_size >= max_blob_size || src_size >= max_blob_size))
+		return 0;
 	max_size = trg_size/2 - 20;
 	max_size = max_size * (max_depth - src_entry->depth) / max_depth;
 	if (max_size == 0)
 		return 0;
 	if (trg_entry->delta && trg_entry->delta_size <= max_size)
 		max_size = trg_entry->delta_size-1;
-	src_size = src_entry->size;
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
@@ -1735,6 +1756,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-blob-size=")) {
+			char *end;
+			max_blob_size = strtoul(arg+16, &end, 0) * 1024;
+			if (!arg[16] || *end)
+				usage(pack_usage);
+			continue;
+		}
 		if (!prefixcmp(arg, "--compression=")) {
 			char *end;
 			int level = strtoul(arg+14, &end, 0);
@@ -1855,6 +1883,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
+	if (pack_to_stdout && max_blob_size)
+		die("--max-blob-size cannot be used to build a pack for transfer.");
+
 	prepare_packed_git();
 
 	if (progress)
diff --git a/cache.h b/cache.h
index ec85d93..a415924 100644
--- a/cache.h
+++ b/cache.h
@@ -343,6 +343,8 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int write_sha1_file_ignore_packs(void *buf, unsigned long len, const char *type,
+					unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
diff --git a/git-repack.sh b/git-repack.sh
index 4ea6e5b..6b4e1af 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -8,7 +8,7 @@ SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 no_update_info= all_into_one= remove_redundant=
-local= quiet= no_reuse= extra=
+local= quiet= no_reuse= extra= max_blob_size=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -18,6 +18,7 @@ do
 	-q)	quiet=-q ;;
 	-f)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
+	--max-blob-size=*) extra="$extra $1" max_blob_size=t ;;
 	--max-pack-size=*) extra="$extra $1" ;;
 	--window=*) extra="$extra $1" ;;
 	--depth=*) extra="$extra $1" ;;
@@ -35,6 +36,12 @@ true)
 	extra="$extra --delta-base-offset" ;;
 esac
 
+# handle blob limiting
+if [ -z "$max_blob_size" ]; then
+	mbs="`git config --int repack.maxblobsize`"
+	[ -n "$mbs" ] && extra="$extra --max-blob-size=$mbs"
+fi
+
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
 PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
diff --git a/sha1_file.c b/sha1_file.c
index 12d2ef2..1424756 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1979,7 +1979,8 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 	return 0;
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+static int write_sha1_file_core(void *buf, unsigned long len, const char *type,
+				int checkpacks, unsigned char *returnsha1)
 {
 	int size, ret;
 	unsigned char *compressed;
@@ -1997,7 +1998,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	filename = sha1_file_name(sha1);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
+	if (checkpacks && has_sha1_file(sha1))
 		return 0;
 	fd = open(filename, O_RDONLY);
 	if (fd >= 0) {
@@ -2062,6 +2063,18 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	return move_temp_to_file(tmpfile, filename);
 }
 
+int write_sha1_file(void *buf, unsigned long len, const char *type,
+		    unsigned char *returnsha1)
+{
+	return write_sha1_file_core(buf, len, type, 1, returnsha1);
+}
+
+int write_sha1_file_ignore_packs(void *buf, unsigned long len, const char *type,
+				 unsigned char *returnsha1)
+{
+	return write_sha1_file_core(buf, len, type, 0, returnsha1);
+}
+
 /*
  * We need to unpack and recompress the object for writing
  * it out to a different file.
-- 
1.5.2.762.gd8c6-dirty
