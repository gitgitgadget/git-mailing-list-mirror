From: Dana How <danahow@gmail.com>
Subject: [PATCH v3] Prevent megablobs from gunking up git packs
Date: Sat, 26 May 2007 12:16:59 -0700
Message-ID: <465887AB.1010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 21:17:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs1lI-0002Pc-85
	for gcvg-git@gmane.org; Sat, 26 May 2007 21:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbXEZTRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758498AbXEZTRI
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 15:17:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:60134 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbXEZTRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 15:17:05 -0400
Received: by nz-out-0506.google.com with SMTP id n1so608135nzf
        for <git@vger.kernel.org>; Sat, 26 May 2007 12:17:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=jHyS4peNhAcM1SNdWRIaC+DgC6vXLb1oeN3nwK4xAmU6qBy7u7zyGEXvzuXa0/T0BHSluY7aObjcMJbmGsZ+iC8Mx4uDeXw3MokT/JIO6U8TYbB2AsTm59Ozmkow3IWC6WPunNhOdo2firrpAnjT3tD7Bo65uHp2XPhtTQ370MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=hMlY2AlQfvAqSRk2nBUaz7VJ4XPOdClec4wbYDhQdEmSRoEHekF3xNgtwhPgWv6L/9+kdkNoICdaEdlAXvnqVJva45MfedXJUqz2aBVt9Ryy9h9y7JdQfTqf8TaZBFS9YYwGeUcVWlpvsyVs45dm9IGDWfBXlWy9NOZDw+bZT7A=
Received: by 10.114.170.1 with SMTP id s1mr2082060wae.1180207022855;
        Sat, 26 May 2007 12:17:02 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id m28sm5640470poh.2007.05.26.12.17.00;
        Sat, 26 May 2007 12:17:01 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48485>


Extremely large blobs distort general-purpose git packfiles.
These megablobs can be either stored in separate "kept" packfiles,
or left as loose objects.  Here we add some features to help
either approach.

This patch implements the following:
1. git pack-objects accepts --max-blob-size=N,  with the effect that
   only loose blobs less than N KB are written to the packfiles(s).
   If an already packed blob violates this limit (perhaps these are
   fast-import packs or max-blob-size was reduced),  it _is_ passed
   through if from a local pack and no loose copy exists.
2. git repack inspects repack.maxblobsize .  If set,  its
   value is passed to git pack-objects on the command line.
   --max-blob-size=N is also accepted by git repack.
3. No other git pack-objects caller uses this feature or sees any change.

During pack *creation* this minimizes including & deltifying megablobs.

During pack *use* this feature helps performance by keeping metadata
in a single smaller packfile,  and possibly reducing the number of index
files that must be read.  Megablobs could be separately packed,  or
left as loose objects.

Documentation has been updated and operation with pack-object's
--stdout is prevented.  This patch is based on "next".

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Documentation/config.txt           |    6 ++++++
 Documentation/git-pack-objects.txt |    5 +++++
 Documentation/git-repack.txt       |    9 +++++++++
 builtin-pack-objects.c             |   33 ++++++++++++++++++++++++++++-----
 cache.h                            |    1 +
 git-repack.sh                      |    9 ++++++++-
 sha1_file.c                        |    2 +-
 7 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 179cb17..4a14f05 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -599,6 +599,12 @@ remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See gitlink:git-remote[1].
 
+repack.maxblobsize::
+	Prevent gitlink:git-repack[1] from newly packing blobs larger than
+	the specified number in kB,  unless overridden by --max-blob-size=N switch.
+	Affected blobs will still be repacked if from a local pack and no loose
+	copy exists.  Defaults to zero which means no maximum size is in effect.
+
 repack.usedeltabaseoffset::
 	Allow gitlink:git-repack[1] to create packs that uses
 	delta-base offset.  Defaults to false.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index cfe127a..9b2e33d 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,11 @@ base-name::
 	times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--max-blob-size=<n>::
+	Maximum size of newly packed blobs, expressed in kB.
+	The default is unlimited.  Affected blobs will still be repacked
+	if from a local pack and no loose copy exists.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 2847c9b..b9d47e1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -65,6 +65,11 @@ OPTIONS
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--max-blob-size=<n>::
+	Maximum size of newly packed blobs, expressed in kB.
+	The default is unlimited.  Affected blobs will still be repacked
+	if from a local pack and no loose copy exists.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
@@ -84,6 +89,10 @@ be able to read (this includes repositories from which packs can
 be copied out over http or rsync, and people who obtained packs
 that way can try to use older git with it).
 
+The configuration variable `repack.MaxBlobSize` provides the
+default for the --max-blob-size option if set.  The latter
+takes precedence.
+
 
 Author
 ------
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 19b0aa1..59be849 100644
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
@@ -564,6 +563,17 @@ static off_t write_one(struct sha1file *f,
 			return 0;
 	}
 
+	/* refuse to include as many megablobs as possible */
+	if (max_blob_size && e->size >= max_blob_size) {
+		struct stat st;
+		/* skip if unpacked, remotely packed, or loose anywhere */
+		if (!e->in_pack || !e->in_pack->pack_local || find_sha1_file(e->sha1, &st)) {
+			e->offset = (off_t)-1;	/* might drop reused delta base if mbs less */
+			written++;
+			return offset;
+		}
+	}
+
 	e->offset = offset;
 	size = write_object(f, e, offset);
 	if (!size) {
@@ -1422,13 +1432,16 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
+	src_size = src_entry->size;
+	/* prevent use if could be later dropped from packfile */
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
@@ -1735,6 +1748,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
@@ -1855,6 +1875,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
 
+	if (pack_to_stdout && max_blob_size)
+		die("--max-blob-size cannot be used to build a pack for transfer.");
+
 	prepare_packed_git();
 
 	if (progress)
diff --git a/cache.h b/cache.h
index 4994d03..424b321 100644
--- a/cache.h
+++ b/cache.h
@@ -356,6 +356,7 @@ extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1, const char **ignore);
 extern int has_sha1_file(const unsigned char *sha1);
+extern char *find_sha1_file(const unsigned char *sha1, struct stat *st);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *);
 
 extern int has_pack_file(const unsigned char *sha1);
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
index e4c3288..17e9dbf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -387,7 +387,7 @@ void prepare_alt_odb(void)
 	read_info_alternates(get_object_directory(), 0);
 }
 
-static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
+char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 {
 	char *name = sha1_file_name(sha1);
 	struct alternate_object_database *alt;
-- 
1.5.2.764.g7ae34
