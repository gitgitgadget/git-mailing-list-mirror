From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Sun, 19 Jul 2015 00:42:21 +0530
Message-ID: <1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 21:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGXXQ-0001DM-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 21:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbbGRTMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 15:12:39 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33746 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbGRTMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 15:12:38 -0400
Received: by pdbnt7 with SMTP id nt7so8480290pdb.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0oEw65BEf4htq47lbpXnoGnR1ehPSDDLC14sKSnbAgM=;
        b=cJyStFbjrMJMb9wj2YhrWAhmh3bFzFYcHCQMbtLVkgZQyXcoALuX+1dTevLaOIg1ft
         4yFwQEUl0LQlg92N8D8GpmXnLsiWpAjQBWchXhttv0eU6VDVdFBXXa0I2Nlqm5W+6GIH
         vRbMNeCX2q3IZYwbHRFNtpXtqawc/FuNAq33qfHyFaGOyKb5BurbDdNdprjZnHSXiCLR
         FMyqmCTU/gJtOJk4UE8IOmbgpGsWotZ0gX0khfLbSA6aGc0jOIOZPaNxHbn98Lmys/xF
         6bQH0MbqOAYH5O0dqEtsruAcMeZFXwiRdNEeHpK/3mB5FGV2jou1SY7DTq8imLYOTXGI
         Vjzw==
X-Received: by 10.70.128.101 with SMTP id nn5mr20854244pdb.56.1437246758330;
        Sat, 18 Jul 2015 12:12:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ra10sm15104498pab.19.2015.07.18.12.12.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jul 2015 12:12:37 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274169>

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
 ref-filter.c | 39 +++++++++++++++++++++++++++++++++++++--
 ref-filter.h |  1 +
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7561727..b81a08d 100644
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
+				die(_("No value given with 'align='"));
+			strtoul_ui(valp, 10, &ref->align_value);
+			if (ref->align_value < 1)
+				die(_("Value should be greater than zero"));
+			v->s = "";
+			continue;
 		} else
 			continue;
 
@@ -1254,17 +1268,38 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
+static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct atom_value *v)
+{
+	if (v->s[0] && ref->align_value) {
+		unsigned int len = 0;
+
+		len = utf8_strwidth(v->s);
+		if (ref->align_value > len) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addstr(&buf, v->s);
+			if (!v->s[0])
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
