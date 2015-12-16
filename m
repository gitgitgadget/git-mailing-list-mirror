From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 11/11] ref-filter: introduce objectname_atom_parser()
Date: Wed, 16 Dec 2015 21:00:02 +0530
Message-ID: <1450279802-29414-12-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:30:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E21-0002Fp-2a
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965436AbbLPPaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:30:17 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34563 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964855AbbLPPaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:30:14 -0500
Received: by mail-pa0-f49.google.com with SMTP id wq6so25157501pac.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=puLVwPX6q9EjQccCdmS5PU77dzSrWrQ129g94gm1x/Y=;
        b=YEJeXRGmE5PwuEyafRtFwYAx5qnLv0TWGoKRnlbftmrWlxhV6SewjbgHB8jGJuU+mf
         sg70usVZwu6M3BA0Vx6ge59FAxIOoxTUXxzV7Nt+KkbdEPxePU0P3ktv5mkufzziVXDB
         WmGzH+BOX8HjQgHVw/oshI0MPjWsurqL99120F1It6lX3Hgo0FQ526r4BW7ZouIzgoLj
         rYQrBEdKc99M4WOS+lVsjz20Af9HnibBvPTgJIn22PddmyDhYNDS4oH7vXMn3KNFNTT4
         tc/oGp4BS6s7hsnwQYwN7pw8w3e6PiSRjDEzu1XfeVuqlf8z4mmM3grpyP+EBP7iYwt9
         IPaA==
X-Received: by 10.66.228.225 with SMTP id sl1mr64341128pac.63.1450279813908;
        Wed, 16 Dec 2015 07:30:13 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:30:13 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282572>

Introduce objectname_atom_parser() which will parse the
'%(objectname)' atom and store information into the 'used_atom'
structure based on the modifiers used along with the atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ce02933..a8fd178 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -43,6 +43,7 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
 			unsigned int no_lines;
 		} contents;
+		enum { O_FULL, O_SHORT } objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -124,6 +125,21 @@ static void contents_atom_parser(struct used_atom *atom)
 		die(_("unrecognized %%(contents) argument: %s"), buf);
 }
 
+static void objectname_atom_parser(struct used_atom *atom)
+{
+	const char * buf;
+
+	if (match_atom_name(atom->str, "objectname", &buf))
+		atom->u.objectname = O_FULL;
+	if (!buf)
+		return;
+
+	if (!strcmp(buf, "short"))
+		atom->u.objectname = O_SHORT;
+	else
+		die(_("unrecognized %%(objectname) argument: %s"), buf);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -184,7 +200,7 @@ static struct {
 	{ "refname" },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
-	{ "objectname" },
+	{ "objectname", FIELD_STR, objectname_atom_parser },
 	{ "tree" },
 	{ "parent" },
 	{ "numparent", FIELD_ULONG },
@@ -461,15 +477,16 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
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
+		}
 	}
 	return 0;
 }
@@ -493,7 +510,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->sha1, v);
+			grab_objectname(name, obj->sha1, v, &used_atom[i]);
 	}
 }
 
@@ -999,7 +1016,7 @@ static void populate_value(struct ref_array_item *ref)
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
