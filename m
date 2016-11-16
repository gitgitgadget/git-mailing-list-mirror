Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53B32021E
	for <e@80x24.org>; Wed, 16 Nov 2016 02:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbcKPCsi (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 21:48:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58536 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932203AbcKPCsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 21:48:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC41D4F8F5;
        Tue, 15 Nov 2016 21:48:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=w
        3JHrh6ShPTVU/Az/CwnAstXrTM=; b=H9Dew5JQsLkZYYnyCjfeBOHmjduCPnbNP
        qvobJXInId0LuJBF1NheUxboRn2roHAMclKnXuwqEDzMJiL+XpBvDJUiG8oy21dq
        +6ij28qLz82GGUgT23FGqOrffKClHmuRf3BEDGKnxJGR27wf4PWOYuppS4aYwlBx
        SA2kLiaFUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=qpA
        djCT1qv4TUpJcO+jvir8YYC4Dz8rjtqu2Yvmz6x4qGHtIvq4+RaqpGplUCvTH8mz
        TghPlkWucj6B90hRe6kY4ySANU8Nv8HNz0HbeEt0+YVrS/sj4H5Vhq0EAC0Bq7Jp
        /aSmnYnngArSAk/a6QbUHxepNV+LuoK3TlS8dRl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3AD94F8F4;
        Tue, 15 Nov 2016 21:48:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 544CE4F8F3;
        Tue, 15 Nov 2016 21:48:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] compression: unify pack.compression configuration parsing
Date:   Tue, 15 Nov 2016 18:48:33 -0800
Message-ID: <xmqqfumsrvge.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A93BCEA-ABA7-11E6-8329-987C12518317-77302942!pb-smtp1.pobox.com
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

 * I was primarily interested in teaching the configuration to
   bulk-checkin codepath, and added a test that succeeds only with
   the code change.  The handling of confugraiton in other two
   codepaths, pack-objects and fast-import, may be totally broken
   with this change if there is no existing test.  A similar set of
   tests for them are very much welcomed, as without them this
   change won't be 'next' worthy yet.

 builtin/pack-objects.c | 14 --------------
 bulk-checkin.c         |  2 --
 cache.h                |  2 ++
 config.c               | 14 ++++++++++++++
 environment.c          |  2 ++
 fast-import.c          | 13 -------------
 t/t1050-large.sh       | 30 ++++++++++++++++++++++++++++++
 7 files changed, 48 insertions(+), 29 deletions(-)

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
index a50a61a197..a5d689f9d3 100644
--- a/cache.h
+++ b/cache.h
@@ -671,6 +671,8 @@ extern const char *git_hooks_path;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int core_compression_seen;
+extern int pack_compression_level;
+extern int pack_compression_seen;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
diff --git a/config.c b/config.c
index 83fdecb1bc..0477386f27 100644
--- a/config.c
+++ b/config.c
@@ -865,6 +865,8 @@ static int git_default_core_config(const char *var, const char *value)
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
 			zlib_compression_level = level;
+		if (!pack_compression_seen)
+			pack_compression_level = level;
 		return 0;
 	}
 
@@ -1125,6 +1127,18 @@ int git_default_config(const char *var, const char *value, void *dummy)
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
index 0935ec696e..88ab1c38c6 100644
--- a/environment.c
+++ b/environment.c
@@ -35,6 +35,8 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
+int pack_compression_level = Z_DEFAULT_COMPRESSION;
+int pack_compression_seen;
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
index 096dbffecc..f800af1451 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -5,6 +5,13 @@ test_description='adding and checking out large blobs'
 
 . ./test-lib.sh
 
+# This should be moved to test-lib.sh together with the
+# copy in t0021 after both topics have graduated to 'master'.
+
+file_size () {
+	perl -e 'print -s $ARGV[0]' "$1"
+}
+
 test_expect_success setup '
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
@@ -17,6 +24,29 @@ test_expect_success setup '
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
+done <<-EOF
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
-- 
2.11.0-rc1-154-g4118e37061

