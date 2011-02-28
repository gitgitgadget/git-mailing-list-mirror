From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] index-pack: --verify
Date: Mon, 28 Feb 2011 01:49:41 -0800
Message-ID: <1298886583-30965-4-git-send-email-gitster@pobox.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 10:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzk8-0000zy-LC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab1B1JuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:50:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1B1JuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:50:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C53213547;
	Mon, 28 Feb 2011 04:51:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LYUG
	99Us/7yUsicDAnT5nj1Uxvk=; b=McoBFhEUSOGfxu98Y5CcyATQoTtJvydiklLa
	QN2POQK1Tzll+clZkNwVrdJYewZ5LI2Evyb/oTsAkNJEy0dsn89VBXjfw0+imW1s
	bB7LETA5SExW83NGLR4gZND8bEUu/BhIbZpgcCOp6TOn6VreG53wTgcNfnzmDtrg
	0FjcsO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Guo5qBI3+irXjCDdedDpGwLXmiDRtzX4LSHj5X3VR+9BCZSHIJODoHbPZoG+IGiM
	zN8vFp3/ktZhafvn9wfkyzmZsAgMNKZFx3Zvu7hILU1LWH7uHPiT0BNJFGXdAxef
	MnTlF94QurhMV63iAQFa2EHUextgt8sewXh6YV4/1q8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1FE53546;
	Mon, 28 Feb 2011 04:51:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9121C3545; Mon, 28 Feb 2011
 04:51:18 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa72
In-Reply-To: <1298886583-30965-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4B90AA5C-4320-11E0-A286-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168089>

Given an existing .pack file and the .idx file that describes it,
this new mode of operation reads and re-index the packfile and makes
sure the existing .idx file matches the result byte-for-byte.

All the objects in the .pack file are validated during this operation as
well.  Unlike verify-pack, which visits each object described in the .idx
file in the SHA-1 order, index-pack efficiently exploits the delta-chain
to avoid rebuilding the objects that are used as the base of deltified
objects over and over again while validating the objects.  This should
result in much quicker verification of the .pack file and its .idx file.

This version however cannot verify a .pack/.idx pair with a handcrafted v2
index that uses 64-bit offset representation for offsets that would fit
within 31-bit. You can create such an .idx file by giving a custom offset
to --index-version option to the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This does not make much of a difference in a small project like git.git
   itself, especially when the repository is packed with not very big depth
   value.

 builtin/index-pack.c  |   46 ++++++++++++++++++++++++++++++++++++++++------
 csum-file.c           |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 csum-file.h           |    2 ++
 pack-write.c          |   26 ++++++++++++++++----------
 pack.h                |    4 ++++
 t/t5302-pack-index.sh |   18 ++++++++++++++++++
 6 files changed, 125 insertions(+), 17 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4df6818..24a9a16 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,7 +11,7 @@
 #include "exec_cmd.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [ --keep | --keep=<msg> ] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry
 {
@@ -891,9 +891,32 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
+static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
+{
+	struct packed_git *p = add_packed_git(pack_name, strlen(pack_name), 1);
+
+	if (!p)
+		die("Cannot open existing pack file '%s'", pack_name);
+	if (open_pack_index(p))
+		die("Cannot open existing pack idx file for '%s'", pack_name);
+
+	/* Read the attributes from the existing idx file */
+	opts->version = p->index_version;
+
+	/*
+	 * Get rid of the idx file as we do not need it anymore.
+	 * NEEDSWORK: extract this bit from free_pack_by_name() in
+	 * sha1_file.c, perhaps?  It shouldn't matter very much as we
+	 * know we haven't installed this pack (hence we never have
+	 * read anything from it).
+	 */
+	close_pack_index(p);
+	free(p);
+}
+
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack = 0;
+	int i, fix_thin_pack = 0, verify = 0;
 	const char *curr_pack, *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
@@ -922,6 +945,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				fix_thin_pack = 1;
 			} else if (!strcmp(arg, "--strict")) {
 				strict = 1;
+			} else if (!strcmp(arg, "--verify")) {
+				verify = 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg = "";
 			} else if (!prefixcmp(arg, "--keep=")) {
@@ -988,6 +1013,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		strcpy(keep_name_buf + len - 5, ".keep");
 		keep_name = keep_name_buf;
 	}
+	if (verify) {
+		if (!index_name)
+			die("--verify with no packfile name given");
+		read_idx_option(&opts, index_name);
+		opts.flags |= WRITE_IDX_VERIFY;
+	}
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
@@ -1038,10 +1069,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_sha1);
 	free(idx_objects);
 
-	final(pack_name, curr_pack,
-		index_name, curr_index,
-		keep_name, keep_msg,
-		pack_sha1);
+	if (!verify)
+		final(pack_name, curr_pack,
+		      index_name, curr_index,
+		      keep_name, keep_msg,
+		      pack_sha1);
+	else
+		close(input_fd);
 	free(objects);
 	free(index_name_buf);
 	free(keep_name_buf);
diff --git a/csum-file.c b/csum-file.c
index 4d50cc5..f70e3dd 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,8 +11,20 @@
 #include "progress.h"
 #include "csum-file.h"
 
