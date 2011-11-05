From: Fernando Vezzosi <buccia@repnz.net>
Subject: [PATCH] Introduce gc.autowarnonly config option
Date: Sat, 5 Nov 2011 14:39:07 +0100
Message-ID: <20111105140529.3A6CE9004A@inscatolati.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 15:18:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMh4W-0004oI-Q9
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 15:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab1KEOR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 10:17:59 -0400
Received: from www.inscatolati.net ([212.45.155.126]:51583 "EHLO
	inscatolati.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab1KEOR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 10:17:58 -0400
X-Greylist: delayed 748 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Nov 2011 10:17:58 EDT
Received: by inscatolati.net (Postfix, from userid 1004)
	id 3A6CE9004A; Sat,  5 Nov 2011 15:05:29 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184848>

When `git gc --auto` would detect need for garbage collection to run, it
would just run.  With this patch, enabling gc.autowarnonly will instead
make it just emit a warning.

Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Fernando Vezzosi <buccia@repnz.net>
---
 builtin/gc.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0498094..65b6616 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -26,6 +26,7 @@ static int pack_refs = 1;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
+static int gc_auto_warn_only = 0;
 static const char *prune_expire = "2.weeks.ago";
 
 #define MAX_ADD 10
@@ -64,6 +65,10 @@ static int gc_config(const char *var, const char *value, void *cb)
 		}
 		return git_config_string(&prune_expire, var, value);
 	}
+	if (!strcmp(var, "gc.autowarnonly")) {
+		gc_auto_warn_only = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -219,6 +224,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
+
+		if (gc_auto_warn_only){
+			fprintf(stderr,
+					_("Pack the repository for optimum performance by running\n"
+					"\"git gc\" manually. See "
+					"\"git help gc\" for more information.\n"));
+			return 0;
+		}
+
 		if (quiet)
 			fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
 		else
-- 
1.7.5.3
