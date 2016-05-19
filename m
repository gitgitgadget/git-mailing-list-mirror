From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 0/4] pathspec magic extension to search for attributes
Date: Thu, 19 May 2016 16:23:19 -0700
Message-ID: <20160519232323.12775-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 20 01:23:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3XHx-0005kO-Tu
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbcESXX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 19:23:29 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34944 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbcESXX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:23:28 -0400
Received: by mail-pf0-f172.google.com with SMTP id b66so13926819pfb.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/azijPKqmvu4HZ8newnRsfx8l9mys4Ir7M73Yq1kp4=;
        b=jWLsA/ImZ/+8Q7XEmzuWLBXvkUZ753j8dF4tGz9gq+Y96FfOif29YAI+ggU4T92TGd
         ziFQZws6r3k3EvXgZY5yozZYuC1umRwvnpe1I5pESnjr2l3V0DTzz/t9iCDp9D393t6/
         rPhS9I2VLV92OO2pQdCjDbpCmShEaXaTx24svAx7JCh+nJPYSaGXVLIR8ARG4XGearqy
         OZx+Y4IkIrSRGZOQsk+fkNq2S07qr66MevZJ4wQnxKKSFUglEcg+BrSYw6GW1dYMsTxO
         4WSgcHrZ8NnvGvtE4pDhjW42gaqey2vuTuvylOObRmmM9CGGIs+kUvECVMNfG58rebI1
         /rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/azijPKqmvu4HZ8newnRsfx8l9mys4Ir7M73Yq1kp4=;
        b=Kn5K7BJz8brAyGy5/lOa2gKG3DbDRUL4UDF88ViJyGttafI4a7cZC+Ozboekm0cjP0
         ka8qzXM40oxdmb+MF1vhxSVRsK4kQwLGTpiaV5owURhhhwlywpB8aavgCvNGDvPFn32i
         no7p4hA30haoll6srqyNDRVFOGNYKuk7LE20NzV8Sm8rAb7AWhcu2MZC/kxrfDihKOkK
         zrwSUccTafpz61KrNpNbYTzt2q8tc2LzjoXE9kJQ0BiUOK8Vm91rUGZzmMYB5tB2arm/
         ya5Lk+gFLwC5Hg3nUs75CtA1Y+do+5ceHLon57vnbzpLP+nUFHorb4TSV+k+W45bwWKX
         21pQ==
X-Gm-Message-State: AOPr4FXvu8O6ODogj0fjKLOm5G1LsCZCSX3334EtI5xRNpSbBWJo7Remml8+2A++FAHxoBkL
X-Received: by 10.98.31.65 with SMTP id f62mr23764656pff.83.1463700207816;
        Thu, 19 May 2016 16:23:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:acf4:8121:b728:8fc4])
        by smtp.gmail.com with ESMTPSA id z17sm22276775pfi.61.2016.05.19.16.23.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 16:23:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.gb4ad9b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295131>

This goes on top of origin/jc/attr, (396bf756f95, attr: expose validity=
 check
for attribute names)

Patches 1 is a small fix, which could go independently as well.
I dropped the patch "string list: improve comment"
Patches 3 and 4 are refactoring pathspec.c a little.
These did not change since v7

Patch 5 contains all of Junios suggestions.

Thanks,
Stefan

diff to v8:
diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index aa9f220..e06520b 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -385,20 +385,23 @@ full pathname may have special meaning:
 Glob magic is incompatible with literal magic.
=20
 attr;;
-	Additionally to matching the pathspec, the path must have the
-	attribute as specified. The syntax for specifying the required
-	attributes is "`attr: [mode] <attribute name> [=3Dvalue]`"
-+
-Attributes can have 4 states (Set, Unset, Set to a value, unspecified)=
 and
-you can query each attribute for certain states. The "`[mode]`" is a s=
pecial
-character to indicate which attribute states are looked for. The follo=
wing
-modes are available:
-
- - an empty "`[mode]`" matches if the attribute is set
- - "`-`" the attribute must be unset
- - "`!`" the attribute must be unspecified
- - an empty "`[mode]`" combined with "`[=3Dvalue]`" matches if the att=
ribute has
-   the given value.
+After `attr:` comes a space separated list of "attribute
+requirements", all of which must be met in order for the
+path to be considered a match; this is in addition to the
+usual non-magic pathspec pattern matching.
+
+Each of the attribute requirements for the path takes one of
+these forms:
+
+- "`ATTR`" requires that the attribute `ATTR` must be set.
+
+- "`-ATTR`" requires that the attribute `ATTR` must be unset.
+
+- "`ATTR=3DVALUE`" requires that the attribute `ATTR` must be
+  set to the string `VALUE`.
+
+- "`!ATTR`" requires that the attribute `ATTR` must be
+  unspecified.
 +
