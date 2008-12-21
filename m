From: "R. Tyler Ballance" <tyler@slide.com>
Subject: [PATCH] Style changes per suggestions from Junio in #git
Date: Sun, 21 Dec 2008 15:37:34 -0600
Message-ID: <1229895454-19498-3-git-send-email-tyler@slide.com>
References: <1229895454-19498-1-git-send-email-tyler@slide.com>
 <1229895454-19498-2-git-send-email-tyler@slide.com>
Cc: "R. Tyler Ballance" <tyler@slide.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 22:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEW0z-0004tl-R7
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 22:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYLUVho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 16:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYLUVhm
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 16:37:42 -0500
Received: from mx0.slide.com ([208.76.68.7]:60575 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYLUVhk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 16:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=From:To:Subject:Date:Message-Id; bh=t
	2QpZhhDu4/odvhZrf4picriVvZBD8T+RvfPkRK9JsU=; b=b+uOCc/P2NYaa4gu5
	zFL2NZD4qab/nJPaFWDQtgftfC1WW2dlzYUCbmV5ytUvgItIxqrtGLTOg7VGjxXu
	FVvJYQo7QgaN0LeUw2jzWhDS0JK8GvjYKLKc4hFw4zyBxjcDxtD8sEC6DTdmfboa
	c6kfbn/vrocynPzbUgKQABivjg=
Received: from nat3.slide.com ([208.76.69.126]:60340 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LEVzY-0001Qj-BH
	for <git@vger.kernel.org>; Sun, 21 Dec 2008 13:37:40 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 4E8A7A6F0001;
	Sun, 21 Dec 2008 13:37:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.498
X-Spam-Level: 
X-Spam-Status: No, score=0.498 tagged_above=-10 required=6.6 tests=[AWL=0.000,
	BAYES_00=-2.599, HELO_LH_LD=1.215, RCVD_IN_PBL=0.905,
	RCVD_IN_SORBS_DUL=0.877, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Q-4eeNu7zMJ; Sun, 21 Dec 2008 13:37:40 -0800 (PST)
Received: from localhost.localdomain (unknown [24.240.213.76])
	by calculon.corp.slide.com (Postfix) with ESMTP id C2431A6F0002;
	Sun, 21 Dec 2008 13:37:39 -0800 (PST)
X-Mailer: git-send-email 
In-Reply-To: <1229895454-19498-2-git-send-email-tyler@slide.com>
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103714>

Moving includes into git-compat-util.h, move away from malloc(2)

Signed-off-by: R. Tyler Ballance <tyler@slide.com>
---
 environment.c     |    9 +++------
 git-compat-util.h |    2 ++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/environment.c b/environment.c
index a3b6bab..aa36360 100644
--- a/environment.c
+++ b/environment.c
@@ -7,8 +7,6 @@
  * even if you might want to know where the git directory etc
  * are.
  */
-#include <sys/time.h>
-#include <sys/resource.h>
 
 #include "cache.h"
 
@@ -80,10 +78,9 @@ static void setup_git_env(void)
 		git_graft_file = git_pathdup("info/grafts");
 	
 	if (DYNAMIC_WINDOW_SIZE) {
-		struct rlimit *as = malloc(sizeof(struct rlimit));
-		if ( (getrlimit(RLIMIT_AS, as) == 0) && ((int)(as->rlim_cur) > 0) ) 
-			packed_git_window_size = (unsigned int)(as->rlim_cur * DYNAMIC_WINDOW_SIZE_PERCENTAGE);
-		free(as);
+		struct rlimit as;
+		if (getrlimit(RLIMIT_AS, &as) == 0 && (int)as.rlim_cur > 0)
+			packed_git_window_size = (unsigned int)(as.rlim_cur * DYNAMIC_WINDOW_SIZE_PERCENTAGE);
 	}
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 9603ca6..dad2dc8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -188,6 +188,8 @@ extern int git_munmap(void *start, size_t length);
 #else /* NO_MMAP */
 
 #include <sys/mman.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 
 /* This value must be multiple of (pagesize * 2) */
 #define DEFAULT_PACKED_GIT_WINDOW_SIZE \
-- 
