Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2ADEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjIHXb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjIHXb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:31:28 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27CAE46
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:31:18 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37494)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeD-00FHSJ-Q9; Fri, 08 Sep 2023 17:12:21 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeB-009u13-H9; Fri, 08 Sep 2023 17:12:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:42 -0500
Message-Id: <20230908231049.2035003-25-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeB-009u13-H9;;;mid=<20230908231049.2035003-25-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+QfoEvKjfNPeVzLMTWQpEc7tGBrVWRgxY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 25/32] pack-compat-map:  Add support for .compat files of a packfile
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These .compat files hold a bidirectional mapping between the names of
stored objects between sha1 and sha256.

Care has been taken so that index-pack --verify can be supported to
validate an existing compat map file is not currupted.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Makefile                  |   2 +
 builtin.h                 |   1 +
 builtin/show-compat-map.c | 139 ++++++++++++++++
 git.c                     |   1 +
 object-file-convert.c     |   7 +
 object-name.c             |  18 ++
 object-store-ll.h         |   6 +
 pack-compat-map.c         | 334 ++++++++++++++++++++++++++++++++++++++
 pack-compat-map.h         |  27 +++
 pack-write.c              | 158 ++++++++++++++++++
 packfile.c                |  12 ++
 11 files changed, 705 insertions(+)
 create mode 100644 builtin/show-compat-map.c
 create mode 100644 pack-compat-map.c
 create mode 100644 pack-compat-map.h

diff --git a/Makefile b/Makefile
index 3c18664def9a..b3f3dbe7bfeb 100644
--- a/Makefile
+++ b/Makefile
@@ -1088,6 +1088,7 @@ LIB_OBJS += pack-check.o
 LIB_OBJS += pack-mtimes.o
 LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
+LIB_OBJS += pack-compat-map.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
@@ -1299,6 +1300,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
+BUILTIN_OBJS += builtin/show-compat-map.o
 BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/sparse-checkout.o
 BUILTIN_OBJS += builtin/stash.o
diff --git a/builtin.h b/builtin.h
index d560baa6618a..25882d281dd2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -223,6 +223,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix);
 int cmd_show(int argc, const char **argv, const char *prefix);
 int cmd_show_branch(int argc, const char **argv, const char *prefix);
 int cmd_show_index(int argc, const char **argv, const char *prefix);
+int cmd_show_compat_map(int argc, const char **argv, const char *prefix);
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
 int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
