From: Stefan Beller <sbeller@google.com>
Subject: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Mon, 16 May 2016 20:13:53 -0700
Message-ID: <20160517031353.23707-5-sbeller@google.com>
References: <20160517031353.23707-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:15:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VTK-0007NJ-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbcEQDOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:14:24 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34622 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754514AbcEQDOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:14:10 -0400
Received: by mail-pa0-f45.google.com with SMTP id qo8so1640365pab.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AW4FGzs+MRpRyL1xpFaI2D9QcTqIbrVucryE4fOS+Po=;
        b=B+CJ9F+v/Xy6rO4IJc4QkB/tYXtvButHnVSerJzj/YW8XMeyR1ZT6gOJ7bbROX6KWs
         RAmbRJtmJfZnrz4hW9imyLXmR23XM7sflZyRUQzM7LqU+yhoHUde6EUJ/FV5yr3WTVWY
         uxoRt3a6l/92uNJ3+XN3tN2n8BOuvy7ymMyo5YH4T/aU/mNwhdvkcnLXEUJumW70LAAN
         OJiCAYqh/h0ym7A0gKqf0aurlmNpCWdzIgcAiYDPwxs+H7B6y4xUgKDbGAIFQ/ZU3mnr
         3AQz5q10ckS0bR+7Q6bw62GCjDMTzcgrGlmLd1VMpybDWr3u2ih8zKSV18qKXMwRayhi
         OVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AW4FGzs+MRpRyL1xpFaI2D9QcTqIbrVucryE4fOS+Po=;
        b=JWbesBJw7SLLaglNzefxrRKoVtm9Gev0MrFAdSAZWtWW2KLcMIFb7a4NO5dOy3Y0cO
         PYZv1gleM+EMU+bpMtB5u1mdhYYzZB1Mfa1X+bJ1GSFZFZb8/Dba0nwAJGYN64/4QPRe
         fUI14pWq7TDslij8UAiYMOwhMxtWjxXguDgoHI2Ixk8tw3x7KCxmwX3ODLiGbOIOsjW4
         RkGD6wQAjDFORePToH6P4VZ7asbKEVLRet6xtVZyi2YT6pJnCZV6FbZAurZiDTsKyqk9
         XfTp7y25AJX7XwArN9yq4+5Nre6pslp3n5+YYgyFEl5CsixNREA0kAux7QAd/Ot8SPo0
         K48w==
X-Gm-Message-State: AOPr4FW/2dnkXthm746GobwVhe51C81Ph7mUoNqLwyJaKGrn0BJ/dLn3R9QZaCFRi5iIltk+
X-Received: by 10.66.149.166 with SMTP id ub6mr5303884pab.21.1463454844199;
        Mon, 16 May 2016 20:14:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id c190sm505683pfb.33.2016.05.16.20.14.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:14:03 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
In-Reply-To: <20160517031353.23707-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294838>

The pathspec mechanism is extended via the new
":(attr:eol=input)pattern/to/match" syntax to filter paths so that it
requires paths to not just match the given pattern but also have the
specified attrs attached for them to be chosen.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c     |  2 +-
 attr.h     |  2 ++
 dir.c      | 49 +++++++++++++++++++++++++++++++++
 pathspec.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 pathspec.h | 16 +++++++++++
 5 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 5178eb8..2d68a3c 100644
--- a/attr.c
+++ b/attr.c
@@ -59,7 +59,7 @@ static unsigned hash_name(const char *name, int namelen)
 	return val;
 }
 
-static int invalid_attr_name(const char *name, int namelen)
+int invalid_attr_name(const char *name, int namelen)
 {
 	/*
 	 * Attribute name cannot begin with '-' and must consist of
diff --git a/attr.h b/attr.h
index 7dc49f8..7fd8b90 100644
--- a/attr.h
+++ b/attr.h
@@ -45,6 +45,8 @@ extern void git_attr_check_append(struct git_attr_check *, const char *);
 extern void git_attr_check_clear(struct git_attr_check *);
 extern void git_attr_check_free(struct git_attr_check *);
 
+extern int invalid_attr_name(const char *name, int namelen);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
diff --git a/dir.c b/dir.c
index 996653b..540ea1f 100644
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
@@ -215,6 +216,51 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
+static struct git_attr_check *check;
+static int match_attrs(const char *name, int namelen,
+		       const struct pathspec_item *item)
+{
+	char *path;
+	int i;
+
+	if (!check) {
+		check = git_attr_check_alloc();
+		for (i = 0; i < item->attr_nr; i++)
+			git_attr_check_append(check, item->attrs[i].attr);
+	}
+
+	path = xmemdupz(name, namelen);
+	git_all_attrs(path, check);
+
+	for (i = 0; i < item->attr_nr; i++) {
+		int matched;
+		const char *value = check->check[i].value;
+
+		if (ATTR_TRUE(value)) {
+			matched = (item->attrs[i].mode == MATCH_SET ||
+				   item->attrs[i].mode == MATCH_NOT_UNSPECIFIED);
+		} else if (ATTR_FALSE(value)) {
+			matched = (item->attrs[i].mode == MATCH_UNSET ||
+				   item->attrs[i].mode == MATCH_NOT_UNSPECIFIED);
+		} else if (ATTR_UNSET(value)) {
+			matched = (item->attrs[i].mode == MATCH_UNSPECIFIED);
+		} else {
+			if (item->attrs[i].mode == MATCH_NOT_UNSPECIFIED) {
+				matched = 1;
+			} else {
+				/* NEEDSWORK: better value matching */
+				matched = !strcmp(item->attrs[i].value, value);
+			}
+		}
+		if (!matched)
+			return 0;
+	}
+
+	free(path);
+
+	return 1;
+}
+
 #define DO_MATCH_EXCLUDE   1
 #define DO_MATCH_DIRECTORY 2
 