-static void flush(struct sha1file *f, void * buf, unsigned int count)
+static void flush(struct sha1file *f, void *buf, unsigned int count)
 {
+	if (0 <= f->check_fd && count)  {
+		unsigned char check_buffer[8192];
+		ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
+
+		if (ret < 0)
+			die_errno("%s: sha1 file read error", f->name);
+		if (ret < count)
+			die("%s: sha1 file truncated", f->name);
+		if (memcmp(buf, check_buffer, count))
+			die("sha1 file '%s' validation error", f->name);
+	}
+
 	for (;;) {
 		int ret = xwrite(f->fd, buf, count);
 		if (ret > 0) {
@@ -59,6 +71,17 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 		fd = 0;
 	} else
 		fd = f->fd;
+	if (0 <= f->check_fd) {
+		char discard;
+		int cnt = read_in_full(f->check_fd, &discard, 1);
+		if (cnt < 0)
+			die_errno("%s: error when reading the tail of sha1 file",
+				  f->name);
+		if (cnt)
+			die("%s: sha1 file has trailing garbage", f->name);
+		if (close(f->check_fd))
+			die_errno("%s: sha1 file error on close", f->name);
+	}
 	free(f);
 	return fd;
 }
@@ -101,10 +124,31 @@ struct sha1file *sha1fd(int fd, const char *name)
 	return sha1fd_throughput(fd, name, NULL);
 }
 
+struct sha1file *sha1fd_check(const char *name)
+{
+	int sink, check;
+	struct sha1file *f;
+
+	sink = open("/dev/null", O_WRONLY);
+	if (sink < 0)
+		return NULL;
+	check = open(name, O_RDONLY);
+	if (check < 0) {
+		int saved_errno = errno;
+		close(sink);
+		errno = saved_errno;
+		return NULL;
+	}
+	f = sha1fd(sink, name);
+	f->check_fd = check;
+	return f;
+}
+
 struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp)
 {
 	struct sha1file *f = xmalloc(sizeof(*f));
 	f->fd = fd;
+	f->check_fd = -1;
 	f->offset = 0;
 	f->total = 0;
 	f->tp = tp;
diff --git a/csum-file.h b/csum-file.h
index 294add2..6a7967c 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -6,6 +6,7 @@ struct progress;
 /* A SHA1-protected file */
 struct sha1file {
 	int fd;
+	int check_fd;
 	unsigned int offset;
 	git_SHA_CTX ctx;
 	off_t total;
@@ -21,6 +22,7 @@ struct sha1file {
 #define CSUM_FSYNC	2
 
 extern struct sha1file *sha1fd(int fd, const char *name);
+extern struct sha1file *sha1fd_check(const char *name);
 extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
 extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
diff --git a/pack-write.c b/pack-write.c
index f739a0f..16529c3 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -47,17 +47,22 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	else
 		sorted_by_sha = list = last = NULL;
 
-	if (!index_name) {
-		static char tmpfile[PATH_MAX];
-		fd = odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_idx_XXXXXX");
-		index_name = xstrdup(tmpfile);
+	if (opts->flags & WRITE_IDX_VERIFY) {
+		assert(index_name);
+		f = sha1fd_check(index_name);
 	} else {
-		unlink(index_name);
-		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+		if (!index_name) {
+			static char tmpfile[PATH_MAX];
+			fd = odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_idx_XXXXXX");
+			index_name = xstrdup(tmpfile);
+		} else {
+			unlink(index_name);
+			fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+		}
+		if (fd < 0)
+			die_errno("unable to create '%s'", index_name);
+		f = sha1fd(fd, index_name);
 	}
-	if (fd < 0)
-		die_errno("unable to create '%s'", index_name);
-	f = sha1fd(fd, index_name);
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
 	index_version = (last_obj_offset >> 31) ? 2 : opts->version;
@@ -142,7 +147,8 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	sha1write(f, sha1, 20);
-	sha1close(f, NULL, CSUM_FSYNC);
+	sha1close(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
+			    ? CSUM_CLOSE : CSUM_FSYNC));
 	git_SHA1_Final(sha1, &ctx);
 	return index_name;
 }
diff --git a/pack.h b/pack.h
index 953f57e..dddafdd 100644
--- a/pack.h
+++ b/pack.h
@@ -35,6 +35,10 @@ struct pack_header {
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
 struct pack_idx_option {
+	unsigned flags;
+	/* flag bits */
+#define WRITE_IDX_VERIFY 01
+
 	uint32_t version;
 	uint32_t off32_limit;
 };
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index b34ea93..7c5fa03 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -65,6 +65,14 @@ test_expect_success \
     'cmp "test-1-${pack1}.idx" "1.idx" &&
      cmp "test-2-${pack2}.idx" "2.idx"'
 
+test_expect_success 'index-pack --verify on index version 1' '
+	git index-pack --verify "test-1-${pack1}.pack"
+'
+
+test_expect_success 'index-pack --verify on index version 2' '
+	git index-pack --verify "test-2-${pack2}.pack"
+'
+
 test_expect_success \
     'index v2: force some 64-bit offsets with pack-objects' \
     'pack3=$(git pack-objects --index-version=2,0x40000 test-3 <obj-list)'
@@ -93,6 +101,16 @@ test_expect_success OFF64_T \
     '64-bit offsets: index-pack result should match pack-objects one' \
     'cmp "test-3-${pack3}.idx" "3.idx"'
 
+test_expect_success OFF64_T 'index-pack --verify on 64-bit offset v2 (cheat)' '
+	# This cheats by knowing which lower offset should still be encoded
+	# in 64-bit representation.
+	git index-pack --verify --index-version=2,0x40000 "test-3-${pack3}.pack"
+'
+
+test_expect_failure OFF64_T 'index-pack --verify on 64-bit offset v2' '
+	git index-pack --verify "test-3-${pack3}.pack"
+'
+
 # returns the object number for given object in given pack index
 index_obj_nr()
 {
-- 
1.7.4.1.249.g4aa72
