From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 5/5] pathspec: record labels
Date: Mon, 16 May 2016 11:05:39 -0700
Message-ID: <20160516180539.4114-6-sbeller@google.com>
References: <20160516180539.4114-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 16 20:06:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MuW-0005og-ER
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbcEPSG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:06:27 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35111 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbcEPSGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:06:20 -0400
Received: by mail-pa0-f54.google.com with SMTP id gj5so9358450pac.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qaGr2QEEU/uOESBZ8UAkSxCyAu5kLVYq0ytE9ATkz3Y=;
        b=OdygepVpXYgBtH7zxQynsCSTZWBOu8S9nSLyyz4qjlr0VX2kV8y0KJ3xrROSzLm7BB
         /oZXidwArmysshWJNE9PHWgVl4dPiuO8RUkMahBL5r2EQ8MS2guYylUfT5/hoI/aO7TF
         51ND6DmT36OifPSKnZwuC7TpADKwQ9NdHv3/5nNy3/UI2DiIsbTkpUFRhGpNF9eF3WX+
         6x2PvzBA0yrYhIS0Xs7Hn9Im5oQBrRDBZYNt3zU7o3ss6VhDSl/r+9EJVkoTu2rg+wLG
         NvljM6hYZk/k70HaLyHu++Jf8/LqdI3FwFXWGcb/vPTtgSonWa8tX1EeCsHshpz6JPbG
         xBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qaGr2QEEU/uOESBZ8UAkSxCyAu5kLVYq0ytE9ATkz3Y=;
        b=dq7n2UEFCLTQMfDWGrwJBfFXCyAZnYDeVFxoOMSSzpWxEGB85kAwopLoAldG8OAQGP
         tsP3nPwRXV0mGmF3a/kyFEfQsMVMzgjb6oYGQg4MargYRcorCCsjQVlgIjzsFM7fCS1q
         rTOQ94xzwGw1NCSh18O7XClPs0ZvjTeYrXXNFSnvky0TnOmoTw8HSEUbX4mAefE0tQx1
         pVulgc5uqKVKGQRcafGUqgcmLNxFYnp8F5LRn3QsGI1HX87CLoDpzGJlaTEqXD0QLMRC
         8u5ZLOLtPED7D7D1HFyJBRaCl17HGrk9sNyvZGqyRFlfHn99R6NalAiRKv9EqGz+fnia
         QwOw==
X-Gm-Message-State: AOPr4FUaeVUzZYOpGgBJMQWBPOgGgF3TPzsK6EFvgeRx4UxcSESH4o9wqwx44owpPu5/P6Kk
X-Received: by 10.66.189.135 with SMTP id gi7mr47698126pac.158.1463421950788;
        Mon, 16 May 2016 11:05:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id yl5sm48873799pac.38.2016.05.16.11.05.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.gb49ffe6.dirty
In-Reply-To: <20160516180539.4114-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294773>

The "label" attribute can be attached to paths, and the pathspec
mechanism is extended via the new ":(label=X)pattern/to/match"
syntax to filter paths so that it requires paths to not just
match the given pattern but also have the specified labels
attached for them to be chosen.

Labels are meant to describe arbitrary set of files, which
is not described via the tree layout.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitattributes.txt    |  12 +++
 Documentation/glossary-content.txt |   4 +
 dir.c                              |  56 +++++++++++++
 pathspec.c                         |  65 ++++++++++++++-
 pathspec.h                         |   2 +
 t/t6134-pathspec-with-labels.sh    | 158 +++++++++++++++++++++++++++++++++++++
 6 files changed, 293 insertions(+), 4 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index af2c682..b846848 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -906,6 +906,18 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
+Attaching labels to path
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+`label`
+^^^^^^^
+By the value of this attribute you can specify a list of arbitrary strings
+to be attached to a path as labels. These labels can be used for
+easier paths matching using pathspecs (linkgit:gitglossary[1]).
+It is required to use only alphanumeric characters, dashes and
+underscores for the labels.
+
+
 USING MACRO ATTRIBUTES
 ----------------------
 
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8ad29e6..e264a58 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -384,6 +384,10 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
 
