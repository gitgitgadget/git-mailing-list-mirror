Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CDCE20986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965139AbcJVXeD (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:34:03 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37518 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965097AbcJVXdf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:35 -0400
Received: by mail-it0-f46.google.com with SMTP id m138so74604526itm.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff3ZaGZo5EBdDccIRocDWGwOMxosTYR+1uZf51TyJlI=;
        b=h0gfOZ/tTLJ9S+AjTOZ1VPqENsLo0XDCl9BRTrGfG+CFCJLNeMAOwH+EUvtObT6UaX
         DdfDr6IaI9/slYRbNwzjE81xnbLWXVD5h/rh2Y55TnM87qJaUIf2X+pR3EGNAiak5x0R
         dp9ChYX2oQ7yhUmPL1ZBafr+gXypoeWM0IKH3phL4ocFTjlSOHNGB3WtKcMAkEtBf1cb
         6vn3drhwgGabxefM3w0Fb/lQtq4R0kaNRWYLPm3jVFz48sfn8KDFXA3EHHKtob8Vfv+G
         lvSo4f5zJ5rGDhd3s46NAEJlkg5wMeh1u44643UKyYu+rEgj+HoIf1dJSFd/GDF1OeND
         HKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ff3ZaGZo5EBdDccIRocDWGwOMxosTYR+1uZf51TyJlI=;
        b=Psam31BwZCTozqZp8QVCec9o0JCgrUurmqvqqXllziFdABM25P1xFPiSYFi63iZ61V
         4WCKKq6wUM29oQ+4p98hppZXApzm0eM8gef26L+hQMrc5KWP9glcpQwClWy7NSaGhHRr
         iWkzBygt3PSZhgQ4/uNulcfeCxonIxTkMdpE3JVs8BTdHTcE2TH+i9WsUvKWHO0YNskd
         hg/bBziUvQjX4VeDZqg1CjwGxXEjUH9eEt+rapoLWE1RiXEYcDQ5mQ+FXQqwndBNiHeZ
         lRk0gkgG6OyOmLK+hxlcFOSGygqBsoQAsfOjFBVb9UQCZuPA1UpZhV6Ib+G9v0m9Qe1j
         t+Aw==
X-Gm-Message-State: ABUngvcts5lvyGB6sPd4Cuy6NlPou/7WAiF0cH8GY4I9qfGf4lgNMWEtn97pHw4G/VKu0Vdl
X-Received: by 10.36.57.147 with SMTP id l141mr7833624ita.22.1477179213843;
        Sat, 22 Oct 2016 16:33:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id u184sm1984825ith.4.2016.10.22.16.33.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 32/36] pathspec: allow querying for attributes
Date:   Sat, 22 Oct 2016 16:32:21 -0700
Message-Id: <20161022233225.8883-33-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
 Documentation/glossary-content.txt |  20 +++++
 dir.c                              |  35 ++++++++
 pathspec.c                         | 103 +++++++++++++++++++++-
 pathspec.h                         |  16 ++++
 t/t6134-pathspec-with-labels.sh    | 170 +++++++++++++++++++++++++++++++++++++
 5 files changed, 340 insertions(+), 4 deletions(-)
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
index 3bad1ad..3ec9117 100644
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
@@ -207,6 +208,37 @@ int within_depth(const char *name, int namelen,
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
 
@@ -262,6 +294,9 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
+	if (item->attr_match_nr && !match_attrs(name, namelen, item))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
diff --git a/pathspec.c b/pathspec.c
index d44f8e7..0eee177 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "attr.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -88,12 +89,78 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
+{
+	struct string_list_item *si;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+
+	if (!value || !strlen(value))
+		die(_("attr spec must not be empty"));
+
+	string_list_split(&list, value, ' ', -1);
+	string_list_remove_empty_items(&list, 0);
+
+	if (!item->attr_check)
+		git_attr_check_alloc(&item->attr_check);
+	else
+		die(_("Only one 'attr:' specification is allowed."));
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
+		am->attr = git_attr_counted(attr, attr_len);
+		if (!am->attr) {
+			struct strbuf sb = STRBUF_INIT;
+			am->match_mode = INVALID_ATTR;
+			invalid_attr_name_message(&sb, attr, attr_len);
+			die(_("invalid attribute in '%s': '%s'"), value, sb.buf);
+		}
+
+		git_attr_check_append(item->attr_check, am->attr);
+	}
+
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
@@ -108,15 +175,21 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
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
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +498,10 @@ void parse_pathspec(struct pathspec *pathspec,
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
@@ -447,6 +523,13 @@ void parse_pathspec(struct pathspec *pathspec,
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
@@ -500,6 +583,18 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
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
index 59809e4..aebe6ea 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,22 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		int attr_match_nr;
+		int attr_match_alloc;
+		struct attr_match {
+			struct git_attr *attr;
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
index 0000000..1c9323c
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,170 @@
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
+test_expect_success 'checking attributes in a multithreaded process' '
+	git status ":(attr:labelB)"
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
2.10.1.508.g6572022

