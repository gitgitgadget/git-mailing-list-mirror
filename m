Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF45C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8C2207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Bp6Vacg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAMMsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728921AbgAMMsI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 05BDA60800
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919686;
        bh=yNXCyUOS/gm9ckTlRze/qC+hL8ZAMuVkWTdnc5fe3T4=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=Bp6Vacg/gvb3BMQ7hgWkPg6PL47r7hPqCBBgE2Aye4yYqLIhBgfvGRp+CkDGEf/ve
         NuaV+mELxXDOE5KIHLN3zxGFrIZumXpzyBP5caupoY9XcMIInX2pYoTVeQHZqmpPAa
         W088ypawl/xvpoLehjzXAGWEkPJBnOSVjXI9J0kZOkTy2G7ZR+WjsXwi1FsM17y20s
         Fp8I4dKhiDLT/Z4TBx9XU9bCHKLt+z8uZ4qisaMztplN5OMq2fPhPnlLUMWEu5FGbm
         Wy1quZrz7PKILZ5ar1rFJE+Hyfhtii9BWA0mESRQmh5nJ4qWOYUR9597qRzHxxCN8k
         wPKNS17Ti2pR/jlgY2OfRZzP0bGOeTKxP97WgpwZBaWQ7nb32t7vJkZPTmgc0lQwBm
         hdERLnP/qQNhp6Els7AzQhBelvOivef96GHHtbpcM2aPobxy/UsM1YZZAq7Dfk2AYD
         w7RU7G5x1CLvoFnAR/6JNvVEQxXmmJi99RocI9dn03Z855KCbpc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 22/22] fast-import: add options for rewriting submodules
Date:   Mon, 13 Jan 2020 12:47:29 +0000
Message-Id: <20200113124729.3684846-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting a repository using submodules from one hash algorithm to
another, it is necessary to rewrite the submodules from the old
algorithm to the new algorithm, since only references to submodules, not
their contents, are written to the fast-export stream. Without rewriting
the submodules, fast-import fails with an "Invalid dataref" error when
encountering a submodule in another algorithm.

Add a pair of options, --rewrite-submodules-from and
--rewrite-submodules-to, that take a list of marks produced by
fast-export and fast-import, respectively, when processing the
submodule. Use these marks to map the submodule commits from the old
algorithm to the new algorithm.

We read marks into two corresponding struct mark_set objects and then
perform a mapping from the old to the new using a hash table. This lets
us reuse the same mark parsing code that is used elsewhere and allows us
to efficiently read and match marks based on their ID, since mark files
need not be sorted.

Note that because we're using a khash table for the object IDs, and this
table copies values of struct object_id instead of taking references to
them, it's necessary to zero the struct object_id values that we use to
insert and look up in the table. Otherwise, we would end up with SHA-1
values that don't match because of whatever stack garbage might be left
in the unused area.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-fast-import.txt |  20 ++++++
 fast-import.c                     | 112 ++++++++++++++++++++++++++++--
 t/t9300-fast-import.sh            | 109 +++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 7889f95940..77c6b3d001 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -122,6 +122,26 @@ Locations of Marks Files
 Relative and non-relative marks may be combined by interweaving
 --(no-)-relative-marks with the --(import|export)-marks= options.
 
+Submodule Rewriting
+~~~~~~~~~~~~~~~~~~~
+
+--rewrite-submodules-from=<name>:<file>::
+--rewrite-submodules-to=<name>:<file>::
+  Rewrite the object IDs for the submodule specified by <name> from the values
+	used in the from <file> to those used in the to <file>. The from marks should
+	have been created by `git fast-export`, and the to marks should have been
+	created by `git fast-import` when importing that same submodule.
++
+<name> may be any arbitrary string not containing a colon character, but the
+same value must be used with both options when specifying corresponding marks.
+Multiple submodules may be specified with different values for <name>. It is an
+error not to use these options in corresponding pairs.
++
+These options are primarily useful when converting a repository from one hash
+algorithm to another; without them, fast-import will fail if it encounters a
+submodule because it has no way of writing the object ID into the new hash
+algorithm.
+
 Performance and Compression Tuning
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/fast-import.c b/fast-import.c
index 6711f71ba7..202dda11a6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -18,6 +18,7 @@
 #include "object-store.h"
 #include "mem-pool.h"
 #include "commit-reach.h"
