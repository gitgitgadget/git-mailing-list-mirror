From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Thu,  6 Aug 2015 00:24:14 +0530
Message-ID: <1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 20:54:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN3pa-00033s-KU
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 20:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbbHESyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 14:54:15 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34408 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbbHESyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 14:54:12 -0400
Received: by pdber20 with SMTP id er20so21857597pdb.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BvumUHhyZ+xE8ygq35c+PSAhnmRoGGk+nTD+s5d0yHk=;
        b=c2cJAbTpMJmPYVeaiAqaN/DETTKYcqe/cOYiY+jqPFKxZp0npDeyNoIG0dKMRXpTZn
         x9kEhNeULE/aulC4ngUj3BjkwrvlYO3tEp7Drca2UQX63jGENreb/PT1bNuoOa4BZ11k
         x+E7Pt5mwbOr70OGldI7GNMlW1LP6RojlX7gpNZWpMZ2LMRS0wzSnwKSrAhNTAADmEzX
         nURJnxNEg0OLUyO6xqxfpVwPxC/Ite2Su6liJIG+2ubqE8GjY+XPPKmeuXIk/g+2gsrg
         VHQ1xAGSJCNSm2CUH+sCxoEadCxm8xVuPLQecl+d/goRYXtNcyzQTn8+3WsJXGmapvrr
         wYEw==
X-Received: by 10.70.37.77 with SMTP id w13mr22308726pdj.49.1438800851892;
        Wed, 05 Aug 2015 11:54:11 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id sp1sm3764412pab.4.2015.08.05.11.54.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Aug 2015 11:54:11 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275386>

Implement an `align` atom which will act as a modifier atom and align
any string with or without an %(atom) appearing before a %(end) atom
to the right, left or middle.

It is followed by `:<type>,<paddinglength>`, where the `<type>` is
either left, right or middle and `<paddinglength>` is the total length
of the padding to be performed. If the atom length is more than the
padding length then no padding is performed. e.g. to pad a succeeding
atom to the middle with a total padding size of 40 we can do a
--format="%(align:middle,40).."

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  8 ++++
 ref-filter.c                       | 84 +++++++++++++++++++++++++++++++++++---
 ref-filter.h                       | 18 +++++++-
 t/t6302-for-each-ref-filter.sh     | 48 ++++++++++++++++++++++
 4 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..d865f98 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,14 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	Align any string with or without %(atom) before the %(end)
+	atom to the right, left or middle. Followed by
+	`:<type>,<paddinglength>`, where the `<type>` is either left,
+	right or middle and `<paddinglength>` is the total length of
+	the padding to be performed. If the string length is more than
+	the padding length then no padding is performed.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 2c074a1..d123299 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,6 +54,8 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "align" },
+	{ "end" },
 };
 
 /*
@@ -620,7 +623,7 @@ static void populate_value(struct ref_array_item *ref)
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
-		const char *refname;
+		const char *refname = NULL;
 		const char *formatp;
 		struct branch *branch = NULL;
 
@@ -687,6 +690,29 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (starts_with(name, "align:")) {
+			const char *valp = NULL;
+			struct align *align = xmalloc(sizeof(struct align));
+
+			skip_prefix(name, "align:", &valp);
+
+			if (skip_prefix(valp, "left,", &valp))
+				align->align_type = ALIGN_LEFT;
+			else if (skip_prefix(valp, "right,", &valp))
+				align->align_type = ALIGN_RIGHT;
+			else if (skip_prefix(valp, "middle,", &valp))
+				align->align_type = ALIGN_MIDDLE;
+			else
+				die(_("align: improper format"));
+			if (strtoul_ui(valp, 10, &align->align_value))
+				die(_("align: positive value expected"));
+			v->align = align;
+			v->modifier_atom = 1;
+			continue;
+		} else if (starts_with(name, "end")) {
+			v->end = 1;
+			v->modifier_atom = 1;
+			continue;
 		} else
 			continue;
 
@@ -1251,12 +1277,48 @@ static void emit(const char *cp, const char *ep, struct ref_formatting_state *st
 
 static void process_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
 {
-	/* Based on the atomv values, the formatting state is set */
+	if (atomv->align) {
+		state->align = atomv->align;
+		atomv->align = NULL;
+	}
+	if (atomv->end)
+		state->end = 1;
 }
 
 static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
 {
-	/* More formatting options to be evetually added */
+	if (state->align && state->end) {
+		struct strbuf *value = state->output;
+		int len = 0, buf_len = value->len;
+		struct align *align = state->align;
+
+		if (!value->buf)
+			return;
+		if (!is_utf8(value->buf)) {
+			len = value->len - utf8_strwidth(value->buf);
+			buf_len -= len;
+		}
+
+		if (align->align_value < buf_len) {
+			state->align = NULL;
+			strbuf_addbuf(final, value);
+			strbuf_release(value);
+			return;
+		}
+
+		if (align->align_type == ALIGN_LEFT)
+			strbuf_addf(final, "%-*s", len + align->align_value, value->buf);
+		else if (align->align_type == ALIGN_MIDDLE) {
+			int right = (align->align_value - buf_len)/2;
+			strbuf_addf(final, "%*s%-*s", align->align_value - right + len,
+				    value->buf, right, "");
+		} else if (align->align_type == ALIGN_RIGHT)
+			strbuf_addf(final, "%*s", align->align_value, value->buf);
+		strbuf_release(value);
+		state->align = NULL;
+		return;
+	} else if (state->align)
+		return;
 	strbuf_addbuf(final, state->output);
 	strbuf_release(state->output);
 }
@@ -1282,10 +1344,19 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 			apply_formatting_state(&state, &final_buf);
 		}
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		process_formatting_state(atomv, &state);
-		print_value(atomv, &state);
-		apply_formatting_state(&state, &final_buf);
+		if (atomv->modifier_atom)
+			process_formatting_state(atomv, &state);
+		else {
+			print_value(atomv, &state);
+			apply_formatting_state(&state, &final_buf);
+		}
+		if (atomv->end) {
+			print_value(atomv, &state);
+			apply_formatting_state(&state, &final_buf);
+		}
 	}
+	if (state.align)
+		die(_("format: align used without an `end` atom"));
 	if (*cp) {
 		sp = cp + strlen(cp);
 		emit(cp, sp, &state);
@@ -1301,6 +1372,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		print_value(&resetv, &state);
 		apply_formatting_state(&state, &final_buf);
 	}
+
 	for (i = 0; i < final_buf.len; i++)
 		printf("%c", final_buf.buf[i]);
 	putchar('\n');
diff --git a/ref-filter.h b/ref-filter.h
index 9e6c2d4..5575fe9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,14 +16,30 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
+typedef enum {
+	ALIGN_LEFT,
+	ALIGN_MIDDLE,
+	ALIGN_RIGHT
+} align_type;
+
 struct ref_formatting_state {
-	int quote_style;
 	struct strbuf *output;
+	struct align *align;
+	int quote_style;
+	unsigned int end : 1;
+};
+
+struct align {
+	align_type align_type;
+	unsigned int align_value;
 };
 
 struct atom_value {
 	const char *s;
+	struct align *align;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	unsigned int modifier_atom : 1,
+		end : 1;
 };
 
 struct ref_sorting {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..76041a2 100755
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
+	|   refname is refs/tags/four  |refs/tags/four
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
