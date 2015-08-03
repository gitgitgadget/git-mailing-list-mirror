From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 03/11] ref-filter: implement an `align` atom
Date: Mon,  3 Aug 2015 22:24:13 +0530
Message-ID: <1438620861-25219-3-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 18:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMJ0V-0000MS-3c
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 18:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbbHCQy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 12:54:28 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35879 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbbHCQy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 12:54:27 -0400
Received: by pdco4 with SMTP id o4so10608405pdc.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pFvYkRjjhna4DiVmZMS0aRQXfZSnu3hF+th/+8n+CJk=;
        b=EH+qrERg4Cl7AYHakw+7pYlmkqD5Dj9iqKTxjcR/yI/rWg7zwiC+LO+BW3jk7+ap/0
         Mxv+DiRvoNf/Z9c5ObfugDMshLkvpQtDsKSr9yWs4+rTyk+ikpsmoimSmmbFMk+BEmeS
         mE4zicXeRSNs/NITjQBUO0j+AwV9ADIBAiQkp1u3c4Jqg9X4ZEs04cPgkkBegorTJe15
         0o16wkwpoGE9qNXFA0lZl6gPQGZLwLYuiW5Hhh9OdpU643cF8I4Ff+yNysmi6kmrnox0
         XG2ophoCh49ud8RQfgQ6y0EWoXtujRRB5k7YirUDzo8ZA02m3FfRcvoq4/Rsm1Mw+6Y0
         6gfw==
X-Received: by 10.70.36.38 with SMTP id n6mr37398863pdj.96.1438620866810;
        Mon, 03 Aug 2015 09:54:26 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id gk5sm18164153pac.21.2015.08.03.09.54.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Aug 2015 09:54:26 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275177>

Implement an `align` atom which will act as a modifier atom and align
succeeding atoms to the right, left or middle. It is followed by
`:<type>,<paddinglength>`, where the `<type>` is either left, right or
middle and `<paddinglength>` is the total length of the padding to be
performed. If the atom length is more than the padding length then no
padding is performed. e.g. to pad a succeeding atom to the middle with
a total padding size of 40 we can do a --format="%(align:middle,40).."

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  7 ++++
 ref-filter.c                       | 69 +++++++++++++++++++++++++++++---
 ref-filter.h                       | 12 ++++++
 t/t6302-for-each-ref-filter.sh     | 80 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..bba6d83 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,13 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+align::
+	Align succeeding atoms to the right, left or middle. Followed
+	by `:<type>,<paddinglength>`, where the `<type>` is either
+	left, right or middle and `<paddinglength>` is the total
+	length of the padding to be performed. If the atom length is
+	more than the padding length then no padding is performed.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index c4c7064..46d8834 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,6 +54,7 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "align" },
 };
 
 /*
@@ -620,7 +622,7 @@ static void populate_value(struct ref_array_item *ref)
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
-		const char *refname;
+		const char *refname = NULL;
 		const char *formatp;
 		struct branch *branch = NULL;
 
@@ -687,6 +689,24 @@ static void populate_value(struct ref_array_item *ref)
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
+			continue;
 		} else
 			continue;
 
@@ -1252,15 +1272,48 @@ static void emit(const char *cp, const char *ep, struct strbuf *output)
 
 static void process_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
 {
-	/* Based on the atomv values, the formatting state is set */
+	if (atomv->align) {
+		state->align = atomv->align;
+		atomv->align = NULL;
+	}
 }
 
 static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *value,
 				   struct strbuf *format)
 {
-	/* More formatting options to be evetually added */
+	if (state->align) {
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
+			strbuf_addbuf(format, value);
+			strbuf_release(value);
+			return;
+		}
+
+		if (align->align_type == ALIGN_LEFT)
+			strbuf_addf(format, "%-*s", len + align->align_value, value->buf);
+		else if (align->align_type == ALIGN_MIDDLE) {
+			int right = (align->align_value - buf_len)/2;
+			strbuf_addf(format, "%*s%-*s", align->align_value - right + len,
+				    value->buf, right, "");
+		} else if (align->align_type == ALIGN_RIGHT)
+			strbuf_addf(format, "%*s", align->align_value, value->buf);
+		strbuf_release(value);
+		state->align = NULL;
+		return;
+	}
 	strbuf_addbuf(format, value);
 	strbuf_release(value);
