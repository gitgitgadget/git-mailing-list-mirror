Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC40C43468
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0E2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yXl/7yGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgGZTz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40798 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728101AbgGZTz0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:55:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 25A986101F;
        Sun, 26 Jul 2020 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793295;
        bh=8QiIX9b7mmHSQN+0z1iHfviFzTayTwTWhiP+//RuSJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yXl/7yGZL4NMhqZWK+EymHB4qHnr/374fOlz9ZcBClyxnld7EloW6aCZa9Ne1uES0
         ewUe5i7KW5hOrBaLsKEEq6GNuwtTj5MNsnR5WEVUPn6L+DRwhQmYJJmHq9/wOWD+2h
         M23/pLlAmXSSZWSHk+5YzdfNbCI9bYdR8arMBorzknZlI8ueu/4fMe/IrUYowOaMRO
         4SF3joE0TjpgqGzss9ww/LRFhsNNQQiO6aSnIssVGJhdX62BAZdwdDiK4/5/CEZGZI
         cHuzOPEiNGOpn3/U0cF0ls0E8PraOGY5iPwaRg3Tks7+TJ3R3GDPD1u7mg6gycpUPt
         iXmiSLu65UfoTSfF+kL+j2Rrc95i7sb+uN/uCygEsyqfkKRyA1ajSWEhxbuxOU8woL
         dO7xLxZZlJCojFQZw73Qt3012Nx4uktQ+Y39gQY/tUEXcJPw0K1mWxeAaqgXLmUsDs
         3TfT1s5Bvcr9vKCeigsz/sSzLu7QuHzjFCAEKXvEpRXq9py8L05
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 31/39] bundle: add new version for use with SHA-256
Date:   Sun, 26 Jul 2020 19:54:16 +0000
Message-Id: <20200726195424.626969-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently we detect the hash algorithm in use by the length of the
object ID.  This is inelegant and prevents us from using a different
hash algorithm that is also 256 bits in length.

Since we cannot extend the v2 format in a backward-compatible way, let's
add a v3 format, which is identical, except for the addition of
capabilities, which are prefixed by an at sign.  We add "object-format"
as the only capability and reject unknown capabilities, since we do not
have a network connection and therefore cannot negotiate with the other
side.

For compatibility, default to the v2 format for SHA-1 and require v3
for SHA-256.

In t5510, always use format v3 so we can be sure we produce consistent
results across hash algorithms.  Since head -n N lists the top N lines
instead of the Nth line, let's run our output through sed to normalize
it and compare it against a fixed value, which will make sure we get
exactly what we're expecting.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-bundle.txt              |  9 ++-
 Documentation/technical/bundle-format.txt | 30 +++++++-
 builtin/bundle.c                          |  5 +-
 bundle.c                                  | 85 +++++++++++++++++------
 bundle.h                                  |  4 +-
 t/t5510-fetch.sh                          | 15 ++--
 t/t5607-clone-bundle.sh                   | 31 +++++++++
 7 files changed, 148 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index d34b0964be..53804cad4b 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -9,7 +9,8 @@ git-bundle - Move objects and refs by archive
 SYNOPSIS
 --------
 [verse]
-'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied] <file> <git-rev-list-args>
+'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]
+		    [--version=<version>] <file> <git-rev-list-args>
 'git bundle' verify [-q | --quiet] <file>
 'git bundle' list-heads <file> [<refname>...]
 'git bundle' unbundle <file> [<refname>...]
@@ -102,6 +103,12 @@ unbundle <file>::
 	is activated.  Unlike --all-progress this flag doesn't actually
 	force any progress display by itself.
 
+--version=<version>::
+	Specify the bundle version.  Version 2 is the older format and can only be
+	used with SHA-1 repositories; the newer version 3 contains capabilities that
+	permit extensions. The default is the oldest supported format, based on the
+	hash algorithm in use.
+
 -q::
 --quiet::
 	This flag makes the command not to report its progress
diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
index 0e828151a5..bac558d049 100644
--- a/Documentation/technical/bundle-format.txt
+++ b/Documentation/technical/bundle-format.txt
@@ -7,6 +7,8 @@ The Git bundle format is a format that represents both refs and Git objects.
 We will use ABNF notation to define the Git bundle format. See
 protocol-common.txt for the details.
 
+A v2 bundle looks like this:
+
 ----
 bundle    = signature *prerequisite *reference LF pack
 signature = "# v2 git bundle" LF
@@ -18,9 +20,28 @@ reference    = obj-id SP refname LF
 pack         = ... ; packfile
 ----
 
+A v3 bundle looks like this:
+
+----
+bundle    = signature *capability *prerequisite *reference LF pack
+signature = "# v3 git bundle" LF
+
+capability   = "@" key ["=" value] LF
+prerequisite = "-" obj-id SP comment LF
+comment      = *CHAR
+reference    = obj-id SP refname LF
+key          = 1*(ALPHA / DIGIT / "-")
+value        = *(%01-09 / %0b-FF)
+
+pack         = ... ; packfile
+----
+
 == Semantics
 
