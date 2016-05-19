From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Wed, 18 May 2016 18:09:30 -0700
Message-ID: <20160519010935.27856-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 03:09:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3CTG-000541-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbcESBJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:09:46 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32790 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbcESBJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:09:45 -0400
Received: by mail-pf0-f175.google.com with SMTP id 206so24191565pfu.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Bnb82nWEDkQM0hqP/aEpw4j0XWsPqhkStnfbauiUIQg=;
        b=nJFjxXv3QPFuXtgGfnfa7Gt+reLKQyxiQezgEQa/+AL9e/3HEnp841U6NQ9x7C59iq
         LTzJjdge3vhtA+82LF3AdbLiYLx9PjdkoLGT+rZ/ss0+nnYw2mqQjsJDjkySW/hZJ7f2
         xlLQgtIMZEaxVvCdGw5i63q38QaepsJmKXtJJEnLcY61ZAq7dxdJN29EuKn8M2DA/BF2
         kS2P1QHvkQcBKHr40pBVXu8NtDIJO4MOnkFP4fOulhVd2CPBG9LMoaTlBxE3I3rJ5urh
         +zaHA7ZfXUR6DrPsnRyUU+ql6m2pHnUJh9DW01+CKdKq0mOugqeCZPeuo9oedd70D5dV
         CzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bnb82nWEDkQM0hqP/aEpw4j0XWsPqhkStnfbauiUIQg=;
        b=Zky3rDwPkXg+xV5o2HRwKykqp7c4HpYkjHkXkK5t1RkYSlaZuhV0kuA/inMA6SRkR5
         GF56E+1+DmD51RIl3LSX3tf4zUgskVfFp5YlbQYL2/8lmuw/S2e11mU2TuS82/jKQyLC
         MPiMt0p7bLZbOlpx2zxNlfizVU21AOKO8r+SjUC1psuRnuZKChOGiA1NZLVZOdjn648z
         ca3Elbz07FBPlNYpO1IqS4TJxYznuohGJGgbCm5L9XXu2QNXzEBp4iO0F0e/6SMwk89k
         FEZDvUSUVzUeZAjepMp2zaY9Q4h/ra1N2cJ+FdA7TI0XPwKeYCbrx0XC8VE5DpJrOkAI
         1LNw==
X-Gm-Message-State: AOPr4FWW2llRiVWcDL2d5mkoy2L8A3SJdHcj0kvnOKONkRjBW/kfSX/xyNWHOG6q3lEwUeAZ
X-Received: by 10.98.54.193 with SMTP id d184mr15365949pfa.59.1463620184275;
        Wed, 18 May 2016 18:09:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id q20sm14957227pfa.90.2016.05.18.18.09.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 18:09:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.g3bde101
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295035>

This goes on top of origin/jc/attr, (396bf756f95, attr: expose validity check
for attribute names)

Patches 1 and 2 are small fixes, which could go independently as well.
Patches 3 and 4 are refactoring pathspec.c a little.
These did not change since v7


diff to v7:
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 866e8d8..aa9f220 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -394,11 +394,9 @@ you can query each attribute for certain states. The "`[mode]`" is a special
 character to indicate which attribute states are looked for. The following
 modes are available:

- - "`+`" the attribute must be set
+ - an empty "`[mode]`" matches if the attribute is set
  - "`-`" the attribute must be unset
- - "`~`" the attribute must be unspecified
- - "`?`" the attribute must not be unspecified, i.e. set, unset or value matches
- - an empty "`[mode]`" matches if the attribute is set or has a value
+ - "`!`" the attribute must be unspecified
  - an empty "`[mode]`" combined with "`[=value]`" matches if the attribute has
    the given value.
 +
