From: dturner@twopensource.com
Subject: [PATCH v2 3/3] cat-file: add --follow-symlinks to --batch
Date: Fri,  8 May 2015 18:38:46 -0400
Message-ID: <1431124726-22562-3-git-send-email-dturner@twopensource.com>
References: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 00:39:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqqvq-0003EZ-G3
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 00:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbbEHWjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 18:39:41 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32888 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbbEHWjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 18:39:36 -0400
Received: by qkx62 with SMTP id 62so57774332qkx.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 15:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nsa9i63kwz3zj4kfjG7XgmEqX7BLofOEuwC6apungEk=;
        b=NQfzL4WnBTuM/Oe/wtuy51ktFR1ABxHPtlzyTJPJYKFOYF2yGvD0YEqX4ilXVoJ0N/
         eNKS1Js1Spc/WpgPgyMTuU011aTOz3GCdnNFn94Jc1wdIwH6AUhoy1gt9fi0T4RjuvJj
         vZyLfl4f1D4NFPjOTovWq49rJAr+JeEPnelImxal0FmURdGBz0d772cu1s7x1ReKYU6G
         tum/jYHjvutOJk3oZ4RRN6GOL8knHTGptyUtM2xf6RCuRbOk7oOrOyxdLawUJyLHuLv2
         n2eK21sikhIPFRiOvvoIO/lQrGbZBVCvK79MI7QBeqiywZAgA8u2QkwLeg487mcfcjYA
         2zlw==
X-Gm-Message-State: ALoCoQkWfGzOfHQddzomF24otRdKBa/jyb/z+LnWMTNoYC2fuWj4YbZdyUNRG5YYTDn96eyK2k8T
X-Received: by 10.55.33.142 with SMTP id f14mr567507qki.1.1431124775750;
        Fri, 08 May 2015 15:39:35 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 104sm4599100qgj.43.2015.05.08.15.39.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 15:39:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268683>

From: David Turner <dturner@twitter.com>

This wires the in-repo-symlink following code through to the cat-file
builtin.  In the event of an out-of-repo link, cat-file will print
the link in a new format.

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/git-cat-file.txt |  28 ++++++-
 builtin/cat-file.c             |  23 +++++-
 t/t1006-cat-file.sh            | 184 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..18b67a3 100644
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
@@ -69,6 +69,19 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--follow-symlinks::
+	Follow symlinks inside the repository.  Instead of providing
+	output about the link itself, provide output about the linked-to
+	object.  This option requires --batch or --batch-check.  In the
+	event of a symlink loop (or more than 40 symlinks in a symlink
+	resolution chain), the file will be treated as missing.  If a
+	symlink points outside the repository (e.g. a link to /foo or a
+	root-level link to ../foo), the portion of the link which is
+	outside the repository will be printed.  Follow-symlinks will
+	be silently turned off if <object> specifies an object in the
+	index rather than one in the object database.
+
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
@@ -148,6 +161,19 @@ the repository, then `cat-file` will ignore any custom format and print:
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
+to the repository root.  For instance, if dir/link points to ../../foo,
+then <symlink> will be ../foo.  <size> is the size of the symlink in
+bytes.
+
 
 CAVEATS
 -------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..8e96dac 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -224,6 +224,7 @@ static void print_object_or_die(int fd, struct expand_data *data)
 
 struct batch_options {
 	int enabled;
+	int follow_symlinks;
 	int print_contents;
 	const char *format;
 };
@@ -232,16 +233,24 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
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
+		printf("symlink %"PRIuMAX"\n%s\n", (uintmax_t)strlen(ctx.path),
+		       ctx.path);
+		return 0;
+	}
+
 	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