-A Git bundle consists of three parts.
+A Git bundle consists of several parts.
+
+* "Capabilities", which are only in the v3 format, indicate functionality that
+	the bundle requires to be read properly.
 
 * "Prerequisites" lists the objects that are NOT included in the bundle and the
   reader of the bundle MUST already have, in order to use the data in the
@@ -46,3 +67,10 @@ put any string here. The reader of the bundle MUST ignore the comment.
 Note that the prerequisites does not represent a shallow-clone boundary. The
 semantics of the prerequisites and the shallow-clone boundaries are different,
 and the Git bundle v2 format cannot represent a shallow clone repository.
+
+== Capabilities
+
+Because there is no opportunity for negotiation, unknown capabilities cause 'git
+bundle' to abort.  The only known capability is `object-format`, which specifies
+the hash algorithm in use, and can take the same values as the
+`extensions.objectFormat` configuration value.
diff --git a/builtin/bundle.c b/builtin/bundle.c
index f049d27a14..e1a85e7dcc 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -60,6 +60,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int all_progress_implied = 0;
 	int progress = isatty(STDERR_FILENO);
 	struct argv_array pack_opts;
+	int version = -1;
 
 	struct option options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -71,6 +72,8 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 		OPT_BOOL(0, "all-progress-implied",
 			 &all_progress_implied,
 			 N_("similar to --all-progress when progress meter is shown")),
+		OPT_INTEGER(0, "version", &version,
+			    N_("specify bundle format version")),
 		OPT_END()
 	};
 	const char* bundle_file;
@@ -91,7 +94,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
-	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts);
+	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
 }
 
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
diff --git a/bundle.c b/bundle.c
index 2a0d744d3f..5c1cc8f4a8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -12,7 +12,16 @@
 #include "refs.h"
 #include "argv-array.h"
 
-static const char bundle_signature[] = "# v2 git bundle\n";
+
+static const char v2_bundle_signature[] = "# v2 git bundle\n";
+static const char v3_bundle_signature[] = "# v3 git bundle\n";
+static struct {
+	int version;
+	const char *signature;
+} bundle_sigs[] = {
+	{ 2, v2_bundle_signature },
+	{ 3, v3_bundle_signature },
+};
 
 static void add_to_ref_list(const struct object_id *oid, const char *name,
 		struct ref_list *list)
@@ -23,15 +32,30 @@ static void add_to_ref_list(const struct object_id *oid, const char *name,
 	list->nr++;
 }
 
-static const struct git_hash_algo *detect_hash_algo(struct strbuf *buf)
+static int parse_capability(struct bundle_header *header, const char *capability)
 {
-	size_t len = strcspn(buf->buf, " \n");
-	int algo;
+	const char *arg;
+	if (skip_prefix(capability, "object-format=", &arg)) {
+		int algo = hash_algo_by_name(arg);
+		if (algo == GIT_HASH_UNKNOWN)
+			return error(_("unable to detect hash algorithm"));
+		header->hash_algo = &hash_algos[algo];
+		return 0;
+	}
+	return error(_("unknown capability '%s'"), capability);
+}
 
