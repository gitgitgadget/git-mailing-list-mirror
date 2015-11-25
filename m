From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 10/10] ref-filter: introduce objectname_atom_parser()
Date: Wed, 25 Nov 2015 19:14:42 +0530
Message-ID: <1448459082-24492-1-git-send-email-Karthik.188@gmail.com>
References: <20151124214842.GA4848@sigill.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 14:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1aN8-00008u-48
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 14:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbKYNod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 08:44:33 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35950 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbbKYNob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 08:44:31 -0500
Received: by pabfh17 with SMTP id fh17so7165339pab.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 05:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vgAsY1dSxuUfXMpZQcLup16RGxDVWZAznlTj+uD3zcw=;
        b=DI/I0518RXACLMMeTtwutZ/LWsLTz8ykrJ/bbWOw/6z34ngr9/57+ZWUpkwagYLJvd
         XBbed4RtpuDg4OGwaRxJ1Nl6jxh6g7PCUWQ2QGPSdkD+z445Ih23O1zQs0ROYYfA8KKE
         3A9ORvUql8P5rNFB4qkv8lvS/FHJg1jiJ8mBueOzMXLaAF5STza2BB12ZZDkEUTGW6KT
         r0bAX9mB83a2ZsP32fPqARfjYOKMOuAPybp9LDUx34w77/YlAlv39yAPBTYewlrUUj9N
         hvCmkmr2rs9FQ18d+LHbvenjQUScr29RKG5ZWZSfT2ziKbwc8AEHkLYU6LOxP60SIQrH
         op4Q==
X-Received: by 10.98.80.20 with SMTP id e20mr31189223pfb.23.1448459071081;
        Wed, 25 Nov 2015 05:44:31 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id q65sm21070807pfa.18.2015.11.25.05.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 05:44:30 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <20151124214842.GA4848@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281711>

Introduce objectname_atom_parser() which will parse the
'%(objectname)' atom and store information into the 'used_atom'
structure based on the modifiers used along with the atom.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 117bbbb..f2add19 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -50,6 +50,10 @@ static struct used_atom {
 				lines : 1,
 				no_lines;
 		} contents;
+		struct {
+			unsigned int shorten : 1,
+				full : 1;
+		} objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -123,6 +127,21 @@ void contents_atom_parser(struct used_atom *atom)
 		die(_("improper format entered contents:%s"), buf);
 }
 
+void objectname_atom_parser(struct used_atom *atom)
+{
+	const char * buf;
+
+	if (match_atom_name(atom->str, "objectname", &buf))
+		atom->u.objectname.full = 1;
+
+	if (!buf)
+		return;
+	if (!strcmp(buf, "short"))
+		atom->u.objectname.shorten = 1;
+	else
+		die(_("improper format entered objectname:%s"), buf);
+}
+
 static align_type get_align_position(const char *type)
 {
 	if (!strcmp(type, "right"))
@@ -186,7 +205,7 @@ static struct {
 	{ "refname", FIELD_STR },
 	{ "objecttype", FIELD_STR },
 	{ "objectsize", FIELD_ULONG },
-	{ "objectname", FIELD_STR },
+	{ "objectname", FIELD_STR, objectname_atom_parser },
 	{ "tree", FIELD_STR },
 	{ "parent", FIELD_STR },
 	{ "numparent", FIELD_ULONG },
@@ -463,15 +482,16 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
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
+		if (atom->u.objectname.shorten) {
+			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			return 1;
+		} else if (atom->u.objectname.full) {
+			v->s = xstrdup(sha1_to_hex(sha1));
+			return 1;
+		}
 	}
 	return 0;
 }
@@ -495,7 +515,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->sha1, v);
+			grab_objectname(name, obj->sha1, v, &used_atom[i]);
 	}
 }
 
@@ -1004,7 +1024,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
+		} else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
-- 
2.6.2