=20
 exclude;;
diff --git a/dir.c b/dir.c
index f60a503..fc071af 100644
--- a/dir.c
+++ b/dir.c
@@ -231,11 +231,11 @@ static int match_attrs(const char *name, int name=
len,
 		match_mode =3D item->attr_match[i].match_mode;
=20
 		if (ATTR_TRUE(value))
-			matched =3D match_mode =3D=3D MATCH_SET;
+			matched =3D (match_mode =3D=3D MATCH_SET);
 		else if (ATTR_FALSE(value))
-			matched =3D match_mode =3D=3D MATCH_UNSET;
+			matched =3D (match_mode =3D=3D MATCH_UNSET);
 		else if (ATTR_UNSET(value))
-			matched =3D match_mode =3D=3D MATCH_UNSPECIFIED;
+			matched =3D (match_mode =3D=3D MATCH_UNSPECIFIED);
 		else
 			matched =3D (match_mode =3D=3D MATCH_VALUE &&
 				   !strcmp(item->attr_match[i].value, value));
diff --git a/pathspec.c b/pathspec.c
index b795a9c..693a5e7 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -115,34 +115,38 @@ static void parse_pathspec_attr_match(struct path=
spec_item *item, const char *va
 		const char *attr =3D si->string;
 		struct attr_match *am =3D &item->attr_match[j];
=20
-		if (attr[0] =3D=3D '!')
+		attr_len =3D strcspn(attr, "=3D");
+		switch (*attr) {
+		case '!':
 			am->match_mode =3D MATCH_UNSPECIFIED;
-		else if (attr[0] =3D=3D '-')
+			attr++;
+			attr_len--;
+			break;
+		case '-':
 			am->match_mode =3D MATCH_UNSET;
-		else
-			am->match_mode =3D MATCH_SET;
-
-		if (am->match_mode !=3D MATCH_SET)
-			/* skip first character */
 			attr++;
+			attr_len--;
+			break;
+		default:
+			if (attr[attr_len] !=3D '=3D')
+				am->match_mode =3D MATCH_SET;
+			else {
+				am->match_mode =3D MATCH_VALUE;
+				am->value =3D xstrdup(&attr[attr_len + 1]);
+				if (strchr(am->value, '\\'))
+					die(_("attr spec values must not contain backslashes"));
+			}
+			break;
+		}
=20
-		attr_len =3D strcspn(attr, "=3D");
-		if (attr[attr_len] =3D=3D '=3D') {
-			am->match_mode =3D MATCH_VALUE;
-			am->value =3D xstrdup(&attr[attr_len + 1]);
-			if (strchr(am->value, '\\'))
-				die(_("attr spec values must not contain backslashes"));
-		} else
-			am->value =3D NULL;
-
-		if (!attr_name_valid(attr, attr_len)) {
+		am->attr =3D git_attr_counted(attr, attr_len);
+		if (!am->attr) {
 			struct strbuf sb =3D STRBUF_INIT;
 			am->match_mode =3D INVALID_ATTR;
 			invalid_attr_name_message(&sb, attr, attr_len);
 			die(_("invalid attribute in '%s': '%s'"), value, sb.buf);
 		}
=20
-		am->attr =3D git_attr_counted(attr, attr_len);
 		git_attr_check_append(item->attr_check, am->attr);
 	}
=20
diff --git a/string-list.h b/string-list.h
index 465a1f0..d3809a1 100644
--- a/string-list.h
+++ b/string-list.h
@@ -106,7 +106,7 @@ void unsorted_string_list_delete_item(struct string=
_list *list, int i, int free_
  * list->strdup_strings must be set, as new memory needs to be
  * allocated to hold the substrings.  If maxsplit is non-negative,
  * then split at most maxsplit times.  Return the number of substrings
- * appended to list. The list may be non-empty already.
+ * appended to list.
  *
  * Examples:
  *   string_list_split(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "b=
az"]
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-la=
bels.sh
index c0d8cda..5da1a63 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -4,39 +4,38 @@ test_description=3D'test labels in pathspecs'
 . ./test-lib.sh
=20
 test_expect_success 'setup a tree' '
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
 	mkdir sub &&
-	for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUnset=
Label fileSetLabel fileValue fileWrongLabel; do
-		: >$p &&
-		git add $p &&
-		: >sub/$p
-		git add sub/$p
-	done &&
-	git commit -m $p &&
+	while read path
+	do
+		: >$path &&
+		git add $path || return 1
+	done <expect &&
+	git commit -m "initial commit" &&
 	git ls-files >actual &&
-	cat <<EOF >expect &&
-fileA
-fileAB
-fileAC
-fileB
-fileBC
-fileC
-fileNoLabel
-fileSetLabel
-fileUnsetLabel
-fileValue
-fileWrongLabel
-sub/fileA
-sub/fileAB
-sub/fileAC
-sub/fileB
-sub/fileBC
-sub/fileC
-sub/fileNoLabel
-sub/fileSetLabel
-sub/fileUnsetLabel
-sub/fileValue
-sub/fileWrongLabel
-EOF
 	test_cmp expect actual
 '
=20
@@ -51,47 +50,45 @@ test_expect_success 'pathspec with labels and non e=
xistent .gitattributes' '
 '
=20
 test_expect_success 'setup .gitattributes' '
-	cat <<EOF >.gitattributes &&
-fileA labelA
-fileB labelB
-fileC labelC
-fileAB labelA labelB
-fileAC labelA labelC
-fileBC labelB labelC
-fileUnsetLabel -label
-fileSetLabel label
-fileValue label=3Dfoo
-fileWrongLabel label=E2=98=BA
-EOF
+	cat <<-EOF >.gitattributes &&
+	fileA labelA
+	fileB labelB
+	fileC labelC
+	fileAB labelA labelB
+	fileAC labelA labelC
+	fileBC labelB labelC
+	fileUnsetLabel -label
+	fileSetLabel label
+	fileValue label=3Dfoo
+	fileWrongLabel label=E2=98=BA
+	EOF
 	git add .gitattributes &&
 	git commit -m "add attributes"
 '
=20
-sq=3D"'"
-
 test_expect_success 'check specific set attr' '
-	cat <<EOF >expect &&
-fileSetLabel
-sub/fileSetLabel
-EOF
+	cat <<-EOF >expect &&
+	fileSetLabel
+	sub/fileSetLabel
+	EOF
 	git ls-files ":(attr:label)" >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'check specific unset attr' '
-	cat <<EOF >expect &&
-fileUnsetLabel
-sub/fileUnsetLabel
-EOF
+	cat <<-EOF >expect &&
+	fileUnsetLabel
+	sub/fileUnsetLabel
+	EOF
 	git ls-files ":(attr:-label)" >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'check specific value attr' '
-	cat <<EOF >expect &&
-fileValue
-sub/fileValue
-EOF
+	cat <<-EOF >expect &&
+	fileValue
+	sub/fileValue
+	EOF
 	git ls-files ":(attr:label=3Dfoo)" >actual &&
 	test_cmp expect actual &&
 	git ls-files ":(attr:label=3Dbar)" >actual &&
@@ -99,61 +96,61 @@ EOF
 '
=20
 test_expect_success 'check unspecified attr' '
-	cat <<EOF >expect &&
-.gitattributes
-fileA
-fileAB
-fileAC
-fileB
-fileBC
-fileC
-fileNoLabel
-fileWrongLabel
-sub/fileA
-sub/fileAB
-sub/fileAC
-sub/fileB
-sub/fileBC
-sub/fileC
-sub/fileNoLabel
-sub/fileWrongLabel
-EOF
-	git ls-files :\(attr:\!label\) >actual &&
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
 	test_cmp expect actual
 '
=20
 test_expect_success 'check multiple unspecified attr' '
-	cat <<EOF >expect &&
-.gitattributes
-fileC
-fileNoLabel
-fileWrongLabel
-sub/fileC
-sub/fileNoLabel
-sub/fileWrongLabel
-EOF
-	git ls-files :\(attr:\!labelB\ \!labelA\ \!label\) >actual &&
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
 	test_cmp expect actual
 '
=20
 test_expect_success 'check label with more labels but excluded path' '
-	cat <<EOF >expect &&
-fileAB
-fileB
-fileBC
-EOF
+	cat <<-EOF >expect &&
+	fileAB
+	fileB
+	fileBC
+	EOF
 	git ls-files ":(attr:labelB)" ":(exclude)sub/" >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'check label excluding other labels' '
-	cat <<EOF >expect &&
-fileAB
-fileB
-fileBC
-sub/fileAB
-sub/fileB
-EOF
+	cat <<-EOF >expect &&
+	fileAB
+	fileB
+	fileBC
+	sub/fileAB
+	sub/fileB
+	EOF
 	git ls-files ":(attr:labelB)" ":(exclude,attr:labelC)sub/" >actual &&
 	test_cmp expect actual
 '
