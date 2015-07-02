From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH 2/4] log: add --count option to git log
Date: Wed,  1 Jul 2015 22:38:54 -0700
Message-ID: <1435815536-30611-2-git-send-email-lawrencesiebert@gmail.com>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Cc: gitster@pobox.com, Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 07:39:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAXDi-0001Y2-He
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 07:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbbGBFj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 01:39:28 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35875 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbbGBFjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 01:39:24 -0400
Received: by ykdr198 with SMTP id r198so59122391ykd.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 22:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zu5aTncNzBAyCxrAXObAORBCCyaTZL9s17vx515pDY4=;
        b=Oe+C98+bpeuVzy8sNWvTBe5G8pIcXHmE6E7/9M0R0sJ2AJ3LKdy1OrPkPwSLroYSPL
         FjX5w+urAQza4HqYz5PyXQiq9UhD/NNzWenHocr5FMLyoxEkutkj5L/5PlD0AYFtHH9l
         KzLfVpMZRwm5TmCnzxnw6GrnUtrE1lCjdAo7GJNwqiLBIS9GimbkjuwvlofMmtB6JxWq
         S7jhvWe5epH9yqUk66OMkP2ACC9TDPqSLc4pfjoV1qQVDKdyj0TRDhHuER3jWQJHErar
         V+zmkzUEThYOoVbAHjlJdjn6+prIRSoAH2kwK0YqMfaGjJyCQRB22vyTCJF2W9qBJ1XS
         Gp5g==
X-Received: by 10.170.125.138 with SMTP id r132mr36759616ykb.19.1435815563836;
        Wed, 01 Jul 2015 22:39:23 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id m12sm4563641ywd.22.2015.07.01.22.39.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 22:39:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273213>

adds --count from git rev-list to git log, without --use-bitmap-index
for the moment.

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 builtin/log.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8781049..ce6df1e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -25,6 +25,7 @@
 #include "version.h"
 #include "mailmap.h"
 #include "gpg-interface.h"
+#include "list-objects.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -317,12 +318,40 @@ static void finish_early_output(struct rev_info *rev)
 	show_early_header(rev, "done", n);
 }
 
+static void show_object(struct object *obj,
+			const struct name_path *path, const char *component,
+			void *cb_data)
+{
+	return;
+}
+
+static void show_commit(struct commit *commit, void *data)
+{
+	struct rev_info *revs = (struct rev_info *)data;
+	if (commit->object.flags & PATCHSAME)
+		revs->count_same++;
+	else if (commit->object.flags & SYMMETRIC_LEFT)
+		revs->count_left++;
+	else
+		revs->count_right++;
+	if (commit->parents) {
+		free_commit_list(commit->parents);
+		commit->parents = NULL;
+	}
+	free_commit_buffer(commit);
+}
+
 static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
 
+	if (rev->count) {
+		prepare_revision_walk(rev);	
+		traverse_commit_list(rev, show_commit, show_object, rev);
+		get_commit_count(rev);
+	}
 	if (rev->early_output)
 		setup_early_output(rev);
 
-- 
1.9.1
