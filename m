From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 07/11] branch: move 'current' check down to the presentation layer
Date: Tue, 28 Jul 2015 12:26:32 +0530
Message-ID: <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyot-0006Hv-47
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbbG1G4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:49 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36572 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbG1G4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:47 -0400
Received: by pdjr16 with SMTP id r16so66786074pdj.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=52EknChemj5tyiE/i1S0PNl25vhHnff6iPMOMBAsB/A=;
        b=oU/+2VAix6IAXJZG/vEMN5qK4N6jJVKJJBdO+9F4XIDt1gdTFVFjYflT5w4mr94PeU
         VEMHwOQhFV8YHjspiufGNSnpBHad7dqfWST6T+a3xguBy/w7Tq9P3GqTEHvvpNQAla4g
         xnP5au6iXewJAuuc9bWKMwcj8OzJCs1+lQ65XtK8VLSNi6HEqNdfoZcyoqV+42qwre8I
         UGB2bb3Zz9z87qE46a4RgnbUSMEGcdwnab70TKFQcbYHNjuyfUlPoRIgvvKxAo3aZXvU
         UwMUQn17xzeiHkdzAJyl6Gkj/RNouWZRVE9yzi7tfC137IWCsLs10udj35cngH8LxUAQ
         TuAw==
X-Received: by 10.70.23.98 with SMTP id l2mr77925244pdf.74.1438066607180;
        Mon, 27 Jul 2015 23:56:47 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:46 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274743>

We check if given ref is the current branch in print_ref_list().  Move
this check to print_ref_item() where it is checked right before
printing.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f3d83d0..ba9cbad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -534,9 +534,9 @@ static char *get_head_description(void)
 }
 
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current, const char *remote_prefix)
+			   int abbrev, int detached, const char *remote_prefix)
 {
-	char c;
+	char c = ' ';
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 	const char *prefix = "";
@@ -547,7 +547,11 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
-		color = BRANCH_COLOR_LOCAL;
+		if (!detached && !strcmp(item->name, head)) {
+			color = BRANCH_COLOR_CURRENT;
+			c = '*';
+		} else
+			color = BRANCH_COLOR_LOCAL;
 		break;
 	case REF_REMOTE_BRANCH:
 		color = BRANCH_COLOR_REMOTE;
@@ -556,18 +560,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	case REF_DETACHED_HEAD:
 		color = BRANCH_COLOR_CURRENT;
 		desc = get_head_description();
+		c = '*';
 		break;
 	default:
 		color = BRANCH_COLOR_PLAIN;
 		break;
 	}
 
-	c = ' ';
-	if (current) {
-		c = '*';
-		color = BRANCH_COLOR_CURRENT;
-	}
-
 	strbuf_addf(&name, "%s%s", prefix, desc);
 	if (verbose) {
 		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
@@ -677,21 +676,17 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	index = ref_list.index;
 
 	/* Print detached heads before sorting and printing the rest */
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
2.4.6
