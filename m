From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 6/6] for-each-ref: avoid color leakage
Date: Mon, 18 Nov 2013 23:09:13 +0530
Message-ID: <1384796353-18701-7-git-send-email-artagnon@gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSwP-0004Az-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab3KRRst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:48:49 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:64653 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3KRRsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:48:45 -0500
Received: by mail-pa0-f48.google.com with SMTP id bj1so7038990pad.35
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yxbQPDpT7RnYDo9SZrGGQDULMEi620Nz48jOcbkL3Zw=;
        b=cPC4mSv+LL4GuuJuX2U2p2BBoVu3ocVjO/jG/DV0DVN0/wo/JppTyb6sBwHCOnU62C
         5EndD92wMnllfCx6KlLGEH7mOAaax07kYMd/KUMZImoUr32kxfBeutpqkdLUhRn/WFpt
         0FL7aYcgfoz7Y6QZQ1k7ysuH7s56F1GgIolwYFSxio2o3R/2rsS40MUqRnnLbXJS+gwC
         tgHgovbogo0V1jBoX7WvlAwDJBMxgXjCCag1Ga2SIqDxGQo6lZWDyMP2myfcUYJaU7wf
         ohAnWBRxc98+a+xWO1cAvUA4oGl82Tp57yhsrEr/EWY7drmM+hzBN5dZD2WJaMaaE1k2
         D/xQ==
X-Received: by 10.68.164.33 with SMTP id yn1mr14601271pbb.89.1384796924586;
        Mon, 18 Nov 2013 09:48:44 -0800 (PST)
Received: from localhost.localdomain ([122.164.173.226])
        by mx.google.com with ESMTPSA id hu10sm24836183pbc.11.2013.11.18.09.48.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 09:48:44 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.5.g70ebc73.dirty
In-Reply-To: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238001>

To make sure that an invocation like the following doesn't leak color,

  $ git for-each-ref --format='%(subject)%(color:green)'

auto-reset at the end of the format string when the last color token
seen in the format string isn't a color-reset.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c  | 29 +++++++++++++++++++++++++----
 t/t6300-for-each-ref.sh |  2 +-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 2ff4e54..04e35ba 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -23,6 +23,7 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	int color : 2; /* 1 indicates color, 2 indicates color-reset */
 };
 
 struct ref_sort {
@@ -668,6 +669,10 @@ static void populate_value(struct refinfo *ref)
 			char color[COLOR_MAXLEN] = "";
 
 			color_parse(name + 6, "--format", color);
+			if (!strcmp(name + 6, "reset"))
+				v->color = 2;
+			else
+				v->color = 1;
 			v->s = xstrdup(color);
 			continue;
 		} else if (!strcmp(name, "flag")) {
@@ -914,11 +919,9 @@ static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs
 	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
 }
 
-static void print_value(struct refinfo *ref, int atom, int quote_style)
+static void print_value(struct atom_value *v, int quote_style)
 {
-	struct atom_value *v;
 	struct strbuf sb = STRBUF_INIT;
-	get_value(ref, atom, &v);
 	switch (quote_style) {
 	case QUOTE_NONE:
 		fputs(v->s, stdout);
@@ -983,17 +986,35 @@ static void emit(const char *cp, const char *ep)
 static void show_ref(struct refinfo *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct atom_value *atomv, resetv;
+	int reset_color = 0;
+	char color[COLOR_MAXLEN] = "";
 
+	color_parse("reset", "--format", color);
+	resetv.s = color;
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
-		print_value(info, parse_atom(sp + 2, ep), quote_style);
+		get_value(info, parse_atom(sp + 2, ep), &atomv);
+		print_value(atomv, quote_style);
+
+		/*
+		 * reset_color is used to avoid color leakage; it
+		 * should be set when the last color atom is not a
+		 * color-reset.
+		 */
+		if (atomv->color == 1)
+			reset_color = 1;
+		else if (atomv->color == 2)
+			reset_color = 0;
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
 		emit(cp, sp);
 	}
+	if (reset_color)
+		print_value(&resetv, quote_style);
 	putchar('\n');
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 69e3155..46866ba 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -356,7 +356,7 @@ $(git rev-parse --short refs/tags/two) $(get_color green)two$(get_color reset)
 EOF
 
 test_expect_success 'Check %(color:...) ' '
-	git for-each-ref --format="%(objectname:short) %(color:green)%(refname:short)%(color:reset)" >actual &&
+	git for-each-ref --format="%(objectname:short) %(color:green)%(refname:short)" >actual &&
 	test_cmp expected actual
 '
 
-- 
1.8.5.rc0.5.g70ebc73.dirty
