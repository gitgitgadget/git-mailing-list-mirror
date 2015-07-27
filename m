From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Mon, 27 Jul 2015 12:57:06 +0530
Message-ID: <1437982035-6658-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 09:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJcom-0000ai-3G
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbbG0H1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:27:18 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35562 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbG0H1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:27:16 -0400
Received: by pdrg1 with SMTP id g1so47355988pdr.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3n1rOwbCSCdESOxbXbfcmrL8PISgE3cO1VZwL5q6kVU=;
        b=mw1PuGJVBKE0qE3qICuv3xQwJvIrL0NwuhZPbwFrTtdO1kFovSquFDQLHZi/mVwY6E
         BYfTIBb+MgBYe/9BzFYobd611ydf27GqfEiruZAVO5ennzYWT5quDE6VQJPtklh02yIs
         hRwJ8A+9p6ADY5m2GA/HN/C3Uez2qnsOnRzjjRklQYlfB5ixaD0aV4FpYOFD40nniXgT
         NRgbx44Nf5KDHWT2uRy5DNuNAVgk49DfamqBhhPd5zUijC6QJMqIchRBRd0c3krE7Uug
         lY064Sdtf/0oPUxLIomtq/lNL/U2Fvemw6ha76iUugjsKPMz0I0jFeyteAmbaE85h4Z0
         wXWA==
X-Received: by 10.70.3.98 with SMTP id b2mr65280736pdb.107.1437982036229;
        Mon, 27 Jul 2015 00:27:16 -0700 (PDT)
Received: from ashley.localdomain ([106.51.241.234])
        by smtp.gmail.com with ESMTPSA id wv4sm27732769pac.2.2015.07.27.00.27.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 00:27:15 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274652>

Make the `color` atom a pseudo atom and ensure that it uses
`ref_formatting_state`.
---
 ref-filter.c | 19 ++++++++++++++++++-
 ref-filter.h |  4 +++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index a3625e8..cc25c85 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -662,6 +662,8 @@ static void populate_value(struct ref_array_item *ref)
 			if (color_parse(name + 6, color) < 0)
 				die(_("unable to parse format"));
 			v->s = xstrdup(color);
+			v->pseudo_atom = 1;
+			v->color = 1;
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -1195,6 +1197,11 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 static void ref_formatting(struct ref_formatting_state *state,
 			   struct atom_value *v, struct strbuf *value)
 {
+	if (state->color) {
+		strbuf_addstr(value, state->color);
+		free(state->color);
+		state->color = NULL;
+	}
 	strbuf_addf(value, "%s", v->s);
 }
 
@@ -1266,6 +1273,13 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
+static void apply_pseudo_state(struct ref_formatting_state *state,
+			       struct atom_value *v)
+{
+	if (v->color)
+		state->color = (char *)v->s;
+}
+
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
@@ -1281,7 +1295,10 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		if (cp < sp)
 			emit(cp, sp);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		print_value(&state, atomv);
+		if (atomv->pseudo_atom)
+			apply_pseudo_state(&state, atomv);
+		else
+			print_value(&state, atomv);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
diff --git a/ref-filter.h b/ref-filter.h
index f24e3ef..7687879 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,11 +19,13 @@
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
-	unsigned int pseudo_atom : 1; /*  atoms which aren't placeholders for ref attributes */
+	unsigned int pseudo_atom : 1, /*  atoms which aren't placeholders for ref attributes */
+		color : 1;
 };
 
 struct ref_formatting_state {
 	int quote_style;
+	char *color;
 };
 
 struct ref_sorting {
-- 
2.4.6
