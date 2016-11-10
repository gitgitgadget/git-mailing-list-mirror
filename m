Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE7F20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966134AbcKJUfg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:36 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35909 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965652AbcKJUfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:18 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so152175076pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/nezX83Z5ooq2xPYqzmubQfs9ZtsdYntLe8ele1l8w=;
        b=pqYExuVYwQkRqOyKJOQ57OSFXEum6axw1h7YeU4Oju9lzNbPzi18Z0gZIlZUEHpF+9
         IfSyafEBBvWYRhtiMz8vKlGmLskjHqtaGGPHGVHrud4iMwEsfxLSHc+S1/PaeM2TVGwR
         CP5iHxXtR+3d8uJFf3DGcQaFwQcM9BQ0k0BMRVCcdDl6zDvzCFF4RR7zAFJPiLpExt+2
         5X5c1/ZIbYTRIS8do0vNYSp8uqYfbJ9/q9+SZvEJdcGoznVNteV6DYy75/2q/Nhp9YJh
         FKG+P7V8s+WJ05LIImGtI0mGC9YHHDu7Sp5nOZ77phlJNc4SJpyzgtcSceVBfGfsH5fV
         HFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/nezX83Z5ooq2xPYqzmubQfs9ZtsdYntLe8ele1l8w=;
        b=W7jVF16R/keqDZitdxYq8aJ5Bi5XQD1lqkoXQW06g7el0Dbdyp23ms10vv6anL2Nre
         Eg9D2UmGaTIRR+C9CymXsl97XMt3E1xARqY+ik6wxuSape7BagaYfp20wY/2fcfquzXH
         XKSl0GcGojAD89fBM2Q3av83jM37hZzuni1reiimPAuio4sSd086A72xx2/szUIJwtVJ
         OeYN7cbn9roxAdO/aljm96XgBE7T6no358j4WbtksS6Y+dCoTXEW9+XOX3gKZBYFDMMl
         zIWxaHvu5J7ghD9t8LAQsPnKzGZKWvl+rbOrEqZQsRT7HQ9AYMxYt3QVW6roiJUHODZ/
         xSeg==
X-Gm-Message-State: ABUngveuJmBJiF54TAAVSzPQILTlIebBGIvs/oqGl1vXeCtdSyZ0a06jnpc6b0VrA4SPIYvf
X-Received: by 10.99.167.67 with SMTP id w3mr38897401pgo.1.1478810117001;
        Thu, 10 Nov 2016 12:35:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id n17sm9257956pfg.80.2016.11.10.12.35.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 31/35] pathspec: allow querying for attributes
Date:   Thu, 10 Nov 2016 12:34:24 -0800
Message-Id: <20161110203428.30512-32-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pathspec mechanism is extended via the new
":(attr:eol=input)pattern/to/match" syntax to filter paths so that it
requires paths to not just match the given pattern but also have the
specified attrs attached for them to be chosen.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.txt |  20 ++++
 dir.c                              |  41 +++++++-
 pathspec.c                         | 106 +++++++++++++++++++-
 pathspec.h                         |  19 +++-
 t/t6134-pathspec-with-labels.sh    | 191 +++++++++++++++++++++++++++++++++++++
 5 files changed, 370 insertions(+), 7 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8ad29e6..f90bd45 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -384,6 +384,26 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
 
+attr;;
+After `attr:` comes a space separated list of "attribute
+requirements", all of which must be met in order for the
+path to be considered a match; this is in addition to the
+usual non-magic pathspec pattern matching.
++
+Each of the attribute requirements for the path takes one of
+these forms:
+
+- "`ATTR`" requires that the attribute `ATTR` must be set.
+
+- "`-ATTR`" requires that the attribute `ATTR` must be unset.
+
+- "`ATTR=VALUE`" requires that the attribute `ATTR` must be
+  set to the string `VALUE`.
+
+- "`!ATTR`" requires that the attribute `ATTR` must be
+  unspecified.
++
+
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspec (magic signature: `!`). If it
diff --git a/dir.c b/dir.c
index 3bad1ad..c56d2ee 100644
--- a/dir.c
+++ b/dir.c
@@ -9,6 +9,7 @@
  */
 #include "cache.h"
 #include "dir.h"
