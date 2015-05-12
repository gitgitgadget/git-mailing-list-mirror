From: dturner@twopensource.com
Subject: [PATCH v6 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 13:45:59 -0400
Message-ID: <1431452759-17732-4-git-send-email-dturner@twopensource.com>
References: <1431452759-17732-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 19:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsEGH-00029U-8b
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 19:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289AbbELRq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 13:46:27 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33232 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918AbbELRqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 13:46:25 -0400
Received: by qkx62 with SMTP id 62so11067963qkx.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 10:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zAB6FCtOW+9u/sUYWFSWsp6/YWlmISmG7jo0UHHAoII=;
        b=EvmRVVD/4OrH8MdQsV664EUXWukZoQLDgCqAc6+KgUoHPnKXJC4vmcw5RKGDNOeCFJ
         2UQFf/gPl1Gs6LQFvXVmM9kF5TNsFstlqp79dd1wC7In5Tpj0p/YCQ7UADa1YPfODOTN
         sO1zmBsoYAxycO3xJGtL6h50Y2/ZOqCv4z9XB1nEyTKEEDUjne7czxjS37gE1zZ+6Gmy
         F7FA0DfDhKtEI6RLmi6Aqc5mmSiTSbgYi21TVEtMbJk4C+J3OpSrPW/si3QjrELMb1Vh
         gub+9OAKx86QAdadvfO5NMer87div45+/QNMfurMpUb60WopvljnMVkbqU0vgBZQQdFv
         CeOg==
X-Gm-Message-State: ALoCoQn1piW+4k9ajqAIbnkPRfHhbgCf+MhwggxCmhh3M9gS84CQUzK/8tXcJBMwj07+bmM6W29Y
X-Received: by 10.55.41.170 with SMTP id p42mr35532313qkp.106.1431452784156;
        Tue, 12 May 2015 10:46:24 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 143sm13700748qhw.21.2015.05.12.10.46.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 May 2015 10:46:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431452759-17732-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268866>

From: David Turner <dturner@twitter.com>

This wires the in-repo-symlink following code through to the cat-file
builtin.  In the event of an out-of-repo link, cat-file will print
the link in a new format.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/git-cat-file.txt |  54 +++++++++++-
 builtin/cat-file.c             |  24 +++++-
 t/t1006-cat-file.sh            | 189 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..9bdfced 100644
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
@@ -69,6 +69,46 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--follow-symlinks::
+	Follow symlinks inside the repository when requesting objects
+	with extended SHA-1 expressions of the form tree-ish:path-in-tree.
+	Instead of providing output about the link itself, provide output
+	about the linked-to object.  This option requires --batch or
+	--batch-check.  In the event of a symlink loop (or more than
+	40 symlinks in a symlink resolution chain), the file will be
+	treated as missing.  If a symlink points outside the tree-ish
+	(e.g. a link to /foo or a root-level link to ../foo), the
+	portion of the link which is outside the tree will be printed.
+	Follow-symlinks will be silently turned off if <object>
+	specifies an object in the index rather than one in the object
+	database.
+
+	For example, consider the a git repository containing:
+	f: a file containing "hello\n"
+	link: a symlink to f
+	dir/link: a symlink to ../f
+	plink: a symlink to ../f
+	alink: a symlink to /etc/passwd
+
+	echo HEAD:f |git cat-file --batch --follow-symlinks would print
+	ce013625030ba8dba906f756967f9e9ca394464a blob 6
+
+	echo HEAD:link |git cat-file --batch --follow-symlinks would print
+	the same thing, as would HEAD:dir/link.
+	Without follow-symlinks, these would print data about the
+	symlink itself.  In the case of HEAD:link, you would see
+	4d1ae35ba2c8ec712fa2a379db44ad639ca277bd blob 1
+
+	Both plink and alink point outside the tree, so they would
+	respectively print:
+	symlink 4
+	../f
+
+	symlink 11
+	/etc/passwd
+
+
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
@@ -148,6 +188,18 @@ the repository, then `cat-file` will ignore any custom format and print:
 <object> SP missing LF
 ------------
 
+If --follow-symlinks is used, and a symlink in the repository points
+outside the repository, then `cat-file` will ignore any custom format
+and print:
+
+------------
+symlink SP <size> LF <symlink> LF
+------------
+
+The symlink will either be absolute (beginning with a /), or relative
+to the tree root.  For instance, if dir/link points to ../../foo, then
+<symlink> will be ../foo.  <size> is the size of the symlink in bytes.
+
 
 CAVEATS
 -------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..6bcf9a0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -224,6 +224,7 @@ static void print_object_or_die(int fd, struct expand_data *data)
 
 struct batch_options {
 	int enabled;
+	int follow_symlinks;
 	int print_contents;
 	const char *format;
 };
@@ -232,16 +233,25 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 			    struct expand_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct object_context ctx;
+	int flags = opt->follow_symlinks ? GET_SHA1_FOLLOW_SYMLINKS : 0;
 
 	if (!obj_name)
 	   return 1;
 
-	if (get_sha1(obj_name, data->sha1)) {
+	if (get_sha1_with_context(obj_name, flags, data->sha1, &ctx)) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
 		return 0;
 	}
 
+	if (ctx.mode == 0) {
+		printf("symlink %"PRIuMAX"\n%s\n",
+		       (uintmax_t)ctx.symlink_path.len,
+		       ctx.symlink_path.buf);
+		return 0;
+	}
+
 	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
@@ -342,9 +352,8 @@ static int batch_option_callback(const struct option *opt,
 {
 	struct batch_options *bo = opt->value;
 
-	if (unset) {
-		memset(bo, 0, sizeof(*bo));
-		return 0;
+	if (bo->enabled) {
+		return 1;
 	}
 
 	bo->enabled = 1;
@@ -369,6 +378,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_SET_INT(0, "follow-symlinks", &batch.follow_symlinks,
+			N_("follow in-repo symlinks; report out-of-repo symlinks (requires --batch or --batch-check)"),
+			    1),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -402,6 +414,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		usage_with_options(cat_file_usage, options);
 	}
 
+	if (batch.follow_symlinks && !batch.enabled) {
+		usage_with_options(cat_file_usage, options);
+	}
+
 	if (batch.enabled)
 		return batch_objects(&batch);
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ab36b1e..b863a68 100755
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
@@ -296,4 +303,186 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+# Tests for git cat-file --follow-symlinks
+test_expect_success 'prep for symlink tests' '
+	echo_without_newline "$hello_content" >morx &&
+	test_ln_s_add morx same-dir-link &&
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
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for broken in-repo, same-dir links' '
+	echo HEAD:broken-same-dir-link missing >expect &&
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
+	echo HEAD:dir/parent-dir-link/nope missing >expect &&
+	echo HEAD:dir/parent-dir-link/nope | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for .. links' '
+	echo HEAD:dir/link-dir/nope missing >expect &&
+	echo HEAD:dir/link-dir/nope | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/link-dir/morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo HEAD:dir/broken-link-in-dir missing >expect &&
+	echo HEAD:dir/broken-link-in-dir | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for ../.. links' '
+	echo HEAD:dir/subdir/grandparent-dir-link/nope missing >expect &&
+	echo HEAD:dir/subdir/grandparent-dir-link/nope | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/subdir/grandparent-dir-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual &&
+	echo HEAD:dir/subdir/parent-dir-link-to-link | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/ links' '
+	echo HEAD:dirlink/morx missing >expect &&
+	echo HEAD:dirlink/morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo $hello_sha1 blob $hello_size >expect &&
+	echo HEAD:dirlink/ind1 | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/subdir links' '
+	echo HEAD:subdirlink/morx missing >expect &&
+	echo HEAD:subdirlink/morx | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	echo HEAD:subdirlink/ind2 | git cat-file --batch-check --follow-symlinks >actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir ->subdir links' '
+	echo HEAD:dir/link-to-child/morx missing >expect &&
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
+	echo HEAD:loop1 missing >expect &&
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
