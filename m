From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Thu, 30 Jul 2015 21:18:43 +0530
Message-ID: <1438271332-10615-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
 <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:49:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKq4q-0003EL-EO
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbbG3Psz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:48:55 -0400
Received: from mail-pd0-f194.google.com ([209.85.192.194]:33903 "EHLO
	mail-pd0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbG3Psy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:48:54 -0400
X-Greylist: delayed 767 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2015 11:48:54 EDT
Received: by pdav4 with SMTP id v4so2288704pda.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1B+yzd8IWa4SHffr5AruXEMtG3HcXxEjzcb7Qmbw7s=;
        b=yZdCFC1cltZPn8ESn2UHht+9R3MMnMGmeSvzprN2I4vz0szpEoHsdqc7QDpvX7NiC2
         4WyhnPKyxtbra+0fJeeXnWe9StUbOMyRtEaIaAN0Xxv1uqaWX566jkGo2UIzzy1Ml5aN
         sljp6kmwRR4oVDXPKO2Qzhb7yEaNccFChwK6eq/yD8ZleH7C6UXondphZ9+XLMTxcd1s
         r6vo+iBBp+YAqLm8eK6GYQb3HhCBkJaEWH1K/Y4c70Bge/lAqb0Z7Gh/rSKEabXSSIeb
         JJXDpIuok1y7B6FZ/Nw+0238ACQ1n2Oto0di143zXMX4tPxF6+B0O2FUVs1tN402CYsN
         Q8Hg==
X-Received: by 10.70.128.226 with SMTP id nr2mr109107194pdb.139.1438271333861;
        Thu, 30 Jul 2015 08:48:53 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id cz1sm2875338pdb.44.2015.07.30.08.48.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:48:53 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275003>

Convert the 'color' atom to behave as a modifier atom and make it use
'ref_formatting_state' which was introduced in the previous patch.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 10 ++++++++--
 ref-filter.h |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d6510a6..9a63d25 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -662,6 +662,8 @@ static void populate_value(struct ref_array_item *ref)
 			if (color_parse(name + 6, color) < 0)
 				die(_("unable to parse format"));
 			v->s = xstrdup(color);
+			v->color = 1;
+			v->modifier_atom = 1;
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -1195,7 +1197,10 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 static void apply_formatting_state(struct ref_formatting_state *state,
 				   const char *buf, struct strbuf *value)
 {
-	/* Eventually we'll format based on the ref_formatting_state */
+	if (state->color) {
+		strbuf_addstr(value, state->color);
+		state->color = NULL;
+	}
 	strbuf_addstr(value, buf);
 }
 
@@ -1278,7 +1283,8 @@ static void emit(const char *cp, const char *ep,
 static void store_formatting_state(struct ref_formatting_state *state,
 				   struct atom_value *atomv)
 {
-	/*  Here the 'ref_formatting_state' variable will be filled */
+	if (atomv->color)
+		state->color = atomv->s;
 }
 
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
diff --git a/ref-filter.h b/ref-filter.h
index 12e6a6b..5d33360 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,11 +19,13 @@
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
-	unsigned int modifier_atom : 1; /*  atoms which act as modifiers for the next atom */
+	unsigned int modifier_atom : 1, /*  atoms which act as modifiers for the next atom */
+		color : 1;
 };
 
 struct ref_formatting_state {
 	int quote_style;
+	const char *color;
 };
 
 struct ref_sorting {
-- 
2.4.6
