From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH] commit: use the generic "sha1_pos" function to lookup sha1
Date: Sat, 20 Mar 2010 17:51:27 +0800
Message-ID: <1269078687-14541-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 10:52:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsvLe-0002XP-Ii
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 10:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab0CTJvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 05:51:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63398 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0CTJvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 05:51:45 -0400
Received: by gyg8 with SMTP id 8so1899623gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VT75FIy4mbcstAaWasEefZfZTr+Ss9h+hg9n0MKgf0k=;
        b=drjx7cZQB74d4blnWyqKPzFyq67ZDmVw+8cPwyVF3n+kGHtQRQ/TBgChCPavmtva0X
         8JGNydCGB+51YV3DWUQvRFgxDmevIoDelSep69XHQohlVlS6dUsInJ9GadJq883A1XBN
         BWBUGleSIyTLU3oH2m7F1pb5JBsImz6gz33UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vUOgW9sCPtfDU50YSHSB5PxvyjFR+X+sa/a3hvp3BBPsjio5C6l7jPbRbQzW4acK1V
         6Wa+Z2Qa5ELGcJxPN9H/pDAwnjV1b0p2rP8X095Hxj4E4wcmtrwL76MyzReVpGY+AuJi
         drYV7cO8ppEy3ug7pA4NW8RfO11qkPlN3efXs=
Received: by 10.91.22.14 with SMTP id z14mr1656575agi.99.1269078703858;
        Sat, 20 Mar 2010 02:51:43 -0700 (PDT)
Received: from localhost.localdomain ([122.70.47.188])
        by mx.google.com with ESMTPS id 20sm211939iwn.13.2010.03.20.02.51.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 02:51:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142700>

Replace different binary search function with a generic one.


Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 commit.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index 731191e..dba67d5 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "sha1-lookup.h"
 
 int save_commit_buffer = 1;
 
@@ -79,23 +80,16 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 static struct commit_graft **commit_graft;
 static int commit_graft_alloc, commit_graft_nr;
 
+static const unsigned char *commit_sha1_access(size_t index, void *table)
+{
+	struct commit_graft **graft = table;
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
+		commit_sha1_access);
 }
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
-- 
1.7.0.2.273.gc2413.dirty