+label=<white space separated list>;;
+	Additionally to matching the pathspec, the path must have a 'label'
+	attribute having set all labels listed here.
+
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspec (magic signature: `!`). If it
diff --git a/dir.c b/dir.c
index 656f272..fd39f92 100644
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
@@ -208,6 +209,58 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
+static int has_all_labels(const char *name, int namelen,
+			   const struct string_list *required_labels)
+{
+	static struct git_attr *attr;
+
+	struct git_attr_check check;
+	char *path;
+	int ret;
+
+	if (!attr)
+		attr = git_attr("label");
+	check.attr = attr;
+
+	path = xmemdupz(name, namelen);
+	if (git_check_attr(path, 1, &check))
+		die("internal bug: git_check_attr died.");
+
+	if (ATTR_TRUE(check.value))
+		ret = 1; /* has all the labels */
+	else if (ATTR_FALSE(check.value)) {
+		warning(_("Path '%s': Label must not be false. Treat as if no label was set."), path);
+		ret = 0;
+	} else if (ATTR_UNSET(check.value))
+		ret = 0; /* has no labels */
+	else {
+		struct string_list_item *si;
+		struct string_list attr_labels = STRING_LIST_INIT_DUP;
+		string_list_split(&attr_labels, check.value, ',', -1);
+		for_each_string_list_item(si, &attr_labels) {
+			if (validate_label_name(si->string)) {
+				warning(_("Ignoring label '%s'"), si->string);
+				free(si->string);
+				si->string = "";
+			}
+		}
+		string_list_remove_empty_items(&attr_labels, 0);
+		string_list_sort(&attr_labels);
+		ret = 1;
+		for_each_string_list_item(si, required_labels) {
+			if (!string_list_has_string(&attr_labels, si->string)) {
+				ret = 0;
+				break;
+			}
+		}
+		string_list_clear(&attr_labels, 0);
+	}
+
+	free(path);
+
+	return ret;
+}
+
 #define DO_MATCH_EXCLUDE   1
 #define DO_MATCH_DIRECTORY 2
 
@@ -263,6 +316,9 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
+	if (item->labels && !has_all_labels(name, namelen, item->labels))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
diff --git a/pathspec.c b/pathspec.c
index 4dff252..2f053fb 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -88,12 +88,42 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static int check_valid_label_name(const char *label)
+{
+	if (!label || !strlen(label))
+		return -1;
+
+	if (!isalpha(*label))
+		return -1;
+
+	while (*label) {
+		if (!(isalnum(*label) ||
+			*label == '-' ||
+			*label == '_'))
+			return -1;
+		label++;
+	}
+
+	return 0;
+}
+
+int validate_label_name(const char *label)
+{
+	int ret = check_valid_label_name(label);
+	if (ret)
+		warning(_("Label '%s': Label names must start with an "
+			  "alphabetic character and use only alphanumeric "
+			  "characters, dashes and underscores."), label);
+	return ret;
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
@@ -108,15 +138,28 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
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
 
+		if (skip_prefix(copyfrom, "label=", &body)) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_add(&sb, body, nextat - body);
+			if (!item->labels) {
+				item->labels = xmalloc(sizeof(*item->labels));
+				string_list_init(item->labels, 1);
+			} else
+				die(_("multiple labels not supported in pathspec magic"));
+			string_list_split(item->labels, sb.buf, ' ', -1);
+			string_list_remove_empty_items(item->labels, 0);
+			strbuf_release(&sb);
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +468,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		unsigned short_magic;
 		entry = argv[i];
-
+		item[i].labels = NULL;
 		item[i].magic = prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
@@ -447,6 +490,13 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard = 1;
 		pathspec->magic |= item[i].magic;
+
+		if (item[i].labels) {
+			struct string_list_item *si;
+			for_each_string_list_item(si, item[i].labels)
+				if (validate_label_name(si->string))
+					die(_("Labels in the wrong syntax are prohibited."));
+		}
 	}
 
 	if (nr_exclude == n)
