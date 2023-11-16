Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y3ZCM9ok"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3CC2
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 21:44:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0c7d27fb0so552015276.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 21:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700113484; x=1700718284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4zDFb+Hh5B+/Mt6k2JTfZaYzYz1+PChfvkiisnQeTI=;
        b=y3ZCM9okIC1jSr2SnBpFPcqThyv+2ygBORVan48u+KniVbsXLZ3S0ALbSVH06ZTCo1
         DdicFqE6/5toqBKxa7O5C+s3D1Jww5F7ENyRGjkFBKbdW0oBWgR75U5UdGN9/366tSE3
         iGsXtAxOLhTBNX/FfxBsEo/qAlRZdepKDm3TJC53Py8rQIv3QLJhSuq/0ZirisbXjcrB
         Wjt1WxJMGXBlIpwVNyn9bigO8JtyH8dyquk5xrI1apIv4ElNphGRjkON4dAnY0YZFAEY
         kieaQeNZYWvA9UbMPv5Z1FbigsKOD59ZsM6apqzu7guaG0xncdXEyTnwBrWaoZcNUyIw
         TvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700113484; x=1700718284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4zDFb+Hh5B+/Mt6k2JTfZaYzYz1+PChfvkiisnQeTI=;
        b=KEi/YQVqYuwH3UK6gPkmuWDqS/cUJAK4AGxrs0+s+FalZ9Eq/SVBorlEsezoOTxnDE
         2YMT47Bw0Mu7XQqwoRpmH14BYv7wyO3u4nEDA43fnA65OPiEIAiCas/uawCAK30g8UTS
         MmDpGqcfUKdjKJ54kM32KJ+vt9tcnMQFMm/tW9P8A7l/CsifTboCXFNgyCDOdPAhiNZb
         zxaAU5rDHXG1VH7lyCP6O8lhZE3Efz7qdE8fqZZurdRwOkChCKk5E1bxyaf8Tkuy/573
         SE/FusNWirtscicIrezac9ft82V3zrOBiulSTI3lkeZirVa0I8F/h8A7pmWXT+CBPgV/
         WZ0g==
X-Gm-Message-State: AOJu0YyWLs8iZKtBnFYilJT2/SoTK1CpMEjJldekJ3fbxr4T2JGPtnBS
	vAUmK/HDYZpdv08LW28u4sVQ5w+ZwVlX
X-Google-Smtp-Source: AGHT+IHlD2KNdx3KZ93BGIqsgvXXo95KbTC3N2KV5yEWRMkTA+WFmn6vvSvuTdxWeRMUsPDR6kINthhCBTtX
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a5b:250:0:b0:d9a:58e1:bb52 with SMTP id
 g16-20020a5b0250000000b00d9a58e1bb52mr410584ybp.6.1700113483671; Wed, 15 Nov
 2023 21:44:43 -0800 (PST)
Date: Thu, 16 Nov 2023 05:44:37 +0000
In-Reply-To: <xmqqttpmtnn5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqttpmtnn5.fsf@gitster.g>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116054437.2343549-1-jojwang@google.com>
Subject: [PATCH 1/1] attr: add builtin objectmode values support
From: Joanna Wang <jojwang@google.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org, jojwang@google.com, sunshine@sunshineco.com, 
	tboegi@web.de
Content-Type: text/plain; charset="UTF-8"

Gives all paths builtin objectmode values based on the paths' modes
(one of 100644, 100755, 120000, 040000, 160000). Users may use
this feature to filter by file types. For example a pathspec such as
':(attr:builtin_objectmode=160000)' could filter for submodules without
needing to have `builtin_objectmode=160000` to be set in .gitattributes
for every submodule path.

These values are also reflected in `git check-attr` results.
If the git_attr_direction is set to GIT_ATTR_INDEX or GIT_ATTR_CHECKIN
and a path is not found in the index, the value will be unspecified.

This patch also reserves the builtin_* attribute namespace for objectmode
and any future builtin attributes. Any user defined attributes using this
reserved namespace will result in a warning. This is a breaking change for
any existing builtin_* attributes.
Pathspecs with some builtin_* attribute name (excluding builtin_objectmode)
will behave like any attribute where there are no user specified values.

Signed-off-by: Joanna Wang <jojwang@google.com>
---

>The idiom is to see if it is still NULL and then call git_attr().
Got it, thank you for explaining again.

