From: Dana How <danahow@gmail.com>
Subject: [PATCH] Prevent megablobs from gunking up git packs
Date: Mon, 21 May 2007 23:14:32 -0700
Message-ID: <46528A48.9050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 08:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNdr-0002vZ-Ap
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbXEVGOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756857AbXEVGOj
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:14:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:26282 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871AbXEVGOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:14:38 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1653148wra
        for <git@vger.kernel.org>; Mon, 21 May 2007 23:14:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Rq3nZRuVIqbZCuHApffVIXZeWLFw71Kr7cqbj39U7MT7TPA8AilqUqp6KaKff/UN8yzQ+j8iEiz+K9R4vp3QicNFMdPFyvrVA+31ULTqu1y6PE3EZcTlOKGdbMf/p8+kxwF7YlLdLQUwRKSLfsnJEELsQyUfYxFfQvyHtCCaDek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ka8iZNHu0wZgmNl6kWP3n7Mepw6RXD7Eci2kA0/e+G6w1whFqtbT/HilasuJKt4TRDPEGQ3HpUCEl7p66gsI1M0RzsUpocVn01NSwHjpB+CMdWraoVSEirdO5uZ+DgJBZmUMjALdueMJW8OMbl76eL06t5zIIr/ldpyElgXph+E=
Received: by 10.114.158.1 with SMTP id g1mr3140216wae.1179814476977;
        Mon, 21 May 2007 23:14:36 -0700 (PDT)
Received: from ?192.168.5.23? ( [64.186.171.227])
        by mx.google.com with ESMTP id y25sm20664923pod.2007.05.21.23.14.34;
        Mon, 21 May 2007 23:14:35 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48073>


Using fast-import and repack with the max-pack-size patch,
3628 commits were imported from Perforce comprising
100.35GB (uncompressed) in 38829 blobs,  and saved in
7 packfiles of 12.5GB total (--window=0 and --depth=0 were
used due to runtime limits).  When using these packfiles,
several git commands showed very large process sizes,
and some slowdowns (compared to comparable operations
on the linux kernel repo) were also apparent.

git stores data in loose blobs or in packfiles.  The former
has essentially now become an exception mechanism,  to store
exceptionally *young* blobs.  Why not use this to store
exceptionally *large* blobs as well?  This allows us to
re-use all the "exception" machinery with only a small change.

Repacking the entire repository with a max-blob-size of 256KB
resulted in a single 13.1MB packfile,  as well as 2853 loose
objects totaling 15.4GB compressed and 100.08GB uncompressed,
11 files per objects/xx directory on average.  All was created
in half the runtime of the previous yet with standard
--window=10 and --depth=50 parameters.  The data in the
packfile was 270MB uncompressed in 35976 blobs.  Operations
such as "git-log --pretty=oneline" were about 30X faster
on a cold cache and 2 to 3X faster otherwise.  Process sizes
remained reasonable.

This patch implements the following:
1. git pack-objects takes a new --max-blob-size=N flag,
   with the effect that only blobs less than N KB are written
   to the packfiles(s).  If a blob was in a pack but violates
   this limit (perhaps the packs were created by fast-import
   or max-blob-size was reduced),  then a new loose object
   is written out if needed so the data is not lost.
2. git repack inspects repack.maxblobsize .  If set,  its
   value is passed to git pack-objects on the command line.
   The user should change repack.maxblobsize ,  NOT specify
   --max-blob-size=N .
3. No other caller of git pack-objects supplies this new flag,
   so other callers see no change.

This patch is on top of the earlier max-pack-size patch,
because I thought I needed some behavior it supplied,
but could be rebased on master if desired.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   33 +++++++++++++++++++++++++++++++--
 cache.h                |    2 ++
 git-repack.sh          |    4 ++++
 sha1_file.c            |   17 +++++++++++++++--
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 930b57a..e88f6b7 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -16,7 +16,7 @@
 
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
-	[--local] [--incremental] [--window=N] [--depth=N] \n\
+	[--local] [--incremental] [--window=N] [--depth=N] [--max-blob-size=N]\n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
 	[--stdout | base-name] [<ref-list | <object-list]";
@@ -73,6 +73,7 @@ static int num_preferred_base;
 static struct progress progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static uint32_t max_blob_size;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -562,6 +563,24 @@ static off_t write_one(struct sha1file *f,
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
+		written++;
+		return offset;
+	}
+
 	e->offset = offset;
 	size = write_object(f, e, offset);
 	if (!size) {
@@ -1391,13 +1410,16 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
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
@@ -1701,6 +1723,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
diff --git a/cache.h b/cache.h
index 3143853..ad39f67 100644
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
index 4ea6e5b..c2b2112 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -35,6 +35,10 @@ true)
 	extra="$extra --delta-base-offset" ;;
 esac
 
+# handle blob limiting
+mbs="`git config --int repack.maxblobsize`"
+[ -n "$mbs" ] && extra="$extra --max-blob-size=$mbs"
+
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
 PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
diff --git a/sha1_file.c b/sha1_file.c
index e715527..8786af7 100644
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
1.5.2.rc3.726.g279d-dirty
