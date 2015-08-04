From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 05/10] branch: move 'current' check down to the presentation layer
Date: Tue,  4 Aug 2015 18:31:18 +0530
Message-ID: <1438693282-15516-5-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:01:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbqo-0003P5-CB
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933998AbbHDNBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35379 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933870AbbHDNBb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:01:31 -0400
Received: by pasy3 with SMTP id y3so8187622pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3M9sRjOGsPRxHcl3EneydZLgI2uvQHLIvf0P3aXXRCg=;
        b=Gd3cbXtBohMS6XQ9Wlqhh80tu1W10+8GetStk0zDROubdezaIk2Vkjf2jCo5jfj+B7
         HEgxzs7UqSERrXlf/zzVlFvi8F/Wv7bd+LC0H3AVLwd57SvT1wYhgMEn59sD2UgjZ7dk
         538+yppAFB0BeHrjtXr0p4Jm5/n926DBtdJR0i4c2t+xKzSEinYEhMqr6w34/rhM+Efg
         mU61X1KpMzkFngRmpgAQYqZkRH3ct5q4SHHkzxkDXx59eP/S3xVKBYs4wjhvt6XttlpQ
         8kHtHBLJVRIzfxlgAINCIVAtRbVXq3A3YRdeW/7E8AatuH/JmqCbkpNKRxBxUmdXX1gf
         xHQA==
X-Received: by 10.68.234.34 with SMTP id ub2mr7464438pbc.101.1438693290534;
        Tue, 04 Aug 2015 06:01:30 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uy6sm1450657pbc.13.2015.08.04.06.01.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:01:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275269>

We check if given ref is the current branch in print_ref_list(). Move
this check to print_ref_item() where it is checked right before
printing.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 81815c9..c5f2944 100644
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
@@ -547,15 +548,18 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
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
 		desc = get_head_description();
+		current = 1;
 		break;
 	default:
 		color = BRANCH_COLOR_PLAIN;
@@ -684,21 +688,17 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	index = ref_list.index;
 
 	/* Print detached HEAD before sorting and printing the rest */
-	if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
-	    !strcmp(ref_list.list[index - 1].name, head)) {
+	if (detached) {
 		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
-			       1, remote_prefix);
+			       detached, remote_prefix);
 		index -= 1;
 	}
 
 	qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < index; i++) {
-		int current = !detached && (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
-			!strcmp(ref_list.list[i].name, head);
+	for (i = 0; i < index; i++)
 		print_ref_item(&ref_list.list[i], maxwidth, verbose,
-			       abbrev, current, remote_prefix);
-	}
+			       abbrev, detached, remote_prefix);
 
 	free_ref_list(&ref_list);
 
-- 
2.5.0
