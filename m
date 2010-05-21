From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 6/7] Support case folding for git add when core.ignorecase=true
Date: Thu, 20 May 2010 22:50:34 -0600
Message-ID: <1274417435-2344-7-git-send-email-jjensen@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:51:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCe-0007k0-1Z
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0EUEux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:50:53 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39246 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0EUEuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:51 -0400
Received: (qmail 28945 invoked by uid 399); 20 May 2010 22:50:50 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE
	autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:49 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAMMMMMMM; 20 May 2010 22:50:49 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147437>

When MyDir/ABC/filea.txt is added to Git, the disk directory MyDir/ABC/
is renamed to mydir/aBc/, and then mydir/aBc/fileb.txt is added, the
index will contain MyDir/ABC/filea.txt and mydir/aBc/fileb.txt. Although
the earlier portions of this patch series account for those differences
in case, this patch makes the pathing consistent by folding the case of
newly added files against the first file added with that path.

In read-cache.c's add_to_index(), the index_name_exists() support used
for git status's case insensitive directory lookups is used to find the
proper directory case according to what the user already checked in.
That is, MyDir/ABC/'s case is used to alter the stored path for
fileb.txt to MyDir/ABC/fileb.txt (instead of mydir/aBc/fileb.txt).

This is especially important when cloning a repository to a case
sensitive file system. MyDir/ABC/ and mydir/aBc/ exist in the same
directory on a Windows machine, but on Linux, the files exist in two
separate directories. The update to add_to_index(), in effect, treats a
Windows file system as case sensitive by making path case consistent.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
---
 read-cache.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f1f789b..b3954d5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -608,6 +608,22 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		ce->ce_mode = ce_mode_from_stat(ent, st_mode);
 	}
 
+	if (ignore_case) {
+		const char *startPtr = ce->name;
+		const char *ptr = startPtr;
+		while (*ptr) {
+			while (*ptr && *ptr != '/')
+				++ptr;
+			if (*ptr == '/') {
+				struct cache_entry *foundce;
+				++ptr;
+				foundce = index_name_exists(&the_index, ce->name, ptr - ce->name, ignore_case);
+				if (foundce)
+					memcpy((void*)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
+			}
+		}
+	}
+
 	alias = index_name_exists(istate, ce->name, ce_namelen(ce), ignore_case);
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
-- 
1.7.1.1930.gca7dd4