diff --git a/dir.c b/dir.c
index 3141a5a..f60a503 100644
--- a/dir.c
+++ b/dir.c
@@ -219,42 +219,31 @@ int within_depth(const char *name, int namelen,
 static int match_attrs(const char *name, int namelen,
 		       const struct pathspec_item *item)
 {
-	char *path;
 	int i;

-	path = xmemdupz(name, namelen);
-	git_check_attr(path, item->attr_check);
-
+	git_check_attr_counted(name, namelen, item->attr_check);
 	for (i = 0; i < item->attr_match_nr; i++) {
 		const char *value;
 		int matched;
 		enum attr_match_mode match_mode;

 		value = item->attr_check->check[i].value;
-
 		match_mode = item->attr_match[i].match_mode;

-		if (ATTR_TRUE(value)) {
-			matched = match_mode == MATCH_SET ||
-				  match_mode == MATCH_SET_OR_VALUE ||
-				  match_mode == MATCH_NOT_UNSPECIFIED;
-		} else if (ATTR_FALSE(value)) {
-			matched = match_mode == MATCH_UNSET ||
-				  match_mode == MATCH_NOT_UNSPECIFIED;
-		} else if (ATTR_UNSET(value)) {
+		if (ATTR_TRUE(value))
+			matched = match_mode == MATCH_SET;
+		else if (ATTR_FALSE(value))
+			matched = match_mode == MATCH_UNSET;
+		else if (ATTR_UNSET(value))
 			matched = match_mode == MATCH_UNSPECIFIED;
-		} else {
-			matched = match_mode == MATCH_NOT_UNSPECIFIED ||
-				  match_mode == MATCH_SET_OR_VALUE ||
-				  (match_mode == MATCH_VALUE &&
+		else
+			matched = (match_mode == MATCH_VALUE &&
 				   !strcmp(item->attr_match[i].value, value));
-		}
+
 		if (!matched)
 			return 0;
 	}

-	free(path);
-
 	return 1;
 }

diff --git a/pathspec.c b/pathspec.c
index 32fb6a8..b795a9c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -96,66 +96,58 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va


 	if (!value || !strlen(value))
-		goto err;
+		die(_("attr spec must not be empty"));

 	string_list_split(&list, value, ' ', -1);
 	string_list_remove_empty_items(&list, 0);

 	if (!item->attr_check)
 		item->attr_check = git_attr_check_alloc();
+	else
+		die(_("Only one 'attr:' specification is allowed."));

 	ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->attr_match_alloc);

 	for_each_string_list_item(si, &list) {
-		size_t val_len;
+		size_t attr_len;

 		int j = item->attr_match_nr++;
-		const char *val = si->string;
+		const char *attr = si->string;
 		struct attr_match *am = &item->attr_match[j];

-		if (val[0] == '?')
-			am->match_mode = MATCH_NOT_UNSPECIFIED;
-		else if (val[0] == '~')
+		if (attr[0] == '!')
 			am->match_mode = MATCH_UNSPECIFIED;
-		else if (val[0] == '+')
-			am->match_mode = MATCH_SET;
-		else if (val[0] == '-')
+		else if (attr[0] == '-')
 			am->match_mode = MATCH_UNSET;
 		else
-			am->match_mode = MATCH_SET_OR_VALUE;
+			am->match_mode = MATCH_SET;

-		if (am->match_mode != MATCH_SET_OR_VALUE)
+		if (am->match_mode != MATCH_SET)
 			/* skip first character */
-			val++;
+			attr++;

-		val_len = strcspn(val, "=,)");
-		if (val[val_len] == '=') {
+		attr_len = strcspn(attr, "=");
+		if (attr[attr_len] == '=') {
 			am->match_mode = MATCH_VALUE;
-			am->value = xstrdup(&val[val_len + 1]);
-			/*
-			 * NEEDSWORK:
-			 * Do we want to allow escaped commas to search
-			 * for comma separated values?
-			 */
+			am->value = xstrdup(&attr[attr_len + 1]);
 			if (strchr(am->value, '\\'))
 				die(_("attr spec values must not contain backslashes"));
 		} else
 			am->value = NULL;

-		if (invalid_attr_name(val, val_len)) {
+		if (!attr_name_valid(attr, attr_len)) {
+			struct strbuf sb = STRBUF_INIT;
 			am->match_mode = INVALID_ATTR;
-			goto err;
+			invalid_attr_name_message(&sb, attr, attr_len);
+			die(_("invalid attribute in '%s': '%s'"), value, sb.buf);
 		}

-		am->attr = git_attr(xmemdupz(val, val_len));
+		am->attr = git_attr_counted(attr, attr_len);
 		git_attr_check_append(item->attr_check, am->attr);
 	}

 	string_list_clear(&list, 0);
 	return;
-err:
-	die(_("attr spec '%s': attrs must not start with '-' and "
-	      "be composed of [-A-Za-z0-9_.]."), value);
 }

 static void eat_long_magic(struct pathspec_item *item, const char *elt,
@@ -188,9 +180,9 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 		}

 		if (skip_prefix(copyfrom, "attr:", &body)) {
-			char *pass = xmemdupz(body, len - strlen("attr:"));
-			parse_pathspec_attr_match(item, pass);
-			free(pass);
+			char *attr_body = xmemdupz(body, len - strlen("attr:"));
+			parse_pathspec_attr_match(item, attr_body);
+			free(attr_body);
 			continue;
 		}

@@ -591,6 +583,8 @@ void free_pathspec(struct pathspec *pathspec)
 {
 	int i, j;
 	for (i = 0; i < pathspec->nr; i++) {
+		if (!pathspec->items[i].attr_match_nr)
+			continue;
 		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
 			free(pathspec->items[i].attr_match[j].value);
 		free(pathspec->items[i].attr_match);
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
index 35b3ab2..c0d8cda 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -74,7 +74,7 @@ test_expect_success 'check specific set attr' '
 fileSetLabel
 sub/fileSetLabel
 EOF
-	git ls-files ":(attr:+label)" >actual &&
+	git ls-files ":(attr:label)" >actual &&
 	test_cmp expect actual
 '

@@ -98,52 +98,41 @@ EOF
 	test_must_be_empty actual
 '

-test_expect_success 'check set or value attr' '
-	cat <<EOF >expect &&
-fileSetLabel
-fileValue
-sub/fileSetLabel
-sub/fileValue
-EOF
-	git ls-files ":(attr:label)" >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'check unspecified attr' '
 	cat <<EOF >expect &&
 .gitattributes
+fileA
+fileAB
+fileAC
+fileB
+fileBC
 fileC
 fileNoLabel
 fileWrongLabel
+sub/fileA
+sub/fileAB
+sub/fileAC
+sub/fileB
+sub/fileBC
 sub/fileC
 sub/fileNoLabel
 sub/fileWrongLabel
 EOF
-	git ls-files ":(attr:~label,attr:~labelA,attr:~labelB)" >actual &&
+	git ls-files :\(attr:\!label\) >actual &&
 	test_cmp expect actual
 '

-test_expect_success 'check not unspecified attr' '
+test_expect_success 'check multiple unspecified attr' '
 	cat <<EOF >expect &&
-fileSetLabel
-fileUnsetLabel
-fileValue
-sub/fileSetLabel
-sub/fileUnsetLabel
-sub/fileValue
-EOF
-	git ls-files ":(attr:?label)" >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'check label with 2 labels' '
-	cat <<EOF >expect &&
-fileAB
-sub/fileAB
+.gitattributes
+fileC
+fileNoLabel
+fileWrongLabel
+sub/fileC
+sub/fileNoLabel
+sub/fileWrongLabel
 EOF
-	git ls-files ":(attr:labelA labelB)" >actual &&
-	test_cmp expect actual &&
-	git ls-files ":(attr:labelA,attr:labelB)" >actual &&
+	git ls-files :\(attr:\!labelB\ \!labelA\ \!label\) >actual &&
 	test_cmp expect actual
 '
