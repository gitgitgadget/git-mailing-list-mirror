From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 06/15] ref-fitler: bump match_atom() name to the top
Date: Tue,  5 Jan 2016 13:33:05 +0530
Message-ID: <1451980994-26865-7-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaH-0007yM-IH
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbcAEIC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:02:59 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36539 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcAEIC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:56 -0500
Received: by mail-pf0-f173.google.com with SMTP id 65so171297579pff.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQAKZOuduQEj7wSwE72ohI7uyiwsIX/QpLRB3naFa5M=;
        b=P3MW48E+70QF2hrG8H+buDi7kaUP74wsNBGF1KJYmMh8b8top84dRAwhAXMYRB29kg
         iedxsqmuqA/ilWzTuwzlQvSBFBCTMcEiIq/cWUKvu2eaBO3RwyeUdenv5PCBUpkfh++u
         bT7eb+0XWhzDEv6YZ7IfiXCdiqXkdFZ0tlOvY7UzaqEW8sFO4eOvb+LtKHUAei6UTgG3
         I+buu7T7Voeu2/gSWS1PKYEqeQBQ6NT2AEhvFGYPQYXQ/k3hhIHFYn7SoKEUeK+30HXb
         9UoMwaOR1zGmtYsFVJ8Wg5AbqmKNdnNM/kSi/tODL/kKoqgiBCW46iAIrqisJkoLv6eZ
         ugSg==
X-Received: by 10.98.66.209 with SMTP id h78mr130327348pfd.29.1451980976435;
        Tue, 05 Jan 2016 00:02:56 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:55 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283357>

Bump match_atom() to the top for usage in further patches.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index efa247a..575d293 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -33,6 +33,22 @@ static struct used_atom {
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
 
+static int match_atom_name(const char *name, const char *atom_name, const char **val)
+{
+	const char *body;
+
+	if (!skip_prefix(name, atom_name, &body))
+		return 0; /* doesn't even begin with "atom_name" */
+	if (!body[0]) {
+		*val = NULL; /* %(atom_name) and no customization */
+		return 1;
+	}
+	if (body[0] != ':')
+		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
+	*val = body + 1; /* "atom_name:val" */
+	return 1;
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -262,22 +278,6 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	pop_stack_element(&state->stack);
 }
 
-static int match_atom_name(const char *name, const char *atom_name, const char **val)
-{
-	const char *body;
-
-	if (!skip_prefix(name, atom_name, &body))
-		return 0; /* doesn't even begin with "atom_name" */
-	if (!body[0]) {
-		*val = NULL; /* %(atom_name) and no customization */
-		return 1;
-	}
-	if (body[0] != ':')
-		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
-	*val = body + 1; /* "atom_name:val" */
-	return 1;
-}
-
 /*
  * In a format string, find the next occurrence of %(atom).
  */
-- 
2.6.4