>We need a precondition here:
>test_expect_success SYMLINKS
Torsten pointed this out in a previous version,
sorry i missed this until Junio pointed it out again.

I've addressed the all the latest feedback in this update.

 Documentation/gitattributes.txt |  15 +
 attr.c                          |  71 ++++-
 t/#t1700-split-index.sh#        | 547 ++++++++++++++++++++++++++++++++
 t/t0003-attributes.sh           |  75 +++++
 t/t6135-pathspec-with-attrs.sh  |  25 ++
 5 files changed, 730 insertions(+), 3 deletions(-)
 create mode 100755 t/#t1700-split-index.sh#

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8c1793c148..784aa9d4de 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -100,6 +100,21 @@ for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
 
+RESERVED BUILTIN_* ATTRIBUTES
+-----------------------------
+
+builtin_* is a reserved namespace for builtin attribute values. Any
+user defined attributes under this namespace will be ignored and
+trigger a warning.
+
+`builtin_objectmode`
+^^^^^^^^^^^^^^^^^^^^
+This attribute is for filtering files by their file bit modes (40000,
+120000, 160000, 100755, 100644). e.g. ':(attr:builtin_objectmode=160000)'.
+You may also check these values with `git check-attr builtin_objectmode -- <file>`.
+If the object is not in the index `git check-attr --cached` will return unspecified.
+
+
 EFFECTS
 -------
 
diff --git a/attr.c b/attr.c
index e62876dfd3..f8a94aeb23 100644
--- a/attr.c
+++ b/attr.c
@@ -17,6 +17,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "read-cache-ll.h"
+#include "refs.h"
 #include "revision.h"
 #include "object-store-ll.h"
 #include "setup.h"
@@ -183,6 +184,15 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 	}
 }
 
+/*
+ * Atribute name cannot begin with "builtin_" which
+ * is a reserved namespace for built in attributes values.
+ */
+static int attr_name_reserved(const char *name)
+{
+	return starts_with(name, "builtin_");
+}
+
 static int attr_name_valid(const char *name, size_t namelen)
 {
 	/*
@@ -315,7 +325,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			cp++;
 			len--;
 		}
-		if (!attr_name_valid(cp, len)) {
+		if (!attr_name_valid(cp, len) || attr_name_reserved(cp)) {
 			report_invalid_attr(cp, len, src, lineno);
 			return NULL;
 		}
@@ -379,7 +389,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		name += strlen(ATTRIBUTE_MACRO_PREFIX);
 		name += strspn(name, blank);
 		namelen = strcspn(name, blank);
-		if (!attr_name_valid(name, namelen)) {
+		if (!attr_name_valid(name, namelen) || attr_name_reserved(name)) {
 			report_invalid_attr(name, namelen, src, lineno);
 			goto fail_return;
 		}
@@ -1240,6 +1250,61 @@ static struct object_id *default_attr_source(void)
 	return &attr_source;
 }
 
+static const char *builtin_object_mode_attr(struct index_state *istate, const char *path)
+{
+	unsigned int mode;
+	struct strbuf sb = STRBUF_INIT;
+	
+	if (direction == GIT_ATTR_CHECKIN) {
+		struct object_id oid;
+		struct stat st;
+		if (lstat(path, &st))
+			die_errno(_("unable to stat '%s'"), path);
+		mode = canon_mode(st.st_mode);
+		if (S_ISDIR(mode)) {
+			/*
+			 *`path` is either a directory or it is a submodule,
+			 * in which case it is already indexed as submodule
+			 * or it does not exist in the index yet and we need to
+			 * check if we can resolve to a ref.
+			*/
+			int pos = index_name_pos(istate, path, strlen(path));
+			if (pos >= 0) {
+				 if (S_ISGITLINK(istate->cache[pos]->ce_mode))
+					 mode = istate->cache[pos]->ce_mode;
+			} else if (resolve_gitlink_ref(path, "HEAD", &oid) == 0) {
+				mode = S_IFGITLINK;
+			}
+		}
+	} else {
+		/*
+		 * For GIT_ATTR_CHECKOUT and GIT_ATTR_INDEX we only check
+		 * for mode in the index.
+		 */
+		int pos = index_name_pos(istate, path, strlen(path));
+		if (pos >= 0)
+			mode = istate->cache[pos]->ce_mode;
+		else 
+			return ATTR__UNSET;
+	}
+	strbuf_addf(&sb, "%06o", mode);
+	return strbuf_detach(&sb, NULL);
+}
+
+
+static const char *compute_builtin_attr(struct index_state *istate,
+					  const char *path,
+					  const struct git_attr *attr) {
+	static const struct git_attr *object_mode_attr;
+
+	if (!object_mode_attr)
+		object_mode_attr = git_attr("builtin_objectmode");
+	
+	if (attr == object_mode_attr)
+		return builtin_object_mode_attr(istate, path);
+	return ATTR__UNSET;
+}
+
 void git_check_attr(struct index_state *istate,
 		    const char *path,
 		    struct attr_check *check)
