From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 02/10] ref-filter: introduce struct used_atom
Date: Thu, 12 Nov 2015 01:14:28 +0530
Message-ID: <1447271075-15364-3-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbJs-00062Z-68
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbbKKTo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:26 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33397 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKKToZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:25 -0500
Received: by padfb7 with SMTP id fb7so5385649pad.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwsYvx8+97msfwaH+VVeI+VjvmLbfmGgPpLHO6EgxxA=;
        b=BiUeQI63ngAPsM5JOhoxeasg+YfznHfi9v/RNfOQl2zuTldgZwZeGuQbmD1X6F4vR9
         IrdOrS739Of2u0h/YE/O+SW7tdbVVB+j2stgxeFCdaVrh0dEikeYADI2WMqkuGSb5D97
         yUoyCWoGcmQ+s9AG8HDdcKKfEsHhdRG2pJyheDR4y7VhwiHyFKxJkANBW+NyaJ84cu/e
         aRyzKShKcuvXpZFy++qV6Yhiq2Eix9QoOWNi+5I8yrjybPtuHeuYPyBtBvhZ1ZrJIpqd
         zSeZGrmBEO9QU/JY5p0Q4b3TiCaq3ZrZ9+iA5MXR2T5y1ExrTau5StpZdQSFeD6Z6Fu/
         Rzmg==
X-Received: by 10.66.163.131 with SMTP id yi3mr17084770pab.44.1447271064448;
        Wed, 11 Nov 2015 11:44:24 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:23 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281183>

Introduce the 'used_array' structure which would replace the existing
implementation of 'used_array' (which a list of atoms). This helps us
parse atom's before hand and store required details into the
'used_array' for future usage.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 62 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index fbbda17..748a2fe 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,23 @@
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
+/*
+ * An atom is a valid field atom listed below, possibly prefixed with
+ * a "*" to denote deref_tag().
+ *
+ * We parse given format string and sort specifiers, and make a list
+ * of properties that we need to extract out of objects.  ref_array_item
+ * structure will hold an array of values extracted that can be
+ * indexed with the "atom number", which is an index into this
+ * array.
+ */
+static struct used_atom {
+	const char *str;
+	cmp_type type;
+} *used_atom;
+static int used_atom_cnt, need_tagged, need_symref;
+static int need_color_reset_at_eol;
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -93,21 +110,6 @@ struct atom_value {
 };
 
 /*
- * An atom is a valid field atom listed above, possibly prefixed with
- * a "*" to denote deref_tag().
- *
- * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  ref_array_item
- * structure will hold an array of values extracted that can be
- * indexed with the "atom number", which is an index into this
- * array.
- */
-static const char **used_atom;
-static cmp_type *used_atom_type;
-static int used_atom_cnt, need_tagged, need_symref;
-static int need_color_reset_at_eol;
-
-/*
  * Used to parse format string and sort specifiers
  */
 int parse_ref_filter_atom(const char *atom, const char *ep)
@@ -123,8 +125,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
-		int len = strlen(used_atom[i]);
-		if (len == ep - atom && !memcmp(used_atom[i], atom, len))
+		int len = strlen(used_atom[i].str);
+		if (len == ep - atom && !memcmp(used_atom[i].str, atom, len))
 			return i;
 	}
 
@@ -151,12 +153,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	at = used_atom_cnt;
 	used_atom_cnt++;
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
-	REALLOC_ARRAY(used_atom_type, used_atom_cnt);
-	used_atom[at] = xmemdupz(atom, ep - atom);
-	used_atom_type[at] = valid_atom[i].cmp_type;
+	used_atom[at].str = xmemdupz(atom, ep - atom);
+	used_atom[at].type = valid_atom[i].cmp_type;
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at], "symref"))
+	if (!strcmp(used_atom[at].str, "symref"))
 		need_symref = 1;
 	return at;
 }
@@ -316,7 +317,7 @@ int verify_ref_format(const char *format)
 		at = parse_ref_filter_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (skip_prefix(used_atom[at], "color:", &color))
+		if (skip_prefix(used_atom[at].str, "color:", &color))
 			need_color_reset_at_eol = !!strcmp(color, "reset");
 	}
 	return 0;
@@ -360,7 +361,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].str;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -384,7 +385,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 	struct tag *tag = (struct tag *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].str;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -406,7 +407,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	struct commit *commit = (struct commit *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].str;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -536,7 +537,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	const char *wholine = NULL;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].str;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -574,7 +575,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	if (!wholine)
 		return;
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].str;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -664,7 +665,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].str;
 		struct atom_value *v = &val[i];
 		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
@@ -787,7 +788,8 @@ static void populate_value(struct ref_array_item *ref)
 
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->str;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
@@ -1446,7 +1448,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 {
 	struct atom_value *va, *vb;
 	int cmp;
-	cmp_type cmp_type = used_atom_type[s->atom];
+	cmp_type cmp_type = used_atom[s->atom].type;
 
 	get_ref_atom_value(a, s->atom, &va);
 	get_ref_atom_value(b, s->atom, &vb);
-- 
2.6.2
