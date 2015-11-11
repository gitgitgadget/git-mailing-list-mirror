From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 01/10] ref-filter: introduce a parsing function for each atom in valid_atom
Date: Thu, 12 Nov 2015 01:14:27 +0530
Message-ID: <1447271075-15364-2-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbJr-00062Z-JF
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbbKKToY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:24 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34857 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKKToX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:23 -0500
Received: by padhk6 with SMTP id hk6so5331053pad.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x79ppZnqgF0Pjg7Szip/Hao5TUpjHt3QBMMhUBK+JvI=;
        b=vYFbBvabggNUAhLtOZYbLC/878Hwme3cUa1OLcn0RhfT0oxUuZkM0eHKyGeSEL9zGK
         2/T18Bzb4SBPBGLAFCE2LW0Kf41XaIdvOkpiHkX6n82Hz/sfqQiRnd+sucBcFydBehGV
         t+gS9d4alHq4ZfTdrerzUaKCpGZ3yCX8n84NySs+Z+HO9FnMCyHX+ApQA9I7GJSfOeH3
         xMVqj8o3G3OOitkMlm6wZReEJMwHMGaZojXb75vs0PpoKL2pzAjFcWeTXW2Uau0cp3sy
         7QLFq4N1oTiUdeP5pQ4PDDjG5gvB3+42xl2ymxnIwdRrKvnUI9kfxB1ynvyhUSiFpZTL
         7tAA==
X-Received: by 10.66.228.33 with SMTP id sf1mr16777707pac.132.1447271062241;
        Wed, 11 Nov 2015 11:44:22 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:21 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281181>

Introduce a parsing function for each atom in valid_atom. Using this
we can define special parsing functions for each of the atoms. Since
we have a third field in valid_atom structure, we now fill out missing
cmp_type values.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e205dd2..fbbda17 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -19,42 +19,43 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 static struct {
 	const char *name;
 	cmp_type cmp_type;
+	void (*parser)(struct used_atom *atom);
 } valid_atom[] = {
-	{ "refname" },
-	{ "objecttype" },
+	{ "refname", FIELD_STR },
+	{ "objecttype", FIELD_STR },
 	{ "objectsize", FIELD_ULONG },
-	{ "objectname" },
-	{ "tree" },
-	{ "parent" },
+	{ "objectname", FIELD_STR },
+	{ "tree", FIELD_STR },
+	{ "parent", FIELD_STR },
 	{ "numparent", FIELD_ULONG },
-	{ "object" },
-	{ "type" },
-	{ "tag" },
-	{ "author" },
-	{ "authorname" },
-	{ "authoremail" },
+	{ "object", FIELD_STR },
+	{ "type", FIELD_STR },
+	{ "tag", FIELD_STR },
+	{ "author", FIELD_STR },
+	{ "authorname", FIELD_STR },
+	{ "authoremail", FIELD_STR },
 	{ "authordate", FIELD_TIME },
-	{ "committer" },
-	{ "committername" },
-	{ "committeremail" },
+	{ "committer", FIELD_STR },
+	{ "committername", FIELD_STR },
+	{ "committeremail", FIELD_STR },
 	{ "committerdate", FIELD_TIME },
-	{ "tagger" },
-	{ "taggername" },
-	{ "taggeremail" },
+	{ "tagger", FIELD_STR },
+	{ "taggername", FIELD_STR },
+	{ "taggeremail", FIELD_STR },
 	{ "taggerdate", FIELD_TIME },
-	{ "creator" },
+	{ "creator", FIELD_STR },
 	{ "creatordate", FIELD_TIME },
-	{ "subject" },
-	{ "body" },
-	{ "contents" },
-	{ "upstream" },
-	{ "push" },
-	{ "symref" },
-	{ "flag" },
-	{ "HEAD" },
-	{ "color" },
-	{ "align" },
-	{ "end" },
+	{ "subject", FIELD_STR },
+	{ "body", FIELD_STR },
+	{ "contents", FIELD_STR },
+	{ "upstream", FIELD_STR },
+	{ "push", FIELD_STR },
+	{ "symref", FIELD_STR },
+	{ "flag", FIELD_STR },
+	{ "HEAD", FIELD_STR },
+	{ "color", FIELD_STR },
+	{ "align", FIELD_STR },
+	{ "end", FIELD_STR },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
-- 
2.6.2
