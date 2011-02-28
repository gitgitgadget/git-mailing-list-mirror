From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] write_idx_file: introduce a struct to hold idx
 customization options
Date: Mon, 28 Feb 2011 01:49:40 -0800
Message-ID: <1298886583-30965-3-git-send-email-gitster@pobox.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 10:50:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzk1-0000vE-4L
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab1B1JuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:50:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1B1JuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:50:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 104E13544;
	Mon, 28 Feb 2011 04:51:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EFFI
	o6vsSQl6scEaucin22zDLLs=; b=Yuz1ZbF8ZBH0AQPPS22+6t4r9jYqIAQRh5bV
	zVEbkdqfQhG9qzPKq78Nr8wFH2fYJLc8vQhuIjbCyOEMWeZsOK77p7VUWnUqS4f3
	A1vis0UGbp9sybElW2+SAWbjKT15euqVrrZ+Xknr9Z3E4bSY/UftC9sC9pP2lBEY
	doH83A0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	gfZ5CjqLUibdCIuuFDYX05S3lnvOfxfuBUl7EByoBfBOXzHot4glVHwJoakVBpVf
	KgJeqee1xxP7+jg6tdu9ohZQzGGz3cnpNe2mhhojh/IQUClK3q+FvYkOHIBVtT02
	3Zajmpsb6Cky0EehVlj3ElNFQW4gmOsJSsP2stKz3Gk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F212E3543;
	Mon, 28 Feb 2011 04:51:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D47383542; Mon, 28 Feb 2011
 04:51:14 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa72
In-Reply-To: <1298886583-30965-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 49568E82-4320-11E0-9C1A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168088>

Remove two globals, pack_idx_default version and pack_idx_off32_limit,
and place them in a pack_idx_option structure.  Allow callers to pass
it to write_idx_file() as a parameter.

Adjust all callers to the API change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c   |   23 +++++++++++++----------
 builtin/pack-objects.c |   20 +++++++++++---------
 fast-import.c          |   10 ++++++----
 pack-write.c           |   17 +++++++++++------
 pack.h                 |   11 +++++++----
 5 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1b5d83a..4df6818 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -880,11 +880,12 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 static int git_index_pack_config(const char *k, const char *v, void *cb)
 {
+	struct pack_idx_option *opts = cb;
+
 	if (!strcmp(k, "pack.indexversion")) {
-		pack_idx_default_version = git_config_int(k, v);
-		if (pack_idx_default_version > 2)
-			die("bad pack.indexversion=%"PRIu32,
-				pack_idx_default_version);
+		opts->version = git_config_int(k, v);
+		if (opts->version > 2)
+			die("bad pack.indexversion=%"PRIu32, opts->version);
 		return 0;
 	}
 	return git_default_config(k, v, cb);
@@ -898,6 +899,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
 	struct pack_idx_entry **idx_objects;
+	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -905,7 +907,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 
-	git_config(git_index_pack_config, NULL);
+	reset_pack_idx_option(&opts);
+	git_config(git_index_pack_config, &opts);
 	if (prefix && chdir(prefix))
 		die("Cannot come back to cwd");
 
@@ -944,12 +947,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				index_name = argv[++i];
 			} else if (!prefixcmp(arg, "--index-version=")) {
 				char *c;
-				pack_idx_default_version = strtoul(arg + 16, &c, 10);
-				if (pack_idx_default_version > 2)
+				opts.version = strtoul(arg + 16, &c, 10);
+				if (opts.version > 2)
 					die("bad %s", arg);
 				if (*c == ',')
-					pack_idx_off32_limit = strtoul(c+1, &c, 0);
-				if (*c || pack_idx_off32_limit & 0x80000000)
+					opts.off32_limit = strtoul(c+1, &c, 0);
+				if (*c || opts.off32_limit & 0x80000000)
 					die("bad %s", arg);
 			} else
 				usage(index_pack_usage);
@@ -1032,7 +1035,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(index_name, idx_objects, nr_objects, pack_sha1);
+	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_sha1);
 	free(idx_objects);
 
 	final(pack_name, curr_pack,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b0503b2..dc471b7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -70,6 +70,7 @@ static int local;
 static int incremental;
 static int ignore_packed_keep;
 static int allow_ofs_delta;
+static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
@@ -493,8 +494,8 @@ static void write_pack_file(void)
 			const char *idx_tmp_name;
 			char tmpname[PATH_MAX];
 
-			idx_tmp_name = write_idx_file(NULL, written_list,
-						      nr_written, sha1);
+			idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
+						      &pack_idx_opts, sha1);
 
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 				 base_name, sha1_to_hex(sha1));
@@ -1880,10 +1881,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.indexversion")) {
-		pack_idx_default_version = git_config_int(k, v);
-		if (pack_idx_default_version > 2)
+		pack_idx_opts.version = git_config_int(k, v);
+		if (pack_idx_opts.version > 2)
 			die("bad pack.indexversion=%"PRIu32,
-				pack_idx_default_version);
+			    pack_idx_opts.version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.packsizelimit")) {
@@ -2130,6 +2131,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	rp_av[1] = "--objects"; /* --thin will make it --objects-edge */
 	rp_ac = 2;
 
