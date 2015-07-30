From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Thu, 30 Jul 2015 21:05:43 +0530
Message-ID: <1438270552-10333-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:36:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKpsG-000114-AP
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbbG3Pfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:35:55 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:33868 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbG3Pfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:35:55 -0400
Received: by pdav4 with SMTP id v4so2266914pda.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1B+yzd8IWa4SHffr5AruXEMtG3HcXxEjzcb7Qmbw7s=;
        b=fUVuwkDn0wMehFFO87woKhnDsDKkIqmCb1gDZqcMv7WDHZoRTnlADyIcRUDIbfMK+O
         lrNMR8n/SRBwfRx4nsAuQsw+8mx0hsi2pI852YCLHxHdxq+FIoijAGS0pTxkhm6LtbFn
         urA86bOLMP9N5GcF9kcC+ogbjQG0vBpEanYyETl7QSg+WwJfuSJqRdqhBW4/UqCacNoE
         bT1R6XNX7yT8trnritPIFT9Dgh8sIXFaLC2jq7er8MA0kgZNuZS2/6AXg2uvdjdrcVN/
         A51rkMtZvMWfqCaMunXictpZB124ZGxHPIJ3ZxDK8aY4dr/8/UpKb9Rr3iQAAt5gi8Ge
         6E3g==
X-Received: by 10.70.48.137 with SMTP id l9mr26309003pdn.45.1438270553532;
        Thu, 30 Jul 2015 08:35:53 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id oq10sm2790985pdb.75.2015.07.30.08.35.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:35:52 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274993>

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
