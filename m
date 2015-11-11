From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 03/10] ref-fitler: bump match_atom() name to the top
Date: Thu, 12 Nov 2015 01:14:29 +0530
Message-ID: <1447271075-15364-4-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbJs-00062Z-Px
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbbKKTo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:29 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33426 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKKTo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:27 -0500
Received: by padfb7 with SMTP id fb7so5385729pad.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mc2Y6gLVihEYXJ8XL6phVpN0ArrLRKmtAo0XgYmgIgI=;
        b=cu8poxmo4lJp9Ke5wDtYFFCojAewIS07Z3nhXuE5GTQJU5gyooZDZ8PxHETo+nCP2T
         yw52lDKFP30SEEYN+t/TNJE9SAGNVytlRp9XmXqA5UErAcd3shnURYNo6rkHWhvlGAQI
         FtbGaNMv5wuXSBgYiOmaguSkFv4kq0SwxwXY5Ukjqd4/HfwrlcIxiPJ86HenQEmsLdHe
         9BnSAZSQNpjjgOcZxSd5x8DYW7OBpVpnrS3I4GN8wy2hn3nK5mbs/ELQQOYCzjXEbPum
         J48AC84kbhgHh2vhGsC3eHZRUGw0rltecMEEkFdO1bkyovBfPhZZSvFQxYtjXX5fwEaq
         Ec8A==
X-Received: by 10.67.4.38 with SMTP id cb6mr17052857pad.34.1447271066590;
        Wed, 11 Nov 2015 11:44:26 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:26 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281185>

Bump match_atom() to the top for usage in further patches.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 748a2fe..1542f5f 100644
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
2.6.2
