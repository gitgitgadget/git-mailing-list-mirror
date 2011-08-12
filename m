From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 26/56] merge-recursive: Split was_tracked() out of would_lose_untracked()
Date: Thu, 11 Aug 2011 23:19:59 -0600
Message-ID: <1313126429-17368-27-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBo-00051N-D6
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab1HLFVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:30 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab1HLFV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:26 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+a1xQ+acTI0R+5vcwwl/Fw5v5OfTykEfIOs8LIhg+3I=;
        b=rz9zC0zCTBBnXYpeyXxqlJBvBykYg9nAxqipEmq/nQOLubzxSqdI/0G2uqEDqGWXr8
         PX9gA2FKjpAp9a2qI0OEGLrDd1CaDPVEOb+tlRO2VMxo5HvhL9UA0VxXC8WcQzu6gnlC
         GEF2TnAM3vEyfMT6u6sNFJIBmJ9Nq1Jn7a4qA=
Received: by 10.231.33.131 with SMTP id h3mr1127677ibd.26.1313126486615;
        Thu, 11 Aug 2011 22:21:26 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.24
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179182>

Checking whether a filename was part of stage 0 or stage 2 is code that we
would like to be able to call from a few other places without also
lstat()-ing the file to see if it exists in the working copy.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e1723d4..c12e4d5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -623,7 +623,7 @@ static int dir_in_way(const char *path, int check_working_copy)
 	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode);
 }
 
-static int would_lose_untracked(const char *path)
+static int was_tracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
@@ -640,11 +640,16 @@ static int would_lose_untracked(const char *path)
 		switch (ce_stage(active_cache[pos])) {
 		case 0:
 		case 2:
-			return 0;
+			return 1;
 		}
 		pos++;
 	}
-	return file_exists(path);
+	return 0;
+}
+
+static int would_lose_untracked(const char *path)
+{
+	return !was_tracked(path) && file_exists(path);
 }
 
 static int make_room_for_path(const char *path)
-- 
1.7.6.100.gac5c1