+	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
@@ -2274,12 +2276,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 		if (!prefixcmp(arg, "--index-version=")) {
 			char *c;
-			pack_idx_default_version = strtoul(arg + 16, &c, 10);
-			if (pack_idx_default_version > 2)
+			pack_idx_opts.version = strtoul(arg + 16, &c, 10);
+			if (pack_idx_opts.version > 2)
 				die("bad %s", arg);
 			if (*c == ',')
-				pack_idx_off32_limit = strtoul(c+1, &c, 0);
-			if (*c || pack_idx_off32_limit & 0x80000000)
+				pack_idx_opts.off32_limit = strtoul(c+1, &c, 0);
+			if (*c || pack_idx_opts.off32_limit & 0x80000000)
 				die("bad %s", arg);
 			continue;
 		}
diff --git a/fast-import.c b/fast-import.c
index 3886a1b..91e936d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -315,6 +315,7 @@ static unsigned int atom_cnt;
 static struct atom_str **atom_table;
 
 /* The .pack file being generated */
+static struct pack_idx_option pack_idx_opts;
 static unsigned int pack_id;
 static struct sha1file *pack_file;
 static struct packed_git *pack_data;
@@ -905,7 +906,7 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(NULL, idx, object_count, pack_data->sha1);
+	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts, pack_data->sha1);
 	free(idx);
 	return tmpfile;
 }
@@ -3055,10 +3056,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.indexversion")) {
-		pack_idx_default_version = git_config_int(k, v);
-		if (pack_idx_default_version > 2)
+		pack_idx_opts.version = git_config_int(k, v);
+		if (pack_idx_opts.version > 2)
 			die("bad pack.indexversion=%"PRIu32,
-			    pack_idx_default_version);
+			    pack_idx_opts.version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.packsizelimit")) {
@@ -3116,6 +3117,7 @@ int main(int argc, const char **argv)
 		usage(fast_import_usage);
 
 	setup_git_directory();
+	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
diff --git a/pack-write.c b/pack-write.c
index a905ca4..f739a0f 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -2,8 +2,12 @@
 #include "pack.h"
 #include "csum-file.h"
 
-uint32_t pack_idx_default_version = 2;
-uint32_t pack_idx_off32_limit = 0x7fffffff;
+void reset_pack_idx_option(struct pack_idx_option *opts)
+{
+	memset(opts, 0, sizeof(*opts));
+	opts->version = 2;
+	opts->off32_limit = 0x7fffffff;
+}
 
 static int sha1_compare(const void *_a, const void *_b)
 {
@@ -18,7 +22,8 @@ static int sha1_compare(const void *_a, const void *_b)
  * will be sorted by SHA1 on exit.
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
-			   int nr_objects, unsigned char *sha1)
+			   int nr_objects, const struct pack_idx_option *opts,
+			   unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
@@ -55,7 +60,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	f = sha1fd(fd, index_name);
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (last_obj_offset >> 31) ? 2 : pack_idx_default_version;
+	index_version = (last_obj_offset >> 31) ? 2 : opts->version;
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -115,7 +120,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		list = sorted_by_sha;
 		for (i = 0; i < nr_objects; i++) {
 			struct pack_idx_entry *obj = *list++;
-			uint32_t offset = (obj->offset <= pack_idx_off32_limit) ?
+			uint32_t offset = (obj->offset <= opts->off32_limit) ?
 				obj->offset : (0x80000000 | nr_large_offset++);
 			offset = htonl(offset);
 			sha1write(f, &offset, 4);
@@ -126,7 +131,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		while (nr_large_offset) {
 			struct pack_idx_entry *obj = *list++;
 			uint64_t offset = obj->offset;
-			if (offset > pack_idx_off32_limit) {
+			if (offset > opts->off32_limit) {
 				uint32_t split[2];
 				split[0] = htonl(offset >> 32);
 				split[1] = htonl(offset & 0xffffffff);
diff --git a/pack.h b/pack.h
index bb27576..953f57e 100644
--- a/pack.h
+++ b/pack.h
@@ -34,9 +34,12 @@ struct pack_header {
  */
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
-/* These may be overridden by command-line parameters */
-extern uint32_t pack_idx_default_version;
-extern uint32_t pack_idx_off32_limit;
+struct pack_idx_option {
+	uint32_t version;
+	uint32_t off32_limit;
+};
+
+extern void reset_pack_idx_option(struct pack_idx_option *);
 
 /*
  * Packed object index header
@@ -55,7 +58,7 @@ struct pack_idx_entry {
 	off_t offset;
 };
 
-extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
+extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *);
-- 
1.7.4.1.249.g4aa72
