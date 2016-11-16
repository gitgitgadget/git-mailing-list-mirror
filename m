Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83ED42021E
	for <e@80x24.org>; Wed, 16 Nov 2016 05:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbcKPFVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 00:21:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55113 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750806AbcKPFVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 00:21:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF7CA50A9E;
        Wed, 16 Nov 2016 00:21:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8NoK7XZ+aNG5re1rsIxte0ogCxw=; b=bX4C+G
        P0DFSM/J1oWXAienXVm1zrVJbjL8GpBU//RmnQhmqAlTKR7KEPydqS+xjC94Ryfj
        3JNKWgcAlutQKdHVm5pQYwZy4ep/hQLq8e9vteU0GC5NF4tWbdcIJeOxpZqUG/NV
        j1M9OuWiGSN78RQLvPbqZn1c/Yi7uDDHeWi90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hF0zDBFxB2ySWO+0yYIfmjXYxfbx4vh8
        vsgxqCiRxsWV5LB0qA0TT0XdkMURPujnGFMqmiWHWlZ2lY5wsR2AXO0Vt0x4OSZd
        xuMXx0H3gtr0vgTON9NKvpiQHsfXIoYnMOJ2lrSAkErV+43dPsxS2FA1uNogoLNH
        2GqvJC4oGR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6F3050A9D;
        Wed, 16 Nov 2016 00:21:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35CAF50A9C;
        Wed, 16 Nov 2016 00:21:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] compression: unify pack.compression configuration parsing
References: <xmqqfumsrvge.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 15 Nov 2016 21:21:28 -0800
In-Reply-To: <xmqqfumsrvge.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 15 Nov 2016 18:48:33 -0800")
Message-ID: <xmqq7f84rodj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 873B6FBE-ABBC-11E6-B285-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are three codepaths that use a variable whose name is
pack_compression_level to affect how objects and deltas sent to a
packfile is compressed.  Unlike zlib_compression_level that controls
the loose object compression, however, this variable was static to
each of these codepaths.  Two of them read the pack.compression
configuration variable, using core.compression as the default, and
one of them also allowed overriding it from the command line.

The other codepath in bulk-checkin did not pay any attention to the
configuration.

