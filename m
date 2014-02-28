From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH v2 2/2] branch: use skip_prefix
Date: Fri, 28 Feb 2014 15:43:33 +0900
Message-ID: <1393569813-68583-1-git-send-email-modocache@gmail.com>
Cc: git@vger.kernel.org, Brian Gesiak <modocache@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHAw-0005FH-AO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbaB1Gn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:43:58 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41710 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbaB1Gnn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:43:43 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so342998pdi.35
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 22:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4YL4wRyMexSTuc7zAU29QDxrFvw2A1xrvZSAhaLxfu0=;
        b=gNzAsw3P6ShJiY3gTcAtCrvUcCkfQwl0b9S63QMsAV6oLCoqUPkLpzigT/9lMt0y4e
         t8wB8WaMfnfsjP344Fh1A9JREbOm9TFIByxomeChmZxZFpVQOMWkx7NesambEiNKa9YU
         y8lE3zWkxao7LEg5uNNj0r4K3VgLMXlohSktl/uTC/jN1lRzaFLgLwnGzd1U9QDSviJU
         8MWS5MURdxelrykaPpk/drbfX1uIsdpk0KTH02ThSRL0ugzeKnKS/oaw3bPRwlxTHV4x
         pnHVXMhXvK5lfjYZe2R5ebDUBAqYC3CsFrN+29q46g2tdFCoVDvtWz8YJNX9A21xcgzC
         rjJQ==
X-Received: by 10.68.198.97 with SMTP id jb1mr1625796pbc.104.1393569822969;
        Thu, 27 Feb 2014 22:43:42 -0800 (PST)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id op3sm2544322pbc.40.2014.02.27.22.43.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 22:43:42 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242893>

The install_branch_config function reimplemented the skip_prefix
function inline. Use skip_prefix function instead for brevity.

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 branch.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..e163f3c 100644
--- a/branch.c
+++ b/branch.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "cache.h"
 #include "branch.h"
 #include "refs.h"
@@ -49,12 +50,11 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	const char *shortname = skip_prefix(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-	if (remote_is_branch
+	if (shortname
 	    && !strcmp(local, shortname)
 	    && !origin) {
 		warning(_("Not setting branch %s as its own upstream."),
@@ -77,29 +77,29 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
+		if (shortname && origin)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
 				  _("Branch %s set up to track remote branch %s from %s."),
 				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
+		else if (shortname && !origin)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track local branch %s by rebasing.") :
 				  _("Branch %s set up to track local branch %s."),
 				  local, shortname);
-		else if (!remote_is_branch && origin)
+		else if (!shortname && origin)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track remote ref %s by rebasing.") :
 				  _("Branch %s set up to track remote ref %s."),
 				  local, remote);
-		else if (!remote_is_branch && !origin)
+		else if (!shortname && !origin)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track local ref %s by rebasing.") :
 				  _("Branch %s set up to track local ref %s."),
 				  local, remote);
 		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+			die("BUG: impossible combination of %p and %p",
+			    shortname, origin);
 	}
 }
 
-- 
1.8.3.4 (Apple Git-47)
