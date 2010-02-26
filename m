From: jackylee <jacky.liye@gmail.com>
Subject: [PATCH] refactor commit_graft_pos using general sha1_pos function
Date: Fri, 26 Feb 2010 11:31:15 -0500
Message-ID: <4B87F753.7040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, rctay89@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 04:31:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkqvL-0007de-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935102Ab0BZDb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:31:26 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:64274 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935056Ab0BZDbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:31:25 -0500
Received: by ywh35 with SMTP id 35so3694035ywh.4
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ugMhRvBUTi0y2UprMMbEhgGLkI5VEYxXCQKhGELhK8M=;
        b=DZcYfg97/gIuvobZ2XZBRE/vOjHz1iJFYFWYxHVAKsPzuLUyaAv042rvtfDFTr9nVr
         YV2bhxIP2A64WArfeSGsk6AoavpFppuryDSYRSKohISvvRCAvP5BuHZpAlHb/ySi8N4H
         jlYXoPhr6m7rKpts5Mr9afVcVCo4nfOWsNnsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=djeSnxU4/cyyuc9/FQujAdGcmqUjTq2EykFR28i0QeDChiK+1IdPcJ2KuItcphtLHO
         +9M0yr7cPrIav7u7EbrKeUJVW4Kv2mYNbxsL8HshBXPdy+OMDQq0SRgKhLNgHznZ87wB
         LtgmNz/mYQDX7Pq7y7lMDVpxMcXIJOQ5rECKg=
Received: by 10.150.71.1 with SMTP id t1mr423813yba.255.1267155084517;
        Thu, 25 Feb 2010 19:31:24 -0800 (PST)
Received: from ?118.229.143.5? ([118.229.143.5])
        by mx.google.com with ESMTPS id 4sm2847113ywg.24.2010.02.25.19.31.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 19:31:23 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141093>

thanks, please ignore the previous mail.
code cleanup according to git janitor page, replace sha1 lookup function with "sha1_pos" general binary search function

Signed-off-by: Li Ye <jacky.liye@gmail.com>
---
 commit.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index 731191e..c44d091 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "sha1-lookup.h"
 
 int save_commit_buffer = 1;
 
@@ -78,24 +79,14 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 
 static struct commit_graft **commit_graft;
 static int commit_graft_alloc, commit_graft_nr;
-
+static const unsigned char *commit_graft_access(size_t index, void *table)
+{
+	struct commit_graft **grafts = table;
+	return (const unsigned char *)grafts[index];
+}
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
+	return sha1_pos(sha1, commit_graft, commit_graft_nr, commit_graft_access);
 }
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
-- 
1.6.3.3
