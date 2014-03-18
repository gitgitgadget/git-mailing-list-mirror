From: Movchan Pavel <movchan.pv@gmail.com>
Subject: [PATCH][GSOC2014] add: Rewrite run_add_interactive to use struct argv_array
Date: Tue, 18 Mar 2014 20:31:14 +0800
Message-ID: <1395145875-5072-1-git-send-email-movchan.pv@gmail.com>
References: <y>
Cc: Movchan Pavel <movchan.pv@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 13:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPtBr-00058W-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 13:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbaCRMbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 08:31:47 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:61311 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaCRMbq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 08:31:46 -0400
Received: by mail-lb0-f173.google.com with SMTP id p9so4739587lbv.32
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bnkwC+9Vd2a8GAIcTuuZ298gLPG/CUeDzgnQa3IpuSM=;
        b=imvoIvOTur9/XvcN3wrQrCvbdTvNt7yNo/4eYlKOuZhglmB9gW2LTyFH+IQu7M2MGT
         v8dAOhw6MpMIqCC/mgclCa8NXyYfPUJS0+oUUYEXq+w0OrNRJ8Ryw7dVslELe/2ZSh54
         Wqi7lY7Yrf4pBq8BtI7efoKASXRidtFu8ByXijlvPx4x6TieNGuIQSZvX9ZcI29Gk8HX
         E9S4v+FY3ciumrOGjCsGEKGVGSV2q7eT+UuncnQc8Z203mMLiaW+6V6qhSSy1wbNJJUk
         B7sr9o3nVt0V0ujoaVjMoRAuu69vRrGiewe76u1gbzZZGkVzJ0fXjl6qsGhve0puBcX7
         rzQg==
X-Received: by 10.152.7.97 with SMTP id i1mr1570775laa.36.1395145905167;
        Tue, 18 Mar 2014 05:31:45 -0700 (PDT)
Received: from DT-pc.Dlink ([77.240.164.44])
        by mx.google.com with ESMTPSA id v20sm7017175lbi.24.2014.03.18.05.31.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Mar 2014 05:31:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244353>

Origin code are code with own realisation argv array editing.
It was changed, and code modified for using unified argv-array
realisation from argv-array.h.
Commit for Google Summer of Code 2014

Signed-off-by: Movchan Pavel <movchan.pv@gmail.com>
---
 builtin/add.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4b045ba..258b491 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -15,6 +15,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "bulk-checkin.h"
+#include "argv-array.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [options] [--] <pathspec>..."),
@@ -141,23 +142,21 @@ static void refresh(int verbose, const struct pathspec *pathspec)
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const struct pathspec *pathspec)
 {
-	int status, ac, i;
-	const char **args;
+	int status, i;
+	struct argv_array *argv = ARGV_ARRAY_INIT;
 
-	args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
-	ac = 0;
-	args[ac++] = "add--interactive";
+	argv_array_push(argv, "add--interactive");
 	if (patch_mode)
-		args[ac++] = patch_mode;
+		argv_array_push(argv, patch_mode);
 	if (revision)
-		args[ac++] = revision;
-	args[ac++] = "--";
+		argv_array_push(argv, revision);
+	argv_array_push(argv, "--");
 	for (i = 0; i < pathspec->nr; i++)
 		/* pass original pathspec, to be re-parsed */
-		args[ac++] = pathspec->items[i].original;
+		argv_array_push(argv, pathspec->items[i].original);
 
-	status = run_command_v_opt(args, RUN_GIT_CMD);
-	free(args);
+	status = run_command_v_opt(argv->argv, RUN_GIT_CMD);
+	argv_array_clear(argv);
 	return status;
 }
 
-- 
1.7.10.4