-	algo = hash_algo_by_length(len / 2);
-	if (algo == GIT_HASH_UNKNOWN)
-		return NULL;
-	return &hash_algos[algo];
+static int parse_bundle_signature(struct bundle_header *header, const char *line)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
+		if (!strcmp(line, bundle_sigs[i].signature)) {
+			header->version = bundle_sigs[i].version;
+			return 0;
+		}
+	}
+	return -1;
 }
 
 static int parse_bundle_header(int fd, struct bundle_header *header,
@@ -42,14 +66,16 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 
 	/* The bundle header begins with the signature */
 	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
-	    strcmp(buf.buf, bundle_signature)) {
+	    parse_bundle_signature(header, buf.buf)) {
 		if (report_path)
-			error(_("'%s' does not look like a v2 bundle file"),
+			error(_("'%s' does not look like a v2 or v3 bundle file"),
 			      report_path);
 		status = -1;
 		goto abort;
 	}
 
+	header->hash_algo = the_hash_algo;
+
 	/* The bundle header ends with an empty line */
 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
 	       buf.len && buf.buf[0] != '\n') {
@@ -57,21 +83,21 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		int is_prereq = 0;
 		const char *p;
 
+		if (header->version == 3 && *buf.buf == '@') {
+			buf.buf[--buf.len] = '\0';
+			if (parse_capability(header, buf.buf + 1)) {
+				status = -1;
+				break;
+			}
+			continue;
+		}
+
 		if (*buf.buf == '-') {
 			is_prereq = 1;
 			strbuf_remove(&buf, 0, 1);
 		}
 		strbuf_rtrim(&buf);
 
-		if (!header->hash_algo) {
-			header->hash_algo = detect_hash_algo(&buf);
-			if (!header->hash_algo) {
-				error(_("unknown hash algorithm length"));
-				status = -1;
-				break;
-			}
-		}
-
 		/*
 		 * Tip lines have object name, SP, and refname.
 		 * Prerequisites have object name that is optionally
@@ -449,13 +475,14 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 }
 
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct argv_array *pack_options)
+		  int argc, const char **argv, struct argv_array *pack_options, int version)
 {
 	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
 	int bundle_to_stdout;
 	int ref_count = 0;
 	struct rev_info revs;
+	int default_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
 
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
@@ -464,8 +491,22 @@ int create_bundle(struct repository *r, const char *path,
 		bundle_fd = hold_lock_file_for_update(&lock, path,
 						      LOCK_DIE_ON_ERROR);
 
-	/* write signature */
-	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
+	if (version == -1)
+		version = default_version;
+
+	if (version < 2 || version > 3) {
+		die(_("unsupported bundle version %d"), version);
+	} else if (version < default_version) {
+		die(_("cannot write bundle version %d with algorithm %s"), version, the_hash_algo->name);
+	} else if (version == 2) {
+		write_or_die(bundle_fd, v2_bundle_signature, strlen(v2_bundle_signature));
+	} else {
+		const char *capability = "@object-format=";
+		write_or_die(bundle_fd, v3_bundle_signature, strlen(v3_bundle_signature));
+		write_or_die(bundle_fd, capability, strlen(capability));
+		write_or_die(bundle_fd, the_hash_algo->name, strlen(the_hash_algo->name));
+		write_or_die(bundle_fd, "\n", 1);
+	}
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
diff --git a/bundle.h b/bundle.h
index 2dc9442024..70c84cab08 100644
--- a/bundle.h
+++ b/bundle.h
@@ -13,6 +13,7 @@ struct ref_list {
 };
 
 struct bundle_header {
+	unsigned version;
 	struct ref_list prerequisites;
 	struct ref_list references;
 	const struct git_hash_algo *hash_algo;
@@ -21,7 +22,8 @@ struct bundle_header {
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct repository *r, const char *path,
-		  int argc, const char **argv, struct argv_array *pack_options);
+		  int argc, const char **argv, struct argv_array *pack_options,
+		  int version);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
 int unbundle(struct repository *r, struct bundle_header *header,
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a66dbe0bde..a4988784af 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -281,15 +281,20 @@ test_expect_success 'create bundle 1' '
 	cd "$D" &&
 	echo >file updated again by origin &&
 	git commit -a -m "tip" &&
-	git bundle create bundle1 master^..master
+	git bundle create --version=3 bundle1 master^..master
 '
 
 test_expect_success 'header of bundle looks right' '
 	head -n 4 "$D"/bundle1 &&
-	head -n 1 "$D"/bundle1 | grep "^#" &&
-	head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
-	head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
-	head -n 4 "$D"/bundle1 | grep "^$"
+	cat >expect <<-EOF &&
+	# v3 git bundle
+	@object-format=$(test_oid algo)
+	-OID message
+	OID message
+
+	EOF
+	sed -e "s/$OID_REGEX .*/OID message/g" -e "5q" "$D"/bundle1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'create bundle 2' '
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 6d5a977fcb..26985f4b44 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -4,6 +4,10 @@ test_description='some bundle related tests'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	test_oid_cache <<-EOF &&
+	version sha1:2
+	version sha256:3
+	EOF
 	test_commit initial &&
 	test_tick &&
 	git tag -m tag tag &&
@@ -94,4 +98,31 @@ test_expect_success 'fetch SHA-1 from bundle' '
 	git fetch --no-tags foo/tip.bundle "$(cat hash)"
 '
 
+test_expect_success 'git bundle uses expected default format' '
+	git bundle create bundle HEAD^.. &&
+	head -n1 bundle | grep "^# v$(test_oid version) git bundle$"
+'
+
+test_expect_success 'git bundle v3 has expected contents' '
+	git branch side HEAD &&
+	git bundle create --version=3 bundle HEAD^..side &&
+	head -n2 bundle >actual &&
+	cat >expect <<-EOF &&
+	# v3 git bundle
+	@object-format=$(test_oid algo)
+	EOF
+	test_cmp expect actual &&
+	git bundle verify bundle
+'
+
+test_expect_success 'git bundle v3 rejects unknown capabilities' '
+	cat >new <<-EOF &&
+	# v3 git bundle
+	@object-format=$(test_oid algo)
+	@unknown=silly
+	EOF
+	test_must_fail git bundle verify new 2>output &&
+	test_i18ngrep "unknown capability .unknown=silly." output
+'
+
 test_done
