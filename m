From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/11] ref-filter: introduce contents_atom_parser()
Date: Wed, 16 Dec 2015 21:00:01 +0530
Message-ID: <1450279802-29414-11-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:30:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E29-0002PK-HC
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934206AbbLPPaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:30:12 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36644 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPPaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:30:11 -0500
Received: by mail-pf0-f177.google.com with SMTP id o64so13672542pfb.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PD8Y8xfb9YYgTXSKEI+qo+MDdUZdE4rAS4evnwzRixU=;
        b=sIWwDm1+PJEqoWCj6VerFRXwr0u3nMocjzw1CJjs5eyekKdTSfSvZsk1LkZZ5Sf7iT
         VobD9b2eu1pcBmZXAtclaGICJjK/CizdWS3C3wWDIZuFyWqLQvZSQXvsaEHRoWWwFFxs
         x8uTzYaF7hpugMGd9pXtTPh+YPwhX+cDK4R3rUEWV/3eS8DtP6gbSZhClfiu3BtAGtd+
         Ta/ndBNKA7KQ32KMKbHgzM2WoIdojL0lM2hj4XqTOkaPr+WA9/ONJM3f0AKbrcmZfL1X
         Q+YFFmMo+WMbdxZo72AVmfxz7g8aOHxre6ni7r7i868w1smf/Q1+GSUjVUOtVGToSysq
         ZnTA==
X-Received: by 10.98.64.80 with SMTP id n77mr6277127pfa.87.1450279810354;
        Wed, 16 Dec 2015 07:30:10 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:30:09 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282574>

Introduce contents_atom_parser() which will parse the '%(contents)'
atom and store information into the 'used_atom' structure based on the
modifiers used along with the atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 77 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 44670e3..ce02933 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -39,6 +39,10 @@ static struct used_atom {
 		struct align align;
 		enum { RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_NORMAL }
 			remote_ref;
+		struct {
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
+			unsigned int no_lines;
+		} contents;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -90,6 +94,36 @@ static void remote_ref_atom_parser(struct used_atom *atom)
 		die(_("unrecognized format: %%(%s)"), atom->str);
 }
 
+static void contents_atom_parser(struct used_atom *atom)
+{
+	const char * buf;
+
+	if (match_atom_name(atom->str, "contents", &buf))
+		atom->u.contents.option = C_BARE;
+	else if (match_atom_name(atom->str, "subject", &buf)) {
+		atom->u.contents.option = C_SUB;
+		return;
+	} else if (match_atom_name(atom->str, "body", &buf)) {
+		atom->u.contents.option = C_BODY_DEP;
+		return;
+	}
+	if (!buf)
+		return;
+
+	if (!strcmp(buf, "body"))
+		atom->u.contents.option = C_BODY;
+	else if (!strcmp(buf, "signature"))
+		atom->u.contents.option = C_SIG;
+	else if (!strcmp(buf, "subject"))
+		atom->u.contents.option = C_SUB;
+	else if (skip_prefix(buf, "lines=", &buf)) {
+		atom->u.contents.option = C_LINES;
+		if (strtoul_ui(buf, 10, &atom->u.contents.no_lines))
+			die(_("positive value expected contents:lines=%s"), buf);
+	} else
+		die(_("unrecognized %%(contents) argument: %s"), buf);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -171,9 +205,9 @@ static struct {
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
@@ -186,11 +220,6 @@ static struct {
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
-struct contents {
-	unsigned int lines;
-	struct object_id oid;
-};
-
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
@@ -207,7 +236,6 @@ struct atom_value {
 	const char *s;
 	union {
 		struct align align;
-		struct contents contents;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -756,20 +784,16 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].str;
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->str;
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
@@ -777,28 +801,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
 
-		if (!strcmp(name, "subject"))
+		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "contents:subject"))
-			v->s = copy_subject(subpos, sublen);
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
+			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.no_lines);
 			v->s = strbuf_detach(&s, NULL);
-		}
+		} else if (atom->u.contents.option == C_BARE)
+			v->s = xstrdup(subpos);
 	}
 }
 
-- 
2.6.4
