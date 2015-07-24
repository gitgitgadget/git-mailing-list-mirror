From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 02/10] ref-filter: make the 'color' use ref_formatting_state
Date: Sat, 25 Jul 2015 00:34:37 +0530
Message-ID: <1437764685-8633-3-git-send-email-Karthik.188@gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:05:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiHi-0003TL-Py
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbbGXTFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:05:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35297 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbGXTFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:05:19 -0400
Received: by pabkd10 with SMTP id kd10so18512724pab.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4twcYyvu3UFtuDRSzxzKt+rd91/jDssSu+kGb8Mc0Y=;
        b=XPf9iPYMrt8LF1X8wR0cN8CoUerbWJA2p/oZI0rJqpEgNY1x+WiRfran8K2H+F2isJ
         JWimetixxX3TB0JbDli5k69YdjTdhTPdkoQoyKfHTVFRp6ScwZRn+6WSf7HsjJg9Sk9b
         RDlnOWmRTWd2JI8lBJ4kM7wms9yS+ZUJ4qsSQPC3KT9zw6aNsGN/FY7OGFdq6Layj/HE
         j0pBr1oK30Hw9BrurMXthLdzqPNWPAjwBrZB2BAyMS+YIr24VCUO0eP1cwWStLxrxG1q
         lrpaW3eRGWJEKJpqZwTCUtA5wPWoZTY25/+Y1rLZuIeZHTfpZn2mAl4dkR+fp0BiSUwJ
         XtNw==
X-Received: by 10.66.235.199 with SMTP id uo7mr34047377pac.112.1437764719025;
        Fri, 24 Jul 2015 12:05:19 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ns14sm15922915pdb.17.2015.07.24.12.05.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:05:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274580>

Make color which was considered as an atom, to use
ref_formatting_state and act as a pseudo atom. This allows
interchangeability between 'align' and 'color'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 16 ++++++++++++----
 ref-filter.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3c90ffc..fd13a23 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -663,7 +663,8 @@ static void populate_value(struct ref_formatting_state *state,
 
 			if (color_parse(name + 6, color) < 0)
 				die(_("unable to parse format"));
-			v->s = xstrdup(color);
+			state->color = xstrdup(color);
+			v->pseudo_atom = 1;
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -1217,6 +1218,11 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 static void ref_formatting(struct ref_formatting_state *state, struct atom_value *v,
 			   struct strbuf *value)
 {
+	if (state->color) {
+		strbuf_addstr(value, state->color);
+		free((void *)state->color);
+		state->color = NULL;
+	}
 	if (state->pad_to_right) {
 		if (!is_utf8(v->s))
 			strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
@@ -1224,8 +1230,9 @@ static void ref_formatting(struct ref_formatting_state *state, struct atom_value
 			int len = strlen(v->s) - utf8_strwidth(v->s);
 			strbuf_addf(value, "%-*s", state->pad_to_right + len, v->s);
 		}
-	} else
-		strbuf_addf(value, "%s", v->s);
+		return;
+	}
+	strbuf_addf(value, "%s", v->s);
 }
 
 static void print_value(struct ref_formatting_state *state, struct atom_value *v)
@@ -1326,7 +1333,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
-		resetv.s = color;
+		resetv.s = "";
+		state.color = xstrdup(color);
 		print_value(&state, &resetv);
 	}
 	putchar('\n');
diff --git a/ref-filter.h b/ref-filter.h
index ea2d0e6..bacbb23 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -31,6 +31,7 @@ struct ref_sorting {
 struct ref_formatting_state {
 	unsigned int pad_to_right; /*pad atoms to the right*/
 	int quote_style;
+	const char *color;
 };
 
 struct ref_array_item {
-- 
2.4.6
