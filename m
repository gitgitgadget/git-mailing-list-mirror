From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 05/10] ref-filter: introduce color_atom_parser()
Date: Thu, 12 Nov 2015 01:14:31 +0530
Message-ID: <1447271075-15364-6-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbJu-00062Z-0J
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbbKKTod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:33 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36623 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbKKTob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:31 -0500
Received: by pabfh17 with SMTP id fh17so5361108pab.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pw6g8iKXye0f9fd4j9jo22svUYeB+pOHhP0ksQh3dA8=;
        b=saShP3ovueVyv13cSOy57fAVBfkkbvh82iLJQmmoTBPTVtRZdfSokhQEmGXAulgbyw
         nZvaPAmKgc4cEkI78ZM/JJ8BCiukFPiuPhh6TwdQ/m8HMs8NlL9c3QOlGOuAC1bQHD9h
         ZL3i1/SRd/Czx224+XyRuk/EO7OFw3OXokJIF3Qm6HBLNblrgbBNaMS4ODC9mhZk0W/j
         4qpYuj0YvCXqcHap8viATdMWaGQLNF/iZdGkrKnS7BByLehFvPciMQQiMQQ/cEnzXIpY
         Az2khiJyPKb/5GRCmKb3wXwaGNnmIC/WP7zYmuZLZN/nz5SW7tZ5uIZCTuF0uQ7mWa9i
         xcHw==
X-Received: by 10.68.104.229 with SMTP id gh5mr17155038pbb.130.1447271070934;
        Wed, 11 Nov 2015 11:44:30 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:30 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281182>

Introduce color_atom_parser() which will parse a "color" atom and
store its color in the "use_atom" structure for further usage in
'populate_value()'.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4af28ef..0523d54 100644
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
 
+void color_atom_parser(struct used_atom *atom)
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
 	{ "symref", FIELD_STR },
 	{ "flag", FIELD_STR },
 	{ "HEAD", FIELD_STR },
-	{ "color", FIELD_STR },
+	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR },
 	{ "end", FIELD_STR },
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
@@ -833,11 +846,10 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
-		} else if (match_atom_name(name, "color", &valp)) {
+		} else if (starts_with(name, "color")) {
 			char color[COLOR_MAXLEN] = "";
+			const char *valp = atom->u.color;
 
-			if (!valp)
-				die(_("expected format: %%(color:<color>)"));
 			if (color_parse(valp, color) < 0)
 				die(_("unable to parse format"));
 			v->s = xstrdup(color);
-- 
2.6.2
