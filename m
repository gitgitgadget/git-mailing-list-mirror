From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/11] ref-fitler: bump match_atom() name to the top
Date: Wed, 16 Dec 2015 20:59:55 +0530
Message-ID: <1450279802-29414-5-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1b-0001Nn-S2
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934149AbbLPP3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:29:53 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33457 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPP3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:29:52 -0500
Received: by mail-pf0-f172.google.com with SMTP id e66so14126026pfe.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WFIkjMh+bqJOrbIiGfzHMVzvgxyy01AeD3LW9hrsCs8=;
        b=JD4oi1lQlSBhUbNB1bsTI95HmELUrGG5vO181Tt/P5r1cGFJVFbpZfRcyWt4N8Q2Th
         Nt7OVJiWJwWGC575hTp4uiTNboTXkN1Afa6WulHCRSxYqHx307guipYAxzmtBcO1xx6E
         zolON1RIXQpJJZ6ZAWkav+f606abRQcBfbenO9H1T7QGYe6Wk4RmQpa83NChbILCbHSj
         ZndU38sj1mZ37ShZ7warUVM7qtVXWkeKr6xWtRPkUbgQKwvbenugbYkknOyC/t7mkJCQ
         B+DOOGkQu04/CCUwpoH093VSWW60DSvU/PTM7qQF1FEoCY6gCoTcpGqIjG2AO+GCbLHX
         R6qw==
X-Received: by 10.98.14.217 with SMTP id 86mr6247343pfo.101.1450279791538;
        Wed, 16 Dec 2015 07:29:51 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:29:50 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282567>

Bump match_atom() to the top for usage in further patches.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 043a02a..f4a6414 100644
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
@@ -260,22 +276,6 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
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