+#include "khash.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -53,6 +54,7 @@ struct object_entry_pool {
 
 struct mark_set {
 	union {
+		struct object_id *oids[1024];
 		struct object_entry *marked[1024];
 		struct mark_set *sets[1024];
 	} data;
@@ -225,6 +227,11 @@ static int allow_unsafe_features;
 /* Signal handling */
 static volatile sig_atomic_t checkpoint_requested;
 
+/* Submodule marks */
+static struct string_list sub_marks_from = STRING_LIST_INIT_DUP;
+static struct string_list sub_marks_to = STRING_LIST_INIT_DUP;
+static kh_oid_map_t *sub_oid_map;
+
 /* Where to write output of cat-blob commands */
 static int cat_blob_fd = STDOUT_FILENO;
 
@@ -1731,6 +1738,11 @@ static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintm
 	insert_mark(s, mark, e);
 }
 
+static void insert_oid_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
+{
+	insert_mark(s, mark, xmemdupz(oid, sizeof(*oid)));
+}
+
 static void read_mark_file(struct mark_set *s, FILE *f, mark_set_inserter_t inserter)
 {
 	char line[512];
@@ -1739,13 +1751,17 @@ static void read_mark_file(struct mark_set *s, FILE *f, mark_set_inserter_t inse
 		char *end;
 		struct object_id oid;
 
+		/* Ensure SHA-1 objects are padded with zeros. */
+		memset(oid.hash, 0, sizeof(oid.hash));
+
 		end = strchr(line, '\n');
 		if (line[0] != ':' || !end)
 			die("corrupt mark line: %s", line);
 		*end = 0;
 		mark = strtoumax(line + 1, &end, 10);
 		if (!mark || end == line + 1
-			|| *end != ' ' || get_oid_hex(end + 1, &oid))
+			|| *end != ' '
+			|| get_oid_hex_any(end + 1, &oid) == GIT_HASH_UNKNOWN)
 			die("corrupt mark line: %s", line);
 		inserter(s, &oid, mark);
 	}
@@ -2146,6 +2162,30 @@ static uintmax_t change_note_fanout(struct tree_entry *root,
 	return do_change_note_fanout(root, root, hex_oid, 0, path, 0, fanout);
 }
 
