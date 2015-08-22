From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 4/8] branch: move 'current' check down to the presentation layer
Date: Sat, 22 Aug 2015 12:21:45 +0530
Message-ID: <1440226309-25415-5-git-send-email-Karthik.188@gmail.com>
References: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 08:52:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZT2ep-0004MV-Nx
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 08:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbbHVGv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 02:51:57 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34788 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbbHVGvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 02:51:53 -0400
Received: by padfo6 with SMTP id fo6so22018987pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YozRWmq1AP/fSf9dxR0VTqtOMXfc2t/uh3gWu/uJMno=;
        b=Iniu5MVmHLp8GQ2SQVNKbb1aIDABG3D/OB5LoKStDWk2u6WXMQsvudVo6XWlUVSths
         QPJx0HrNvEuUjQxXiS1OxcpzAKFCrJLgVBjRW+43lFYAP/7Gx2jt/uaYYTTpVDGsKmCV
         Ei6sqrV4qbs75YFr9I055tSaOUdBws43OrafC7VugqUOIj9HQ9x0aMuZBIZXasgJlORG
         3WJVSQPAGDU1S/U/aiEqroyJHkQJvpWKddvkmo6UCG3yDdONl3LS1NYJggV96kBM9eps
         MobXDZzaM/gR8lTm+3NgLkUFacFd/u1b/mG0QUre4bar6BfVSqXVmF/GSTNiPcEV8plT
         C7Og==
X-Received: by 10.68.109.34 with SMTP id hp2mr24874161pbb.52.1440226313365;
        Fri, 21 Aug 2015 23:51:53 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm4412342pac.22.2015.08.21.23.51.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 23:51:52 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276382>

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
index 6ba7a3f..4d9e4d0 100644
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
@@ -685,21 +689,17 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
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
