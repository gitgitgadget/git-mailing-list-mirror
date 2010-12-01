From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH]  commit: Remove backward goto in read_craft_line()
Date: Wed,  1 Dec 2010 20:59:06 +0100
Message-ID: <1291233546-4962-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 20:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNspm-00024l-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab0LAT7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:59:14 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64516 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478Ab0LAT7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:59:13 -0500
Received: by gwj20 with SMTP id 20so3674076gwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 11:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fddKS5pw/HaG7TwUkO9/nNBofh5yXbitbxAVdJvbajc=;
        b=FJLnsTBHepfRE1cI2m/AcgchlmeKKymnx+npCv8m16grt4++/bPbPPG/ekhkxuJrOM
         TfmmS/a+/hwCHKwQnZ6d6llcKHzXDKm83JNHDS2xK5FrkAQNbuvc6irnWhQFsjYaLGTw
         ICrPLZH2w2AYfNetAS6xVnH+IEXugcez3+0Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dfYb3G+JMmmaHlYOluZFnHXM0WcnE1bJiC+ARDBkKHZLi9kpVxucO3nBlDubW8FrSI
         8I9pDyZpqAxRPMGL2Qk+87nbOORkoaSFMv9lHMLEdOiqbWEnkMZ0IoWcfSjLV55TnTQy
         wIU4+KNgh6NIzh4J0MMq79z4eOTIMvMK7WCdM=
Received: by 10.223.122.201 with SMTP id m9mr8765172far.79.1291233552367;
        Wed, 01 Dec 2010 11:59:12 -0800 (PST)
Received: from localhost.localdomain (dslb-094-223-220-166.pools.arcor-ip.net [94.223.220.166])
        by mx.google.com with ESMTPS id n15sm171849fam.36.2010.12.01.11.59.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 11:59:11 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162592>

 Bad graft data is noticed in several places in read_graft_line and
 in each case we go back to the first site of detection.  Move the
 error handling to the end of the function for better readability.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 commit.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 0094ec1..642ee34 100644
--- a/commit.c
+++ b/commit.c
@@ -137,12 +137,8 @@ struct commit_graft *read_graft_line(char *buf, int len)
 		buf[--len] = '\0';
 	if (buf[0] == '#' || buf[0] == '\0')
 		return NULL;
-	if ((len + 1) % 41) {
-	bad_graft_data:
-		error("bad graft data: %s", buf);
-		free(graft);
-		return NULL;
-	}
+	if ((len + 1) % 41)
+		goto bad_graft_data;
 	i = (len + 1) / 41 - 1;
 	graft = xmalloc(sizeof(*graft) + 20 * i);
 	graft->nr_parent = i;
@@ -155,6 +151,10 @@ struct commit_graft *read_graft_line(char *buf, int len)
 			goto bad_graft_data;
 	}
 	return graft;
+ bad_graft_data:
+	error("bad graft data: %s", buf);
+	free(graft);
+	return NULL;
 }
 
 static int read_graft_file(const char *graft_file)
-- 
1.7.1