+#include "attr.h"
 #include "refs.h"
 #include "wildmatch.h"
 #include "pathspec.h"
@@ -139,7 +140,8 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	for (n = 0; n < pathspec->nr; n++) {
 		size_t i = 0, len = 0, item_len;
@@ -207,6 +209,37 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
+static int match_attrs(const char *name, int namelen,
+		       const struct pathspec_item *item)
+{
+	int i;
+	struct git_attr_result *res = git_attr_result_alloc(item->attr_check);
+
+	git_check_attr(name, item->attr_check, res);
+	for (i = 0; i < item->attr_match_nr; i++) {
+		const char *value;
+		int matched;
+		enum attr_match_mode match_mode;
+
+		value = res[i].value;
+		match_mode = item->attr_match[i].match_mode;
+
+		if (ATTR_TRUE(value))
+			matched = (match_mode == MATCH_SET);
+		else if (ATTR_FALSE(value))
+			matched = (match_mode == MATCH_UNSET);
+		else if (ATTR_UNSET(value))
+			matched = (match_mode == MATCH_UNSPECIFIED);
+		else
+			matched = (match_mode == MATCH_VALUE &&
+				   !strcmp(item->attr_match[i].value, value));
+		if (!matched)
+			return 0;
+	}
+
+	return 1;
+}
+
 #define DO_MATCH_EXCLUDE   1
 #define DO_MATCH_DIRECTORY 2
 
@@ -262,6 +295,9 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
+	if (item->attr_match_nr && !match_attrs(name, namelen, item))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
@@ -314,7 +350,8 @@ static int do_match_pathspec(const struct pathspec *ps,
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	if (!ps->nr) {
 		if (!ps->recursive ||
diff --git a/pathspec.c b/pathspec.c
index d44f8e7..4aa7ea5 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "attr.h"
+#include "argv-array.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -88,12 +90,79 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
+{
+	struct string_list_item *si;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct argv_array attrs = ARGV_ARRAY_INIT;
+
+
+	if (!value || !strlen(value))
+		die(_("attr spec must not be empty"));
+
+	string_list_split(&list, value, ' ', -1);
+	string_list_remove_empty_items(&list, 0);
+
+	ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->attr_match_alloc);
+
+	for_each_string_list_item(si, &list) {
+		size_t attr_len;
+
+		int j = item->attr_match_nr++;
+		const char *attr = si->string;
+		struct attr_match *am = &item->attr_match[j];
+
+		switch (*attr) {
+		case '!':
+			am->match_mode = MATCH_UNSPECIFIED;
+			attr++;
+			attr_len = strlen(attr);
+			break;
+		case '-':
+			am->match_mode = MATCH_UNSET;
+			attr++;
+			attr_len = strlen(attr);
+			break;
+		default:
+			attr_len = strcspn(attr, "=");
+			if (attr[attr_len] != '=')
+				am->match_mode = MATCH_SET;
+			else {
+				am->match_mode = MATCH_VALUE;
+				am->value = xstrdup(&attr[attr_len + 1]);
+				if (strchr(am->value, '\\'))
+					die(_("attr spec values must not contain backslashes"));
+			}
+			break;
+		}
+
+		if (!attr_name_valid(attr, attr_len)) {
+			struct strbuf sb = STRBUF_INIT;
+			am->match_mode = INVALID_ATTR;
+			invalid_attr_name_message(&sb, attr, attr_len);
+			die(_("invalid attribute in '%s': '%s'"), value, sb.buf);
+		}
+
+		argv_array_push(&attrs, xmemdupz(attr, attr_len));
+	}
+
+	if (!item->attr_check)
+		git_attr_check_initv(&item->attr_check, attrs.argv);
+	else
+		die(_("Only one 'attr:' specification is allowed."));
+
+	argv_array_clear(&attrs);
+	string_list_clear(&list, 0);
+	return;
+}
+
 static void eat_long_magic(struct pathspec_item *item, const char *elt,
 		unsigned *magic, int *pathspec_prefix,
 		const char **copyfrom_, const char **long_magic_end)
 {
 	int i;
 	const char *copyfrom = *copyfrom_;
+	const char *body;
 	/* longhand */
 	const char *nextat;
 	for (copyfrom = elt + 2;
@@ -108,15 +177,22 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 		if (!len)
 			continue;
 
-		if (starts_with(copyfrom, "prefix:")) {
+		if (skip_prefix(copyfrom, "prefix:", &body)) {
 			char *endptr;
-			*pathspec_prefix = strtol(copyfrom + 7,
-						  &endptr, 10);
+			*pathspec_prefix = strtol(body, &endptr, 10);
 			if (endptr - copyfrom != len)
 				die(_("invalid parameter for pathspec magic 'prefix'"));
 			continue;
 		}
 
+		if (skip_prefix(copyfrom, "attr:", &body)) {
+			char *attr_body = xmemdupz(body, len - strlen("attr:"));
+			parse_pathspec_attr_match(item, attr_body);
+			free(attr_body);
+			*magic |= PATHSPEC_ATTR;
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +501,10 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		unsigned short_magic;
 		entry = argv[i];
-
+		item[i].attr_check = NULL;
+		item[i].attr_match = NULL;
+		item[i].attr_match_nr = 0;
+		item[i].attr_match_alloc = 0;
 		item[i].magic = prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
@@ -447,6 +526,13 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard = 1;
 		pathspec->magic |= item[i].magic;
+
+		if (item[i].attr_match_nr) {
+			int j;
+			for (j = 0; j < item[i].attr_match_nr; j++)
+				if (item[i].attr_match[j].match_mode == INVALID_ATTR)
+					die(_("attribute spec in the wrong syntax are prohibited."));
+		}
 	}
 
 	if (nr_exclude == n)
@@ -500,6 +586,18 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 void clear_pathspec(struct pathspec *pathspec)
 {
+	int i, j;
+	for (i = 0; i < pathspec->nr; i++) {
+		if (!pathspec->items[i].attr_match_nr)
+			continue;
+		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
+			free(pathspec->items[i].attr_match[j].value);
+		free(pathspec->items[i].attr_match);
+		if (pathspec->items[i].attr_check)
+			git_attr_check_clear(pathspec->items[i].attr_check);
+		free(pathspec->items[i].attr_check);
+	}
+
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
diff --git a/pathspec.h b/pathspec.h
index 59809e4..c2d046d 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -8,13 +8,15 @@
 #define PATHSPEC_GLOB		(1<<3)
 #define PATHSPEC_ICASE		(1<<4)
 #define PATHSPEC_EXCLUDE	(1<<5)
+#define PATHSPEC_ATTR		(1<<6)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
 	 PATHSPEC_LITERAL	| \
 	 PATHSPEC_GLOB		| \
 	 PATHSPEC_ICASE		| \
-	 PATHSPEC_EXCLUDE)
+	 PATHSPEC_EXCLUDE	| \
+	 PATHSPEC_ATTR)
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
@@ -32,6 +34,21 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		int attr_match_nr;
+		int attr_match_alloc;
+		struct attr_match {
+			char *value;
+			enum attr_match_mode {
+				MATCH_SET,
+				MATCH_UNSET,
+				MATCH_VALUE,
+				MATCH_UNSPECIFIED,
+				MATCH_NOT_UNSPECIFIED,
+				MATCH_SET_OR_VALUE,
+				INVALID_ATTR
+			} match_mode;
+		} *attr_match;
+		struct git_attr_check *attr_check;
 	} *items;
 };
 
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
new file mode 100755
index 0000000..e276811
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,191 @@
+#!/bin/sh
+
+test_description='test labels in pathspecs'
+. ./test-lib.sh
+
+test_expect_success 'setup a tree' '
+	cat <<-EOF >expect &&
+	fileA
+	fileAB
+	fileAC
+	fileB
+	fileBC
+	fileC
+	fileNoLabel
+	fileSetLabel
+	fileUnsetLabel
+	fileValue
+	fileWrongLabel
+	sub/fileA
+	sub/fileAB
+	sub/fileAC
+	sub/fileB
+	sub/fileBC
+	sub/fileC
+	sub/fileNoLabel
+	sub/fileSetLabel
+	sub/fileUnsetLabel
+	sub/fileValue
+	sub/fileWrongLabel
+	EOF
+	mkdir sub &&
+	while read path
+	do
+		: >$path &&
+		git add $path || return 1
+	done <expect &&
+	git commit -m "initial commit" &&
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pathspec with no attr' '
+	test_must_fail git ls-files ":(attr:)"
+'
+
+test_expect_success 'pathspec with labels and non existent .gitattributes' '
+	git ls-files ":(attr:label)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'setup .gitattributes' '
+	cat <<-EOF >.gitattributes &&
+	fileA labelA
+	fileB labelB
+	fileC labelC
+	fileAB labelA labelB
+	fileAC labelA labelC
+	fileBC labelB labelC
+	fileUnsetLabel -label
+	fileSetLabel label
+	fileValue label=foo
+	fileWrongLabel label☺
+	EOF
+	git add .gitattributes &&
+	git commit -m "add attributes"
+'
+
+test_expect_success 'check specific set attr' '
+	cat <<-EOF >expect &&
+	fileSetLabel
+	sub/fileSetLabel
+	EOF
+	git ls-files ":(attr:label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific unset attr' '
+	cat <<-EOF >expect &&
+	fileUnsetLabel
+	sub/fileUnsetLabel
+	EOF
+	git ls-files ":(attr:-label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific value attr' '
+	cat <<-EOF >expect &&
+	fileValue
+	sub/fileValue
+	EOF
+	git ls-files ":(attr:label=foo)" >actual &&
+	test_cmp expect actual &&
+	git ls-files ":(attr:label=bar)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'check unspecified attr' '
+	cat <<-EOF >expect &&
+	.gitattributes
+	fileA
+	fileAB
+	fileAC
+	fileB
+	fileBC
+	fileC
+	fileNoLabel
+	fileWrongLabel
+	sub/fileA
+	sub/fileAB
+	sub/fileAC
+	sub/fileB
+	sub/fileBC
+	sub/fileC
+	sub/fileNoLabel
+	sub/fileWrongLabel
+	EOF
+	git ls-files ":(attr:!label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check multiple unspecified attr' '
+	cat <<-EOF >expect &&
+	.gitattributes
+	fileC
+	fileNoLabel
+	fileWrongLabel
+	sub/fileC
+	sub/fileNoLabel
+	sub/fileWrongLabel
+	EOF
+	git ls-files ":(attr:!labelB !labelA !label)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with more labels but excluded path' '
+	cat <<-EOF >expect &&
+	fileAB
+	fileB
+	fileBC
+	EOF
+	git ls-files ":(attr:labelB)" ":(exclude)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label excluding other labels' '
+	cat <<-EOF >expect &&
+	fileAB
+	fileB
+	fileBC
+	sub/fileAB
+	sub/fileB
+	EOF
+	git ls-files ":(attr:labelB)" ":(exclude,attr:labelC)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fail on multiple attr specifiers in one pathspec item' '
+	test_must_fail git ls-files . ":(attr:labelB,attr:labelC)" 2>actual &&
+	test_i18ngrep "Only one" actual
+'
+
+test_expect_success 'checking attributes in a multithreaded process' '
+	cat <<-EOF >expect &&
+	fileA:A
+	EOF
+	echo A >fileA &&
+	echo A >fileB &&
+	git grep A -- ":(attr:labelA)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fail if attr magic is used places not implemented' '
+	# The main purpose of this test is to check that we actually fail
+	# when you attempt to use attr magic in commands that do not implement
+	# attr magic. This test does not advocate git-add to stay that way,
+	# though, but git-add is convenient as it has its own internal pathspec
+	# parsing.
+	test_must_fail git add ":(attr:labelB)" 2>actual &&
+	test_i18ngrep "unsupported magic" actual
+'
+
+test_expect_success 'abort on giving invalid label on the command line' '
+	test_must_fail git ls-files . ":(attr:☺)"
+'
+
+test_expect_success 'abort on asking for wrong magic' '
+	test_must_fail git ls-files . ":(attr:-label=foo)" &&
+	test_must_fail git ls-files . ":(attr:!label=foo)"
+'
+
+test_done
-- 
2.10.1.469.g00a8914

