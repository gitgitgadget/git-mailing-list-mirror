From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 4/8] branch: move 'current' check down to the presentation layer
Date: Sun, 20 Sep 2015 23:40:23 +0530
Message-ID: <1442772627-25421-5-git-send-email-Karthik.188@gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 20:10:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdj4L-0006dC-EI
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 20:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbbITSKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 14:10:31 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35401 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbbITSK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 14:10:29 -0400
Received: by pacgz1 with SMTP id gz1so11570800pac.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9SQXn39e/7ovajAyGjB4wPIxeGThFH6V62zY4CEOuo=;
        b=pfX6LV1Cq4H+kcYFmW9K28tp9pzib59OrQlp39u5xUX3cR+4TlkS8wayftTmVbiqza
         87wCsEUh+Q02M8E5js1J2uVM9sBYTE9ftCtww5LVEfzmRGRORpNZzW1vO2SvFSDec03k
         CfbUQkJz8UuTqiME2kXNvLMdbXjtvfusv93YmMz8GKVsqmoNEML1CVBfGWd5726ep8TN
         rQoqrlbDnCgSDSx9SQb6OaLrD3+zSjWw3xpI5pbYbJGaeAzxqx0kKlbf179c+VqPDOkn
         SeyJXLQ8+dIV29loFRdyI9KXhUvKLJCG0qv11GEFJF3nWmKFRKZPj86vv0BGJBU42Hlc
         Kbyw==
X-Received: by 10.68.241.234 with SMTP id wl10mr5480873pbc.27.1442772628878;
        Sun, 20 Sep 2015 11:10:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id qr5sm20037916pbb.26.2015.09.20.11.10.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 11:10:28 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278249>

We check if given ref is the current branch in print_ref_list(). Move
this check to print_ref_item() where it is checked right before
printing. This enables a smooth transition to using ref-filter APIs,
as we can later replace the current check while printing to just check
for FILTER_REFS_DETACHED instead.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 572ba21..ad87de9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -534,9 +534,10 @@ static char *get_head_description(void)
 }
 
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current, const char *remote_prefix)
+			   int abbrev, int detached, const char *remote_prefix)
 {
 	char c;
+	int current = 0;
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 	const char *prefix = "";
@@ -548,15 +549,18 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
-		color = BRANCH_COLOR_LOCAL;
+		if (!detached && !strcmp(item->name, head))
+			current = 1;
+		else
+			color = BRANCH_COLOR_LOCAL;
 		break;
 	case REF_REMOTE_BRANCH:
 		color = BRANCH_COLOR_REMOTE;
 		prefix = remote_prefix;
 		break;
 	case REF_DETACHED_HEAD:
-		color = BRANCH_COLOR_CURRENT;
 		desc = to_free = get_head_description();
+		current = 1;
 		break;
 	default:
 		color = BRANCH_COLOR_PLAIN;
@@ -684,15 +688,9 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < ref_list.index; i++) {
-		int current = !detached && (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
-			!strcmp(ref_list.list[i].name, head);
-		/*  If detached the first ref_item is the current ref */
-		if (detached && i == 0)
-			current = 1;
+	for (i = 0; i < ref_list.index; i++)
 		print_ref_item(&ref_list.list[i], maxwidth, verbose,
-			       abbrev, current, remote_prefix);
-	}
+			       abbrev, detached, remote_prefix);
 
 	free_ref_list(&ref_list);
 
-- 
2.5.1
