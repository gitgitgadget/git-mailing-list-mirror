From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 5/9] git rm: collect file modes
Date: Sat, 10 Apr 2010 19:23:46 +0100
Message-ID: <1270923830-11830-6-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMP-0007O3-Kz
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab0DJSYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:19 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37799 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064Ab0DJSX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:57 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLV-0006qS-Qa; Sat, 10 Apr 2010 19:23:54 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-00036K-Gr; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144566>

This patch causes git rm to collect file modes alongside file names
in its list data structure.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 builtin/rm.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 05a5158..61ec2cf 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -18,15 +18,18 @@ static const char * const builtin_rm_usage[] = {
 static struct {
 	int nr, alloc;
 	const char **name;
+	unsigned int *mode;
 } list;
 
-static void add_list(const char *name)
+static void add_list(const char *name, unsigned int mode)
 {
 	if (list.nr >= list.alloc) {
 		list.alloc = alloc_nr(list.alloc);
 		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
+		list.mode = xrealloc(list.mode, list.alloc * sizeof(unsigned int));
 	}
-	list.name[list.nr++] = name;
+	list.name[list.nr] = name;
+	list.mode[list.nr++] = mode;
 }
 
 static int check_local_mod(unsigned char *head, int index_only)
@@ -182,7 +185,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		struct cache_entry *ce = active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
-		add_list(ce->name);
+		add_list(ce->name, ce->ce_mode);
 	}
 
 	if (pathspec) {
-- 
1.6.5
