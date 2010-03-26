From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 08/12] git rm: collect file modes
Date: Fri, 26 Mar 2010 15:25:36 +0000
Message-ID: <1269617140-7827-9-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQg-0005ou-FS
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453Ab0CZP0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:16 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55552 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754325Ab0CZPZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:58 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001o9-QC; Fri, 26 Mar 2010 15:25:55 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023P-E6; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143243>

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