@@ -1253,7 +1318,7 @@ void git_check_attr(struct index_state *istate,
 		unsigned int n = check->items[i].attr->attr_nr;
 		const char *value = check->all_attrs[n].value;
 		if (value == ATTR__UNKNOWN)
-			value = ATTR__UNSET;
+			value = compute_builtin_attr(istate, path, check->all_attrs[n].attr);
 		check->items[i].value = value;
 	}
 }
diff --git a/t/#t1700-split-index.sh# b/t/#t1700-split-index.sh#
new file mode 100755
index 0000000000..a7b7263b35
--- /dev/null
+++ b/t/#t1700-split-index.sh#
@@ -0,0 +1,547 @@
+#!/bin/sh
+
+test_description='split index mode tests'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# We need total control of index splitting here
+sane_unset GIT_TEST_SPLIT_INDEX
+
+# Testing a hard coded SHA against an index with an extension
+# that can vary from run to run is problematic so we disable
+# those extensions.
+sane_unset GIT_TEST_FSMONITOR
+sane_unset GIT_TEST_INDEX_THREADS
+
+# Create a file named as $1 with content read from stdin.
+# Set the file's mtime to a few seconds in the past to avoid racy situations.
+create_non_racy_file () {
+	cat >"$1" &&
+	test-tool chmtime =-5 "$1"
+}
+
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	own_v3 sha1:8299b0bcd1ac364e5f1d7768efb62fa2da79a339
+	own_v3 sha256:38a6d2925e3eceec33ad7b34cbff4e0086caa0daf28f31e51f5bd94b4a7af86b
+
+	base_v3 sha1:39d890139ee5356c7ef572216cebcd27aa41f9df
+	base_v3 sha256:c9baeadf905112bf6c17aefbd7d02267afd70ded613c30cafed2d40cb506e1ed
+
+	own_v4 sha1:432ef4b63f32193984f339431fd50ca796493569
+	own_v4 sha256:6738ac6319c25b694afa7bcc313deb182d1a59b68bf7a47b4296de83478c0420
+
+	base_v4 sha1:508851a7f0dfa8691e9f69c7f055865389012491
+	base_v4 sha256:3177d4adfdd4b6904f7e921d91d715a471c0dde7cf6a4bba574927f02b699508
+	EOF
+'
+
+test_expect_success 'enable split index' '
+	git config splitIndex.maxPercentChange 100 &&
+	git update-index --split-index &&
+	test-tool dump-split-index .git/index >actual &&
+	indexversion=$(git update-index --show-index-version) &&
+
+	# NEEDSWORK: Stop hard-coding checksums.
+	if test "$indexversion" = "4"
+	then
+		own=$(test_oid own_v4) &&
+		base=$(test_oid base_v4)
+	else
+		own=$(test_oid own_v3) &&
+		base=$(test_oid base_v3)
+	fi &&
+
+	cat >expect <<-EOF &&
+	own $own
+	base $base
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add one file' '
+	create_non_racy_file one &&
+	git update-index --add one &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	base $base
+	100644 $EMPTY_BLOB 0	one
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'disable split index' '
+	git update-index --no-split-index &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	BASE=$(test-tool dump-split-index .git/index | sed -n "s/^own/base/p") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	not a split index
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'enable split index again, "one" now belongs to base index"' '
+	git update-index --split-index &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'modify original file, base index untouched' '
+	echo modified | create_non_racy_file one &&
+	file1_blob=$(git hash-object one) &&
+	git update-index one &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $file1_blob 0	one
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	q_to_tab >expect <<-EOF &&
+	$BASE
+	100644 $file1_blob 0Q
+	replacements: 0
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add another file, which stays index' '
+	create_non_racy_file two &&
+	git update-index --add two &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $file1_blob 0	one
+	100644 $EMPTY_BLOB 0	two
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	q_to_tab >expect <<-EOF &&
+	$BASE
+	100644 $file1_blob 0Q
+	100644 $EMPTY_BLOB 0	two
+	replacements: 0
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'remove file not in base index' '
+	git update-index --force-remove two &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $file1_blob 0	one
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	q_to_tab >expect <<-EOF &&
+	$BASE
+	100644 $file1_blob 0Q
+	replacements: 0
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'remove file in base index' '
+	git update-index --force-remove one &&
+	git ls-files --stage >ls-files.actual &&
+	test_must_be_empty ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions: 0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add original file back' '
+	create_non_racy_file one &&
+	git update-index --add one &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	100644 $EMPTY_BLOB 0	one
+	replacements:
+	deletions: 0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add new file' '
+	create_non_racy_file two &&
+	git update-index --add two &&
+	git ls-files --stage >actual &&
+	cat >expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'unify index, two files remain' '
+	git update-index --no-split-index &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	two
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	not a split index
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse --shared-index-path' '
+	test_create_repo split-index &&
+	(
+		cd split-index &&
+		git update-index --split-index &&
+		echo .git/sharedindex* >expect &&
+		git rev-parse --shared-index-path >actual &&
+		test_cmp expect actual &&
+		mkdir subdirectory &&
+		cd subdirectory &&
+		echo ../.git/sharedindex* >expect &&
+		git rev-parse --shared-index-path >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	create_non_racy_file three &&
+	git update-index --add three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	three
+	100644 $EMPTY_BLOB 0	two
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set core.splitIndex config variable to false' '
+	git config core.splitIndex false &&
+	git update-index --force-remove three &&
+	git ls-files --stage >ls-files.actual &&
+	cat >ls-files.expect <<-EOF &&
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	two
+	EOF
+	test_cmp ls-files.expect ls-files.actual &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	not a split index
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set core.splitIndex config variable back to true' '
+	git config core.splitIndex true &&
+	create_non_racy_file three &&
+	git update-index --add three &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	create_non_racy_file four &&
+	git update-index --add four &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	100644 $EMPTY_BLOB 0	four
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
+	git config --unset splitIndex.maxPercentChange &&
+	create_non_racy_file five &&
+	git update-index --add five &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	create_non_racy_file six &&
+	git update-index --add six &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	100644 $EMPTY_BLOB 0	six
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check splitIndex.maxPercentChange set to 0' '
+	git config splitIndex.maxPercentChange 0 &&
+	create_non_racy_file seven &&
+	git update-index --add seven &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	create_non_racy_file eight &&
+	git update-index --add eight &&
+	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
+	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'shared index files expire after 2 weeks by default' '
+	create_non_racy_file ten &&
+	git update-index --add ten &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
+	just_under_2_weeks_ago=$((5-14*86400)) &&
+	test-tool chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
+	create_non_racy_file eleven &&
+	git update-index --add eleven &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
+	just_over_2_weeks_ago=$((-1-14*86400)) &&
+	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
+	create_non_racy_file twelve &&
+	git update-index --add twelve &&
+	test $(ls .git/sharedindex.* | wc -l) -le 2
+'
+
+test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
+	git config splitIndex.sharedIndexExpire "16.days.ago" &&
+	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
+	create_non_racy_file thirteen &&
+	git update-index --add thirteen &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
+	just_over_16_days_ago=$((-1-16*86400)) &&
+	test-tool chmtime =$just_over_16_days_ago .git/sharedindex.* &&
+	create_non_racy_file fourteen &&
+	git update-index --add fourteen &&
+	test $(ls .git/sharedindex.* | wc -l) -le 2
+'
+
+test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"' '
+	git config splitIndex.sharedIndexExpire never &&
+	just_10_years_ago=$((-365*10*86400)) &&
+	test-tool chmtime =$just_10_years_ago .git/sharedindex.* &&
+	create_non_racy_file fifteen &&
+	git update-index --add fifteen &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
+	git config splitIndex.sharedIndexExpire now &&
+	just_1_second_ago=-1 &&
+	test-tool chmtime =$just_1_second_ago .git/sharedindex.* &&
+	create_non_racy_file sixteen &&
+	git update-index --add sixteen &&
+	test $(ls .git/sharedindex.* | wc -l) -le 2
+'
+
+test_expect_success POSIXPERM 'same mode for index & split index' '
+	git init same-mode &&
+	(
+		cd same-mode &&
+		test_commit A &&
+		test_modebits .git/index >index_mode &&
+		test_must_fail git config core.sharedRepository &&
+		git -c core.splitIndex=true status &&
+		shared=$(ls .git/sharedindex.*) &&
+		case "$shared" in
+		*" "*)
+			# we have more than one???
+			false ;;
+		*)
+			test_modebits "$shared" >split_index_mode &&
+			test_cmp index_mode split_index_mode ;;
+		esac
+	)
+'
+
+while read -r mode modebits
+do
+	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
+		# Remove existing shared index files
+		git config core.splitIndex false &&
+		git update-index --force-remove one &&
+		rm -f .git/sharedindex.* &&
+		# Create one new shared index file
+		git config core.sharedrepository "$mode" &&
+		git config core.splitIndex true &&
+		create_non_racy_file one &&
+		git update-index --add one &&
+		echo "$modebits" >expect &&
+		test_modebits .git/index >actual &&
+		test_cmp expect actual &&
+		shared=$(ls .git/sharedindex.*) &&
+		case "$shared" in
+		*" "*)
+			# we have more than one???
+			false ;;
+		*)
+			test_modebits "$shared" >actual &&
+			test_cmp expect actual ;;
+		esac
+	'
+done <<\EOF
+0666 -rw-rw-rw-
+0642 -rw-r---w-
+EOF
+
+test_expect_success POSIXPERM,SANITY 'graceful handling when splitting index is not allowed' '
+	test_create_repo ro &&
+	(
+		cd ro &&
+		test_commit initial &&
+		git update-index --split-index &&
+		test -f .git/sharedindex.*
+	) &&
+	cp ro/.git/index new-index &&
+	test_when_finished "chmod u+w ro/.git" &&
+	chmod u-w ro/.git &&
+	GIT_INDEX_FILE="$(pwd)/new-index" git -C ro update-index --split-index &&
+	chmod u+w ro/.git &&
+	rm ro/.git/sharedindex.* &&
+	GIT_INDEX_FILE=new-index git ls-files >actual &&
+	echo initial.t >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'writing split index with null sha1 does not write cache tree' '
+	git config core.splitIndex true &&
+	git config splitIndex.maxPercentChange 0 &&
+	git commit -m "commit" &&
+	{
+		git ls-tree HEAD &&
+		printf "160000 commit $ZERO_OID\\tbroken\\n"
+	} >broken-tree &&
+	echo "add broken entry" >msg &&
+
+	tree=$(git mktree <broken-tree) &&
+	test_tick &&
+	commit=$(git commit-tree $tree -p HEAD <msg) &&
+	git update-ref HEAD "$commit" &&
+	GIT_ALLOW_NULL_SHA1=1 git reset --hard &&
+	test_might_fail test-tool dump-cache-tree >cache-tree.out &&
+	test_line_count = 0 cache-tree.out
+'
+
+test_expect_success 'do not refresh null base index' '
+	test_create_repo merge &&
+	(
+		cd merge &&
+		test_commit initial &&
+		git checkout -b side-branch &&
+		test_commit extra &&
+		git checkout main &&
+		git update-index --split-index &&
+		test_commit more &&
+		# must not write a new shareindex, or we wont catch the problem
+		git -c splitIndex.maxPercentChange=100 merge --no-edit side-branch 2>err &&
+		# i.e. do not expect warnings like
+		# could not freshen shared index .../shareindex.00000...
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'reading split index at alternate location' '
+	git init reading-alternate-location &&
+	(
+		cd reading-alternate-location &&
+		>file-in-alternate &&
+		git update-index --split-index --add file-in-alternate
+	) &&
+	echo file-in-alternate >expect &&
+
+	# Should be able to find the shared index both right next to
+	# the specified split index file ...
+	GIT_INDEX_FILE=./reading-alternate-location/.git/index \
+	git ls-files --cached >actual &&
+	test_cmp expect actual &&
+
+	# ... and, for backwards compatibility, in the current GIT_DIR
+	# as well.
+	mv -v ./reading-alternate-location/.git/sharedindex.* .git &&
+	GIT_INDEX_FILE=./reading-alternate-location/.git/index \
+	git ls-files --cached >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'GIT_TEST_SPLIT_INDEX works' '
+	git init git-test-split-index &&
+	(
+		cd git-test-split-index &&
+		>file &&
+		GIT_TEST_SPLIT_INDEX=1 git update-index --add file &&
+		ls -l .git/sharedindex.* >actual &&
+		test_line_count = 1 actual
+	)
+'
+
+test_done
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index aee2298f01..86f8681570 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -19,6 +19,20 @@ attr_check () {
 	test_must_be_empty err
 }
 
+attr_check_object_mode_basic () {
+	path="$1" &&
+	expect="$2" &&
+	check_opts="$3" &&
+	git check-attr $check_opts builtin_objectmode -- "$path" >actual 2>err &&
+	echo "$path: builtin_objectmode: $expect" >expect &&
+	test_cmp expect actual
+}
+
+attr_check_object_mode () {
+	attr_check_object_mode_basic "$@" &&
+	test_must_be_empty err
+}
+
 attr_check_quote () {
 	path="$1" quoted_path="$2" expect="$3" &&
 
@@ -558,4 +572,65 @@ test_expect_success EXPENSIVE 'large attributes file ignored in index' '
 	test_cmp expect err
 '
 
+test_expect_success 'builtin object mode attributes work (dir and regular paths)' '
+	>normal &&
+	attr_check_object_mode normal 100644 &&
+	mkdir dir &&
+	attr_check_object_mode dir 040000
+'
+
+test_expect_success POSIXPERM 'builtin object mode attributes work (executable)' '
+	>exec && chmod +x exec &&
+	attr_check_object_mode exec 100755
+'
+
+test_expect_success SYMLINKS 'builtin object mode attributes work (symlinks)' '
+	>to_sym ln -s to_sym sym &&
+	attr_check_object_mode sym 120000
+'
+
+test_expect_success 'native object mode attributes work with --cached' '
+	>normal &&
+	git add normal &&
+	empty_blob=$(git rev-parse :normal) &&
+	git update-index --index-info <<-EOF &&
+	100755 $empty_blob 0	exec
+	120000 $empty_blob 0	symlink
+	EOF
+	attr_check_object_mode normal 100644 --cached &&
+	attr_check_object_mode exec 100755 --cached &&
+	attr_check_object_mode symlink 120000 --cached
+'
+
+test_expect_success 'check object mode attributes work for submodules' '
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		mv .git .real &&
+		echo "gitdir: .real" >.git &&
+		test_commit first
+	) &&
+	attr_check_object_mode sub 160000 &&
+	attr_check_object_mode sub unspecified --cached &&
+	git add sub &&
+	attr_check_object_mode sub 160000 --cached
+'
+
+test_expect_success 'we do not allow user defined builtin_* attributes' '
+	echo "foo* builtin_foo" >.gitattributes &&
+	git add .gitattributes 2>actual &&
+	echo "builtin_foo is not a valid attribute name: .gitattributes:1" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'user defined builtin_objectmode values are ignored' '
+	echo "foo* builtin_objectmode=12345" >.gitattributes &&
+	git add .gitattributes &&
+	>foo_1 &&
+	attr_check_object_mode_basic foo_1 100644 &&
+	echo "builtin_objectmode is not a valid attribute name: .gitattributes:1" >expect &&
+	test_cmp expect err
+'
+
 test_done
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index a9c1e4e0ec..b08a32ea68 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -295,4 +295,29 @@ test_expect_success 'reading from .gitattributes in a subdirectory (3)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pathspec with builtin_objectmode attr can be used' '
+	>mode_exec_file_1 &&
+
+	git status -s ":(attr:builtin_objectmode=100644)mode_exec_*" >actual &&
+	echo ?? mode_exec_file_1 >expect &&
+	test_cmp expect actual &&
+
+	git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&
+	git status -s ":(attr:builtin_objectmode=100755)mode_exec_*" >actual &&
+	echo AM mode_exec_file_1 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'builtin_objectmode attr can be excluded' '
+	>mode_1_regular &&
+	>mode_1_exec  && chmod +x mode_1_exec &&
+	git status -s ":(exclude,attr:builtin_objectmode=100644)" "mode_1_*" >actual &&
+	echo ?? mode_1_exec >expect &&
+	test_cmp expect actual &&
+
+	git status -s ":(exclude,attr:builtin_objectmode=100755)" "mode_1_*" >actual &&
+	echo ?? mode_1_regular >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0.rc0.421.g78406f8d94-goog

