From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 07/10] ref-filter: introduce align_atom_parser()
Date: Thu, 12 Nov 2015 01:14:33 +0530
Message-ID: <1447271075-15364-8-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbK0-0006Fl-Si
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbbKKToi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:38 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34609 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbKKTog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:36 -0500
Received: by pacfl14 with SMTP id fl14so5347916pac.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+BixjeHlT/5pry9/iNP0w+UKIAW5mSd7PeQCiDCgCIE=;
        b=rflTubJKiVlbp/ESjRiz6xgTzkDmvXI6B1uXe0x6/p8VhLfIM+fWGEZBCko8TvTRpV
         nIU7xjQ09LDr5PlFVwnu7bIP2oKUBR/jDtrctGrzxYMLCC59PTgtcUKGEG5MbsAkKcyF
         7ag5HKgPSjneQtoJ63MJsVppuZwZxlDhaT2bvtQjDs19xjPSHA7Se0gRXiUwJbTFVoI1
         B6zJ7SCuWuz4FjxftzeTyjGUY7VuzB3HVZOUcErbXpo8Zc4PevtIADROxzu6TQ2LQJW+
         wAsROvvU1Lb9jtIUwYCsKJcdpw9M5nKodFBdClglWRAxcc1muGgwgnbbsTSW3mpPKDiz
         5U3A==
X-Received: by 10.66.234.101 with SMTP id ud5mr17019981pac.136.1447271075331;
        Wed, 11 Nov 2015 11:44:35 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:34 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281186>

Introduce align_atom_parser() which will parse 'align' atoms and store
the required width and position into the 'used_atom' structure. While
we're here, add support for the usage of 'width=' and 'position=' when
using the 'align' atom (e.g. %(align:position=middle,width=30)).

Add documentation and modify the existing tests in t6302 to reflect
the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  18 ++++---
 ref-filter.c                       | 102 +++++++++++++++++++++++--------------
 t/t6302-for-each-ref-filter.sh     |   4 +-
 3 files changed, 75 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c6f073c..56ffdc1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -129,14 +129,16 @@ color::
 
 align::
 	Left-, middle-, or right-align the content between
-	%(align:...) and %(end). The "align:" is followed by `<width>`
-	and `<position>` in any order separated by a comma, where the
-	`<position>` is either left, right or middle, default being
-	left and `<width>` is the total length of the content with
-	alignment. If the contents length is more than the width then
-	no alignment is performed. If used with '--quote' everything
-	in between %(align:...) and %(end) is quoted, but if nested
-	then only the topmost level performs quoting.
+	%(align:...) and %(end). The "align:" is followed by
+	`width=<width>` and `position=<position>` in any order
+	separated by a comma, where the `<position>` is either left,
+	right or middle, default being left and `<width>` is the total
+	length of the content with alignment. The prefix for the
+	arguments is not mandatory. If the contents length is more
+	than the width then no alignment is performed. If used with
+	'--quote' everything in between %(align:...) and %(end) is
+	quoted, but if nested then only the topmost level performs
+	quoting.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 4e8b3c9..049e6b9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,11 @@
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
+struct align {
+	align_type position;
+	unsigned int width;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -31,6 +36,7 @@ static struct used_atom {
 	cmp_type type;
 	union {
 		const char *color;
+		struct align align;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -63,6 +69,61 @@ void color_atom_parser(struct used_atom *atom)
 		die(_("expected format: %%(color:<color>)"));
 }
 
+static align_type get_align_position(const char *type)
+{
+	if (!strcmp(type, "right"))
+		return ALIGN_RIGHT;
+	else if (!strcmp(type, "middle"))
+		return ALIGN_MIDDLE;
+	else if (!strcmp(type, "left"))
+		return ALIGN_LEFT;
+	return -1;
+}
+
+void align_atom_parser(struct used_atom *atom)
+{
+	struct align *align = &atom->u.align;
+	const char *buf = NULL;
+	struct strbuf **s, **to_free;
+	int width = -1;
+
+	match_atom_name(atom->str, "align", &buf);
+	if (!buf)
+		die(_("expected format: %%(align:<width>,<position>)"));
+	s = to_free = strbuf_split_str_without_term(buf, ',', 0);
+
+	/*  By default align to ALGIN_LEFT */
+	align->position = ALIGN_LEFT;
+
+	while (*s) {
+		int position;
+		buf = s[0]->buf;
+
+		position = get_align_position(buf);
+
+		if (skip_prefix(buf, "position=", &buf)) {
+			position = get_align_position(buf);
+			if (position == -1)
+				die(_("improper format entered align:%s"), s[0]->buf);
+			align->position = position;
+		} else if (skip_prefix(buf, "width=", &buf)) {
+			if (strtoul_ui(buf, 10, (unsigned int *)&width))
+				die(_("improper format entered align:%s"), s[0]->buf);
+		} else if (!strtoul_ui(buf, 10, (unsigned int *)&width))
+				;
+		else if (position != -1)
+			align->position = position;
+		else
+			die(_("improper format entered align:%s"), s[0]->buf);
+		s++;
+	}
+
+	if (width < 0)
+		die(_("positive width expected with the %%(align) atom"));
+	align->width = width;
+	strbuf_list_free(to_free);
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -101,17 +162,12 @@ static struct {
 	{ "flag", FIELD_STR },
 	{ "HEAD", FIELD_STR },
 	{ "color", FIELD_STR, color_atom_parser },
-	{ "align", FIELD_STR },
+	{ "align", FIELD_STR, align_atom_parser },
 	{ "end", FIELD_STR },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
-struct align {
-	align_type position;
-	unsigned int width;
-};
-
 struct contents {
 	unsigned int lines;
 	struct object_id oid;
@@ -881,39 +937,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = " ";
 			continue;
 		} else if (match_atom_name(name, "align", &valp)) {
-			struct align *align = &v->u.align;
-			struct strbuf **s, **to_free;
-			int width = -1;
-
-			if (!valp)
-				die(_("expected format: %%(align:<width>,<position>)"));
-
-			/*
-			 * TODO: Implement a function similar to strbuf_split_str()
-			 * which would omit the separator from the end of each value.
-			 */
-			s = to_free = strbuf_split_str_without_term(valp, ',', 0);
-
-			align->position = ALIGN_LEFT;
-
-			while (*s) {
-				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
-					;
-				else if (!strcmp(s[0]->buf, "left"))
-					align->position = ALIGN_LEFT;
-				else if (!strcmp(s[0]->buf, "right"))
-					align->position = ALIGN_RIGHT;
-				else if (!strcmp(s[0]->buf, "middle"))
-					align->position = ALIGN_MIDDLE;
-				else
-					die(_("improper format entered align:%s"), s[0]->buf);
-				s++;
-			}
-
-			if (width < 0)
-				die(_("positive width expected with the %%(align) atom"));
-			align->width = width;
-			strbuf_list_free(to_free);
+			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..688751e 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -97,7 +97,7 @@ test_expect_success 'left alignment is default' '
 	refname is refs/tags/three    |refs/tags/three
 	refname is refs/tags/two      |refs/tags/two
 	EOF
-	git for-each-ref --format="%(align:30)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="%(align:width=30)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
@@ -113,7 +113,7 @@ test_expect_success 'middle alignment' '
 	|  refname is refs/tags/three  |refs/tags/three
 	|   refname is refs/tags/two   |refs/tags/two
 	EOF
-	git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="|%(align:position=middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.6.2
