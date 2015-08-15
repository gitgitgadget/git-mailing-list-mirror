From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Sat, 15 Aug 2015 23:30:35 +0530
Message-ID: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:01:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflv-0001wf-Ct
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbbHOSBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:01:30 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33717 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbHOSAv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:51 -0400
Received: by pabyb7 with SMTP id yb7so79255710pab.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=R8qEEcApz4IFa9s7r7RFgk+m6+35+/ITfnWZvWGaCAs=;
        b=DZ7bpedj1yAK1PHn/A4Jbn+LIJ06NCAWDcSRj0X0zSh4iSDIxF2S4pE+4eICqjS6ZL
         1WqJedlaa8yWCLpyRDI9Uw7nEz5DYvLG3Wy+eD1VihLrgHNYQH1n/+Bde3b1CB9foQuI
         LczJVua8L99kEVE91ZUqoNIc4jNC/WgN2kvWYD4L1pMhib4S4/jv07QvSXuH4lSRUlTB
         F1Fh7u0okZjFc9wr7f0P3gLQDN5izfLkY0tGR8V+seswO8D1V+h5JJUlfYTBBagJEdhB
         2o9/3eLL6JgkT4bQmMjNMzX8NxF69bgq4RciECALyv8PMMShTHZOu4s4LvLiz3Ehr6oI
         nuGw==
X-Received: by 10.66.219.102 with SMTP id pn6mr99814996pac.80.1439661651300;
        Sat, 15 Aug 2015 11:00:51 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:50 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276006>

Implement an `align` atom which left-, middle-, or right-aligns the
content between %(align:..) and %(end).

It is followed by `:<width>,<position>`, where the `<position>` is
either left, right or middle and `<width>` is the size of the area
into which the content will be placed. If the content between
%(align:) and %(end) is more than the width then no alignment is
performed. e.g. to align a refname atom to the middle with a total
width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".

This is done by calling the strbuf_utf8_align() function in utf8.c.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  8 ++++
 ref-filter.c                       | 81 +++++++++++++++++++++++++++++++++++---
 ref-filter.h                       |  1 +
 t/t6302-for-each-ref-filter.sh     | 48 ++++++++++++++++++++++
 4 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..2b82334 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,14 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	left-, middle-, or right-align the content between %(align:..)
+	and %(end). Followed by `:<position>,<width>`, where the
+	`<position>` is either left, right or middle and `<width>` is
+	the total length of the content with alignment. If the
+	contents length is more than the width then no alignment is
+	performed.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 3259363..eac99d0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,16 +54,27 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "align" },
+	{ "end" },
+};
+
+struct align {
+	align_type position;
+	unsigned int width;
 };
 
 struct ref_formatting_state {
 	struct strbuf output;
 	struct ref_formatting_state *prev;
+	void (*attend)(struct ref_formatting_state *state);
+	void *cb_data;
 	int quote_style;
 };
 
 struct atom_value {
 	const char *s;
+	struct align *align;
+	void (*handler)(struct atom_value *atomv, struct ref_formatting_state **state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
 
@@ -137,12 +149,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 
 static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)
 {
-	struct ref_formatting_state *new_state = xcalloc(1, sizeof(struct ref_formatting_state));
-	struct ref_formatting_state *tmp = *state;
+	struct ref_formatting_state *new = xcalloc(1, sizeof(struct ref_formatting_state));
+	struct ref_formatting_state *old = *state;
 
-	*state = new_state;
-	new_state->prev = tmp;
-	return new_state;
+	*state = new;
+	new->prev = old;
+	return new;
 }
 
 static void pop_state(struct ref_formatting_state **state)
@@ -625,6 +637,34 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static void align_handler(struct ref_formatting_state *state)
+{
+	struct strbuf aligned = STRBUF_INIT;
+	struct ref_formatting_state *return_to = state->prev;
+	struct align *align = (struct align *)state->cb_data;
+
+	strbuf_utf8_align(&aligned, align->position, align->width, state->output.buf);
+	strbuf_addbuf(&return_to->output, &aligned);
+	strbuf_release(&aligned);
+}
+
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *new = push_new_state(state);
+	strbuf_init(&new->output, 0);
+	new->attend = align_handler;
+	new->cb_data = atomv->align;
+}
+
+static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *current = *state;
+	if (!current->attend)
+		die(_("format: `end` atom used without a supporting atom"));
+	current->attend(current);
+	pop_state(state);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -653,6 +693,7 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
 		if (*name == '*') {
@@ -718,6 +759,34 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (skip_prefix(name, "align:", &valp)) {
+			struct align *align = xmalloc(sizeof(struct align));
+			char *ep = strchr(valp, ',');
+
+			if (ep)
+				*ep = '\0';
+
+			if (strtoul_ui(valp, 10, &align->width))
+				die(_("positive width expected align:%s"), valp);
+
+			if (!ep || starts_with(ep + 1, "left"))
+				align->position = ALIGN_LEFT;
+			else if (starts_with(ep + 1, "right"))
+				align->position = ALIGN_RIGHT;
+			else if (starts_with(ep + 1, "middle"))
+				align->position = ALIGN_MIDDLE;
+			else
+				die(_("improper format entered align:%s"), ep + 1);
+
+			if (ep)
+				*ep = ',';
+
+			v->align = align;
+			v->handler = align_atom_handler;
+			continue;
+		} else if (!strcmp(name, "end")) {
+			v->handler = end_atom_handler;
+			continue;
 		} else
 			continue;
 
@@ -1296,6 +1365,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			append_literal(cp, sp, state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
+		if (atomv->handler)
+			atomv->handler(atomv, &state);
 		append_atom(atomv, state);
 	}
 	if (*cp) {
diff --git a/ref-filter.h b/ref-filter.h
index 45026d0..144a633 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
+#include "utf8.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..b252a50 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,52 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'left alignment' '
+	cat >expect <<-\EOF &&
+	refname is refs/heads/master  |refs/heads/master
+	refname is refs/heads/side    |refs/heads/side
+	refname is refs/odd/spot      |refs/odd/spot
+	refname is refs/tags/double-tag|refs/tags/double-tag
+	refname is refs/tags/four     |refs/tags/four
+	refname is refs/tags/one      |refs/tags/one
+	refname is refs/tags/signed-tag|refs/tags/signed-tag
+	refname is refs/tags/three    |refs/tags/three
+	refname is refs/tags/two      |refs/tags/two
+	EOF
+	git for-each-ref --format="%(align:30,left)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'middle alignment' '
+	cat >expect <<-\EOF &&
+	| refname is refs/heads/master |refs/heads/master
+	|  refname is refs/heads/side  |refs/heads/side
+	|   refname is refs/odd/spot   |refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|  refname is refs/tags/four   |refs/tags/four
+	|   refname is refs/tags/one   |refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|  refname is refs/tags/three  |refs/tags/three
+	|   refname is refs/tags/two   |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,middle)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'right alignment' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
