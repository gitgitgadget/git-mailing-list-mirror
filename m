From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 4/8] branch: move 'current' check down to the presentation layer
Date: Wed, 19 Aug 2015 00:45:41 +0530
Message-ID: <1439925345-9969-5-git-send-email-Karthik.188@gmail.com>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 21:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmMb-0003fv-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbbHRTPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:15:53 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34552 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbbHRTPu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:15:50 -0400
Received: by pdbfa8 with SMTP id fa8so71215544pdb.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1OmAa7VYug9mROnFsVScF93hJ0oxx8x5rzuKr6gLtc=;
        b=hPtx39KUP2SpNxDiR1tQqlnMccI1Awb/j3jw0QtgcRESOe1/WP96+FEIEaCl0dWyME
         yecWD9grDKgoKHJp4+76OICFQmpdSLq5N6uA5rYo2v015HQmgwp7CoNgS6M5T/cQepDz
         /RtD8AMSwlY12/4ABVyq7fFvfs5k3DCVCvfIKL1yAqrmu7dcjTOkWNUecMddyIdFhyRI
         bindPzJAehRxVzUE3kPUgLUXipq/XBA4rkoTOD2gM7iB3K+fsELsEZ6nPP+VXQTovuHk
         VXJvUrRVhkbIHx5+inKs0I7Yz1OzzEsVJpmaiXA6/kgi93a/PSl/YnBzOlIJpXI3ouGf
         DTYA==
X-Received: by 10.70.7.162 with SMTP id k2mr16175876pda.128.1439925350205;
        Tue, 18 Aug 2015 12:15:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id v2sm43800pda.34.2015.08.18.12.15.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 12:15:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276151>

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
index c0ca67f..bba7752 100644
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
