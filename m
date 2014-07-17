From: Michael Barabanov <michael.barabanov@windriver.com>
Subject: [PATCH] use local cloning if insteadOf makes a local URL
Date: Thu, 17 Jul 2014 00:09:32 -0700
Message-ID: <1405580972-26078-1-git-send-email-michael.barabanov@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 09:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7fp0-0002Az-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 09:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaGQHJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 03:09:39 -0400
Received: from mail.windriver.com ([147.11.1.11]:44578 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbaGQHJh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 03:09:37 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s6H79YOH019769
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 17 Jul 2014 00:09:35 -0700 (PDT)
Received: from localhost.localdomain (172.25.45.237) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.169.1; Thu, 17 Jul 2014 00:09:33 -0700
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253724>

Move the is_local logic to the place where origin remote has been setup and
check if the remote url can be used to do local cloning.

This saves a lot of space (and time) in some of the mirroring scenarios that
involve insteadOf rewrites.

Signed-off-by: Michael Barabanov <michael.barabanov@windriver.com>
---
 builtin/clone.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f0dabec..bbd169c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -799,18 +799,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("repository '%s' does not exist"), repo_name);
 	else
 		repo = repo_name;
-	is_local = option_local != 0 && path && !is_bundle;
-	if (is_local) {
-		if (option_depth)
-			warning(_("--depth is ignored in local clones; use file:// instead."));
-		if (!access(mkpath("%s/shallow", path), F_OK)) {
-			if (option_local > 0)
-				warning(_("source repository is shallow, ignoring --local"));
-			is_local = 0;
-		}
-	}
-	if (option_local > 0 && !is_local)
-		warning(_("--local is ignored"));
 
 	/* no need to be strict, transport_set_option() will validate it again */
 	if (option_depth && atoi(option_depth) < 1)
@@ -903,6 +891,19 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
+	path = get_repo_path(remote->url[0], &is_bundle);
+	is_local = option_local != 0 && path && !is_bundle;
+	if (is_local) {
+		if (option_depth)
+			warning(_("--depth is ignored in local clones; use file:// instead."));
+		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (option_local > 0)
+				warning(_("source repository is shallow, ignoring --local"));
+			is_local = 0;
+		}
+	}
+	if (option_local > 0 && !is_local)
+		warning(_("--local is ignored"));
 	transport->cloning = 1;
 
 	if (!transport->get_refs_list || (!is_local && !transport->fetch))
-- 
1.9.1
