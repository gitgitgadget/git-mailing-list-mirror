From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH v2 2/4] log: add --count option to git log
Date: Thu,  2 Jul 2015 16:50:09 -0700
Message-ID: <1435881011-13879-3-git-send-email-lawrencesiebert@gmail.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 01:50:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAoFt-0005H0-I0
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 01:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbbGBXuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 19:50:52 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36277 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbbGBXun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 19:50:43 -0400
Received: by ykdr198 with SMTP id r198so82511420ykd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OXvKtjRsbU0X06f77P/HaT9lVy6vZ6l7+YgB+ydO/s=;
        b=OS4tvFanYfWsQYuI1bEvpe36yYrpof5Nnh5K5wf5q+kAP62JPCqT8vb20nCgMkM04z
         hhoAo1qQhVmbavf3JwXbxGhoUUgh0C96fVamx9ZJj+dCvS9A3f34oB7G799NoB7uHNgF
         aQ05y0wG1Hyl8MRkogHlj3wRz+SZZD/+3S0Ih0lcbxKsJaCjBsjbpRFHaJ9yvAeZh6sv
         CltaMj1Jj0kMO2BGGymkulnGCaosR/lVkoUv3S1bTxazeOhOUZ/IlGfrnRFq0L54BdSK
         GplXDHT3/0HpaGCutQ+ecW1+TTUsfILy6j0QWG2j/KTrpDDIKXK/OhCOD6+oiXNWWVbA
         TAUw==
X-Received: by 10.129.90.67 with SMTP id o64mr38916405ywb.21.1435881042570;
        Thu, 02 Jul 2015 16:50:42 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id b131sm7190938ywc.18.2015.07.02.16.50.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 16:50:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273278>

adds --count from git rev-list to git log, without --use-bitmap-index
for the moment.

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 builtin/log.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8781049..4aaff3a 100644
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
