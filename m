From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 07/11] ref-filter: introduce align_atom_parser()
Date: Wed, 16 Dec 2015 20:59:58 +0530
Message-ID: <1450279802-29414-8-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:30:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1r-0001uN-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934185AbbLPPaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:30:04 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36570 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPPaB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:30:01 -0500
Received: by mail-pf0-f182.google.com with SMTP id o64so13670489pfb.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dsHnWOjuyjEdzEJecRXQfhw7Rp6cUzAu4UDln6bVv7M=;
        b=cGTchDzNFPVCShk9QJFjjGWbyUWKaqyNdMKtR0gHA/uwOkAC64PUr6ictz5THLlmKk
         azUL9s1TEa3n6506R8IIRJtbBU0zjCtOHMgJeoAwXQpmaxfDNTzdhv4RLh5sQBZcFO4l
         rld+6paIBQDhIvm+12aBH9aJhNK4T6h5EDf3zrpC1dqAUs5wXqs44WuvjBAf0d8mFCUs
         cOgOE4H0DkuhbHY3FieMBV9g20oGPV+dutzfkjCIZCDiUi7SLRnwUfY5xpy/sjRxDiGT
         +a0eAoCt+c0JC7XvU1WwmJ9Zng2UHcha+hpDHA+LkQf03vG+CgktN7N2RtP//+QpIw66
         yU1Q==
X-Received: by 10.98.1.77 with SMTP id 74mr6358786pfb.0.1450279800848;
        Wed, 16 Dec 2015 07:30:00 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:30:00 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282570>

Introduce align_atom_parser() which will parse an "align" atom and
store the required alignment position and width in the "use_atom"
structure for further usage in 'populate_value()'.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 86 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3b61c62..a44673c 100644
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
@@ -63,6 +69,49 @@ static void color_atom_parser(struct used_atom *atom)
 		die(_("expected format: %%(color:<color>)"));
 }
 
+static align_type parse_align_position(const char *s)
+{
+	if (!strcmp(s, "right"))
+		return ALIGN_RIGHT;
+	else if (!strcmp(s, "middle"))
+		return ALIGN_MIDDLE;
+	else if (!strcmp(s, "left"))
+		return ALIGN_LEFT;
+	return -1;
+}
+
+static void align_atom_parser(struct used_atom *atom)
+{
+	struct align *align = &atom->u.align;
+	const char *buf = NULL;
+	struct strbuf **s, **to_free;
+	int width = -1;
+
+	match_atom_name(atom->str, "align", &buf);
+	if (!buf)
+		die(_("expected format: %%(align:<width>,<position>)"));
+	s = to_free = strbuf_split_str_omit_term(buf, ',', 0);
+
+	align->position = ALIGN_LEFT;
+
+	while (*s) {
+		int position;
+
+		if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
+			;
+		else if ((position = parse_align_position(s[0]->buf)) > 0)
+			align->position = position;
+		else
+			die(_("unrecognized %%(align) argument: %s"), s[0]->buf);
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
@@ -101,17 +150,12 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
-	{ "align" },
+	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
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
@@ -880,35 +924,7 @@ static void populate_value(struct ref_array_item *ref)
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
-			s = to_free = strbuf_split_str_omit_term(valp, ',', 0);
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
-- 
2.6.4
