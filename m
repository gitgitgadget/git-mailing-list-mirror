From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Wed, 19 Aug 2015 00:07:22 +0530
Message-ID: <1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRllb-0008Iz-2u
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbbHRShj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:37:39 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34898 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbHRShi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:37:38 -0400
Received: by pdob1 with SMTP id b1so15491495pdo.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5n/L14IoQk+m5/kVakQtyErqqPKjdGhTLxptYiTQTbE=;
        b=vwcCRZ2y7XMImQ53tjYK3TETLQ58yMJM1N5FVMrbm150+lb1muoKjlSXR0IRTawDdn
         s3NxWnvP69EolISuk/MohN9LA6VozcEDVJL7BFjcfF7VODCfVNohYMNL/nd0fs7udrtK
         tRlglFEAdudeKpZBNc7x3VPMX83VCl2T/sr0wlDeNrmQ4sI7ETyuKOSykUK8VZg4mEyn
         3M2c8n+1Hune76WsKu8FY1OvE0neAwE+OpyOot5NVL95eUvwmMbOa5htPcFZqA4qK29u
         1lBWf1sSmX9qY95zhRmTfNg90eOE2IvtsHsbbvLlVK/wOasWdE42Irq5/cBwqpu9vyoG
         FpRA==
X-Received: by 10.70.51.65 with SMTP id i1mr16094314pdo.90.1439923058380;
        Tue, 18 Aug 2015 11:37:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.37.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:37:37 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276140>

Introduce a stack machinery for ref_formatting_state, this allows us
to push and pop states. Whenever we pop a state the strbuf from that
state is appended into the next state on the stack, this will allow us
to support nesting of modifier atoms.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index dd62640..74532d3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -56,6 +56,7 @@ static struct {
 };
 
 struct ref_formatting_state {
+	struct ref_formatting_state *prev;
 	struct strbuf output;
 	int quote_style;
 };
@@ -134,6 +135,27 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
+static void push_new_state(struct ref_formatting_state **stack)
+{
+	struct ref_formatting_state *s = xcalloc(1, sizeof(struct ref_formatting_state));
+
+	strbuf_init(&s->output, 0);
+	s->prev = *stack;
+	*stack = s;
+}
+
+static void pop_state(struct ref_formatting_state **stack)
+{
+	struct ref_formatting_state *current = *stack;
+	struct ref_formatting_state *prev = current->prev;
+
+	if (prev)
+		strbuf_addbuf(&prev->output, &current->output);
+	strbuf_release(&current->output);
+	free(current);
+	*stack = prev;
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -1262,23 +1284,24 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct ref_formatting_state state;
+	struct strbuf *final_buf;
+	struct ref_formatting_state *state = NULL;
 
-	strbuf_init(&state.output, 0);
-	state.quote_style = quote_style;
+	push_new_state(&state);
+	state->quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			append_literal(cp, sp, &state);
+			append_literal(cp, sp, state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		append_atom(atomv, &state);
+		append_atom(atomv, state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		append_literal(cp, sp, &state);
+		append_literal(cp, sp, state);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1287,11 +1310,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		append_atom(&resetv, &state);
+		append_atom(&resetv, state);
 	}
-	fwrite(state.output.buf, 1, state.output.len, stdout);
+	final_buf = &state->output;
+	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	pop_state(&state);
 	putchar('\n');
-	strbuf_release(&state.output);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-- 
2.5.0
