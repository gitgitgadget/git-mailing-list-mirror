From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 4/8] branch: move 'current' check down to the presentation layer
Date: Sun, 13 Sep 2015 12:53:51 +0530
Message-ID: <1442129035-31386-5-git-send-email-Karthik.188@gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 09:24:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb1du-0002uR-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 09:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbbIMHX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 03:23:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36132 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbbIMHX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 03:23:58 -0400
Received: by padhk3 with SMTP id hk3so113214635pad.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 00:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5WAtkYUG7BA47Dn56QtlaKs1WIG7iHUSM61ze7R+hA=;
        b=WucfVBrXQJaS7fNFN19vJZAITZNCoES0fsqyxWlG4tosh0HtXCN4DE4uC2buszUi+C
         kLW8jDqvjacp2NnDa9zE4mmKNTozaRITBJWp4Eyj1m+GsxYQdiDWoxG5wBqvyzaBDxfh
         BK77aExc7pf09oqbcVjDpnDA5MpWaZhjz1KyjhxRof/F+XZzXGXo/d8epLXLgBKGJZNB
         Rp+5km8EUv5aqyhAHq1uZSaPtHBjVs0kScw0OSONz0VT+2lzRNChkrLfg+5XVGSwdKrw
         4HzEZ5XVWB60lP1k5g4AxhxwA4S8o2OUwsOJxYN2kMcP4DKNFY8s0CuDzdQMOVsspA0R
         3xGw==
X-Received: by 10.66.144.99 with SMTP id sl3mr11564646pab.127.1442129037546;
        Sun, 13 Sep 2015 00:23:57 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id g5sm7688014pat.21.2015.09.13.00.23.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Sep 2015 00:23:57 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277764>

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
2.5.1