+static int parse_mapped_oid_hex(const char *hex, struct object_id *oid, const char **end)
+{
+	int algo;
+	khiter_t it;
+
+	/* Make SHA-1 object IDs have all-zero padding. */
+	memset(oid->hash, 0, sizeof(oid->hash));
+
+	algo = parse_oid_hex_any(hex, oid, end);
+	if (algo == GIT_HASH_UNKNOWN)
+		return -1;
+
+	it = kh_get_oid_map(sub_oid_map, *oid);
+	/* No such object? */
+	if (it == kh_end(sub_oid_map)) {
+		/* If we're using the same algorithm, pass it through. */
+		if (hash_algos[algo].format_id == the_hash_algo->format_id)
+			return 0;
+		return -1;
+	}
+	oidcpy(oid, kh_value(sub_oid_map, it));
+	return 0;
+}
+
 /*
  * Given a pointer into a string, parse a mark reference:
  *
@@ -2232,7 +2272,7 @@ static void file_change_m(const char *p, struct branch *b)
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
-		if (parse_oid_hex(p, &oid, &p))
+		if (parse_mapped_oid_hex(p, &oid, &p))
 			die("Invalid dataref: %s", command_buf.buf);
 		oe = find_object(&oid);
 		if (*p++ != ' ')
@@ -2406,7 +2446,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
-		if (parse_oid_hex(p, &oid, &p))
+		if (parse_mapped_oid_hex(p, &oid, &p))
 			die("Invalid dataref: %s", command_buf.buf);
 		oe = find_object(&oid);
 		if (*p++ != ' ')
@@ -2941,7 +2981,7 @@ static void parse_cat_blob(const char *p)
 			die("Unknown mark: %s", command_buf.buf);
 		oidcpy(&oid, &oe->idx.oid);
 	} else {
-		if (parse_oid_hex(p, &oid, &p))
+		if (parse_mapped_oid_hex(p, &oid, &p))
 			die("Invalid dataref: %s", command_buf.buf);
 		if (*p)
 			die("Garbage after SHA1: %s", command_buf.buf);
@@ -3005,6 +3045,42 @@ static struct object_entry *dereference(struct object_entry *oe,
 	return find_object(oid);
 }
 
+static void insert_mapped_mark(uintmax_t mark, void *object, void *cbp)
+{
+	struct object_id *fromoid = object;
+	struct object_id *tooid = find_mark(cbp, mark);
+	int ret;
+	khiter_t it;
+
+	it = kh_put_oid_map(sub_oid_map, *fromoid, &ret);
+	/* We've already seen this object. */
+	if (ret == 0)
+		return;
+	kh_value(sub_oid_map, it) = tooid;
+}
+
+static void build_mark_map_one(struct mark_set *from, struct mark_set *to)
+{
+	for_each_mark(from, 0, insert_mapped_mark, to);
+}
+
+static void build_mark_map(struct string_list *from, struct string_list *to)
+{
+	struct string_list_item *fromp, *top;
+
+	sub_oid_map = kh_init_oid_map();
+
+	for_each_string_list_item(fromp, from) {
+		top = string_list_lookup(to, fromp->string);
+		if (!fromp->util) {
+			die(_("Missing from marks for submodule '%s'"), fromp->string);
+		} else if (!top || !top->util) {
+			die(_("Missing to marks for submodule '%s'"), fromp->string);
+		}
+		build_mark_map_one(fromp->util, top->util);
+	}
+}
+
 static struct object_entry *parse_treeish_dataref(const char **p)
 {
 	struct object_id oid;
@@ -3016,7 +3092,7 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 			die("Unknown mark: %s", command_buf.buf);
 		oidcpy(&oid, &e->idx.oid);
 	} else {	/* <sha1> */
-		if (parse_oid_hex(*p, &oid, p))
+		if (parse_mapped_oid_hex(*p, &oid, p))
 			die("Invalid dataref: %s", command_buf.buf);
 		e = find_object(&oid);
 		if (*(*p)++ != ' ')
@@ -3222,6 +3298,26 @@ static void option_export_pack_edges(const char *edges)
 	pack_edges = xfopen(edges, "a");
 }
 
