From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 4/8] branch: move 'current' check down to the presentation layer
Date: Wed, 23 Sep 2015 23:41:09 +0530
Message-ID: <1443031873-25280-5-git-send-email-Karthik.188@gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 20:11:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeoVm-0001gT-5V
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 20:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbbIWSLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 14:11:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36700 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbIWSLO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 14:11:14 -0400
Received: by pacgz1 with SMTP id gz1so12816626pac.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gUyq1FRk3KbKvxy12g1Y+ZDElwrSk4EC8DcQEtZkKbQ=;
        b=LEFzo2CBpsseYhaUXa6BZYX2ARE99ebW+GJJmKFynkzYvn97BfXCfwSkb/ZLXRwFmg
         nbPSZryRLxiHsaCTLIy7Tzc8lvJgy5Z4JB2BwFGKAA9lcHF1oWYayB/ynt2qO2nNQDv/
         mBJ8gcubenNhZpfqzMn6zQr6nwwqCFZyty0f0QnixwlDl5gTvWoTxNu4Ygh1Sxd9kR7p
         9ckc5PIH4E87DF6fZ8/s5iMTM04D4/k8isxggyQ3KvhwWCZcKs1HXfsyP2gdQsKlm4Yu
         yB8fWAycT6qTmssoi+FsD4yqxysM/8LYyLqN7CiJdp8vNvrhJtY+XlvJAVLyKfk8vyqC
         WVbA==
X-Received: by 10.66.102.106 with SMTP id fn10mr33328009pab.156.1443031874015;
        Wed, 23 Sep 2015 11:11:14 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id bs3sm9107777pbd.89.2015.09.23.11.11.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Sep 2015 11:11:13 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278495>

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
index a2a35f4..1a664ed 100644
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
