From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] commit: use generic sha1_pos()
Date: Wed,  1 Jun 2011 16:20:16 +0300
Organization: Texas Instruments\n
Message-ID: <1306934416-4205-1-git-send-email-balbi@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 15:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRlNf-0003rn-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 15:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab1FANWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 09:22:35 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43335 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751411Ab1FANWd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 09:22:33 -0400
Received: from mail-bw0-f49.google.com ([209.85.214.49]) (using TLSv1) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTeY9FrLe9xJh+9+8sJ9fJ7biW3Z7tHAE@postini.com; Wed, 01 Jun 2011 06:22:32 PDT
Received: by mail-bw0-f49.google.com with SMTP id 1so46844bwz.36
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 06:22:30 -0700 (PDT)
Received: by 10.204.8.141 with SMTP id h13mr1253107bkh.64.1306934421304;
        Wed, 01 Jun 2011 06:20:21 -0700 (PDT)
Received: from localhost (cs181221225.pp.htv.fi [82.181.221.225])
        by mx.google.com with ESMTPS id k16sm853554bks.13.2011.06.01.06.20.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 06:20:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.300.gc565c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174866>

instead of reimplementing the binary search,
use the generic sha1_pos().

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 commit.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index ac337c7..ee8788f 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "sha1-lookup.h"
 
 int save_commit_buffer = 1;
 
@@ -92,23 +93,17 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 static struct commit_graft **commit_graft;
 static int commit_graft_alloc, commit_graft_nr;
 
+static const unsigned char *commit_graft_access(size_t index, void *table)
+{
+	struct commit_graft **graft = table;
+
+	return graft[index]->sha1;
+}
+
 static int commit_graft_pos(const unsigned char *sha1)
 {
-	int lo, hi;
-	lo = 0;
-	hi = commit_graft_nr;
-	while (lo < hi) {
-		int mi = (lo + hi) / 2;
-		struct commit_graft *graft = commit_graft[mi];
-		int cmp = hashcmp(sha1, graft->sha1);
-		if (!cmp)
-			return mi;
-		if (cmp < 0)
-			hi = mi;
-		else
-			lo = mi + 1;
-	}
-	return -lo - 1;
+	return sha1_pos(sha1, commit_graft, commit_graft_nr,
+			commit_graft_access);
 }
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
-- 
1.7.5.1.300.gc565c
