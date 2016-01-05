From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 14/15] ref-filter: introduce contents_atom_parser()
Date: Tue,  5 Jan 2016 13:33:13 +0530
Message-ID: <1451980994-26865-15-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaU-0008BI-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbcAEIDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:21 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33145 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcAEIDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:13 -0500
Received: by mail-pa0-f49.google.com with SMTP id cy9so211256629pac.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkeZvahVmbBEh8WmdYxssUNMVkTN16EdE7x+u7hJuRI=;
        b=V486EcFOvUVu0pv1VdE5oadds9C0kZbYoNU00SfRi1O1A5vDVLu3bJbAlf/YUK1T0v
         kDIOMoTArCpbXN2phnknUqjbhs357C1zJtoU1BU5SrvZZyldsB28KIF/iK8MPtSxSMh8
         vCGxRYeFnSFG8xl2qbIUilLMweiyA1cVhrKlWUxgB3U2erKTQWItB7I7EDmticTiYYjx
         gBAmW4hMTYANEiWDZRi5gKYCRaX74WGFgal7Aadph5ymlsWRUVWXWLp8SvR5Pmx5DBd/
         evW9yLYG8XTrI2uP+nSoJcL2SPDTkG+8Y+GcURtZhgOQ6LqZvZUmBqq92id5TaugXqOm
         ey+g==
X-Received: by 10.66.140.39 with SMTP id rd7mr132432211pab.86.1451980992973;
        Tue, 05 Jan 2016 00:03:12 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:12 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283362>

Introduce contents_atom_parser() which will parse the '%(contents)'
atom and store information into the 'used_atom' structure based on the
modifiers used along with the atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 74 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 32b4674..9e61530 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -39,6 +39,10 @@ static struct used_atom {
 		struct align align;
 		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
 			remote_ref;
+		struct {
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
+			unsigned int nlines;
+		} contents;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -96,6 +100,35 @@ static void remote_ref_atom_parser(struct used_atom *atom)
 		die(_("unrecognized format: %%(%s)"), atom->name);
 }
 
+static void contents_atom_parser(struct used_atom *atom)
+{
+	const char * buf;
+
+	if (match_atom_name(atom->name, "subject", &buf) && !buf) {
+		atom->u.contents.option = C_SUB;
+		return;
+	} else if (match_atom_name(atom->name, "body", &buf) && !buf) {
+		atom->u.contents.option = C_BODY_DEP;
+		return;
+	} if (!match_atom_name(atom->name, "contents", &buf))
+		  die("BUG: parsing non-'contents'");
+
+	if (!buf)
+		atom->u.contents.option = C_BARE;
+	else if (!strcmp(buf, "body"))
+		atom->u.contents.option = C_BODY;
+	else if (!strcmp(buf, "signature"))
+		atom->u.contents.option = C_SIG;
+	else if (!strcmp(buf, "subject"))
+		atom->u.contents.option = C_SUB;
+	else if (skip_prefix(buf, "lines=", &buf)) {
+		atom->u.contents.option = C_LINES;
+		if (strtoul_ui(buf, 10, &atom->u.contents.nlines))
+			die(_("positive value expected contents:lines=%s"), buf);
+	} else
+		die(_("unrecognized %%(contents) argument: %s"), buf);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -178,9 +211,9 @@ static struct {
 	{ "taggerdate", FIELD_TIME },
 	{ "creator" },
 	{ "creatordate", FIELD_TIME },
-	{ "subject" },
-	{ "body" },
-	{ "contents" },
+	{ "subject", FIELD_STR, contents_atom_parser },
+	{ "body", FIELD_STR, contents_atom_parser },
+	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref" },
@@ -193,11 +226,6 @@ static struct {
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
-struct contents {
-	unsigned int lines;
-	struct object_id oid;
-};
-
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
@@ -214,7 +242,6 @@ struct atom_value {
 	const char *s;
 	union {
 		struct align align;
-		struct contents contents;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -764,19 +791,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
+		struct used_atom *atom = &used_atom[i];
 		struct atom_value *v = &val[i];
-		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "contents") &&
-		    strcmp(name, "contents:subject") &&
-		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature") &&
-		    !starts_with(name, "contents:lines="))
+		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -784,28 +807,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
 
-		if (!strcmp(name, "subject"))
-			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "contents:subject"))
+		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "body"))
+		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
-		else if (!strcmp(name, "contents:body"))
+		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
-		else if (!strcmp(name, "contents:signature"))
+		else if (atom->u.contents.option == C_SIG)
 			v->s = xmemdupz(sigpos, siglen);
-		else if (!strcmp(name, "contents"))
-			v->s = xstrdup(subpos);
-		else if (skip_prefix(name, "contents:lines=", &valp)) {
+		else if (atom->u.contents.option == C_LINES) {
 			struct strbuf s = STRBUF_INIT;
 			const char *contents_end = bodylen + bodypos - siglen;
 
-			if (strtoul_ui(valp, 10, &v->u.contents.lines))
-				die(_("positive value expected contents:lines=%s"), valp);
 			/*  Size is the length of the message after removing the signature */
-			append_lines(&s, subpos, contents_end - subpos, v->u.contents.lines);
+			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
 			v->s = strbuf_detach(&s, NULL);
-		}
+		} else if (atom->u.contents.option == C_BARE)
+			v->s = xstrdup(subpos);
 	}
 }
 
-- 
2.6.4
