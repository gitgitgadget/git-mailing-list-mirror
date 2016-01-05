From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 08/15] ref-filter: introduce color_atom_parser()
Date: Tue,  5 Jan 2016 13:33:07 +0530
Message-ID: <1451980994-26865-9-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaI-0007yM-4o
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcAEIDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:04 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33932 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcAEIDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:01 -0500
Received: by mail-pf0-f170.google.com with SMTP id e65so163373000pfe.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qOTXHWE7ebIurmmki4VlGYg8vc+omWZCbN7yEImlVfU=;
        b=YxeLi4AeiwlHbzu8SPGhTh4J5Xcpo+L9f9hdjrKd6s27BrcmlpRdEmWHrq9eR8FZ4n
         5QCyk2a0oenZJVwYAkBt8V66u6HYdSddwlFBYUJ3zAb2aNprVIgmUHkd2Wthl0exeEiC
         k6e3gHdPoS8v2vYKi7SQ/yyEE3b3vlvq2bNXbKLWLWYb/Qmt/4wPGk/ut1cBN14R+7/u
         jriNMF8SCWotdVo/SWe9Ln/QWdmmAKog3dq5cMuTDPsc3kJjkEYf2wUAq97bDtZ0fhm4
         r/VCsSahfEmapm6pJ4xnYnaRTKIcrEaIHJdoDf0eqNtWomjno6/me4AJB3rpM6S2Pw7q
         vwcA==
X-Received: by 10.98.87.69 with SMTP id l66mr52104159pfb.85.1451980980583;
        Tue, 05 Jan 2016 00:03:00 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:00 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283356>

Introduce color_atom_parser() which will parse a "color" atom and
store its color in the "used_atom" structure for further usage in
populate_value().

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index b54c872..9708d67 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -29,6 +29,9 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 static struct used_atom {
 	const char *name;
 	cmp_type type;
+	union {
+		char *color;
+	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
@@ -53,6 +56,18 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
 	return 1;
 }
 
+static void color_atom_parser(struct used_atom *atom)
+{
+	if (!match_atom_name(atom->name, "color", (const char **)&atom->u.color))
+		die("BUG: parsing non-'color'");
+	if (!atom->u.color)
+		die(_("expected format: %%(color:<color>)"));
+	/* atom->u.color points to part of atom->name */
+	atom->u.color = xstrdup(atom->u.color);
+	if (color_parse(atom->u.color, atom->u.color) < 0)
+		die(_("invalid color value: %s"), atom->u.color);
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -90,7 +105,7 @@ static struct {
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
-	{ "color" },
+	{ "color", FIELD_STR, color_atom_parser },
 	{ "align" },
 	{ "end" },
 };
@@ -175,6 +190,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
 		valid_atom[i].parser(&used_atom[at]);
 	if (*atom == '*')
@@ -794,6 +810,7 @@ static void populate_value(struct ref_array_item *ref)
 
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
 		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
@@ -834,14 +851,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
-		} else if (match_atom_name(name, "color", &valp)) {
-			char color[COLOR_MAXLEN] = "";
-
-			if (!valp)
-				die(_("expected format: %%(color:<color>)"));
-			if (color_parse(valp, color) < 0)
-				die(_("unable to parse format"));
-			v->s = xstrdup(color);
+		} else if (starts_with(name, "color:")) {
+			v->s = atom->u.color;
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
-- 
2.6.4
