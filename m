From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 22:52:27 +0530
Message-ID: <1437412947-17555-1-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT7szz=cwzEmVDPKucRbh2o_8mBhUY22=R8qCU34QPwGg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 19:22:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHElt-0005DA-9Z
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 19:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbbGTRW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 13:22:29 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36513 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbbGTRW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 13:22:28 -0400
Received: by pachj5 with SMTP id hj5so104455771pac.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IqFEbl2rmIjWZk9JcfgrqtA1QNOa84asYx0RFqRb/6o=;
        b=ie7uVAmyzhKTQJpWK3sjRsaUvAJw2RQ7tVknB+NUAu6Q9kf3YbL7q84KmRDdcAxCqT
         8IsTeV87JbvSvwvdAvpi5HCwRAhuUdB+g6AjIPX85IPahAKQ0TUXi16qXgTQ0vwM2B4G
         QtUZ9WhZ2Lj+LIoHsh9ElqiVzjbZMUc3IzSf4fuK0jSM6qkMEWC8h/+5E377PGDTlpp1
         CuMCslogLWDEDw/yx1RP6c7l1kxqWrZLkJ6d1+VHyLD050B0ym2id5MSJFcuLvrWVQOJ
         iZRI8cqrCayU0+Ob27NHkBhcQ9CerPeopc6ngUVlz3mQt4rak1Saghys3QFs6XUV5N6N
         PZXw==
X-Received: by 10.66.222.41 with SMTP id qj9mr63234188pac.139.1437412948001;
        Mon, 20 Jul 2015 10:22:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id bx7sm22851602pdb.82.2015.07.20.10.22.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jul 2015 10:22:26 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZT7szz=cwzEmVDPKucRbh2o_8mBhUY22=R8qCU34QPwGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274332>

From: Karthik Nayak <karthik.188@gmail.com>

Add a new atom "align" and support %(align:X) where X is a number.
This will align the preceeding atom value to the left followed by
spaces for a total length of X characters. If X is less than the item
size, the entire atom value is printed.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 41 +++++++++++++++++++++++++++++++++++++++--
 ref-filter.h |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7561727..93f59aa 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,8 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
+#include "git-compat-util.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -53,6 +55,7 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "align" },
 };
 
 /*
@@ -620,7 +623,7 @@ static void populate_value(struct ref_array_item *ref)
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
-		const char *refname;
+		const char *refname = NULL;
 		const char *formatp;
 		struct branch *branch = NULL;
 
@@ -687,6 +690,17 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (starts_with(name, "align:")) {
+			const char *valp = NULL;
+
+			skip_prefix(name, "align:", &valp);
+			if (!valp[0])
+				die(_("no value given with 'align:'"));
+			strtoul_ui(valp, 10, &ref->align_value);
+			if (ref->align_value < 1)
+				die(_("value should be greater than zero: align:%u"), ref->align_value);
+			v->s = "";
+			continue;
 		} else
 			continue;
 
@@ -1254,17 +1268,40 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
+static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct atom_value *v)
+{
+	if (ref->align_value && !starts_with(used_atom[parsed_atom], "align")) {
+		unsigned int len = 0;
+
+		if (*v->s)
+			len = utf8_strwidth(v->s);
+		if (ref->align_value > len) {
+			struct strbuf buf = STRBUF_INIT;
+			if (*v->s)
+				strbuf_addstr(&buf, v->s);
+			if (*v->s && v->s[0] == '\0')
+				free((char *)v->s);
+			strbuf_addchars(&buf, ' ', ref->align_value - len);
+			v->s = strbuf_detach(&buf, NULL);
+		}
+		ref->align_value = 0;
+	}
+}
+
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
+		int parsed_atom;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
-		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
+		parsed_atom = parse_ref_filter_atom(sp + 2, ep);
+		get_ref_atom_value(info, parsed_atom, &atomv);
+		assign_formating(info, parsed_atom, atomv);
 		print_value(atomv, quote_style);
 	}
 	if (*cp) {
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..12ffbc5 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -30,6 +30,7 @@ struct ref_sorting {
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
+	unsigned int align_value;
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
-- 
2.4.6
