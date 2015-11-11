From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 09/10] ref-filter: introduce contents_atom_parser()
Date: Thu, 12 Nov 2015 01:14:35 +0530
Message-ID: <1447271075-15364-10-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbK2-0006Fl-8R
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbbKKTon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:43 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33580 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbbKKTok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:40 -0500
Received: by padfb7 with SMTP id fb7so5386287pad.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5+VxxleAywS/LDFIeyfu0jGtGBkZ/0tSWKPFp5B09fE=;
        b=iUVaW3AF7Ssa6jQ8pVe55ECT7QanZC4TSgAcckGmzKbVXC/De/jue+8PFBFI+l811Q
         hoYGSl3vKNbwdALU8vWXHtuNienqoE4qkqTsS9nKorXXUNl7B7Ei8yiE9+M8ZUmmxBXE
         A9BUeuk/cIvwCdR1aXhbef9OfUBB/oDejwmJUYZHUdnK73nVmugog9WkTOUd7LmWHY3j
         2PrWW3tVJAbWG0Delbr/ecPIdtZBs/zdRP1MNKRlEg/kcWHt2DCaZtPgFEtHm19ZlIUR
         aL0FFF47lk/JwVbCXFtLO3TeIwfxs3nrkc5eMW0b5MYnDFmNC3saCQNtgp/l1131SenW
         vJOw==
X-Received: by 10.68.113.194 with SMTP id ja2mr16733323pbb.52.1447271079731;
        Wed, 11 Nov 2015 11:44:39 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:39 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281188>

Introduce contents_atom_parser() which will parse the '%(contents)'
atom and store information into the 'used_atom' structure based on the
modifiers used along with the atom.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 66 ++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 802629b..117bbbb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -42,6 +42,14 @@ static struct used_atom {
 				track : 1,
 				trackshort : 1;
 		} remote_ref;
+		struct {
+			unsigned int subject : 1,
+				body : 1,
+				signature : 1,
+				all : 1,
+				lines : 1,
+				no_lines;
+		} contents;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -92,6 +100,29 @@ void remote_ref_atom_parser(struct used_atom *atom)
 		die(_("improper format entered align:%s"), buf);
 }
 
+void contents_atom_parser(struct used_atom *atom)
+{
+	const char * buf;
+
+	if (match_atom_name(atom->str, "contents", &buf))
+		atom->u.contents.all = 1;
+
+	if (!buf)
+		return;
+	if (!strcmp(buf, "body"))
+		atom->u.contents.body = 1;
+	else if (!strcmp(buf, "signature"))
+		atom->u.contents.signature = 1;
+	else if (!strcmp(buf, "subject"))
+		atom->u.contents.subject = 1;
+	else if (skip_prefix(buf, "lines=", &buf)) {
+		atom->u.contents.lines = 1;
+		if (strtoul_ui(buf, 10, &atom->u.contents.no_lines))
+			die(_("positive value expected contents:lines=%s"), buf);
+	} else
+		die(_("improper format entered contents:%s"), buf);
+}
+
 static align_type get_align_position(const char *type)
 {
 	if (!strcmp(type, "right"))
@@ -178,7 +209,7 @@ static struct {
 	{ "creatordate", FIELD_TIME },
 	{ "subject", FIELD_STR },
 	{ "body", FIELD_STR },
-	{ "contents", FIELD_STR },
+	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref", FIELD_STR },
@@ -191,11 +222,6 @@ static struct {
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
-struct contents {
-	unsigned int lines;
-	struct object_id oid;
-};
-
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
@@ -212,7 +238,6 @@ struct atom_value {
 	const char *s;
 	union {
 		struct align align;
-		struct contents contents;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -761,20 +786,16 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
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
+		    !atom->u.contents.all)
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -784,26 +805,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 
 		if (!strcmp(name, "subject"))
 			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "contents:subject"))
+		else if (atom->u.contents.subject)
 			v->s = copy_subject(subpos, sublen);
 		else if (!strcmp(name, "body"))
 			v->s = xmemdupz(bodypos, bodylen);
-		else if (!strcmp(name, "contents:body"))
+		else if (atom->u.contents.body)
 			v->s = xmemdupz(bodypos, nonsiglen);
-		else if (!strcmp(name, "contents:signature"))
+		else if (atom->u.contents.signature)
 			v->s = xmemdupz(sigpos, siglen);
-		else if (!strcmp(name, "contents"))
-			v->s = xstrdup(subpos);
-		else if (skip_prefix(name, "contents:lines=", &valp)) {
+		else if (atom->u.contents.lines) {
 			struct strbuf s = STRBUF_INIT;
 			const char *contents_end = bodylen + bodypos - siglen;
 
-			if (strtoul_ui(valp, 10, &v->u.contents.lines))
-				die(_("positive value expected contents:lines=%s"), valp);
 			/*  Size is the length of the message after removing the signature */
-			append_lines(&s, subpos, contents_end - subpos, v->u.contents.lines);
+			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.no_lines);
 			v->s = strbuf_detach(&s, NULL);
-		}
+		} else /*  For %(contents) without modifiers */
+			v->s = xstrdup(subpos);
 	}
 }
 
-- 
2.6.2