diff --git a/builtin/show-compat-map.c b/builtin/show-compat-map.c
new file mode 100644
index 000000000000..8cc10bdaab61
--- /dev/null
+++ b/builtin/show-compat-map.c
@@ -0,0 +1,139 @@
+#include "builtin.h"
+#include "gettext.h"
+#include "hash.h"
+#include "hex.h"
+#include "pack.h"
+#include "parse-options.h"
+#include "repository.h"
+
+static const char *const show_compat_map_usage[] = {
+	"git show-compat-map [--verbose] ",
+	NULL
+};
+
+struct pack_compat_map_header {
+	uint8_t sig[4];
+	uint8_t version;
+	uint8_t first_oid_version;
+	uint8_t second_oid_version;
+	uint8_t mbz1;
+	uint32_t nr_objects;
+	uint8_t first_abbrev_len;
+	uint8_t mbz2;
+	uint8_t second_abbrev_len;
+	uint8_t mbz3;
+};
+
+struct map_entry {
+	struct object_id oid;
+	uint32_t index;
+};
+
+static const struct git_hash_algo *from_oid_version(unsigned oid_version)
+{
+	if (oid_version == 1) {
+		return &hash_algos[GIT_HASH_SHA1];
+	} else if (oid_version == 2) {
+		return &hash_algos[GIT_HASH_SHA256];
+	}
+	die("unknown oid version %u\n", oid_version);
+}
+
+static void read_half_map(struct map_entry *map, unsigned nr,
+		     const struct git_hash_algo *algo)
+{
+	unsigned i;
+	for (i = 0; i < nr; i++) {
+		uint32_t index;
+		if (fread(map[i].oid.hash, algo->rawsz, 1, stdin) != 1)
+			die("unable to read hash of %s entry %u/%u",
+			    algo->name, i, nr);
+		if (fread(&index, 4, 1, stdin) != 1)
+			die("unable to read index of %s entry %u/%u",
+			    algo->name, i, nr);
+		map[i].oid.algo = hash_algo_by_ptr(algo);
+		map[i].index = ntohl(index);
+	}
+}
+
+static void print_half_map(const struct map_entry *map,
+			   unsigned nr)
+{
+	unsigned i;
+	for (i = 0; i < nr; i++) {
+		printf("%s %"PRIu32"\n",
+		       oid_to_hex(&map[i].oid),
+		       map[i].index);
+	}
+}
+
+static void print_map(const struct map_entry *map,
+		      const struct map_entry *compat_map,
+		      unsigned nr)
+{
+	unsigned i;
+	for (i = 0; i < nr; i++) {
+		printf("%s ",
+		       oid_to_hex(&map[i].oid));
+		printf("%s\n",
+		       oid_to_hex(&compat_map[map[i].index].oid));
+	}
+}
+
+int cmd_show_compat_map(int argc, const char **argv, const char *prefix)
+{
+	const struct git_hash_algo *algo = NULL, *compat = NULL;
+	unsigned nr;
+	struct pack_compat_map_header hdr;
+	struct map_entry *map, *compat_map;
+	int verbose = 0;
+	const struct option show_comapt_map_options[] = {
+		OPT_BOOL(0, "verbose", &verbose,
+			 N_("print implementation details of the map file")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, show_comapt_map_options,
+			     show_compat_map_usage, 0);
+
+	if (fread(&hdr, sizeof(hdr), 1, stdin) != 1)
+		die("unable to read header");
+	if ((hdr.sig[0] != 'C') ||
+	    (hdr.sig[1] != 'M') ||
+	    (hdr.sig[2] != 'A') ||
+	    (hdr.sig[3] != 'P'))
+		die("Missing map signature");
+	if (hdr.version != 1)
+		die("Unknown map version");
+	if ((hdr.mbz1 != 0) ||
+	    (hdr.mbz2 != 0) ||
+	    (hdr.mbz3 != 0))
+		die("Must be zero fields non-zero");
+
+	nr = ntohl(hdr.nr_objects);
+
+	algo = from_oid_version(hdr.first_oid_version);
+	compat = from_oid_version(hdr.second_oid_version);
+
+
+	if (verbose) {
+		printf("Map v%u for %u objects from %s to %s abbrevs (%u:%u)\n",
+		       hdr.version,
+		       nr,
+		       algo->name, compat->name,
+		       hdr.first_abbrev_len,
+		       hdr.second_abbrev_len);
+	}
+	ALLOC_ARRAY(map, nr);
+	ALLOC_ARRAY(compat_map, nr);
+	read_half_map(map, nr, algo);
+	read_half_map(compat_map, nr, compat);
+	if (verbose) {
+		print_half_map(map, nr);
+		print_half_map(compat_map, nr);
+	}
+	print_map(map, compat_map, nr);
+	free(compat_map);
+	free(map);
+	return 0;
+}
diff --git a/git.c b/git.c
index c67e44dd82d2..bfaeece5ae0e 100644
--- a/git.c
+++ b/git.c
@@ -606,6 +606,7 @@ static struct cmd_struct commands[] = {
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-index", cmd_show_index, RUN_SETUP_GENTLY },
+	{ "show-compat-map", cmd_show_compat_map, RUN_SETUP_GENTLY },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
diff --git a/object-file-convert.c b/object-file-convert.c
index d381d3d2ea65..7978aa63dfa9 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -9,6 +9,7 @@
 #include "loose.h"
 #include "commit.h"
 #include "gpg-interface.h"
+#include "pack-compat-map.h"
 #include "object-file-convert.h"
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
@@ -27,6 +28,12 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 		return 0;
 	}
 	if (repo_loose_object_map_oid(repo, dest, to, src)) {
+		/*
+		 * It's not in the loose object map, so let's see if it's in a
+		 * pack.
+		 */
+		if (!repo_packed_oid_to_algop(repo, src, to, dest))
+			return 0;
 		/*
 		 * We may have loaded the object map at repo initialization but
 		 * another process (perhaps upstream of a pipe from us) may have
diff --git a/object-name.c b/object-name.c
index ebe87f5c4fdd..d33c82bc96ba 100644
--- a/object-name.c
+++ b/object-name.c
@@ -26,6 +26,7 @@
 #include "commit-reach.h"
 #include "date.h"
 #include "object-file-convert.h"
+#include "pack-compat-map.h"
 
 static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
 
@@ -210,6 +211,19 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 		unique_in_pack(p, ds);
 }
 
+static void find_short_packed_compat_object(struct disambiguate_state *ds)
+{
+	struct packed_git *p;
+
+	/* Skip, unless compatibility oids are wanted */
+	if (!ds->algo && (&hash_algos[ds->algo] != ds->repo->compat_hash_algo))
+		return;
+
+	for (p = get_packed_git(ds->repo); p && !ds->ambiguous; p = p->next)
+		pack_compat_map_each(ds->repo, p, ds->bin_pfx.hash, ds->len,
+				     match_prefix, ds);
+}
+
 static int finish_object_disambiguation(struct disambiguate_state *ds,
 					struct object_id *oid)
 {
@@ -581,6 +595,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
+	find_short_packed_compat_object(&ds);
 	status = finish_object_disambiguation(&ds, oid);
 
 	/*
@@ -592,6 +607,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		reprepare_packed_git(r);
 		find_short_object_filename(&ds);
 		find_short_packed_object(&ds);
+		find_short_packed_compat_object(&ds);
 		status = finish_object_disambiguation(&ds, oid);
 	}
 
@@ -659,6 +675,7 @@ int repo_for_each_abbrev(struct repository *r, const char *prefix,
 	ds.cb_data = &collect;
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
+	find_short_packed_compat_object(&ds);
 
 	ret = oid_array_for_each_unique(&collect, fn, cb_data);
 	oid_array_clear(&collect);
@@ -871,6 +888,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	ds.cb_data = (void *)&mad;
 
 	find_short_object_filename(&ds);
+	find_short_packed_compat_object(&ds);
 	(void)finish_object_disambiguation(&ds, &oid_ret);
 
 	hex[mad.cur_len] = 0;
diff --git a/object-store-ll.h b/object-store-ll.h
index c5f2bb2fc2fe..c37c19ada0c3 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -135,6 +135,12 @@ struct packed_git {
 	 */
 	const uint32_t *mtimes_map;
 	size_t mtimes_size;
+
+	const void *compat_mapping;
+	size_t compat_mapping_size;
+	const uint8_t *hash_map;
+	const uint8_t *compat_hash_map;
+
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 };
diff --git a/pack-compat-map.c b/pack-compat-map.c
new file mode 100644
index 000000000000..3a992095ebe3
--- /dev/null
+++ b/pack-compat-map.c
@@ -0,0 +1,334 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "hash-ll.h"
+#include "hash.h"
+#include "object-store.h"
+#include "object-file.h"
+#include "packfile.h"
+#include "pack-compat-map.h"
+#include "packfile.h"
+
+struct pack_compat_map_header {
+	uint8_t sig[4];
+	uint8_t version;
+	uint8_t first_oid_version;
+	uint8_t second_oid_version;
+	uint8_t mbz1;
+	uint32_t nr_objects;
+	uint8_t first_abbrev_len;
+	uint8_t mbz2;
+	uint8_t second_abbrev_len;
+	uint8_t mbz3;
+};
+
+static char *pack_compat_map_filename(struct packed_git *p)
+{
+	size_t len;
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		BUG("pack_name does not end in .pack");
+	return xstrfmt("%.*s.compat", (int)len, p->pack_name);
+}
+
+static int oid_version_match(const char *filename,
+			     unsigned oid_version,
+			     const struct git_hash_algo *algo)
+{
+	const struct git_hash_algo *found = NULL;
+	int ret = 0;
+
+	if (oid_version == 1) {
+		found = &hash_algos[GIT_HASH_SHA1];
+	} else if (oid_version == 2) {
+		found = &hash_algos[GIT_HASH_SHA256];
+	}
+	if (found == NULL) {
+		ret = error(_("compat map file %s hash version %u unknown"),
+			    filename, oid_version);
+	}
+	else if (found != algo) {
+		ret = error(_("compat map file %s found hash %s expected hash %s"),
+			    filename, found->name, algo->name);
+	}
+	return ret;
+}
+
+
+static int load_pack_compat_map_file(char *compat_map_file,
+				     struct repository *repo,
+				     struct packed_git *p)
+{
+	const struct pack_compat_map_header *hdr;
+	unsigned compat_map_objects = 0;
+	const uint8_t *data = NULL;
+	const uint8_t *packs_hash = NULL;
+	int fd, ret = 0;
+	struct stat st;
+	size_t size, map1sz, map2sz, expected_size;
+
+	fd = git_open(compat_map_file);
+
+	if (fd < 0) {
+		ret = -1;
+		goto cleanup;
+	}
+	if (fstat(fd, &st)) {
+		ret = error_errno(_("failed to read %s"), compat_map_file);
+		goto cleanup;
+	}
+
+	size = xsize_t(st.st_size);
+
+	if (size < sizeof(struct pack_compat_map_header)) {
+		ret = error(_("compat map file %s is too small"), compat_map_file);
+		goto cleanup;
+	}
+
+	data = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	hdr = (const struct pack_compat_map_header *)data;
+	if ((hdr->sig[0] != 'C') ||
+	    (hdr->sig[1] != 'M') ||
+	    (hdr->sig[2] != 'A') ||
+	    (hdr->sig[3] != 'P')) {
+		ret = error(_("compat map file %s has unknown signature"),
+			    compat_map_file);
+		goto cleanup;
+	}
+
+	if (hdr->version != 1) {
+		ret = error(_("compat map file %s has unsupported version %"PRIu8),
+			    compat_map_file, hdr->version);
+		goto cleanup;
+	}
+
+	ret = oid_version_match(compat_map_file, hdr->first_oid_version, repo->hash_algo);
+	if (ret)
+		goto cleanup;
+	ret = oid_version_match(compat_map_file, hdr->second_oid_version, repo->compat_hash_algo);
+	if (ret)
+		goto cleanup;
+	compat_map_objects = ntohl(hdr->nr_objects);
+	if (compat_map_objects != p->num_objects) {
+		ret = error(_("compat map file %s number of objects found %u wanted %u"),
+			    compat_map_file, compat_map_objects, p->num_objects);
+		goto cleanup;
+	}
+
+	map1sz = st_mult(repo->hash_algo->rawsz + 4, compat_map_objects);
+	map2sz = st_mult(repo->compat_hash_algo->rawsz + 4, compat_map_objects);
+
+	expected_size = sizeof(struct pack_compat_map_header);
+	expected_size = st_add(expected_size, map1sz);
+	expected_size = st_add(expected_size, map2sz);
+	expected_size = st_add(expected_size, 2 * repo->hash_algo->rawsz);
+
+	if (size != expected_size) {
+		ret = error(_("compat map file %s is corrupt size %zu expected %zu objects %u sz1 %zu sz2 %zu"),
+			    compat_map_file, size, expected_size, compat_map_objects,
+			    map1sz, map2sz
+			);
+		goto cleanup;
+	}
+
+	packs_hash = data + sizeof(struct pack_compat_map_header) + map1sz + map2sz;
+	if (hashcmp(packs_hash, p->hash)) {
+		ret = error(_("compat map file %s does not match pack %s\n"),
+			      compat_map_file, hash_to_hex(p->hash));
+	}
+
+
+	p->compat_mapping = data;
+	p->compat_mapping_size = size;
+
+	p->hash_map = data + sizeof(struct pack_compat_map_header);
+	p->compat_hash_map = p->hash_map + map1sz;
+
+cleanup:
+	if (ret) {
+		if (data) {
+			munmap((void *)data, size);
+		}
+	}
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
+
+int load_pack_compat_map(struct repository *repo, struct packed_git *p)
+{
+	char *compat_map_name = NULL;
+	int ret = 0;
+
+	if (p->compat_mapping)
+		return ret;	/* already loaded */
+
+	if (!repo->compat_hash_algo)
+		return 1;		/* Nothing to do */
+
+	ret = open_pack_index(p);
+	if (ret < 0)
+		goto cleanup;
+
+	compat_map_name = pack_compat_map_filename(p);
+	ret = load_pack_compat_map_file(compat_map_name, repo, p);
+cleanup:
+	free(compat_map_name);
+	return ret;
+}
+
+static int keycmp(const unsigned char *a, const unsigned char *b,
+		  size_t key_hex_size)
+{
+	size_t key_byte_size = key_hex_size / 2;
+	unsigned a_last, b_last, mask = (key_hex_size & 1) ? 0xf0 : 0;
+	int cmp = memcmp(a, b, key_byte_size);
+	if (cmp)
+		return cmp;
+
+	a_last = a[key_byte_size] & mask;
+	b_last = b[key_byte_size] & mask;
+
+	if (a_last == b_last)
+		cmp = 0;
+	else if (a_last < b_last)
+		cmp = -1;
+	else
+		cmp = 1;
+
+	return cmp;
+}
+
+static const uint8_t *bsearch_map(const unsigned char *hash,
+				  const uint8_t *table, unsigned nr,
+				  size_t entry_size, size_t key_hex_size)
+{
+	uint32_t hi, lo;
+
+	hi = nr - 1;
+	lo = 0;
+	while (lo < hi) {
+		unsigned mi = lo + ((hi - lo) / 2);
+		const unsigned char *entry = table + (mi * entry_size);
+		int cmp = keycmp(entry, hash, key_hex_size);
+		if (!cmp)
+			return entry;
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	if (lo == hi) {
+		const unsigned char *entry = table + (lo * entry_size);
+		int cmp = keycmp(entry, hash, key_hex_size);
+		if (!cmp)
+			return entry;
+	}
+	return NULL;
+}
+
+static void map_each(const struct git_hash_algo *compat,
+		     const unsigned char *prefix, size_t prefix_hexsz,
+		     const uint8_t *table, unsigned nr, size_t entry_bytes,
+		     compat_map_iter_t iter, void *data)
+{
+	const uint8_t *found, *last = table + (entry_bytes * nr);
+
+	found = bsearch_map(prefix, table, nr, entry_bytes, prefix_hexsz);
+	if (!found)
+		return;
+
+	/* Visit each matching key */
+	do {
+		struct object_id oid;
+
+		if (keycmp(found, prefix, prefix_hexsz) != 0)
+			break;
+
+		oidread_algop(&oid, found, compat);
+		if (iter(&oid, data) == CB_BREAK)
+			break;
+
+		found = found + entry_bytes;
+	} while (found < last);
+}
+
+void pack_compat_map_each(struct repository *repo, struct packed_git *p,
+			 const unsigned char *prefix, size_t prefix_hexsz,
+			 compat_map_iter_t iter, void *data)
+{
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+
+	if (!p->num_objects ||
+	    (!p->compat_mapping && load_pack_compat_map(repo, p)))
+		return;
+
+	if (prefix_hexsz > compat->hexsz)
+		prefix_hexsz = compat->hexsz;
+
+	map_each(compat, prefix, prefix_hexsz,
+		 p->compat_hash_map, p->num_objects, compat->rawsz + 4,
+		 iter, data);
+}
+
+static int compat_map_to_algop(const struct object_id *src,
+			       const struct git_hash_algo *to,
+			       const struct git_hash_algo *from,
+			       const uint8_t *to_table,
+			       const uint8_t *from_table,
+			       unsigned nr,
+			       struct object_id *dest)
+{
+	const uint8_t *found;
+	uint32_t index;
+
+	if (src->algo != hash_algo_by_ptr(from))
+		return -1;
+
+	found = bsearch_map(src->hash,
+			    from_table, nr,
+			    from->rawsz + 4,
+			    from->hexsz);
+	if (!found)
+		return -1;
+
+	index = ntohl(*(uint32_t *)(found + from->rawsz));
+	oidread_algop(dest, to_table + index * (to->rawsz + 4), to);
+	return 0;
+}
+
+static int pack_to_algop(struct repository *repo, struct packed_git *p,
+			 const struct object_id *src,
+			 const struct git_hash_algo *to, struct object_id *dest)
+{
+	if (!p->compat_mapping && load_pack_compat_map(repo, p))
+		return -1;
+
+	if (to == repo->hash_algo) {
+		return compat_map_to_algop(src, to, repo->compat_hash_algo,
+					   p->hash_map,
+					   p->compat_hash_map,
+					   p->num_objects, dest);
+	}
+	else if (to == repo->compat_hash_algo) {
+		return compat_map_to_algop(src, to, repo->hash_algo,
+					   p->compat_hash_map,
+					   p->hash_map,
+					   p->num_objects, dest);
+	}
+	else
+		return -1;
+}
+
+int repo_packed_oid_to_algop(struct repository *repo,
+			     const struct object_id *src,
+			     const struct git_hash_algo *to,
+			     struct object_id *dest)
+{
+	struct packed_git *p;
+	for (p = get_packed_git(repo); p; p = p->next) {
+		if (!pack_to_algop(repo, p, src, to, dest))
+			return 0;
+	}
+	return -1;
+}
diff --git a/pack-compat-map.h b/pack-compat-map.h
new file mode 100644
index 000000000000..2a4561ffdff6
--- /dev/null
+++ b/pack-compat-map.h
@@ -0,0 +1,27 @@
+#ifndef PACK_COMPAT_MAP_H
+#define PACK_COMPAT_MAP_H
+
+#include "cbtree.h"
+struct repository;
+struct packed_git;
+struct object_id;
+struct git_hash_algo;
+struct pack_idx_entry;
+
+int load_pack_compat_map(struct repository *repo, struct packed_git *p);
+
+typedef enum cb_next (*compat_map_iter_t)(const struct object_id *, void *data);
+void pack_compat_map_each(struct repository *repo, struct packed_git *p,
+			 const unsigned char *prefix, size_t prefix_hexsz,
+			 compat_map_iter_t, void *data);
+
+int repo_packed_oid_to_algop(struct repository *repo,
+			     const struct object_id *src,
+			     const struct git_hash_algo *to,
+			     struct object_id *dest);
+
+const char *write_compat_map_file(const char *compat_map_name,
+				  struct pack_idx_entry **objects,
+				  int nr_objects, const unsigned char *hash);
+
+#endif /* PACK_COMPAT_MAP_H */
diff --git a/pack-write.c b/pack-write.c
index b19ddf15b284..f22eea964f77 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -12,6 +12,7 @@
 #include "pack-revindex.h"
 #include "path.h"
 #include "strbuf.h"
+#include "object-file-convert.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -345,6 +346,157 @@ static char *write_mtimes_file(struct packing_data *to_pack,
 	return mtimes_name;
 }
 
+struct map_entry {
+	const struct pack_idx_entry *idx;
+	uint32_t oid_index;
+	uint32_t compat_oid_index;
+};
+
+static int map_oid_cmp(const void *_a, const void *_b)
+{
+	struct map_entry *a = *(struct map_entry **)_a;
+	struct map_entry *b = *(struct map_entry **)_b;
+	return oidcmp(&a->idx->oid, &b->idx->oid);
+}
+
+static int map_compat_oid_cmp(const void *_a, const void *_b)
+{
+	struct map_entry *a = *(struct map_entry **)_a;
+	struct map_entry *b = *(struct map_entry **)_b;
+	return oidcmp(&a->idx->compat_oid, &b->idx->compat_oid);
+}
+
+struct pack_compat_map_header {
+	uint8_t sig[4];
+	uint8_t version;
+	uint8_t first_oid_version;
+	uint8_t second_oid_version;
+	uint8_t mbz1;
+	uint32_t nr_objects;
+	uint8_t first_abbrev_len;
+	uint8_t mbz2;
+	uint8_t second_abbrev_len;
+	uint8_t mbz3;
+};
+
+static inline unsigned last_matching_offset(const struct object_id *a,
+					    const struct object_id *b,
+					    const struct git_hash_algo *algop)
+{
+	unsigned i;
+	for (i = 0; i < algop->rawsz; i++)
+		if (a->hash[i] != b->hash[i])
+			return i;
+	/* We should never hit this case. */
+	return i;
+}
+
+/*
+ * The *hash contains the pack content hash.
+ * The objects array is passed in sorted.
+ */
+const char *write_compat_map_file(const char *compat_map_name,
+				  struct pack_idx_entry **objects,
+				  int nr_objects, const unsigned char *hash)
+{
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	unsigned short_name_len, compat_short_name_len;
+	struct hashfile *f;
+	struct map_entry *map_entries, **map;
+	struct pack_compat_map_header hdr;
+	unsigned i;
+	int fd;
+
+	if (!compat || !nr_objects)
+		return NULL;
+
+	ALLOC_ARRAY(map_entries, nr_objects);
+	ALLOC_ARRAY(map, nr_objects);
+	short_name_len = 1;
+	for (i = 0; i < nr_objects; ++i) {
+		unsigned offset;
+
+		map[i] = &map_entries[i];
+		map_entries[i].idx = objects[i];
+		if (!objects[i]->compat_oid.algo)
+			BUG("No mapping from %s to %s\n",
+			    oid_to_hex(&objects[i]->oid),
+			    compat->name);
+
+		map_entries[i].oid_index = i;
+		map_entries[i].compat_oid_index = 0;
+		if (i == 0)
+			continue;
+
+		offset = last_matching_offset(&map_entries[i].idx->oid,
+					      &map_entries[i - 1].idx->oid,
+					      algo);
+		if (offset > short_name_len)
+			short_name_len = offset;
+	}
+	QSORT(map, nr_objects, map_compat_oid_cmp);
+	compat_short_name_len = 1;
+	for (i = 0; i < nr_objects; ++i) {
+		unsigned offset;
+
+		map[i]->compat_oid_index = i;
+
+		if (i == 0)
+			continue;
+
+		offset = last_matching_offset(&map[i]->idx->compat_oid,
+					      &map[i - 1]->idx->compat_oid,
+					      compat);
+		if (offset > compat_short_name_len)
+			compat_short_name_len = offset;
+	}
+
+	if (compat_map_name) {
+		/* Verify an existing compat map file */
+		f = hashfd_check(compat_map_name);
+	} else {
+		struct strbuf tmp_file = STRBUF_INIT;
+		fd = odb_mkstemp(&tmp_file, "pack/tmp_compat_map_XXXXXX");
+		compat_map_name = strbuf_detach(&tmp_file, NULL);
+		f = hashfd(fd, compat_map_name);
+	}
+
+	hdr.sig[0] = 'C';
+	hdr.sig[1] = 'M';
+	hdr.sig[2] = 'A';
+	hdr.sig[3] = 'P';
+	hdr.version = 1;
+	hdr.first_oid_version = oid_version(algo);
+	hdr.second_oid_version = oid_version(compat);
+	hdr.mbz1 = 0;
+	hdr.nr_objects = htonl(nr_objects);
+	hdr.first_abbrev_len = short_name_len;
+	hdr.mbz2 = 0;
+	hdr.second_abbrev_len = compat_short_name_len;
+	hdr.mbz3 = 0;
+	hashwrite(f, &hdr, sizeof(hdr));
+
+	QSORT(map, nr_objects, map_oid_cmp);
+	for (i = 0; i < nr_objects; i++) {
+		hashwrite(f, map[i]->idx->oid.hash, algo->rawsz);
+		hashwrite_be32(f, map[i]->compat_oid_index);
+	}
+	QSORT(map, nr_objects, map_compat_oid_cmp);
+	for (i = 0; i < nr_objects; i++) {
+		hashwrite(f, map[i]->idx->compat_oid.hash, compat->rawsz);
+		hashwrite_be32(f, map[i]->oid_index);
+	}
+
+	hashwrite(f, hash, algo->rawsz);
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE | CSUM_FSYNC);
+	free(map);
+	free(map_entries);
+	return compat_map_name;
+}
+
 off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
 {
 	struct pack_header hdr;
@@ -548,6 +700,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 {
 	const char *rev_tmp_name = NULL;
 	char *mtimes_tmp_name = NULL;
+	const char *compat_map_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -566,11 +719,16 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 						    hash);
 	}
 
+	compat_map_tmp_name = write_compat_map_file(NULL, written_list,
+						    nr_written, hash);
+
 	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
 	if (rev_tmp_name)
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
 	if (mtimes_tmp_name)
 		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
+	if (compat_map_tmp_name)
+		rename_tmp_packfile(name_buffer, compat_map_tmp_name, "compat");
 
 	free((char *)rev_tmp_name);
 	free(mtimes_tmp_name);
diff --git a/packfile.c b/packfile.c
index 1fae0fcdd9e7..c1a6bd9bc6b3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -349,6 +349,17 @@ static void close_pack_mtimes(struct packed_git *p)
 	p->mtimes_map = NULL;
 }
 
+static void close_pack_compat_map(struct packed_git *p)
+{
+	if (!p->compat_mapping)
+		return;
+
+	munmap((void *)p->compat_mapping, p->compat_mapping_size);
+	p->compat_mapping = NULL;
+	p->hash_map = NULL;
+	p->compat_hash_map = NULL;
+}
+
 void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
@@ -356,6 +367,7 @@ void close_pack(struct packed_git *p)
 	close_pack_index(p);
 	close_pack_revindex(p);
 	close_pack_mtimes(p);
+	close_pack_compat_map(p);
 	oidset_clear(&p->bad_objects);
 }
 
-- 
2.41.0

