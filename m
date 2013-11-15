From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 6/6] for-each-ref: auto reset color after each atom
Date: Fri, 15 Nov 2013 16:29:08 +0530
Message-ID: <1384513148-22633-7-git-send-email-artagnon@gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 12:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhHGG-0007Px-RG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 12:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350Ab3KOLIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 06:08:25 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:38003 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758331Ab3KOLIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 06:08:15 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so1799913pdj.30
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BByal62tuzMMJjluqNZcsibQAxKaLS3DdYIgB3uY6Xc=;
        b=SQ+vrSEtuNvsVlcCLzgFdQ/89N1JyvahQmkHlNVjWxYs5GAE81S9qKMzSNzj5SUnSr
         UwKe6aCCJ3RNmtA0u19x5gDSwdz1hkcXFqB2Q0wMqLNnpOubMjddCP9gGkW4F0/95g7E
         GJlqqWij6JFpfDmTP1GcDdetP95wkVtLoKilSxjhK0N0JIeR5c2RXuhXfq15Yh4y2GUr
         QF/kX3nJxiTg1CgRHTUEclm3hZcxFlCZfVscmBzpFhqyWFTKRoys1egMAEbPCTo4cYNc
         BY4SqVXlTY8CjwlrfsKobE679EgqjwBfQt1KRTUXov7z08uvKk6x5ieMcjDLVE2x8Oe0
         rFQg==
X-Received: by 10.68.196.3 with SMTP id ii3mr6319704pbc.160.1384513694977;
        Fri, 15 Nov 2013 03:08:14 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id tu6sm3761840pbc.41.2013.11.15.03.08.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2013 03:08:14 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.6.gfd75b41
In-Reply-To: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237905>

It makes it easier to write a sensible format string, since you don't
have to %(color:reset) after each atom. Additionally, to make sure that
an invocation like the following doesn't leak color,

  $ git for-each-ref --format='%(subject)%(color:green)'

auto-reset at the end of the format string as well.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c  | 22 ++++++++++++++++++----
 t/t6300-for-each-ref.sh |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 2ff4e54..1050aea 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -23,6 +23,7 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	int color : 1;
 };
 
 struct ref_sort {
@@ -669,6 +670,7 @@ static void populate_value(struct refinfo *ref)
 
 			color_parse(name + 6, "--format", color);
 			v->s = xstrdup(color);
+			v->color = 1;
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
@@ -914,11 +916,9 @@ static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs
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
@@ -983,17 +983,31 @@ static void emit(const char *cp, const char *ep)
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
+		if (reset_color) {
+			print_value(&resetv, quote_style);
+			reset_color = 0;
+		}
+		if (atomv->color)
+			reset_color = 1;
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
index 35ca991..2bf2bea 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -348,7 +348,7 @@ $(get_color red)$(git rev-parse --short HEAD)$(get_color reset) origin/master
 EOF
 
 test_expect_success 'Check %(color:...) ' '
-	git for-each-ref --format="%(color:red)%(objectname:short)%(color:reset) %(upstream:short)" refs/heads >actual &&
+	git for-each-ref --format="%(color:red)%(objectname:short) %(upstream:short)" refs/heads >actual &&
 	test_cmp expected actual
 '
 
-- 
1.8.5.rc0.6.gfd75b41