Unify the configuration parsing to git_default_config(), where we
implement the parsing of core.loosecompression and core.compression
and make the former override the latter, by moving code to parse
pack.compression and also allow core.compression to give default to
this variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Now comes with new tests to cover pack-objects and fast-import,
   which should not fail with or without code change because they
   are only here to prevent regression with this change.

   On the code side, *_compression_seen variables are also made
   private to config.c, as these variables are used only by the
   config reader to implement "core.compression gives the default to
   *.compression" logic and the code is consolidated to this single
   file.

 builtin/pack-objects.c              | 14 --------
 bulk-checkin.c                      |  2 --
 cache.h                             |  2 +-
 config.c                            | 16 +++++++++
 environment.c                       |  2 +-
 fast-import.c                       | 13 -------
 t/t1050-large.sh                    | 29 ++++++++++++++++
 t/t5315-pack-objects-compression.sh | 44 ++++++++++++++++++++++++
 t/t9303-fast-import-compression.sh  | 67 +++++++++++++++++++++++++++++++++++++
 9 files changed, 158 insertions(+), 31 deletions(-)
 create mode 100755 t/t5315-pack-objects-compression.sh
 create mode 100755 t/t9303-fast-import-compression.sh

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fd52bd6b4..8841f8b366 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -61,8 +61,6 @@ static int delta_search_threads;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress *progress_state;
-static int pack_compression_level = Z_DEFAULT_COMPRESSION;
-static int pack_compression_seen;
 
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
@@ -2368,16 +2366,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		depth = git_config_int(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "pack.compression")) {
-		int level = git_config_int(k, v);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad pack compression level %d", level);
-		pack_compression_level = level;
-		pack_compression_seen = 1;
-		return 0;
-	}
 	if (!strcmp(k, "pack.deltacachesize")) {
 		max_delta_cache_size = git_config_int(k, v);
 		return 0;
@@ -2869,8 +2857,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
-	if (!pack_compression_seen && core_compression_seen)
-		pack_compression_level = core_compression_level;
 
 	progress = isatty(2);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 4347f5c76a..991b4a13e2 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -7,8 +7,6 @@
 #include "pack.h"
 #include "strbuf.h"
 
-static int pack_compression_level = Z_DEFAULT_COMPRESSION;
-
 static struct bulk_checkin_state {
 	unsigned plugged:1;
 
diff --git a/cache.h b/cache.h
index a50a61a197..b14c0e8e38 100644
--- a/cache.h
+++ b/cache.h
@@ -670,7 +670,7 @@ extern const char *git_attributes_file;
 extern const char *git_hooks_path;
 extern int zlib_compression_level;
 extern int core_compression_level;
-extern int core_compression_seen;
+extern int pack_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
diff --git a/config.c b/config.c
index 83fdecb1bc..2f1aef742e 100644
--- a/config.c
+++ b/config.c
@@ -66,6 +66,8 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;
 
+static int core_compression_seen;
+static int pack_compression_seen;
 static int zlib_compression_seen;
 
 /*
@@ -865,6 +867,8 @@ static int git_default_core_config(const char *var, const char *value)
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
 			zlib_compression_level = level;
+		if (!pack_compression_seen)
+			pack_compression_level = level;
 		return 0;
 	}
 
@@ -1125,6 +1129,18 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		pack_size_limit_cfg = git_config_ulong(var, value);
 		return 0;
 	}
+
+	if (!strcmp(var, "pack.compression")) {
+		int level = git_config_int(var, value);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die(_("bad pack compression level %d"), level);
+		pack_compression_level = level;
+		pack_compression_seen = 1;
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 0935ec696e..4bce3eebfa 100644
--- a/environment.c
+++ b/environment.c
@@ -34,7 +34,7 @@ const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
-int core_compression_seen;
+int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
diff --git a/fast-import.c b/fast-import.c
index cb545d7df5..f561ba833b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -284,8 +284,6 @@ static unsigned long max_depth = 10;
 static off_t max_packsize;
 static int unpack_limit = 100;
 static int force_update;
-static int pack_compression_level = Z_DEFAULT_COMPRESSION;
-static int pack_compression_seen;
 
 /* Stats and misc. counters */
 static uintmax_t alloc_count;
@@ -3381,15 +3379,6 @@ static void git_pack_config(void)
 		if (max_depth > MAX_DEPTH)
 			max_depth = MAX_DEPTH;
 	}
-	if (!git_config_get_int("pack.compression", &pack_compression_level)) {
-		if (pack_compression_level == -1)
-			pack_compression_level = Z_DEFAULT_COMPRESSION;
-		else if (pack_compression_level < 0 ||
-			 pack_compression_level > Z_BEST_COMPRESSION)
-			git_die_config("pack.compression",
-					"bad pack compression level %d", pack_compression_level);
-		pack_compression_seen = 1;
-	}
 	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
 		pack_idx_opts.version = indexversion_value;
 		if (pack_idx_opts.version > 2)
@@ -3454,8 +3443,6 @@ int cmd_main(int argc, const char **argv)
 	setup_git_directory();
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
-	if (!pack_compression_seen && core_compression_seen)
-		pack_compression_level = core_compression_level;
 
 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 096dbffecc..6fd264cff0 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -5,6 +5,12 @@ test_description='adding and checking out large blobs'
 
 . ./test-lib.sh
 
+# This should be moved to test-lib.sh together with the
+# copy in t0021 after both topics have graduated to 'master'.
+file_size () {
+	perl -e 'print -s $ARGV[0]' "$1"
+}
+
 test_expect_success setup '
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
@@ -17,6 +23,29 @@ test_expect_success setup '
 	export GIT_ALLOC_LIMIT
 '
 
+# add a large file with different settings
+while read expect config
+do
+	test_expect_success "add with $config" '
+		test_when_finished "rm -f .git/objects/pack/pack-*.* .git/index" &&
+		git $config add large1 &&
+		sz=$(file_size .git/objects/pack/pack-*.pack) &&
+		case "$expect" in
+		small) test "$sz" -le 100000 ;;
+		large) test "$sz" -ge 100000 ;;
+		esac
+	'
+done <<\EOF
+large -c core.compression=0
+small -c core.compression=9
+large -c core.compression=0 -c pack.compression=0
+large -c core.compression=9 -c pack.compression=0
+small -c core.compression=0 -c pack.compression=9
+small -c core.compression=9 -c pack.compression=9
+large -c pack.compression=0
+small -c pack.compression=9
+EOF
+
 test_expect_success 'add a large file or two' '
 	git add large1 huge large2 &&
 	# make sure we got a single packfile and no loose objects
diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
new file mode 100755
index 0000000000..34c47dae09
--- /dev/null
+++ b/t/t5315-pack-objects-compression.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='pack-object compression configuration'
+
+. ./test-lib.sh
+
+# This should be moved to test-lib.sh together with the
+# copy in t0021 after both topics have graduated to 'master'.
+file_size () {
+	perl -e 'print -s $ARGV[0]' "$1"
+}
+
+test_expect_success setup '
+	printf "%2000000s" X |
+	git hash-object -w --stdin >object-name &&
+	# make sure it resulted in a loose object
+	ob=$(sed -e "s/\(..\).*/\1/" object-name) &&
+	ject=$(sed -e "s/..\(.*\)/\1/" object-name) &&
+	test -f .git/objects/$ob/$ject
+'
+
+while read expect config
+do
+	test_expect_success "pack-objects with $config" '
+		test_when_finished "rm -f pack-*.*" &&
+		git $config pack-objects pack <object-name &&
+		sz=$(file_size pack-*.pack) &&
+		case "$expect" in
+		small) test "$sz" -le 100000 ;;
+		large) test "$sz" -ge 100000 ;;
+		esac
+	'
+done <<\EOF
+large -c core.compression=0
+small -c core.compression=9
+large -c core.compression=0 -c pack.compression=0
+large -c core.compression=9 -c pack.compression=0
+small -c core.compression=0 -c pack.compression=9
+small -c core.compression=9 -c pack.compression=9
+large -c pack.compression=0
+small -c pack.compression=9
+EOF
+
+test_done
diff --git a/t/t9303-fast-import-compression.sh b/t/t9303-fast-import-compression.sh
new file mode 100755
index 0000000000..856219f46a
--- /dev/null
+++ b/t/t9303-fast-import-compression.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='compression setting of fast-import utility'
+. ./test-lib.sh
+
+# This should be moved to test-lib.sh together with the
+# copy in t0021 after both topics have graduated to 'master'.
+file_size () {
+	perl -e 'print -s $ARGV[0]' "$1"
+}
+
+import_large () {
+	(
+		echo blob
+		echo "data <<EOD"
+		printf "%2000000s\n" "$*"
+		echo EOD
+	) | git "$@" fast-import
+}
+
+while read expect config
+do
+	test_expect_success "fast-import (packed) with $config" '
+		test_when_finished "rm -f .git/objects/pack/pack-*.*" &&
+		test_when_finished "rm -rf .git/objects/??" &&
+		import_large -c fastimport.unpacklimit=0 $config &&
+		sz=$(file_size .git/objects/pack/pack-*.pack) &&
+		case "$expect" in
+		small) test "$sz" -le 100000 ;;
+		large) test "$sz" -ge 100000 ;;
+		esac
+	'
+done <<\EOF
+large -c core.compression=0
+small -c core.compression=9
+large -c core.compression=0 -c pack.compression=0
+large -c core.compression=9 -c pack.compression=0
+small -c core.compression=0 -c pack.compression=9
+small -c core.compression=9 -c pack.compression=9
+large -c pack.compression=0
+small -c pack.compression=9
+EOF
+
+while read expect config
+do
+	test_expect_success "fast-import (loose) with $config" '
+		test_when_finished "rm -f .git/objects/pack/pack-*.*" &&
+		test_when_finished "rm -rf .git/objects/??" &&
+		import_large -c fastimport.unpacklimit=9 $config &&
+		sz=$(file_size .git/objects/??/????*) &&
+		case "$expect" in
+		small) test "$sz" -le 100000 ;;
+		large) test "$sz" -ge 100000 ;;
+		esac
+	'
+done <<\EOF
+large -c core.compression=0
+small -c core.compression=9
+large -c core.compression=0 -c core.loosecompression=0
+large -c core.compression=9 -c core.loosecompression=0
+small -c core.compression=0 -c core.loosecompression=9
+small -c core.compression=9 -c core.loosecompression=9
+large -c core.loosecompression=0
+small -c core.loosecompression=9
+EOF
+
+test_done
-- 
2.11.0-rc1-154-g4118e37061

