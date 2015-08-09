From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Sun,  9 Aug 2015 19:41:38 +0530
Message-ID: <1439129506-9989-6-git-send-email-Karthik.188@gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORKu-0006u7-F1
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036AbbHIOMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:12:14 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35578 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbbHIOL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:11:58 -0400
Received: by pacgr6 with SMTP id gr6so8152404pac.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yaojfd9Vr6javiHj+FIIrAcG6fr/untkeWr+bnK/7v8=;
        b=whA122KWNrwduwUKEOJ/VZj4QkCMrruvOZN6ONPciQ+syTlVgMPFdVXnCPgPTIpjKG
         WUSWgQ4zbZiQj7QOsBsA9TAUhcy3QGPvkdFxfBN4AURs2Xv4nTTIPFyHMSP42p+AvN1+
         yGxE/lDkQKQouJGMoFFSUQlioY52TFDFE5iB4b4z9FKvgplFUDECu5uDqq+2FQ5nBeTa
         3+ePF781HeDQouxz28UgmDkleAMTUdKwtplJwe/McXILF+vbgEw8ARern61Ttgtt2JwC
         H7humbMzxhUNhJsWK3v1dEqOOH3LMEjeC63Ypq4EeQ+zg0wPy9MAmSK6IyQonv4GNs0Z
         vN2A==
X-Received: by 10.66.147.131 with SMTP id tk3mr35570414pab.104.1439129517786;
        Sun, 09 Aug 2015 07:11:57 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.11.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:11:57 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275542>

Implement an `align` atom which left-, middle-, or right-aligns the
content between %(align:..) and %(end).

It is followed by `:<position>,<width>`, where the `<position>` is
either left, right or middle and `<width>` is the size of the area
into which the content will be placed. If the content between
%(align:) and %(end) is more than the width then no alignment is
performed. e.g. to align a refname atom to the middle with a total
width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".

This is done by calling the strbuf_utf8_align() function in utf8.c and
currently does not support nested alignment.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  9 +++++
 ref-filter.c                       | 72 +++++++++++++++++++++++++++++++++++---
 ref-filter.h                       |  1 +
 t/t6302-for-each-ref-filter.sh     | 48 +++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..d949812 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,15 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	Implement an `align` atom which left-, middle-, or
+	right-aligns the content between %(align:..)  and
+	%(end). Followed by `:<position>,<width>`, where the
+	`<position>` is either left, right or middle and `<width>` is
+	the total length of the content with alignment. If the
+	contents length is more than the width then no alignment is
+	performed. Currently nested alignment is not supported.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index e2df209..57e988c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,11 +54,21 @@ static struct {
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
 
 struct atom_value{
 	const char *s;
+	struct align *align;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	unsigned int modifier_atom : 1,
+		end : 1;
 };
 
 /*
@@ -627,6 +638,7 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
 		if (*name == '*') {
@@ -692,6 +704,26 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (skip_prefix(name, "align:", &valp)) {
+			struct align *align = xmalloc(sizeof(struct align));
+
+			if (skip_prefix(valp, "left,", &valp))
+				align->position = ALIGN_LEFT;
+			else if (skip_prefix(valp, "right,", &valp))
+				align->position = ALIGN_RIGHT;
+			else if (skip_prefix(valp, "middle,", &valp))
+				align->position = ALIGN_MIDDLE;
+			else
+				die(_("improper format entered align:%s"), valp);
+			if (strtoul_ui(valp, 10, &align->width))
+				die(_("positive width expected align:%s"), valp);
+			v->align = align;
+			v->modifier_atom = 1;
+			continue;
+		} else if (!strcmp(name, "end")) {
+			v->end = 1;
+			v->modifier_atom = 1;
+			continue;
 		} else
 			continue;
 
@@ -1198,7 +1230,9 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 
 struct ref_formatting_state {
 	struct strbuf output;
+	struct align *align;
 	int quote_style;
+	unsigned int end : 1;
 };
 
 static void format_quote_value(struct atom_value *v, struct ref_formatting_state *state)
@@ -1262,12 +1296,31 @@ static void append_non_atom(const char *cp, const char *ep, struct ref_formattin
 
 static void set_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
 {
-	/* Based on the atomv values, the formatting state is set */
+	if (atomv->align) {
+		state->align = atomv->align;
+		atomv->align = NULL;
+	}
+	if (atomv->end)
+		state->end = 1;
+}
+
+static int align_ref_strbuf(struct ref_formatting_state *state, struct strbuf *final)
+{
+	if (state->align && state->end) {
+		struct align *align = state->align;
+		strbuf_utf8_align(final, align->position, align->width, state->output.buf);
+		strbuf_reset(&state->output);
+		state->align = NULL;
+		return 1;
+	} else if (state->align)
+		return 1;
+	return 0;
 }
 
 static void perform_state_formatting(struct ref_formatting_state *state, struct strbuf *final)
 {
-	/* More formatting options to be eventually added */
+	if (align_ref_strbuf(state, final))
+		return;
 	strbuf_addbuf(final, &state->output);
 	strbuf_reset(&state->output);
 }
@@ -1280,6 +1333,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 
 	state.quote_style = quote_style;
 	strbuf_init(&state.output, 0);
+	state.align = NULL;
+	state.end = 0;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
@@ -1290,10 +1345,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 			perform_state_formatting(&state, &final_buf);
 		}
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		set_formatting_state(atomv, &state);
-		format_quote_value(atomv, &state);
-		perform_state_formatting(&state, &final_buf);
+		if (atomv->modifier_atom)
+			set_formatting_state(atomv, &state);
+		else {
+			format_quote_value(atomv, &state);
+			perform_state_formatting(&state, &final_buf);
+		}
+		if (atomv->end)
+			perform_state_formatting(&state, &final_buf);
 	}
+	if (state.align)
+		die(_("format: align used without an `end` atom"));
 	if (*cp) {
 		sp = cp + strlen(cp);
 		append_non_atom(cp, sp, &state);
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
index 505a360..f6b921b 100755
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
+	git for-each-ref --format="%(align:left,30)refname is %(refname)%(end)|%(refname)" >actual &&
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
+	git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
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
+	git for-each-ref --format="|%(align:right,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
