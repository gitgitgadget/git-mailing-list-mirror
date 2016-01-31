From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 11/12] ref-filter: introduce contents_atom_parser()
Date: Sun, 31 Jan 2016 23:12:55 +0530
Message-ID: <1454262176-6594-12-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:47:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw5b-0006YH-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbcAaRrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:47:03 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34335 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbcAaRpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:45:02 -0500
Received: by mail-pf0-f195.google.com with SMTP id 65so6419054pfd.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dMZRCdHUKd3xtMOQhJiIaXmgLOzj1bXG/0DJSodRcI=;
        b=FuzqgS5WyMH4rLEc2Z0oN3WLAxeeAHKRn95LQRh53Fc7TG1ywYXuUMR6YIvpYHVD/a
         uDlq9XErsCgoj+3/lTa9GuePr8iNKBGWsiTNZ3Mw0GQZtRD2TrhS7LQdD72Ftd+bC1M5
         Bxfo/QFDuGAauqdkSfGWWa3QI5sttblEPl+6X/a5fYJtP6Aly4VRInsUJb1VNr5OlAix
         QTNxoBnfc+ADq7kvRBN7enmwSn59eKkA3eP5jAzbXMr1w+2ZiB+MMYJqlCnIu9QGJKDo
         +tNq3rMsaaiVn3QjqRDIr94yuwTLVFJ4WnMqssTMHL9AlN3dQf5IQAxCmaI4bZHNfR2Q
         PUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dMZRCdHUKd3xtMOQhJiIaXmgLOzj1bXG/0DJSodRcI=;
        b=X3Uz02lsDDzjPhzyFTJ9EEcWcXuqlyNAMeFJ58tocbKXKcGMAEhEeFX2edVoB2AtXo
         CQsvgDiwmIv75JQhBO5gaqGn/P+sNKpXYa1s+wjwOJMrNPtesjhgRRctLSb0Dnl6lsix
         X8QeoGABQI7St5ZpIeR7Z1aCVq8D+StbVJJNZQB8h3O8cL52LRMv3w07ei+k/etxHq7P
         iBXCXGoFdDpqYyUDc4zJq1jXDsPf6shPn0GdWFVB9WLQJYyd6SW/aZe2D3BU8T6G5hMK
         NGeHG2WLch4299egKU/M+1yGvfOonq4Q0Yk5kexHNYaPMnNfNiMT3zAN9HjTHm7SncEO
         H98Q==
X-Gm-Message-State: AG10YOTMhh19QqAz17aJ6czzWZsBdWS7UUvpzTgBDSCkk+Jv2NVYHQ9Eap0rXFBYVa0T4A==
X-Received: by 10.98.33.77 with SMTP id h74mr17198116pfh.157.1454262301565;
        Sun, 31 Jan 2016 09:45:01 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:45:01 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285167>

Introduce contents_atom_parser() which will parse the '%(contents)'
atom and store information into the 'used_atom' structure based on the
modifiers used along with the atom. Also introduce body_atom_parser()
and subject_atom_parser() for parsing atoms '%(body)' and '%(subject)'
respectively.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 77 ++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 99c152d..b2043a0 100644
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
@@ -66,6 +70,38 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized format: %%(%s)"), atom->name);
 }
 
+static void body_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (arg)
+		die("%%(body) atom does not take arguments");
+	atom->u.contents.option = C_BODY_DEP;
+}
+
+static void subject_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (arg)
+		die("%%(subject) atom does not take arguments");
+	atom->u.contents.option = C_SUB;
+}
+
+static void contents_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		atom->u.contents.option = C_BARE;
+	else if (!strcmp(arg, "body"))
+		atom->u.contents.option = C_BODY;
+	else if (!strcmp(arg, "signature"))
+		atom->u.contents.option = C_SIG;
+	else if (!strcmp(arg, "subject"))
+		atom->u.contents.option = C_SUB;
+	else if (skip_prefix(arg, "lines=", &arg)) {
+		atom->u.contents.option = C_LINES;
+		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
+			die(_("positive value expected contents:lines=%s"), arg);
+	} else
+		die(_("unrecognized %%(contents) argument: %s"), arg);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -145,9 +181,9 @@ static struct {
 	{ "taggerdate", FIELD_TIME },
 	{ "creator" },
 	{ "creatordate", FIELD_TIME },
-	{ "subject" },
-	{ "body" },
-	{ "contents" },
+	{ "subject", FIELD_STR, subject_atom_parser },
+	{ "body", FIELD_STR, body_atom_parser },
+	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref" },
@@ -160,11 +196,6 @@ static struct {
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
-struct contents {
-	unsigned int lines;
-	struct object_id oid;
-};
-
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
@@ -181,7 +212,6 @@ struct atom_value {
 	const char *s;
 	union {
 		struct align align;
-		struct contents contents;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -733,19 +763,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 
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
@@ -753,28 +779,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
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
+			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
 			v->s = strbuf_detach(&s, NULL);
-		}
+		} else if (atom->u.contents.option == C_BARE)
+			v->s = xstrdup(subpos);
 	}
 }
 
-- 
2.7.0
