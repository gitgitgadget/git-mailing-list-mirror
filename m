From: dturner@twopensource.com
Subject: [PATCH v7 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 21:49:59 -0400
Message-ID: <1431481799-23560-4-git-send-email-dturner@twopensource.com>
References: <1431481799-23560-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 03:50:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsLoU-0001Iy-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 03:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbbEMBuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 21:50:19 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33080 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922AbbEMBuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 21:50:15 -0400
Received: by igbpi8 with SMTP id pi8so106163448igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 18:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhV0pI0e/u4GuehQr9oIycq2bkXCofexz+WYIQvJao8=;
        b=XfLla/qfH53GolG2tv8R6MmW/7FvH6CSE/MS4JShnBSAp2SZiinwTsUucrH83n/E0W
         K+4fXHH+tlqT6rm6R61kPSa3Q7IhPhgFV9R78fA0LrkzluuLORhhO7PIYxjIrHNV2AKK
         RYO3oyfDYTeehtzbXnMYPRoG83AhKHRVXOWm4V94UVqvDjEn/3eLvskDXLh4MvxcGZZs
         L8HVD8qH1EE5/dEMo2iS/IrB2wqC55Y/5i+6p3vMCYdVjZBDCUaLdqf1s9uSQdAqrVRj
         nvBbbBbwzG1ChQYpzWJJAAfUJfIkXqhozeEAmiNVvuJB8Dimjk3NlA3HcdbjTOVJiiP8
         sz8w==
X-Gm-Message-State: ALoCoQm5ki0jBGCx7emt9jvmMEBu6RJr96gOxjbj9rhiW3AzE4Do8UgBac9UsWd518ldS5QM6r6d
X-Received: by 10.50.117.35 with SMTP id kb3mr7662306igb.13.1431481814990;
        Tue, 12 May 2015 18:50:14 -0700 (PDT)
Received: from ubuntu.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id s5sm2534656igh.6.2015.05.12.18.50.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 May 2015 18:50:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431481799-23560-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268916>

From: David Turner <dturner@twitter.com>

This wires the in-repo-symlink following code through to the cat-file
builtin.  In the event of an out-of-repo link, cat-file will print
the link in a new format.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/git-cat-file.txt |  98 +++++++++++++++++++-
 builtin/cat-file.c             |  46 ++++++++-
 t/t1006-cat-file.sh            | 205 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..f4e3590 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
-'git cat-file' (--batch | --batch-check) < <list-of-objects>
+'git cat-file' (--batch | --batch-check) [--follow-symlinks] < <list-of-objects>
 
 DESCRIPTION
 -----------
@@ -69,6 +69,61 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--follow-symlinks::
+	With --batch or --batch-check, follow symlinks inside the
+	repository when requesting objects with extended SHA-1
+	expressions of the form tree-ish:path-in-tree.  Instead of
+	providing output about the link itself, provide output about
+	the linked-to object.  If a symlink points outside the
+	tree-ish (e.g. a link to /foo or a root-level link to ../foo),
+	the portion of the link which is outside the tree will be
+	printed.
+[normal]
+	This option does not (currently) work correctly when an
+	object in the index is specified (e.g. `:link` instead of
+	`HEAD:link`) rather than one in the tree.
+[normal]
+	This option cannot be used unless `--batch` or `--batch-check`
+	is used, because it would be impossible to distinguish between
+	the output for an out-of-repo symlink, and the contents of a
+	blob.
+
+For example, consider a git repository containing:
+
+--
+	f: a file containing "hello\n"
+	link: a symlink to f
+	dir/link: a symlink to ../f
+	plink: a symlink to ../f
+	alink: a symlink to /etc/passwd
+--
+For a regular file `f`, `echo HEAD:f | git cat-file --batch` would print
+--
+	ce013625030ba8dba906f756967f9e9ca394464a blob 6
+--
+
+And `echo HEAD:link | git cat-file --batch --follow-symlinks` would print
+the same thing, as would `HEAD:dir/link`, as they both point at `HEAD:f`.
+
+Without `--follow-symlinks`, these would print data about the
+symlink itself.  In the case of `HEAD:link`, you would see
+
+--
+	4d1ae35ba2c8ec712fa2a379db44ad639ca277bd blob 1
+--
+
+Both `plink` and `alink` point outside the tree, so they would
+respectively print:
+
+--
+	symlink 4
+	../f
+
+	symlink 11
+	/etc/passwd
+--
+
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
@@ -148,6 +203,47 @@ the repository, then `cat-file` will ignore any custom format and print:
 <object> SP missing LF
 ------------
 
+If --follow-symlinks is used, and a symlink in the repository points
+outside the repository, then `cat-file` will ignore any custom format
+and print:
+
+------------
+symlink SP <size> LF
+<symlink> LF
+------------
+
+The symlink will either be absolute (beginning with a /), or relative
+to the tree root.  For instance, if dir/link points to ../../foo, then
+<symlink> will be ../foo.  <size> is the size of the symlink in bytes.
+
+If --follow-symlinks is used, the following error messages will be
+displayed:
+
+------------
+<object> SP missing LF
+------------
+is printed when the initial symlink requested does not exist.
+
+------------
+dangling SP <size> LF
+<object> LF
+------------
+is printed when the initial symlink exists, but something that
+it (transitive-of) points to does not.
+
+------------
+loop SP <size> LF
+<object> LF
+------------
+is printed for symlink loops (or any symlinks that
+require more than 40 link resolutions to resolve).
+
+------------
+notdir SP <size> LF
+<object> LF
+------------
+is printed when, during symlink resolution, a file is used as a
+directory name.
 
 CAVEATS
 -------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..6ed4807 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "userdiff.h"
 #include "streaming.h"
+#include "tree-walk.h"
 
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 {
@@ -224,6 +225,7 @@ static void print_object_or_die(int fd, struct expand_data *data)
 
 struct batch_options {
 	int enabled;
+	int follow_symlinks;
 	int print_contents;
 	const char *format;
 };
@@ -232,12 +234,40 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 			    struct expand_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct object_context ctx;
+	int flags = opt->follow_symlinks ? GET_SHA1_FOLLOW_SYMLINKS : 0;
+	enum follow_symlinks_result result;
 
 	if (!obj_name)
 	   return 1;
 
-	if (get_sha1(obj_name, data->sha1)) {
-		printf("%s missing\n", obj_name);
+	result = get_sha1_with_context(obj_name, flags, data->sha1, &ctx);
+	if (result != FOUND) {
+		switch(result) {
+		case MISSING_OBJECT:
+			printf("%s missing\n", obj_name);
+			break;
+		case DANGLING_SYMLINK:
+			printf("dangling %"PRIuMAX"\n%s\n", strlen(obj_name),
+			       obj_name);
+			break;
+		case SYMLINK_LOOP:
+			printf("loop %"PRIuMAX"\n%s\n", strlen(obj_name),
+			       obj_name);
+			break;
+		case NOT_DIR:
+			printf("notdir %"PRIuMAX"\n%s\n", strlen(obj_name),
+			       obj_name);
+			break;
+		}
+		fflush(stdout);
+		return 0;
+	}
+
+	if (ctx.mode == 0) {
+		printf("symlink %"PRIuMAX"\n%s\n",
+		       (uintmax_t)ctx.symlink_path.len,
+		       ctx.symlink_path.buf);
 		fflush(stdout);
 		return 0;
 	}
@@ -342,9 +372,8 @@ static int batch_option_callback(const struct option *opt,
 {
 	struct batch_options *bo = opt->value;
 
-	if (unset) {
-		memset(bo, 0, sizeof(*bo));
-		return 0;
+	if (bo->enabled) {
+		return 1;
 	}
 
 	bo->enabled = 1;
@@ -369,6 +398,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_SET_INT(0, "follow-symlinks", &batch.follow_symlinks,
+			N_("follow in-repo symlinks; report out-of-repo symlinks (requires --batch or --batch-check)"),
+			    1),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -402,6 +434,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		usage_with_options(cat_file_usage, options);
 	}
 
+	if (batch.follow_symlinks && !batch.enabled) {
+		usage_with_options(cat_file_usage, options);
+	}
+
 	if (batch.enabled)
 		return batch_objects(&batch);
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ab36b1e..a494013 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -189,6 +189,13 @@ do
     '
 done
 
+for opt in t s e p
+do
+    test_expect_success "Passing -$opt with --follow-symlinks fails" '
+	    test_must_fail git cat-file --follow-symlinks -$opt $hello_sha1
+	'
+done
+
 test_expect_success "--batch-check for a non-existent named object" '
     test "foobar42 missing
 foobar84 missing" = \
@@ -296,4 +303,202 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+# Tests for git cat-file --follow-symlinks
+test_expect_success 'prep for symlink tests' '
+	echo_without_newline "$hello_content" >morx &&
+	test_ln_s_add morx same-dir-link &&
+	test_ln_s_add dir link-to-dir &&
+	test_ln_s_add ../fleem out-of-repo-link &&
+	test_ln_s_add .. out-of-repo-link-dir &&
+	test_ln_s_add same-dir-link link-to-link &&
+	test_ln_s_add nope broken-same-dir-link &&
+	mkdir dir &&
+	test_ln_s_add ../morx dir/parent-dir-link &&
+	test_ln_s_add .. dir/link-dir &&
+	test_ln_s_add ../../escape dir/out-of-repo-link &&
+	test_ln_s_add ../.. dir/out-of-repo-link-dir &&
+	test_ln_s_add nope dir/broken-link-in-dir &&
+	mkdir dir/subdir &&
+	test_ln_s_add ../../morx dir/subdir/grandparent-dir-link &&
+	test_ln_s_add ../../../great-escape dir/subdir/out-of-repo-link &&
+	test_ln_s_add ../../.. dir/subdir/out-of-repo-link-dir &&
+	test_ln_s_add ../../../ dir/subdir/out-of-repo-link-dir-trailing &&
+	test_ln_s_add ../parent-dir-link dir/subdir/parent-dir-link-to-link &&
+	echo_without_newline "$hello_content" >dir/subdir/ind2 &&
+	echo_without_newline "$hello_content" >dir/ind1 &&
+	test_ln_s_add dir dirlink &&
+	test_ln_s_add dir/subdir subdirlink &&
+	test_ln_s_add subdir/ind2 dir/link-to-child &&
+	test_ln_s_add dir/link-to-child link-to-down-link &&
+	test_ln_s_add dir/.. up-down &&
+	test_ln_s_add dir/../ up-down-trailing &&
+	test_ln_s_add dir/../morx up-down-file &&
+	test_ln_s_add dir/../../morx up-up-down-file &&
+	test_ln_s_add subdirlink/../../morx up-two-down-file &&
+	test_ln_s_add loop1 loop2 &&
+	test_ln_s_add loop2 loop1 &&
+	git add morx dir/subdir/ind2 dir/ind1 &&
+	git commit -am "test" &&
+	echo $hello_sha1 blob $hello_size >found
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for non-links' '
+	echo HEAD:morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo HEAD:nope missing >expect &&
+	echo HEAD:nope | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for in-repo, same-dir links' '
+	echo HEAD:same-dir-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for in-repo, links to dirs' '
+	echo HEAD:link-to-dir/ind1 | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for broken in-repo, same-dir links' '
+	echo dangling 25 >expect &&
+	echo HEAD:broken-same-dir-link >>expect &&
+	echo HEAD:broken-same-dir-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for same-dir links-to-links' '
+	echo HEAD:link-to-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for parent-dir links' '
+	echo HEAD:dir/parent-dir-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo notdir 29 >expect &&
+	echo HEAD:dir/parent-dir-link/nope >>expect &&
+	echo HEAD:dir/parent-dir-link/nope | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for .. links' '
+	echo dangling 22 >expect &&
+	echo HEAD:dir/link-dir/nope >>expect &&
+	echo HEAD:dir/link-dir/nope | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/link-dir/morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo dangling 27 >expect &&
+	echo HEAD:dir/broken-link-in-dir >>expect &&
+	echo HEAD:dir/broken-link-in-dir | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for ../.. links' '
+	echo notdir 41 >expect &&
+	echo HEAD:dir/subdir/grandparent-dir-link/nope >>expect &&
+	echo HEAD:dir/subdir/grandparent-dir-link/nope | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/subdir/grandparent-dir-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo HEAD:dir/subdir/parent-dir-link-to-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/ links' '
+	echo dangling 17 >expect &&
+	echo HEAD:dirlink/morx >>expect &&
+	echo HEAD:dirlink/morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo $hello_sha1 blob $hello_size >expect &&
+	echo HEAD:dirlink/ind1 | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/subdir links' '
+	echo dangling 20 >expect &&
+	echo HEAD:subdirlink/morx >>expect &&
+	echo HEAD:subdirlink/morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:subdirlink/ind2 | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir ->subdir links' '
+	echo notdir 27 >expect &&
+	echo HEAD:dir/link-to-child/morx >>expect &&
+	echo HEAD:dir/link-to-child/morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/link-to-child | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo HEAD:link-to-down-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks' '
+	echo symlink 8 >expect &&
+	echo ../fleem >>expect &&
+	echo HEAD:out-of-repo-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo symlink 2 >expect &&
+	echo .. >>expect &&
+	echo HEAD:out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks in dirs' '
+	echo symlink 9 >expect &&
+	echo ../escape >>expect &&
+	echo HEAD:dir/out-of-repo-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo symlink 2 >expect &&
+	echo .. >>expect &&
+	echo HEAD:dir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks in subdirs' '
+	echo symlink 15 >expect &&
+	echo ../great-escape >>expect &&
+	echo HEAD:dir/subdir/out-of-repo-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo symlink 2 >expect &&
+	echo .. >>expect &&
+	echo HEAD:dir/subdir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo symlink 3 >expect &&
+	echo ../ >>expect &&
+	echo HEAD:dir/subdir/out-of-repo-link-dir-trailing | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
+	echo HEAD: | git cat-file --batch-check >expect &&
+	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo symlink 7 >expect &&
+	echo ../morx >>expect &&
+	echo HEAD:up-up-down-file | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:up-two-down-file | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlink breaks loops' '
+	echo loop 10 >expect &&
+	echo HEAD:loop1 >>expect &&
+	echo HEAD:loop1 | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch --follow-symlink returns correct sha and mode' '
+	echo HEAD:morx | git cat-file --batch >expect &&
+	echo HEAD:morx | git cat-file --batch --follow-symlinks >actual &&
+	test_cmp expect actual
+'
 test_done
-- 
2.0.4.315.gad8727a-twtrsrc
