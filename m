From: jacky.liye@gmail.com
Subject: [PATCH] refactor commit_graft_pos using general sha1_pos function
Date: Thu, 25 Feb 2010 14:57:27 -0500
Message-ID: <1267127847-6172-1-git-send-email-jacky.liye@gmail.com>
Cc: jackylee <jacky.liye@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 08:04:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkXle-0001b8-1y
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 08:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0BYHEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 02:04:07 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:43821 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab0BYHEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 02:04:06 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2010 02:04:06 EST
Received: by pzk32 with SMTP id 32so480376pzk.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 23:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/s29UpSaAlzNDH8LWrA7pNMjadTkeEa/2yC7zfATxuU=;
        b=O7jnfeQgC+n86pdPF2bloVvYbxwqtXBLa1JUDM2gBKDxpYREOWTPEJ030/LoxwQXKF
         u224/vXcBJL4sGOjz1qmwOLQHKOi3jcEoVA9ycJ5WVudsiiX12AJjQgTp/JpKrtCbzpE
         W2S0DSxBi0H6CF4DQmBfvf12cV42kLqQJ0RsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XxTzRluVwnGELKO0aDSOw/bIvETtREU5KqlGdeN+78IcPkjVS+h1I4uycvO58H8guj
         FJzAnFJsnSlEbAQfM7f0aGivB1nCIZ7+1B6My7vTYh7jhUpQZ0FmpSolqRoLEAY7Mhbd
         pV74VIZLhQe16Kf1uV1kwWd++t63ZEXnGYgNM=
Received: by 10.140.56.21 with SMTP id e21mr381925rva.164.1267081059823;
        Wed, 24 Feb 2010 22:57:39 -0800 (PST)
Received: from localhost.localdomain ([118.229.143.5])
        by mx.google.com with ESMTPS id 20sm1731753pzk.11.2010.02.24.22.57.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 22:57:39 -0800 (PST)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141029>

From: jackylee <jacky.liye@gmail.com>


Signed-off-by: jacky.liye <jacky.liye@gmail.com>
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
