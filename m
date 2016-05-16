From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/5] pathspec labels
Date: Mon, 16 May 2016 11:05:34 -0700
Message-ID: <20160516180539.4114-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 16 20:05:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Mtu-0005Uw-2z
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbcEPSFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:05:47 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33769 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbcEPSFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:05:43 -0400
Received: by mail-pf0-f170.google.com with SMTP id 206so70298960pfu.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QuFy4+RxZbcf+rQ00t0+8usDtah2VdpWzHRkZ54Gxmc=;
        b=e/m+QOuU1rjscQlRNgB0c8wHkiJgb5b1v+ZGOXMe3ONHSZm80YBzTkQoh3MIsyhIIx
         ajU/aPIixQCVYdoE8QGfNj5mZvLXYBor67AwZZToYqe10HLTUL9PK8bH8yf7357HtbF/
         J9EKNoFeWgyyfKLy8034fVauU8s7lk1kaeJLmMHXmda1yC4eecuwlCBN3nALjNElsGHJ
         LdOFzcyjsp11vfQ7nN9OD55d/SXm7o2U/mjqd3S+TrMWYnJ/Tl5iqGhBteqIMnvPoKcu
         L5FzmvlEbriFixGUyf7X3/RihoUZMf8jGHahY8xgu9/jtpHIaevngXsiraP1LvYoa9Y1
         rMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QuFy4+RxZbcf+rQ00t0+8usDtah2VdpWzHRkZ54Gxmc=;
        b=S6UZqa3Xmw1liK9xjXloW0RTjmMaSInNk4J6AFmnhXfmVHLnHE4yvixVQf3XTqkkTT
         3qYhpVwSeLrd653YV+MxiIEJ0/En5UDIKsch3THDp+g28WV2jS3TJcLloC65wjt2irl4
         hHGYzgAbg0Zfx7cAOgoHyIX3v0VSmqu4cvCU0obkmePG2JZQtV6GupCFhJheRknzSm/S
         t0jARuTjN015e5y3t0RuyILfdvb920P4Ty1bQaEVx+0BFh3WU0gZMZWHduY1+FXlSUrr
         8V8vHCIwSyPFXddYwsLhEt+6Uu5/h+3uUE7Iv76KsBdji5ZIfY50JKP/wrfJvfaMg9np
         wZ2A==
X-Gm-Message-State: AOPr4FX7W5OFxTDbVrZgNbWNgo3R3/2GiebyMkEzLVT8gH0DprZo1oeMwI70wR87KWw6Xpgh
X-Received: by 10.98.25.74 with SMTP id 71mr47043774pfz.94.1463421942040;
        Mon, 16 May 2016 11:05:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id a64sm48888112pfa.6.2016.05.16.11.05.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:41 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.gb49ffe6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294769>

Thanks Junio for the review!
Thanks Duy for suggestions to think about in the not-submodule case :)

* when invalid labels are found
  -> in the .gitattributes "warn and ignore"
  -> in command line args die(..)
* treat labels set to false as unset.
* fixes in documentation/ reworded the commit message

Thanks,
Stefan

diff to current origin/sb/pathspec-label (v2 of the series, so a lot):

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
index a1fc9e0..e264a58 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -362,11 +362,6 @@ glob;;
 	For example, "Documentation/{asterisk}.html" matches
 	"Documentation/git.html" but not "Documentation/ppc/ppc.html"
 	or "tools/perf/Documentation/perf.html".
-
-label:<white space separated list>;;
-	Labels can be assigned to pathspecs in the .gitattributes file.
-	By specifying a list of labels the pattern will match only
-	files which have all of the listed labels.
 +
 Two consecutive asterisks ("`**`") in patterns matched against
 full pathname may have special meaning:
@@ -389,6 +384,10 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
 
+label=<white space separated list>;;
+	Additionally to matching the pathspec, the path must have a 'label'
+	attribute having set all labels listed here.
+
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
 	through all exclude pathspec (magic signature: `!`). If it
diff --git a/attr.h b/attr.h
index f6fc7c3..8b08d33 100644
--- a/attr.h
+++ b/attr.h
@@ -18,7 +18,6 @@ extern const char git_attr__false[];
 #define ATTR_TRUE(v) ((v) == git_attr__true)
 #define ATTR_FALSE(v) ((v) == git_attr__false)
 #define ATTR_UNSET(v) ((v) == NULL)
