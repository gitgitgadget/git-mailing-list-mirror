From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 04/15] ref-filter: introduce struct used_atom
Date: Tue,  5 Jan 2016 13:33:03 +0530
Message-ID: <1451980994-26865-5-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMa5-0007qp-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbcAEIDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:00 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34426 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcAEICx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:53 -0500
Received: by mail-pa0-f52.google.com with SMTP id uo6so191792154pac.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G2DN5Epd/9xUwB2KavA4clO36GNHs4NFsG5DEdlWGm8=;
        b=be+KCv+DhUsC7gZgIcizhouDT2dc3FVc2FRMZgiYRdsmT4hxYp8uViMhhvlegs7DxW
         dA7ikNQEgR9jtRThyIh3mqm/h8Lr1EdgbTzB6R9WIRY0LUTeLbERMY/KlCSy3OMK01Q8
         TP5vFTyJIX6PlVixFQWJeu90H+jPB+AI7U1UabUG9BluQvD5uEEJPRyvvmWDgWyn6RBr
         dLVJlrsE1pIeTvCgXMALAfWZvo2LFeyyhhM7IGw8WXiyEFwUAuryYfVPq+/wnn5thoFd
         9bWmE4mhbR1MEJa/stIOmAd6K+JPo8Ur5h9Z3OsvSFNPcFgMi1wegm6F0DQayV1nH4B6
         4N/w==
X-Received: by 10.66.221.228 with SMTP id qh4mr131485855pac.68.1451980972281;
        Tue, 05 Jan 2016 00:02:52 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:51 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283353>

Introduce the 'used_atom' structure to replace the existing
implementation of 'used_atom' (which is a list of atoms). This helps
us parse atoms beforehand and store required details into the
'used_atom' for future usage.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 388e2dd..75ebd03 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -17,7 +17,7 @@
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
 /*
- * An atom is a valid field atom listed above, possibly prefixed with
+ * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
@@ -26,8 +26,10 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
  * indexed with the "atom number", which is an index into this
  * array.
  */
-static const char **used_atom;
-static cmp_type *used_atom_type;
+static struct used_atom {
+	const char *name;
+	cmp_type type;
+} *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
 
@@ -122,8 +124,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
-		int len = strlen(used_atom[i]);
-		if (len == ep - atom && !memcmp(used_atom[i], atom, len))
+		int len = strlen(used_atom[i].name);
+		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
 			return i;
 	}
 
@@ -150,12 +152,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	at = used_atom_cnt;
 	used_atom_cnt++;
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
-	REALLOC_ARRAY(used_atom_type, used_atom_cnt);
-	used_atom[at] = xmemdupz(atom, ep - atom);
-	used_atom_type[at] = valid_atom[i].cmp_type;
+	used_atom[at].name = xmemdupz(atom, ep - atom);
+	used_atom[at].type = valid_atom[i].cmp_type;
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at], "symref"))
+	if (!strcmp(used_atom[at].name, "symref"))
 		need_symref = 1;
 	return at;
 }
@@ -315,7 +316,7 @@ int verify_ref_format(const char *format)
 		at = parse_ref_filter_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (skip_prefix(used_atom[at], "color:", &color))
+		if (skip_prefix(used_atom[at].name, "color:", &color))
 			need_color_reset_at_eol = !!strcmp(color, "reset");
 	}
 	return 0;
@@ -359,7 +360,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -383,7 +384,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 	struct tag *tag = (struct tag *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -405,7 +406,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	struct commit *commit = (struct commit *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -535,7 +536,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	const char *wholine = NULL;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -573,7 +574,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	if (!wholine)
 		return;
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -663,7 +664,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
@@ -786,7 +787,7 @@ static void populate_value(struct ref_array_item *ref)
 
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
@@ -1438,7 +1439,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 {
 	struct atom_value *va, *vb;
 	int cmp;
-	cmp_type cmp_type = used_atom_type[s->atom];
+	cmp_type cmp_type = used_atom[s->atom].type;
 
 	get_ref_atom_value(a, s->atom, &va);
 	get_ref_atom_value(b, s->atom, &vb);
-- 
2.6.4
