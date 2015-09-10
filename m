From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 00/14] port tag.c to use ref-filter APIs
Date: Thu, 10 Sep 2015 21:18:16 +0530
Message-ID: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:48:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za45N-0004qs-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 17:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbbIJPsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 11:48:25 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36433 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbbIJPsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 11:48:24 -0400
Received: by padhk3 with SMTP id hk3so46297051pad.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vIjlCePSrMB4+eFsP/8uGJxPwCXysEtFeG+tF10w7u0=;
        b=fEr1OH9Y5uG9rzBMwMo0J8OT9VMCbvIrhCi96cMXPe9tzKjEXDR5WyEPIBgS7yBtRd
         tGBybPvMHGMNp+E7wDP5cjW7Y1n2AWVWyj+GD6NC4XNIbF5+PVUvHXltBl3jaMYq4TQq
         1knoZO9j5icbEt3BbPxbQx8VXQXo/TayzVKgWSo85KCSHa/acjQgq2Be/lbqwSELahch
         eaaObseQM9sOkEozXnrdVYeqtRF2TdOxF/Cq5KwtwK0rmT9waaFZm/4Nli1HnOWlgB8S
         i4fKyxDbXa3aSmJg9VipDTn3PoUPLWUbYe/K4iQScPZ41UMXfLBRgC5brI2R/J6wS7MR
         W6DA==
X-Received: by 10.67.12.196 with SMTP id es4mr37159171pad.83.1441900103646;
        Thu, 10 Sep 2015 08:48:23 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ts1sm12738918pbc.74.2015.09.10.08.48.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Sep 2015 08:48:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277583>

This is part of the series of unifying the code used by
"git tag -l, git branch -l, git for-each-ref".

The previous version can be found here (version 16):
article.gmane.org/gmane.comp.version-control.git/277394

Changes in this version:
* The arguments of the %(align) atom are interchangeable.
* Small grammatical changes.
* Small changes in the tests to reflect changes in the align
atom code.

Karthik Nayak (14):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: introduce ref_formatting_state and ref_formatting_stack
  utf8: add function to align a string into given strbuf
  ref-filter: introduce handler function for each atom
  ref-filter: introduce match_atom_name()
  ref-filter: implement an `align` atom
  ref-filter: add option to filter out tags, branches and remotes
  ref-filter: add support for %(contents:lines=X)
  ref-filter: add support to sort by version
  ref-filter: add option to match literal pattern
  tag.c: use 'ref-filter' data structures
  tag.c: use 'ref-filter' APIs
  tag.c: implement '--format' option
  tag.c: implement '--merged' and '--no-merged' options

 Documentation/git-for-each-ref.txt |  17 +-
 Documentation/git-tag.txt          |  27 ++-
 builtin/for-each-ref.c             |   1 +
 builtin/tag.c                      | 369 ++++++---------------------------
 ref-filter.c                       | 412 ++++++++++++++++++++++++++++++++-----
 ref-filter.h                       |  25 ++-
 refs.c                             |   9 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     | 174 ++++++++++++++++
 t/t7004-tag.sh                     |  47 ++++-
 utf8.c                             |  21 ++
 utf8.h                             |  15 ++
 12 files changed, 742 insertions(+), 376 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c5154bb..16b4ac5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,14 +128,15 @@ color::
 	are described in `color.branch.*`.
 
 align::
-	Left-, middle-, or right-align the content between %(align:...)
-	and %(end). Followed by `:<width>,<position>`, where the
-	`<position>` is either left, right or middle and `<width>` is
-	the total length of the content with alignment. If the
-	contents length is more than the width then no alignment is
-	performed. If used with '--quote' everything in between
-	%(align:...) and %(end) is quoted, but if nested then only the
-	topmost level performs quoting.
+	Left-, middle-, or right-align the content between
+	%(align:...) and %(end). The "align:" is followed by `<width>`
+	and `<position>` in any order separated by a comma, where the
+	`<position>` is either left, right or middle, default being
+	left and `<width>` is the total length of the content with
+	alignment. If the contents length is more than the width then
+	no alignment is performed. If used with '--quote' everything
+	in between %(align:...) and %(end) is quoted, but if nested
+	then only the topmost level performs quoting.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/builtin/tag.c b/builtin/tag.c
index f55dfda..081fe84 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -42,10 +42,11 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 		filter->lines = 0;
 
 	if (!format) {
-		if (filter->lines)
-			format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) "
-						   "%%(contents:lines=%d)", filter->lines);
-		else
+		if (filter->lines) {
+			format = xstrfmt("%s %%(contents:lines=%d)",
+					 "%(align:15)%%(refname:short)%%(end)", filter->lines);
+			to_free = format;
+		} else
 			format = "%(refname:short)";
 	}
 
diff --git a/ref-filter.c b/ref-filter.c
index e3024d3..59716db 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -274,7 +274,7 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
 	}
 	if (body[0] != ':')
 		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
