From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Tue,  4 Aug 2015 18:13:00 +0530
Message-ID: <1438692188-14367-3-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:43:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbYz-0004FQ-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933134AbbHDMnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:43:21 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32919 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbbHDMnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 08:43:19 -0400
Received: by padck2 with SMTP id ck2so8000009pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 05:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wpl7OHY1S/3pa4aZ0eHYyH2PbWvsq3KoXAhKxJ1AcXU=;
        b=0Uj/wkRxVPWOCfFEoT0b73iKUmko6+1ll6Dj9pXJvgvq/b6Nyk6c+9znwzUgPVGRHU
         s1OIcbTmaKI/t1Zgp3KAEDr9Hmhm7zBcxltUKpOEJ/LpvsHrP3kwFH5KggZnGUlqp2p+
         nNlrZqC5O6DN7DDsm1WnNAP+CZGBUnK3/s1ziHzyOcN+F4LvdhGNFmMV1alibwWIBHeZ
         pX6uwxKUARJUWAoKSwmV0vgzYM0heOSAqhg0mWBapcS2IMfl9ZLhJ3TPAAwmtYCJ+st5
         j3fZd8pER1NicbWLbzvs8m1kpWrTbrIsHMDADfih+jTX3Bz1MM2PUa8j0nQATn45CCQI
         woWQ==
X-Received: by 10.68.202.72 with SMTP id kg8mr7503874pbc.42.1438692199233;
        Tue, 04 Aug 2015 05:43:19 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id m2sm1359951pdr.64.2015.08.04.05.43.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 05:43:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275255>

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
 ref-filter.h                       | 14 +++++++
 t/t6302-for-each-ref-filter.sh     | 48 ++++++++++++++++++++++
 4 files changed, 148 insertions(+), 6 deletions(-)

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
index 9e6c2d4..81de1e2 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,14 +16,28 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
+#define ALIGN_LEFT 0x01
+#define ALIGN_RIGHT 0x02
+#define ALIGN_MIDDLE 0x04
+
 struct ref_formatting_state {
 	int quote_style;
 	struct strbuf *output;
+	struct align *align;
+	unsigned int end : 1;
+};
+
+struct align {
+	unsigned int align_type,
+		align_value;
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
