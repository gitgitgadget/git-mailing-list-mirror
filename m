From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 05/13] ref-filter: implement an `align` atom
Date: Wed, 19 Aug 2015 00:07:24 +0530
Message-ID: <1439923052-7373-6-git-send-email-Karthik.188@gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRlli-0008NX-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbbHRShq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:37:46 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32897 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbHRSho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:37:44 -0400
Received: by pabyb7 with SMTP id yb7so138282643pab.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2dLa3zAM8CMpuyLwBCLONEiA7/KhwaIPuQGZJuk4/Mc=;
        b=Qo4A6oJ1ya3XlHF57pthOtjIKyO1mvJG81pOyBSXubQ6oncUU5G0Apj+LnjXF8Js0s
         wVcgNVovDnLYyg2r/7SlPR3sMQyuxyfPIcLqsiq7t5OFw1+Ge6XwHro9Cyq19Ht7kW1v
         beWjEsZ2PpVxUwYHC9QSDEoGE70S2B4c1WUWjzA1O1etMu4RXFDRa0YDK5a1RKkV5Crk
         RO5ixv02V6bdzGPLyD+Omnym6X3AgKsYQ8+9dhupHKqlT4xHs0aeoNHY4BI7IHIqcfaR
         4+fPjcw9d6YsXytIkA8wIKtUOrncz5rUaHB624/UisH1TVAGJPDUbEgM2nDvEWvRN9FQ
         YmAA==
X-Received: by 10.66.132.16 with SMTP id oq16mr16265207pab.13.1439923063826;
        Tue, 18 Aug 2015 11:37:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.37.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:37:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276137>

Implement an `align` atom which left-, middle-, or right-aligns the
content between %(align:..) and %(end).

It is followed by `:<width>,<position>`, where the `<position>` is
either left, right or middle and `<width>` is the size of the area
into which the content will be placed. If the content between
%(align:) and %(end) is more than the width then no alignment is
performed. e.g. to align a refname atom to the middle with a total
width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".

We now have a `handler()` for each atom_value which will be called
when that atom_value is being parsed, and similarly an `at_end`
function for each state which is to be called when the `end` atom is
encountered. Using this implement the `align` atom which aligns the
given strbuf by calling `strbuf_utf8_align()` from utf8.c

This is done by assigning a 'handler' function to each atom_value and
a related 'at_end' function for each state. The align_handler()
defined uses strbuf_utf8_align() from utf8.c to perform the alignment.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  8 +++++
 ref-filter.c                       | 73 ++++++++++++++++++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 48 +++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..fe7889c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,14 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	Left-, middle-, or right-align the content between %(align:..)
+	and %(end). Followed by `:<width>>,<position>`, where the
+	`<position>` is either left, right or middle and `<width>` is
+	the total length of the content with alignment. If the
+	contents length is more than the width then no alignment is
+	performed.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 74532d3..ecbcc5a 100644
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
 	struct ref_formatting_state *prev;
 	struct strbuf output;
+	void (*at_end)(struct ref_formatting_state *state);
+	void *cb_data;
 	int quote_style;
 };
 
 struct atom_value {
 	const char *s;
+	struct align *align;
+	void (*handler)(struct atom_value *atomv, struct ref_formatting_state **state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
 
@@ -626,6 +638,36 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static void align_handler(struct ref_formatting_state *state)
+{
+	struct align *align = (struct align *)state->cb_data;
+	struct strbuf s = STRBUF_INIT;
+
+	strbuf_utf8_align(&s, align->position, align->width, state->output.buf);
+	strbuf_reset(&state->output);
+	strbuf_addbuf(&state->output, &s);
+	free(align);
+}
+
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *new;
+
+	push_new_state(state);
+	new = *state;
+	new->at_end = align_handler;
+	new->cb_data = atomv->align;
+}
+
+static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *current = *state;
+	if (!current->at_end)
+		die(_("format: `end` atom used without a supporting atom"));
+	current->at_end(current);
+	pop_state(state);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -654,6 +696,7 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
 		if (*name == '*') {
@@ -719,6 +762,34 @@ static void populate_value(struct ref_array_item *ref)
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
+			if (!ep || !strcmp(ep + 1, "left"))
+				align->position = ALIGN_LEFT;
+			else if (!strcmp(ep + 1, "right"))
+				align->position = ALIGN_RIGHT;
+			else if (!strcmp(ep + 1, "middle"))
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
 
@@ -1297,6 +1368,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			append_literal(cp, sp, state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
+		if (atomv->handler)
+			atomv->handler(atomv, &state);
 		append_atom(atomv, state);
 	}
 	if (*cp) {
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