-	*val = body + 1; /* "atomname:val" */
+	*val = body + 1; /* "atom_name:val" */
 	return 1;
 }
 
@@ -884,43 +884,40 @@ static void populate_value(struct ref_array_item *ref)
 			continue;
 		} else if (match_atom_name(name, "align", &valp)) {
 			struct align *align = &v->u.align;
-			struct strbuf **s;
+			struct strbuf **s, **to_free;
+			int width = -1;
 
 			if (!valp)
-				die(_("expected format: %%(align:<width>, <position>)"));
+				die(_("expected format: %%(align:<width>,<position>)"));
 
 			/*
 			 * TODO: Implement a function similar to strbuf_split_str()
-			 * which would strip the terminator at the end.
+			 * which would omit the separator from the end of each value.
 			 */
-			s = strbuf_split_str(valp, ',', 0);
-
-			/* If the position is given trim the ',' from the first strbuf */
-			if (s[1])
-				strbuf_setlen(s[0], s[0]->len - 1);
-			if (s[2])
-				die(_("align:<width>,<position> followed by garbage: %s"), s[2]->buf);
-
-			if (strtoul_ui(s[0]->buf, 10, &align->width))
-				die(_("positive width expected align:%s"), s[0]->buf);
-
-			/*
-			 * TODO: Implement a more general check, so that the values
-			 * do not always have to be in a specific order.
-			 */
-			if (!s[1])
-				align->position = ALIGN_LEFT;
-			else if (!strcmp(s[1]->buf, "left"))
-				align->position = ALIGN_LEFT;
-			else if (!strcmp(s[1]->buf, "right"))
-				align->position = ALIGN_RIGHT;
-			else if (!strcmp(s[1]->buf, "middle"))
-				align->position = ALIGN_MIDDLE;
-			else
-				die(_("improper format entered align:%s"), s[1]->buf);
-
-			strbuf_list_free(s);
+			s = to_free = strbuf_split_str(valp, ',', 0);
+
+			align->position = ALIGN_LEFT;
+
+			while (*s) {
+				if (s[1])
+					strbuf_setlen(s[0], s[0]->len - 1);
+				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
+					;
+				else if (!strcmp(s[0]->buf, "left"))
+					align->position = ALIGN_LEFT;
+				else if (!strcmp(s[0]->buf, "right"))
+					align->position = ALIGN_RIGHT;
+				else if (!strcmp(s[0]->buf, "middle"))
+					align->position = ALIGN_MIDDLE;
+				else
+					die(_("improper format entered align:%s"), s[0]->buf);
+				s++;
+			}
 
+			if (width < 0)
+				die(_("positive width expected with the %%(align) atom"));
+			align->width = width;
+			strbuf_list_free(to_free);
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 4bc1055..fe4796c 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -85,7 +85,7 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
-test_expect_success 'left alignment' '
+test_expect_success 'left alignment is default' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/master  |refs/heads/master
 	refname is refs/heads/side    |refs/heads/side
@@ -97,7 +97,7 @@ test_expect_success 'left alignment' '
 	refname is refs/tags/three    |refs/tags/three
 	refname is refs/tags/two      |refs/tags/two
 	EOF
-	git for-each-ref --format="%(align:30,left)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="%(align:30)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
@@ -113,7 +113,7 @@ test_expect_success 'middle alignment' '
 	|  refname is refs/tags/three  |refs/tags/three
 	|   refname is refs/tags/two   |refs/tags/two
 	EOF
-	git for-each-ref --format="|%(align:30,middle)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
@@ -137,17 +137,17 @@ test_expect_success 'right alignment' '
 
 test_expect_success 'alignment with format quote' "
 	cat >expect <<-\EOF &&
-	|'       master| A U Thor       '|
-	|'        side| A U Thor        '|
-	|'      odd/spot| A U Thor      '|
-	|'         double-tag|          '|
-	|'        four| A U Thor        '|
-	|'        one| A U Thor         '|
-	|'         signed-tag|          '|
-	|'       three| A U Thor        '|
-	|'        two| A U Thor         '|
+	|'      '\''master| A U Thor'\''      '|
+	|'       '\''side| A U Thor'\''       '|
+	|'     '\''odd/spot| A U Thor'\''     '|
+	|'        '\''double-tag| '\''        '|
+	|'       '\''four| A U Thor'\''       '|
+	|'       '\''one| A U Thor'\''        '|
+	|'        '\''signed-tag| '\''        '|
+	|'      '\''three| A U Thor'\''       '|
+	|'       '\''two| A U Thor'\''        '|
 	EOF
-	git for-each-ref --shell --format='|%(align:30,middle)%(refname:short)| %(authorname)%(end)|' >actual &&
+	git for-each-ref --shell --format=\"|%(align:30,middle)'%(refname:short)| %(authorname)'%(end)|\" >actual &&
 	test_cmp expect actual
 "
 
-- 
2.5.1