@@ -342,9 +351,8 @@ static int batch_option_callback(const struct option *opt,
 {
 	struct batch_options *bo = opt->value;
 
-	if (unset) {
-		memset(bo, 0, sizeof(*bo));
-		return 0;
+	if (bo->enabled) {
+		return 1;
 	}
 
 	bo->enabled = 1;
@@ -369,6 +377,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
+		OPT_SET_INT(0, "follow-symlinks", &batch.follow_symlinks,
+			N_("follow in-repo symlinks; report out-of-repo symlinks (requires --batch or --batch-check)"),
+			    1),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
@@ -402,6 +413,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		usage_with_options(cat_file_usage, options);
 	}
 
+	if (batch.follow_symlinks && !batch.enabled) {
+		usage_with_options(cat_file_usage, options);
+	}
+
 	if (batch.enabled)
 		return batch_objects(&batch);
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ab36b1e..a9ef3a6 100755
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
@@ -296,4 +303,181 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+# Tests for git cat-file --follow-symlinks
+test_expect_success 'prep for symlink tests' '
+	echo_without_newline "$hello_content" > morx &&
+	ln -s morx same-dir-link &&
+	ln -s ../fleem out-of-repo-link &&
+	ln -s .. out-of-repo-link-dir &&
+	ln -s same-dir-link link-to-link &&
+	ln -s nope broken-same-dir-link &&
+	mkdir dir &&
+	ln -s ../morx dir/parent-dir-link &&
+	ln -s .. dir/link-dir &&
+	ln -s ../../escape dir/out-of-repo-link &&
+	ln -s ../.. dir/out-of-repo-link-dir &&
+	ln -s nope dir/broken-link-in-dir &&
+	mkdir dir/subdir &&
+	ln -s ../../morx dir/subdir/grandparent-dir-link &&
+	ln -s ../../../great-escape dir/subdir/out-of-repo-link &&
+	ln -s ../../.. dir/subdir/out-of-repo-link-dir &&
+	ln -s ../../../ dir/subdir/out-of-repo-link-dir-trailing &&
+	ln -s ../parent-dir-link dir/subdir/parent-dir-link-to-link &&
+	echo_without_newline "$hello_content" >dir/subdir/ind2 &&
+	echo_without_newline "$hello_content" >dir/ind1 &&
+	ln -s dir dirlink &&
+	ln -s dir/subdir subdirlink &&
+	ln -s subdir/ind2 dir/link-to-child &&
+	ln -s dir/link-to-child link-to-down-link &&
+	ln -s dir/.. up-down &&
+	ln -s dir/../ up-down-trailing &&
+	ln -s dir/../morx up-down-file &&
+	ln -s dir/../../morx up-up-down-file &&
+	ln -s subdirlink/../../morx up-two-down-file &&
+	ln -s loop1 loop2 &&
+	ln -s loop2 loop1 &&
+	git add . &&
+	git commit -am "test"
+'
+
+echo $hello_sha1 blob $hello_size > found
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for non-links' '
+	echo HEAD:morx | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual &&
+	echo HEAD:nope missing > expect &&
+	echo HEAD:nope | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for in-repo, same-dir links' '
+	echo HEAD:same-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for broken in-repo, same-dir links' '
+	echo HEAD:broken-same-dir-link missing > expect &&
+	echo HEAD:broken-same-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for same-dir links-to-links' '
+	echo HEAD:link-to-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for parent-dir links' '
+	echo HEAD:dir/parent-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual &&
+	echo HEAD:dir/parent-dir-link/nope missing > expect &&
+	echo HEAD:dir/parent-dir-link/nope | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for .. links' '
+	echo HEAD:dir/link-dir/nope missing > expect &&
+	echo HEAD:dir/link-dir/nope | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/link-dir/morx | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual &&
+	echo HEAD:dir/broken-link-in-dir missing > expect &&
+	echo HEAD:dir/broken-link-in-dir | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for ../.. links' '
+	echo HEAD:dir/subdir/grandparent-dir-link/nope missing > expect &&
+	echo HEAD:dir/subdir/grandparent-dir-link/nope | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/subdir/grandparent-dir-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual &&
+	echo HEAD:dir/subdir/parent-dir-link-to-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/ links' '
+	echo HEAD:dirlink/morx missing > expect &&
+	echo HEAD:dirlink/morx | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo $hello_sha1 blob $hello_size > expect &&
+	echo HEAD:dirlink/ind1 | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/subdir links' '
+	echo HEAD:subdirlink/morx missing > expect &&
+	echo HEAD:subdirlink/morx | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo HEAD:subdirlink/ind2 | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir -> subdir links' '
+	echo HEAD:dir/link-to-child/morx missing > expect &&
+	echo HEAD:dir/link-to-child/morx | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo HEAD:dir/link-to-child | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual &&
+	echo HEAD:link-to-down-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks' '
+	echo symlink 8 > expect &&
+	echo ../fleem >> expect &&
+	echo HEAD:out-of-repo-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo symlink 2 > expect &&
+	echo .. >> expect &&
+	echo HEAD:out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks in dirs' '
+	echo symlink 9 > expect &&
+	echo ../escape >> expect &&
+	echo HEAD:dir/out-of-repo-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo symlink 2 > expect &&
+	echo .. >> expect &&
+	echo HEAD:dir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-of-repo symlinks in subdirs' '
+	echo symlink 15 > expect &&
+	echo ../great-escape >> expect &&
+	echo HEAD:dir/subdir/out-of-repo-link | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo symlink 2 > expect &&
+	echo .. >> expect &&
+	echo HEAD:dir/subdir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo symlink 3 > expect &&
+	echo ../ >> expect &&
+	echo HEAD:dir/subdir/out-of-repo-link-dir-trailing | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
+	echo HEAD: | git cat-file --batch-check > expect &&
+	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual &&
+	echo symlink 7 > expect &&
+	echo ../morx >> expect &&
+	echo HEAD:up-up-down-file | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	echo HEAD:up-two-down-file | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp found actual
+'
+
+test_expect_success 'git cat-file --batch-check --follow-symlink breaks loops' '
+	echo HEAD:loop1 missing > expect &&
+	echo HEAD:loop1 | git cat-file --batch-check --follow-symlinks > actual &&
+	test_cmp expect actual
+'
 test_done
-- 
2.0.4.315.gad8727a-twtrsrc
