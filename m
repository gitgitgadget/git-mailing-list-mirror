From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 02/11] ref-filter: introduce ref_formatting_state
Date: Mon,  3 Aug 2015 22:24:12 +0530
Message-ID: <1438620861-25219-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 18:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMJ0Q-0000KI-6G
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 18:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbbHCQyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 12:54:25 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33396 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbbHCQyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 12:54:24 -0400
Received: by pdbnt7 with SMTP id nt7so76053449pdb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jjSprRjMT9sifjDwBzr0udPGB9hm/frC/7e8XVPHVD8=;
        b=sJMVJwFY2A3OWLVvAxZupEH32iBKQSiSOOFojRTrlf6N0qzKRRpV4iCXwnqJHtqnCe
         bNfk7pbV7EI/1Gn8DnxVL6VNZZ5N0fZyDPlhJHG4AvnSvk5rwFb7+L0RuJdvIFjR614/
         VcrbY+OzRkO5PycaX9x0y15ilqceM4QkJ1/z54hv45WXDpCRLhhGkBEKJBMcta2MnjPH
         wJCOhb0LODo+ZysTGf/kNwl6VVeeAMJ2eqN1QFfUKLda52dpudCnMP3SMksvduQ/Q5f6
         v44TXquWgrnBJhNch2GNMGXuT1dH2Z0EJV9SOkux48vQXYbKM4wQ8X9zCimcq3/jObUv
         jquw==
X-Received: by 10.70.20.196 with SMTP id p4mr37820682pde.58.1438620863830;
        Mon, 03 Aug 2015 09:54:23 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id gk5sm18164153pac.21.2015.08.03.09.54.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Aug 2015 09:54:23 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275175>

Introduce a ref_formatting_state which will eventually hold the values
of modifier atoms. Implement this within ref-filter.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 49 +++++++++++++++++++++++++++++++++++++------------
 ref-filter.h |  4 ++++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index febdc45..c4c7064 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1190,9 +1190,10 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, int quote_style, struct strbuf *output)
+static void print_value(struct atom_value *v, struct ref_formatting_state *state,
+			struct strbuf *output)
 {
-	switch (quote_style) {
+	switch (state->quote_style) {
 	case QUOTE_NONE:
 		strbuf_addstr(output, v->s);
 		break;
@@ -1249,24 +1250,47 @@ static void emit(const char *cp, const char *ep, struct strbuf *output)
 	}
 }
 
+static void process_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	/* Based on the atomv values, the formatting state is set */
+}
+
+static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *value,
+				   struct strbuf *format)
+{
+	/* More formatting options to be evetually added */
+	strbuf_addbuf(format, value);
+	strbuf_release(value);
+}
+
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf output = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
+	struct strbuf final_buf = STRBUF_INIT;
+	struct ref_formatting_state state;
 	int i;
 
+	memset(&state, 0, sizeof(state));
+	state.quote_style = quote_style;
+
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
-		struct atom_value *atomv;
+		struct atom_value *atomv = NULL;
 
 		ep = strchr(sp, ')');
-		if (cp < sp)
-			emit(cp, sp, &output);
+		if (cp < sp) {
+			emit(cp, sp, &value);
+			apply_formatting_state(&state, &value, &final_buf);
+		}
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(atomv, quote_style, &output);
+		process_formatting_state(atomv, &state);
+		print_value(atomv, &state, &value);
+		apply_formatting_state(&state, &value, &final_buf);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp, &output);
+		emit(cp, sp, &value);
+		apply_formatting_state(&state, &value, &final_buf);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1275,12 +1299,13 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, quote_style, &output);
+		print_value(&resetv, &state, &value);
+		apply_formatting_state(&state, &value, &final_buf);
 	}
-	for (i = 0; i < output.len; i++)
-		printf("%c", output.buf[i]);
+	for (i = 0; i < final_buf.len; i++)
+		printf("%c", final_buf.buf[i]);
 	putchar('\n');
-	strbuf_release(&output);
+	strbuf_release(&final_buf);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..b64677f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,6 +16,10 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
+struct ref_formatting_state {
+	int quote_style;
+};
+
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
-- 
2.4.6