-#define ATTR_CUSTOM(v) (!(ATTR_UNSET(v) || ATTR_FALSE(v) || ATTR_TRUE(v)))
 
 /*
  * Send one or more git_attr_check to git_check_attr(), and
diff --git a/dir.c b/dir.c
index 51d5965..fd39f92 100644
--- a/dir.c
+++ b/dir.c
@@ -209,25 +209,56 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
-void load_labels(const char *name, int namelen, struct string_list *list)
+static int has_all_labels(const char *name, int namelen,
+			   const struct string_list *required_labels)
 {
 	static struct git_attr *attr;
+
 	struct git_attr_check check;
-	char *path = xmemdupz(name, namelen);
+	char *path;
+	int ret;
 
 	if (!attr)
 		attr = git_attr("label");
 	check.attr = attr;
 
+	path = xmemdupz(name, namelen);
 	if (git_check_attr(path, 1, &check))
-		die("git_check_attr died");
-
-	if (ATTR_CUSTOM(check.value)) {
-		string_list_split(list, check.value, ',', -1);
-		string_list_sort(list);
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
 	}
 
 	free(path);
+
+	return ret;
 }
 
 #define DO_MATCH_EXCLUDE   1
@@ -285,14 +316,8 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
-	if (item->group) {
-		struct string_list has_labels = STRING_LIST_INIT_DUP;
-		struct string_list_item *si;
-		load_labels(name, namelen, &has_labels);
-		for_each_string_list_item(si, item->group)
-			if (!string_list_has_string(&has_labels, si->string))
-				return 0;
-	}
+	if (item->labels && !has_all_labels(name, namelen, item->labels))
+		return 0;
 
 	/* If the match was just the prefix, we matched */
 	if (!*match)