+
 }
 
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
@@ -1283,9 +1336,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 			apply_formatting_state(&state, &value, &final_buf);
 		}
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		process_formatting_state(atomv, &state);
-		print_value(atomv, &state, &value);
-		apply_formatting_state(&state, &value, &final_buf);
+		if (atomv->align)
+			process_formatting_state(atomv, &state);
+		else {
+			print_value(atomv, &state, &value);
+			apply_formatting_state(&state, &value, &final_buf);
+		}
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -1302,6 +1358,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		print_value(&resetv, &state, &value);
 		apply_formatting_state(&state, &value, &final_buf);
 	}
+
 	for (i = 0; i < final_buf.len; i++)
 		printf("%c", final_buf.buf[i]);
 	putchar('\n');
diff --git a/ref-filter.h b/ref-filter.h
index b64677f..01f8cb3 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,12 +16,24 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
+#define ALIGN_LEFT 0x01
+#define ALIGN_RIGHT 0x02
+#define ALIGN_MIDDLE 0x04
+
 struct ref_formatting_state {
 	int quote_style;
+	struct align *align;
+	struct strbuf *sb;
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
 };
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..87225dd 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,84 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'left alignment' '
+	cat >expect <<-\EOF &&
+	refs/heads/master   |refs/heads/master
+	refs/heads/side     |refs/heads/side
+	refs/odd/spot       |refs/odd/spot
+	refs/tags/double-tag|refs/tags/double-tag
+	refs/tags/four      |refs/tags/four
+	refs/tags/one       |refs/tags/one
+	refs/tags/signed-tag|refs/tags/signed-tag
+	refs/tags/three     |refs/tags/three
+	refs/tags/two       |refs/tags/two
+	EOF
+	git for-each-ref --format="%(align:left,20)%(refname)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'middle alignment' '
+	cat >expect <<-\EOF &&
+	|  refs/heads/master |refs/heads/master
+	|   refs/heads/side  |refs/heads/side
+	|    refs/odd/spot   |refs/odd/spot
+	|refs/tags/double-tag|refs/tags/double-tag
+	|   refs/tags/four   |refs/tags/four
+	|    refs/tags/one   |refs/tags/one
+	|refs/tags/signed-tag|refs/tags/signed-tag
+	|   refs/tags/three  |refs/tags/three
+	|    refs/tags/two   |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:middle,20)%(refname)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'right alignment' '
+	cat >expect <<-\EOF &&
+	|   refs/heads/master|refs/heads/master
+	|     refs/heads/side|refs/heads/side
+	|       refs/odd/spot|refs/odd/spot
+	|refs/tags/double-tag|refs/tags/double-tag
+	|      refs/tags/four|refs/tags/four
+	|       refs/tags/one|refs/tags/one
+	|refs/tags/signed-tag|refs/tags/signed-tag
+	|     refs/tags/three|refs/tags/three
+	|       refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:right,20)%(refname)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment value lesser than atom value' '
+	cat >expect <<-\EOF &&
+	|refs/heads/master|
+	|refs/heads/side|
+	|  refs/odd/spot|
+	|refs/tags/double-tag|
+	| refs/tags/four|
+	|  refs/tags/one|
+	|refs/tags/signed-tag|
+	|refs/tags/three|
+	|  refs/tags/two|
+	EOF
+	git for-each-ref --format="|%(align:right,15)%(refname)|" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'non atom alignment' '
+	cat >expect <<-\EOF &&
+	|    |master  |  refs/heads/master|  refs/heads/master
+	|    |side  |  refs/heads/side|  refs/heads/side
+	|    |odd/spot  |  refs/odd/spot|  refs/odd/spot
+	|    |double-tag  |  refs/tags/double-tag|  refs/tags/double-tag
+	|    |four  |  refs/tags/four|  refs/tags/four
+	|    |one  |  refs/tags/one|  refs/tags/one
+	|    |signed-tag  |  refs/tags/signed-tag|  refs/tags/signed-tag
+	|    |three  |  refs/tags/three|  refs/tags/three
+	|    |two  |  refs/tags/two|  refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:right,5)|%(refname:short)%(align:middle,5)|%(refname)%(align:left,3)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
