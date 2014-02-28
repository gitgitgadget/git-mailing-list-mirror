From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 2/2] branch: use skip_prefix
Date: Fri, 28 Feb 2014 12:04:19 +0900
Message-ID: <1393556659-32717-2-git-send-email-modocache@gmail.com>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
Cc: modocache <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 04:04:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJDkg-0007vw-VO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 04:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbaB1DEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 22:04:37 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:61044 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaB1DEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 22:04:36 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so143784pbc.18
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 19:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCxKRxEeyV6nbDclgedjQ+dA6rWEftZJDXQZpAdjsmI=;
        b=VZevq5nFVH1cTYWrb69SVpJfNSTlPUVCHyzOkxclPydqqSCcKDOz9BFDYwZFl+pEbK
         6MlkTLasuJLeiL4/nqmr0PtCFDuWj3UTpVQig21tRxgkQUR2bDQgR17R3ohlwWo+iKm7
         dXPeu89yUeUhnm4nDiaangG/JRqDgxkYVwUw7DN34ERkm/jmDvogYmx1/L7Ww21RWpBK
         6tF9eLpSkUaBVTfWZA5KCpCXSonPuSY35wGLhlmRfFw39qgtbmyWB7ybV3ee7PSWDNM3
         hKe8USC4FgJBhV+/xHzw++kbI4RQkVTkN/2qlAsENNejOIy/7/3JEUDBZ1218otx4J7N
         BxtQ==
X-Received: by 10.68.66.1 with SMTP id b1mr555780pbt.43.1393556676329;
        Thu, 27 Feb 2014 19:04:36 -0800 (PST)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id qw8sm797392pbb.27.2014.02.27.19.04.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 19:04:35 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
In-Reply-To: <1393556659-32717-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242883>

From: modocache <modocache@gmail.com>

The install_branch_config function reimplemented the skip_prefix
function inline. Use skip_prefix function instead for brevity.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
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