+static void option_rewrite_submodules(const char *arg, struct string_list *list)
+{
+	struct mark_set *ms;
+	FILE *fp;
+	char *s = xstrdup(arg);
+	char *f = strchr(s, ':');
+	if (!f)
+		die(_("Expected format name:filename for submodule rewrite option"));
+	*f = '\0';
+	f++;
+	ms = xcalloc(1, sizeof(*ms));
+	string_list_insert(list, s)->util = ms;
+
+	fp = fopen(f, "r");
+	if (!fp)
+		die_errno("cannot read '%s'", f);
+	read_mark_file(ms, fp, insert_oid_entry);
+	fclose(fp);
+}
+
 static int parse_one_option(const char *option)
 {
 	if (skip_prefix(option, "max-pack-size=", &option)) {
@@ -3284,6 +3380,11 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_export_marks(arg);
 	} else if (!strcmp(feature, "alias")) {
 		; /* Don't die - this feature is supported */
+	} else if (skip_prefix(feature, "rewrite-submodules-to=", &arg)) {
+		option_rewrite_submodules(arg, &sub_marks_to);
+	} else if (skip_prefix(feature, "rewrite-submodules-from=", &arg)) {
+		option_rewrite_submodules(arg, &sub_marks_from);
+	} else if (skip_prefix(feature, "rewrite-submodules-from=", &arg)) {
 	} else if (!strcmp(feature, "get-mark")) {
 		; /* Don't die - this feature is supported */
 	} else if (!strcmp(feature, "cat-blob")) {
@@ -3389,6 +3490,7 @@ static void parse_argv(void)
 	seen_data_command = 1;
 	if (import_marks_file)
 		read_marks();
+	build_mark_map(&sub_marks_from, &sub_marks_to);
 }
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ae9950a9c2..22c6c27763 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3382,4 +3382,113 @@ test_expect_success 'X: handling encoding' '
 	git log -1 --format=%B encoding | grep $(printf "\317\200")
 '
 
+###
+### series Y (submodules and hash algorithms)
+###
+
+cat >Y-sub-input <<\Y_INPUT_END
+blob
+mark :1
+data 4
+foo
+
+reset refs/heads/master
+commit refs/heads/master
+mark :2
+author Full Name <user@company.tld> 1000000000 +0100
+committer Full Name <user@company.tld> 1000000000 +0100
+data 24
+Test submodule commit 1
+M 100644 :1 file
+
+blob
+mark :3
+data 8
+foo
+bar
+
+commit refs/heads/master
+mark :4
+author Full Name <user@company.tld> 1000000001 +0100
+committer Full Name <user@company.tld> 1000000001 +0100
+data 24
+Test submodule commit 2
+from :2
+M 100644 :3 file
+Y_INPUT_END
+
+# Note that the submodule object IDs are intentionally not translated.
+cat >Y-main-input <<\Y_INPUT_END
+blob
+mark :1
+data 4
+foo
+
+reset refs/heads/master
+commit refs/heads/master
+mark :2
+author Full Name <user@company.tld> 2000000000 +0100
+committer Full Name <user@company.tld> 2000000000 +0100
+data 14
+Test commit 1
+M 100644 :1 file
+
+blob
+mark :3
+data 73
+[submodule "sub1"]
+	path = sub1
+	url = https://void.example.com/main.git
+
+commit refs/heads/master
+mark :4
+author Full Name <user@company.tld> 2000000001 +0100
+committer Full Name <user@company.tld> 2000000001 +0100
+data 14
+Test commit 2
+from :2
+M 100644 :3 .gitmodules
+M 160000 0712c5be7cf681388e355ef47525aaf23aee1a6d sub1
+
+blob
+mark :5
+data 8
+foo
+bar
+
+commit refs/heads/master
+mark :6
+author Full Name <user@company.tld> 2000000002 +0100
+committer Full Name <user@company.tld> 2000000002 +0100
+data 14
+Test commit 3
+from :4
+M 100644 :5 file
+M 160000 ff729f5e62f72c0c3978207d9a80e5f3a65f14d7 sub1
+Y_INPUT_END
+
+cat >Y-marks <<\Y_INPUT_END
+:2 0712c5be7cf681388e355ef47525aaf23aee1a6d
+:4 ff729f5e62f72c0c3978207d9a80e5f3a65f14d7
+Y_INPUT_END
+
+test_expect_success 'Y: setup' '
+	test_oid_cache <<-EOF
+	Ymaster sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
+	Ymaster sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
+	EOF
+'
+
+test_expect_success 'Y: rewrite submodules' '
+	git init main1 &&
+	(
+		cd main1 &&
+		git init sub2 &&
+		git -C sub2 fast-import --export-marks=../sub2-marks <../Y-sub-input &&
+		git fast-import --rewrite-submodules-from=sub:../Y-marks \
+			--rewrite-submodules-to=sub:sub2-marks <../Y-main-input &&
+		test "$(git rev-parse master)" = "$(test_oid Ymaster)"
+	)
+'
+
 test_done
