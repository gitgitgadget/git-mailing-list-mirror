From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 07/11] ref-filter: introduce align_atom_parser()
Date: Wed, 17 Feb 2016 23:36:15 +0530
Message-ID: <1455732379-22479-8-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:06:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6UD-0006tQ-9g
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423513AbcBQSF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:56 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36247 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423479AbcBQSFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:54 -0500
Received: by mail-pf0-f170.google.com with SMTP id e127so15348778pfe.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k9qd1ljBmsnZx13sJFjOe5W4q2mJ24lDqg0WxZCRB+4=;
        b=BpeBSRrLMEAqZ7v0TW5LURR0zEF1b12m0TEiABHcn2sfdCZYY64WcC8krqHIDUvmwq
         V938OvH8xqVy6rXPwGhFjAz6Qn/CdbBUqDr0J2PzqJBtlRQTRFL+8Fv24ZoUl574Wai8
         NH7i2RoQxqRY7LvRL1m/web6JFSDLoiWXQmT0jZkyf9RXOcGhiRrdUO90cp3Thr/Te1Y
         XdFUXBM+ihJeu9R9eLuPU7fxGIuwtBmx7fOsas4N0oI+yVotd6byq5a5gJSh5yqIxkH7
         g6vzWgUVGz4+L/HFodYe9lBJX1C4iJ3A6T4plKzzsMka0ZxCgqqVQ22o+Ku99owNfRUX
         Tx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k9qd1ljBmsnZx13sJFjOe5W4q2mJ24lDqg0WxZCRB+4=;
        b=RasAvdsH/e44zlxilOmCCt0VKE/EcE3252R3hG/u8n2v4KiPGoQcK8Bdx0NBrY5dqe
         1S//4o8uK2n4s2Og5/l/HZLPrBZ7SPU88UG43nehdO3QbRyPKTHYBl6Zkl44bW46oLMu
         CorsUtTW1KNrYfN1GUJf7q/IejUj5QYPJ/j7D5GnTLl80dQUIHIAyJ1gQOGkrZwx32Mv
         YNlXvgYZ9zE4Y3fP8viQIuPd8DTr/EcmMCa47T0cmqQlIj4dgT5rTpgGEw9E28EbrOgN
         cwentvwXIpQsy3ZLaLS0eKVR0a0RCtUEH6jE7YBTOH/uK1OZXGlga/PEf5gYb+AlbZv+
         RDPQ==
X-Gm-Message-State: AG10YORWQRNEiUCSUz4UOlrB0664ydWRouVC6TgL2fh/M1kLe+lEDakQ2OClH3MuZo9d6g==
X-Received: by 10.98.73.2 with SMTP id w2mr3972478pfa.106.1455732353755;
        Wed, 17 Feb 2016 10:05:53 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:53 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286524>

Introduce align_atom_parser() which will parse an 'align' atom and
store the required alignment position and width in the 'used_atom'
structure for further usage in populate_value().

Since this patch removes the last usage of match_atom_name(), remove
the function from ref-filter.c.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 91 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e8b076d..797f9fe 100644
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
 		char color[COLOR_MAXLEN];
+		struct align align;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -55,6 +61,37 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
+static void align_atom_parser(struct used_atom *atom, const char *arg)
+{
+	struct align *align = &atom->u.align;
+	struct string_list params = STRING_LIST_INIT_DUP;
+	int i;
+	unsigned int width = ~0U;
+
+	if (!arg)
+		die(_("expected format: %%(align:<width>,<position>)"));
+
+	align->position = ALIGN_LEFT;
+
+	string_list_split(&params, arg, ',', -1);
+	for (i = 0; i < params.nr; i++) {
+		const char *s = params.items[i].string;
+		int position;
+
+		if (!strtoul_ui(s, 10, &width))
+			;
+		else if ((position = parse_align_position(s)) >= 0)
+			align->position = position;
+		else
+			die(_("unrecognized %%(align) argument: %s"), s);
+	}
+
+	if (width == ~0U)
+		die(_("positive width expected with the %%(align) atom"));
+	align->width = width;
+	string_list_clear(&params, 0);
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -93,17 +130,12 @@ static struct {
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
@@ -288,22 +320,6 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	pop_stack_element(&state->stack);
 }
 
-static int match_atom_name(const char *name, const char *atom_name, const char **val)
-{
-	const char *body;
-
-	if (!skip_prefix(name, atom_name, &body))
-		return 0; /* doesn't even begin with "atom_name" */
-	if (!body[0]) {
-		*val = NULL; /* %(atom_name) and no customization */
-		return 1;
-	}
-	if (body[0] != ':')
-		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
-	*val = body + 1; /* "atom_name:val" */
-	return 1;
-}
-
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -845,7 +861,6 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
-		const char *valp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -909,34 +924,8 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
-		} else if (match_atom_name(name, "align", &valp)) {
-			struct align *align = &v->u.align;
-			struct string_list params = STRING_LIST_INIT_DUP;
-			int i;
-			int width = -1;
-
-			if (!valp)
-				die(_("expected format: %%(align:<width>,<position>)"));
-
-			align->position = ALIGN_LEFT;
-
-			string_list_split(&params, valp, ',', -1);
-			for (i = 0; i < params.nr; i++) {
-				const char *s = params.items[i].string;
-				int position;
-
-				if (!strtoul_ui(s, 10, (unsigned int *)&width))
-					;
-				else if ((position = parse_align_position(s)) >= 0)
-					align->position = position;
-				else
-					die(_("improper format entered align:%s"), s);
-			}
-
-			if (width < 0)
-				die(_("positive width expected with the %%(align) atom"));
-			align->width = width;
-			string_list_clear(&params, 0);
+		} else if (starts_with(name, "align")) {
+			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.7.1
