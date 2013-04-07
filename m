From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 6/6] format-patch: trivial cleanups
Date: Sun,  7 Apr 2013 12:46:24 -0500
Message-ID: <1365356784-24872-7-git-send-email-felipe.contreras@gmail.com>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 19:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOthi-0004LT-J5
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934227Ab3DGRsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:48:22 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:41117 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934193Ab3DGRsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:48:20 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so5438552oah.28
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=W0vbSCezoTdrXMtuzheb0tNL06ec1H09/QJSAArKl7U=;
        b=RIpLaZKpPJaUgasfS6Uz6Yv99PhD2bG16VNwYV4IJe1V3AkCv6ZshtcrZCh0iGHIQF
         mGPAtCycioybZ0ErDzwtsc88TpVZKENyoQgRxzTF9Kv9gi2XKj86vlPAk8rQpmGM1uMY
         b2llfAPdZbTP4wy71MEKqbidg0r8ZotelUtNUGlwFbQK3o9r8m3gaswMrgmoGZv2OL/m
         6wzcbAHM0cxhevnWVd5LoGjuaJnugbtCGYMk3260IW54G3lezwmSDmzgbXEEr1PT1Ldq
         wqSIGmb9IS620GLKwdaSPcQ2x+xKBE0AolWpKNASsB64PtpCsjqGz5xn6W2t2PeLnF2V
         z2IA==
X-Received: by 10.60.35.197 with SMTP id k5mr12956134oej.138.1365356900264;
        Sun, 07 Apr 2013 10:48:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t9sm20670675obk.13.2013.04.07.10.48.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 10:48:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220345>

Now that the cover-letter code has been shuffled, we can do some
cleanups.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/log.c | 71 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index cf09a81..bbfe6bc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -807,9 +807,37 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
 	}
 }
 
+static char *find_branch_name(struct rev_info *rev)
+{
+	int i, positive = -1;
+	unsigned char branch_sha1[20];
+	const unsigned char *tip_sha1;
+	const char *ref;
+	char *full_ref, *branch = NULL;
+
+	for (i = 0; i < rev->cmdline.nr; i++) {
+		if (rev->cmdline.rev[i].flags & UNINTERESTING)
+			continue;
+		if (positive < 0)
+			positive = i;
+		else
+			return NULL;
+	}
+	if (positive < 0)
+		return NULL;
+	ref = rev->cmdline.rev[positive].name;
+	tip_sha1 = rev->cmdline.rev[positive].item->sha1;
+	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
+	    !prefixcmp(full_ref, "refs/heads/") &&
+	    !hashcmp(tip_sha1, branch_sha1))
+		branch = xstrdup(full_ref + strlen("refs/heads/"));
+	free(full_ref);
+	return branch;
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
-			      int nr, struct commit **list, struct commit *head,
+			      int nr, struct commit **list,
 			      const char *branch_name,
 			      int quiet)
 {
@@ -823,6 +851,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct diff_options opts;
 	int need_8bit_cte = 0;
 	struct pretty_print_context pp = {0};
+	struct commit *head = list[0];
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die(_("Cover letter needs email format"));
@@ -840,6 +869,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		if (has_non_ascii(list[i]->buffer))
 			need_8bit_cte = 1;
 
+	if (!branch_name)
+		branch_name = find_branch_name(rev);
+
 	msg = body;
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode = DATE_RFC2822;
@@ -1046,36 +1078,6 @@ static int cc_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static char *find_branch_name(struct rev_info *rev)
-{
-	int i, positive = -1;
-	unsigned char branch_sha1[20];
-	const unsigned char *tip_sha1;
-	const char *ref;
-	char *full_ref, *branch = NULL;
-
-	for (i = 0; i < rev->cmdline.nr; i++) {
-		if (rev->cmdline.rev[i].flags & UNINTERESTING)
-			continue;
-		if (positive < 0)
-			positive = i;
-		else
-			return NULL;
-	}
-	if (0 <= positive) {
-		ref = rev->cmdline.rev[positive].name;
-		tip_sha1 = rev->cmdline.rev[positive].item->sha1;
-	} else {
-		return NULL;
-	}
-	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
-	    !prefixcmp(full_ref, "refs/heads/") &&
-	    !hashcmp(tip_sha1, branch_sha1))
-		branch = xstrdup(full_ref + strlen("refs/heads/"));
-	free(full_ref);
-	return branch;
-}
-
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1090,7 +1092,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int cover_letter = -1;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
-	struct commit *origin = NULL, *head = NULL;
+	struct commit *origin = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
@@ -1367,7 +1369,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (nr == 0)
 		/* nothing to do */
 		return 0;
-	head = list[0];
 	total = nr;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
@@ -1391,10 +1392,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
-		if (!branch_name)
-			branch_name = find_branch_name(&rev);
 		make_cover_letter(&rev, use_stdout,
-				  origin, nr, list, head, branch_name, quiet);
+				  origin, nr, list, branch_name, quiet);
 		total++;
 		start_number--;
 	}
-- 
1.8.2