@@ -502,6 +552,13 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 void free_pathspec(struct pathspec *pathspec)
 {
+	int i;
+	for (i = 0; i < pathspec->nr; i++) {
+		if (pathspec->items[i].labels)
+			string_list_clear(pathspec->items[i].labels, 1);
+		free(pathspec->items[i].labels);
+	}
+
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
diff --git a/pathspec.h b/pathspec.h
index 0c11262..bf02931 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,7 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		struct string_list *labels;
 	} *items;
 };
 
@@ -98,5 +99,6 @@ extern char *find_pathspecs_matching_against_index(const struct pathspec *pathsp
 extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
 extern const char *check_path_for_gitlink(const char *path);
 extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
+extern int validate_label_name(const char *label);
 
 #endif /* PATHSPEC_H */
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
new file mode 100755
index 0000000..e2e4753
--- /dev/null
+++ b/t/t6134-pathspec-with-labels.sh
@@ -0,0 +1,158 @@
+#!/bin/sh
+
+test_description='test labels in pathspecs'
+. ./test-lib.sh
+
+test_expect_success 'setup a tree' '
+	mkdir sub &&
+	for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUnsetLabel fileSetLabel; do
+		: >$p &&
+		git add $p &&
+		: >sub/$p
+		git add sub/$p
+	done &&
+	git commit -m $p &&
+	git ls-files >actual &&
+	cat <<EOF >expect &&
+fileA
+fileAB
+fileAC
+fileB
+fileBC
+fileC
+fileNoLabel
+fileSetLabel
+fileUnsetLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileB
+sub/fileBC
+sub/fileC
+sub/fileNoLabel
+sub/fileSetLabel
+sub/fileUnsetLabel
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'pathspec with no label and non existent .gitattributes' '
+	git ls-files ":(label=)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'pathspec with labels and non existent .gitattributes' '
+	git ls-files ":(label=a)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'setup .gitattributes' '
+	cat <<EOF >.gitattributes &&
+fileA label=labelA
+fileB label=labelB
+fileC label=labelC
+fileAB label=labelA,labelB
+fileAC label=labelA,labelC
+fileBC label=labelB,labelC
+fileUnsetLabel -label
+fileSetLabel label
+EOF
+	git add .gitattributes &&
+	git commit -m "add attributes"
+'
+
+sq="'"
+
+test_expect_success 'check for any label' '
+	cat <<EOF >expect &&
+fileA
+fileAB
+fileAC
+fileB
+fileBC
+fileC
+fileSetLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileB
+sub/fileBC
+sub/fileC
+sub/fileSetLabel
+EOF
+	cat <<EOF >expect2 &&
+warning: Path ${sq}fileUnsetLabel${sq}: Label must not be unset
+warning: Path ${sq}sub/fileUnsetLabel${sq}: Label must not be unset
+EOF
+	git ls-files ":(label=)" >actual 2>actual2 &&
+	test_cmp expect actual &&
+	test_cmp expect2 actual2
+
+'
+
+test_expect_success 'check specific label' '
+	cat <<EOF >expect &&
+fileA
+fileAB
+fileAC
+fileSetLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileSetLabel
+EOF
+	git ls-files ":(label=labelA)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with 2 labels' '
+	cat <<EOF >expect &&
+fileAB
+fileSetLabel
+sub/fileAB
+sub/fileSetLabel
+EOF
+	git ls-files ":(label=labelA labelB)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label with more labels' '
+	test_must_fail git ls-files ":(label=labelA,label=labelB)" 2>actual &&
+	test_i18ngrep "not supported" actual
+'
+
+test_expect_success 'check label with more labels but excluded path' '
+	cat <<EOF >expect &&
+fileAB
+fileB
+fileBC
+fileSetLabel
+EOF
+	git ls-files ":(label=labelB)" ":(exclude)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check label excluding other labels' '
+	cat <<EOF >expect &&
+fileAB
+fileB
+fileBC
+fileSetLabel
+sub/fileAB
+sub/fileB
+EOF
+	git ls-files ":(label=labelB)" ":(exclude,label=labelC)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check for paths with no label' '
+	cat <<EOF >expect &&
+.gitattributes
+fileNoLabel
+sub/fileNoLabel
+EOF
+	git ls-files . ":(exclude,label=)" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.8.2.401.gb49ffe6.dirty