@@ -270,6 +316,9 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
+	if (item->attr_nr && !match_attrs(name, namelen, item))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
diff --git a/pathspec.c b/pathspec.c
index 4dff252..523ac8c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "attr.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -88,12 +89,73 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+/*
+ * Check if the given string is a good specification to search for attributes.
+ * Accepted strings:
+ * [+-!] ATTRIBUTE_NAME [= <space separated list of values> ]
+ *
+ * Examples:
+ * attr:+val to find value set to true
+ * attr:-val to find a value set to false
+ * attr:!val to find a value that is not set
+ *     (i.e. it is neither set as "val", "val=<empty>", nor unset as "-val")
+ * attr:val=value: to find value that have at least a and b set.
+ *
+ * This only checks one attr, multiple attrs need to be given as multiple
+ * strings.
+ */
+
+static void parse_attr_item(struct attr_item *attr, const char *value)
+{
+	size_t val_len;
+	const char *val = value;
+
+	if (!val || !strlen(val))
+		goto out;
+
+	if (val[0] == '+')
+		attr->mode = MATCH_SET;
+	else if (val[0] == '-')
+		attr->mode = MATCH_UNSET;
+	else if (val[0] == '!')
+		attr->mode = MATCH_UNSPECIFIED;
+	else
+		attr->mode = NOT_INIT;
+
+	if (attr->mode != NOT_INIT)
+		val++;
+
+	val_len = strcspn(val, "=,)");
+	if (val[val_len] == '=')
+		attr->mode = MATCH_VALUE;
+	else
+		attr->mode = MATCH_NOT_UNSPECIFIED;
+
+	if (invalid_attr_name(val, val_len))
+		goto out;
+
+	attr->attr = xmemdupz(val, val_len);
+
+	if (attr->mode == MATCH_VALUE) {
+		const char *after_equal = val + val_len + 1;
+		size_t after_equal_end = strcspn(after_equal, ",)");
+		attr->value = xmemdupz(after_equal, after_equal_end);
+	} else
+		attr->value = NULL;
+	return;
+out:
+	attr->mode = INVALID_ATTR;
+	warning(_("attr spec '%s': attrs must not start with '-' and "
+		  "be composed of [-A-Za-z0-9_.]."), value);
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
@@ -108,15 +170,20 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
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
+			ALLOC_GROW(item->attrs, item->attr_nr + 1, item->attr_alloc);
+			parse_attr_item(&item->attrs[item->attr_nr++], body);
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
@@ -425,7 +492,9 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		unsigned short_magic;
 		entry = argv[i];
-
+		item[i].attrs = NULL;
+		item[i].attr_nr = 0;
+		item[i].attr_alloc = 0;
 		item[i].magic = prefix_pathspec(item + i, &short_magic,
 						argv + i, flags,
 						prefix, prefixlen, entry);
@@ -447,6 +516,13 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard = 1;
 		pathspec->magic |= item[i].magic;
+
+		if (item[i].attr_nr) {
+			int j;
+			for (j = 0; j < item[i].attr_nr; j++)
+				if (item[i].attrs[j].mode == INVALID_ATTR)
+					die(_("attribute spec in the wrong syntax are prohibited."));
+		}
 	}
 
 	if (nr_exclude == n)
@@ -502,6 +578,15 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 void free_pathspec(struct pathspec *pathspec)
 {
+	int i, j;
+	for (i = 0; i < pathspec->nr; i++) {
+		for (j = 0; j < pathspec->items[j].attr_nr; j++) {
+			free(pathspec->items[i].attrs[j].attr);
+			free(pathspec->items[i].attrs[j].value);
+		}
+		free(pathspec->items[i].attrs);
+	}
+
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
diff --git a/pathspec.h b/pathspec.h
index 0c11262..89d73db 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,21 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
+		int attr_nr;
+		int attr_alloc;
+		struct attr_item {
+			char *attr;
+			char *value;
+			enum attr_match_mode {
+				NOT_INIT,
+				MATCH_SET,
+				MATCH_UNSET,
+				MATCH_VALUE,
+				MATCH_UNSPECIFIED,
+				MATCH_NOT_UNSPECIFIED,
+				INVALID_ATTR
+			} mode;
+		} *attrs;
 	} *items;
 };
 
@@ -98,5 +113,6 @@ extern char *find_pathspecs_matching_against_index(const struct pathspec *pathsp
 extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
 extern const char *check_path_for_gitlink(const char *path);
 extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
+extern int validate_label_name(const char *label);
 
 #endif /* PATHSPEC_H */
-- 
2.8.2.401.g9c0faef
