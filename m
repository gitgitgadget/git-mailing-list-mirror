From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 15/15] ref-filter: introduce objectname_atom_parser()
Date: Tue,  5 Jan 2016 13:33:14 +0530
Message-ID: <1451980994-26865-16-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaZ-0008BI-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbcAEIDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:22 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36076 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbcAEIDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:15 -0500
Received: by mail-pa0-f53.google.com with SMTP id yy13so118735158pab.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMmcH4GDbxZ6NBiB+AiGZSdCsRH1POFf2y1oEiJQ5nM=;
        b=BhFUBVu3z0+12ILC7XxHZeW/dDaUicNrr5OZf/I6iCCLg2VgCYsGSEDaY0P8CBkq/v
         hQ7viiTknLP1MXl+KpZvfyxnXmsygy10IwtiTpb21EEpWCuejI4oBa685kv3boprJUvj
         ky6LgXLnnH8cUbmJVxSzO5mny1okmXmDjxNO89dEzaqRZP2AEZ/OJ1u5oextxm4h8RcB
         0qLHxMHO6BfPHfUsTXI/ETWOA5jbFJbYzC7UMTdiN9ygEyCjVv0e98XrLBm/Tk8xXNt+
         3KEiij1b+9VREkDsiAwVjnKi5DC0WynNmdjC/2OkBlll83IHsjyZFB2xzi7A7uOFNhL1
         D7AA==
X-Received: by 10.66.250.165 with SMTP id zd5mr59160167pac.9.1451980995111;
        Tue, 05 Jan 2016 00:03:15 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:14 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283361>

Introduce objectname_atom_parser() which will parse the
'%(objectname)' atom and store information into the 'used_atom'
structure based on the modifiers used along with the atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9e61530..57b4280 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -43,6 +43,7 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
 			unsigned int nlines;
 		} contents;
+		enum { O_FULL, O_SHORT } objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -129,6 +130,20 @@ static void contents_atom_parser(struct used_atom *atom)
 		die(_("unrecognized %%(contents) argument: %s"), buf);
 }
 
+static void objectname_atom_parser(struct used_atom *atom)
+{
+	const char * buf;
+
+	if (!match_atom_name(atom->name, "objectname", &buf))
+		die("BUG: parsing non-'objectname'");
+	if (!buf)
+		atom->u.objectname = O_FULL;
+	else if (!strcmp(buf, "short"))
+		atom->u.objectname = O_SHORT;
+	else
+		die(_("unrecognized %%(objectname) argument: %s"), buf);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -190,7 +205,7 @@ static struct {
 	{ "refname" },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
-	{ "objectname" },
+	{ "objectname", FIELD_STR, objectname_atom_parser },
 	{ "tree" },
 	{ "parent" },
 	{ "numparent", FIELD_ULONG },
@@ -467,15 +482,17 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
 }
 
 static int grab_objectname(const char *name, const unsigned char *sha1,
-			    struct atom_value *v)
+			   struct atom_value *v, struct used_atom *atom)
 {
-	if (!strcmp(name, "objectname")) {
-		v->s = xstrdup(sha1_to_hex(sha1));
-		return 1;
-	}
-	if (!strcmp(name, "objectname:short")) {
-		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
-		return 1;
+	if (starts_with(name, "objectname")) {
+		if (atom->u.objectname == O_SHORT) {
+			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			return 1;
+		} else if (atom->u.objectname == O_FULL) {
+			v->s = xstrdup(sha1_to_hex(sha1));
+			return 1;
+		} else
+			die("BUG: unknown %%(objectname) option");
 	}
 	return 0;
 }
@@ -499,7 +516,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->sha1, v);
+			grab_objectname(name, obj->sha1, v, &used_atom[i]);
 	}
 }
 
@@ -1001,7 +1018,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
+		} else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
-- 
2.6.4
