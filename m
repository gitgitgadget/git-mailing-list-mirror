From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 09/15] ref-filter: introduce align_atom_parser()
Date: Tue,  5 Jan 2016 13:33:08 +0530
Message-ID: <1451980994-26865-10-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMab-0008BI-5h
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbcAEIDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:25 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35051 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbcAEIDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:03 -0500
Received: by mail-pa0-f48.google.com with SMTP id do7so1663805pab.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05NXwS9ONFCbnVt8XYOJVgLll+t49P2bnMV+90HBxZo=;
        b=lH6X1IEPCeUD2TlxF9WhMI8hPWJbOBb7rKvVAAC9yGlzV9r+o9E5FOPGfqmBJb5Emr
         YuqNUDw+zFizM/EOdBREb//TCmfxsJh7ba+cH4fWWrkMcYC7rcyDr6j2WmFrbgGQ1crm
         084N7AMtdGtGVBGnkkOc6wcrSs8RnxK9FE2DBjhAagg3K3F7rT5Q0Urmawle/UidR+0S
         UFIWodMAf2+Nsmi7rhwPx6kme7yMvk97z/vz9Yemn2OdEAX+KhWHlvrPLiDjhjyoOxV0
         xWfWO5BfpYgwDLLMXyOXxbyc3snRg+p02miUHM8RwNyZWxr72x/v5HnOEJI++z/V7x/m
         ziUA==
X-Received: by 10.66.177.193 with SMTP id cs1mr74400609pac.132.1451980982589;
        Tue, 05 Jan 2016 00:03:02 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:02 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283363>

Introduce align_atom_parser() which will parse an 'align' atom and
store the required alignment position and width in the 'used_atom'
structure for further usage in populate_value().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 83 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9708d67..fa081a8 100644
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
 		char *color;
+		struct align align;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -68,6 +74,43 @@ static void color_atom_parser(struct used_atom *atom)
 		die(_("invalid color value: %s"), atom->u.color);
 }
 
+static void align_atom_parser(struct used_atom *atom)
+{
+	struct align *align = &atom->u.align;
+	const char *buf = NULL;
+	struct strbuf **s, **to_free;
+	int width = -1;
+
+	if (!match_atom_name(atom->name, "align", &buf))
+		die("BUG: parsing non-'align'");
+	if (!buf)
+		die(_("expected format: %%(align:<width>,<position>)"));
+	s = to_free = strbuf_split_str_omit_term(buf, ',', 0);
+
+	align->position = ALIGN_LEFT;
+
+	while (*s) {
+		buf = s[0]->buf;
+
+		if (!strtoul_ui(buf, 10, (unsigned int *)&width))
+			;
+		else if (!strcmp(buf, "left"))
+			align->position = ALIGN_LEFT;
+		else if (!strcmp(buf, "right"))
+			align->position = ALIGN_RIGHT;
+		else if (!strcmp(buf, "middle"))
+			align->position = ALIGN_MIDDLE;
+		else
+			die(_("unrecognized %%(align) argument: %s"), buf);
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
@@ -106,17 +149,12 @@ static struct {
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
@@ -816,7 +854,6 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
-		const char *valp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -880,36 +917,8 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
-		} else if (match_atom_name(name, "align", &valp)) {
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
+		} else if (starts_with(name, "align")) {
+			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.6.4