diff --git a/pathspec.c b/pathspec.c
index c227c25..2f053fb 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -88,13 +88,42 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
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
-	const char *out;
+	const char *body;
 	/* longhand */
 	const char *nextat;
 	for (copyfrom = elt + 2;
@@ -109,25 +138,24 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
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
 
-		if (skip_prefix(copyfrom, "label:", &out)) {
+		if (skip_prefix(copyfrom, "label=", &body)) {
 			struct strbuf sb = STRBUF_INIT;
-			size_t l = nextat - out;
-			strbuf_add(&sb, out, l);
-			if (!item->group) {
-				item->group = xmalloc(sizeof(*item->group));
-				string_list_init(item->group, 1);
-			}
-			string_list_split(item->group, sb.buf, ' ', -1);
-			string_list_remove_empty_items(item->group, 0);
+			strbuf_add(&sb, body, nextat - body);
+			if (!item->labels) {
+				item->labels = xmalloc(sizeof(*item->labels));
+				string_list_init(item->labels, 1);
+			} else
+				die(_("multiple labels not supported in pathspec magic"));
+			string_list_split(item->labels, sb.buf, ' ', -1);
+			string_list_remove_empty_items(item->labels, 0);
 			strbuf_release(&sb);
 			continue;
 		}
@@ -440,7 +468,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		unsigned short_magic;
 		entry = argv[i];
-		item[i].group = NULL;
+		item[i].labels = NULL;
 		item[i].magic = prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
@@ -462,6 +490,13 @@ void parse_pathspec(struct pathspec *pathspec,
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
@@ -519,9 +554,9 @@ void free_pathspec(struct pathspec *pathspec)
 {
 	int i;
 	for (i = 0; i < pathspec->nr; i++) {
-		if (pathspec->items[i].group)
-			string_list_clear(pathspec->items[i].group, 1);
-		free(pathspec->items[i].group);
+		if (pathspec->items[i].labels)
+			string_list_clear(pathspec->items[i].labels, 1);
+		free(pathspec->items[i].labels);
 	}
 
 	free(pathspec->items);
diff --git a/pathspec.h b/pathspec.h
index e3f7ebf..bf02931 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,7 +32,7 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
-		struct string_list *group;
+		struct string_list *labels;
 	} *items;
 };
 
@@ -99,5 +99,6 @@ extern char *find_pathspecs_matching_against_index(const struct pathspec *pathsp
 extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
 extern const char *check_path_for_gitlink(const char *path);
 extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
+extern int validate_label_name(const char *label);
 
 #endif /* PATHSPEC_H */
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
index 0c061ce..e2e4753 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -4,88 +4,155 @@ test_description='test labels in pathspecs'
 . ./test-lib.sh
 
 test_expect_success 'setup a tree' '
-	for p in file sub/file sub/sub/file sub/file2 sub/sub/sub/file sub2/file; do
-		if echo $p | grep /; then
-			mkdir -p $(dirname $p)
-		fi &&
+	mkdir sub &&
+	for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUnsetLabel fileSetLabel; do
 		: >$p &&
 		git add $p &&
-		git commit -m $p
+		: >sub/$p
+		git add sub/$p
 	done &&
-	git log --oneline --format=%s >actual &&
+	git commit -m $p &&
+	git ls-files >actual &&
 	cat <<EOF >expect &&
-sub2/file
-sub/sub/sub/file
-sub/file2
-sub/sub/file
-sub/file
-file
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
 EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'pathspec with labels and no .gitattributes exists' '
-	git ls-files ":(label:a)" >actual &&
+test_expect_success 'pathspec with no label and non existent .gitattributes' '
+	git ls-files ":(label=)" >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'pathspec with labels and non existent .gitattributes' '
+	git ls-files ":(label=a)" >actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'setup .gitattributes' '
-	cat <<-EOF >.gitattributes &&
-	/file label=b
-	sub/file label=a
-	sub/sub/* label=b,c
-	EOF
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
 	git add .gitattributes &&
 	git commit -m "add attributes"
 '
 
-test_expect_success 'check label' '
-	cat <<-EOF >expect &&
-	sub/file
-	EOF
-	git ls-files ":(label:a)" >actual &&
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
 	test_cmp expect actual
 '
 
-test_expect_success 'check label from label list' '
-	cat <<-EOF >expect &&
-	sub/sub/file
-	EOF
-	git ls-files ":(label:c)" >actual &&
+test_expect_success 'check label with 2 labels' '
+	cat <<EOF >expect &&
+fileAB
+fileSetLabel
+sub/fileAB
+sub/fileSetLabel
+EOF
+	git ls-files ":(label=labelA labelB)" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'check label with more labels' '
-	cat <<-EOF >expect &&
-	file
-	sub/sub/file
-	EOF
-	git ls-files ":(label:b)" >actual &&
-	test_cmp expect actual
+	test_must_fail git ls-files ":(label=labelA,label=labelB)" 2>actual &&
+	test_i18ngrep "not supported" actual
 '
 
 test_expect_success 'check label with more labels but excluded path' '
-	cat <<-EOF >expect &&
-	sub/sub/file
-	EOF
-	git ls-files ":(label:b)" ":(exclude)./file" >actual &&
+	cat <<EOF >expect &&
+fileAB
+fileB
+fileBC
+fileSetLabel
+EOF
+	git ls-files ":(label=labelB)" ":(exclude)sub/" >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'check label specifying more labels' '
-	cat <<-EOF >expect &&
-	sub/sub/file
-	EOF
-	git ls-files ":(label:b c)" >actual &&
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
 	test_cmp expect actual
 '
 
-test_expect_success 'check label specifying more labels' '
-	cat <<-EOF >expect &&
-	sub/file
-	sub/sub/file
-	EOF
-	git ls-files ":(label:b c)" ":(label:a)" >actual &&
+test_expect_success 'check for paths with no label' '
+	cat <<EOF >expect &&
+.gitattributes
+fileNoLabel
+sub/fileNoLabel
+EOF
+	git ls-files . ":(exclude,label=)" >actual &&
 	test_cmp expect actual
 '
+
 test_done



Stefan Beller (5):
  Documentation: fix a typo
  Documentation: correct typo in example for querying attributes
  pathspec: move long magic parsing out of prefix_pathspec
  pathspec: move prefix check out of the inner loop
  pathspec: record labels

 Documentation/gitattributes.txt               |  14 ++-
 Documentation/glossary-content.txt            |   4 +
 Documentation/technical/api-gitattributes.txt |   2 +-
 dir.c                                         |  56 +++++++++
 pathspec.c                                    | 144 ++++++++++++++++-------
 pathspec.h                                    |   2 +
 t/t6134-pathspec-with-labels.sh               | 158 ++++++++++++++++++++++++++
 7 files changed, 340 insertions(+), 40 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

-- 
2.8.2.401.gb49ffe6.dirty
