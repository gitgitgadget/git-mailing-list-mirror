From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 06/11] ref-filter: introduce color_atom_parser()
Date: Wed, 16 Dec 2015 20:59:57 +0530
Message-ID: <1450279802-29414-7-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:30:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1l-0001k8-VS
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934172AbbLPP37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:29:59 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33503 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPP36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:29:58 -0500
Received: by mail-pf0-f180.google.com with SMTP id e66so14127323pfe.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SoaBtGgHkPl922lS4uJiK8IlOi+p5oSuwq/W/+RWjRY=;
        b=Bkq51mwO4Xx/kRuxFjELKRHfBHGg7qVMJ3faovQXAjOSo3NFFGoyRLeOUSSrZfrKGa
         DgGwkbdaU6MsPBhO8n1qIObgwrLjh2ZpIol29KhbW47gHWWP4AJirFYuMjrjhjNea40a
         Gh284Hrkbu6mDFkx6l2Q/Ew4wAnBUjmUww4Nf3tLzlhhkU+r4PMO/ovfr2bKp9vw1wJJ
         V/7ZmvIGN6NgSIsbbDD4NFZqsbxLcRHbOIQcgq8Swy6BDVphnOfsGWMSKyvsVBOjEL7O
         1bDw51DWmMThjakCVVUZNn2gVpdHi3CbuVq62zr0dHCOCZOsSdPB2ZzxamVkOCgFqciI
         vQfQ==
X-Received: by 10.98.70.156 with SMTP id o28mr6254215pfi.43.1450279797995;
        Wed, 16 Dec 2015 07:29:57 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:29:57 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282568>

Introduce color_atom_parser() which will parse a "color" atom and
store its color in the "use_atom" structure for further usage in
'populate_value()'.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7d33b83..3b61c62 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -29,6 +29,9 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 static struct used_atom {
 	const char *str;
 	cmp_type type;
+	union {
+		const char *color;
+	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
@@ -53,6 +56,13 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
 	return 1;
 }
 
+static void color_atom_parser(struct used_atom *atom)
+{
+	match_atom_name(atom->str, "color", &atom->u.color);
+	if (!atom->u.color)
+		die(_("expected format: %%(color:<color>)"));
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -90,7 +100,7 @@ static struct {
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
-	{ "color" },
+	{ "color", FIELD_STR, color_atom_parser },
 	{ "align" },
 	{ "end" },
 };
@@ -175,6 +185,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].str = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
+	if (valid_atom[i].parser)
+		valid_atom[i].parser(&used_atom[at]);
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(used_atom[at].str, "symref"))
@@ -833,12 +846,10 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
-		} else if (match_atom_name(name, "color", &valp)) {
+		} else if (starts_with(name, "color:")) {
 			char color[COLOR_MAXLEN] = "";
 
-			if (!valp)
-				die(_("expected format: %%(color:<color>)"));
-			if (color_parse(valp, color) < 0)
+			if (color_parse(atom->u.color, color) < 0)
 				die(_("unable to parse format"));
 			v->s = xstrdup(color);
 			continue;
-- 
2.6.4
