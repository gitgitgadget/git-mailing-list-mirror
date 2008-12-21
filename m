From: "R. Tyler Ballance" <tyler@slide.com>
Subject: [PATCH] Add support for changing packed_git_window_size at process start time
Date: Sun, 21 Dec 2008 15:37:33 -0600
Message-ID: <1229895454-19498-2-git-send-email-tyler@slide.com>
References: <1229895454-19498-1-git-send-email-tyler@slide.com>
Cc: "R. Tyler Ballance" <tyler@slide.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 22:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEW0z-0004tl-5T
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 22:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbYLUVhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 16:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbYLUVhl
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 16:37:41 -0500
Received: from mx0.slide.com ([208.76.68.7]:60574 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbYLUVhk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 16:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=From:To:Subject:Date:Message-Id; bh=Y
	FsjiqJuyuok2aE5XpjeNVIa9ZfFTfJ+RX4eH7bCcmo=; b=uO/23RPBJwwmWeBlc
	JefRGbRCu72Kz1JL8Wi2R9vNoAGfI0m4v3EyLOeQkAkzrwKnTJZKwUmQxE9u+Xt2
	JN6aX7SuvtDkc6kAOutYT4GG2gI5DS4UIJyzBlc15rYfhGCu7icxOUo7keHxmJPd
	dmQ0LIABoKXX7E/TxpVuH5hXF4=
Received: from nat3.slide.com ([208.76.69.126]:60330 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LEVzX-0001Qg-PH
	for <git@vger.kernel.org>; Sun, 21 Dec 2008 13:37:39 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id BBBB0A6F0001;
	Sun, 21 Dec 2008 13:37:39 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.498
X-Spam-Level: 
X-Spam-Status: No, score=0.498 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, HELO_LH_LD=1.215, RCVD_IN_PBL=0.905,
	RCVD_IN_SORBS_DUL=0.877, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liCtAdWKXdVg; Sun, 21 Dec 2008 13:37:39 -0800 (PST)
Received: from localhost.localdomain (unknown [24.240.213.76])
	by calculon.corp.slide.com (Postfix) with ESMTP id 40516A6F0002;
	Sun, 21 Dec 2008 13:37:39 -0800 (PST)
X-Mailer: git-send-email 
In-Reply-To: <1229895454-19498-1-git-send-email-tyler@slide.com>
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103712>

"Works" insofar that it will alter the packed_git_window_size variable in environment.c
when the environment is set up. It /doesn't/ work when commands like git-diff(1) and git-log(1)
call get_revision() which seems to disregard the setting if the packed_window_size is set to something
low (i.e. ulimit -v 32768)

Signed-off-by: R. Tyler Ballance <tyler@slide.com>
---
 environment.c     |   10 ++++++++++
 git-compat-util.h |    4 ++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/environment.c b/environment.c
index e278bce..a3b6bab 100644
--- a/environment.c
+++ b/environment.c
@@ -7,6 +7,9 @@
  * even if you might want to know where the git directory etc
  * are.
  */
+#include <sys/time.h>
+#include <sys/resource.h>
+
 #include "cache.h"
 
 char git_default_email[MAX_GITNAME];
@@ -75,6 +78,13 @@ static void setup_git_env(void)
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = git_pathdup("info/grafts");
+	
+	if (DYNAMIC_WINDOW_SIZE) {
+		struct rlimit *as = malloc(sizeof(struct rlimit));
+		if ( (getrlimit(RLIMIT_AS, as) == 0) && ((int)(as->rlim_cur) > 0) ) 
+			packed_git_window_size = (unsigned int)(as->rlim_cur * DYNAMIC_WINDOW_SIZE_PERCENTAGE);
+		free(as);
+	}
 }
 
 int is_bare_repository(void)
diff --git a/git-compat-util.h b/git-compat-util.h
index e20b1e8..9603ca6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -182,6 +182,8 @@ extern int git_munmap(void *start, size_t length);
 
 /* This value must be multiple of (pagesize * 2) */
 #define DEFAULT_PACKED_GIT_WINDOW_SIZE (1 * 1024 * 1024)
+#define DYNAMIC_WINDOW_SIZE 0
+#define DYNAMIC_WINDOW_SIZE_PERCENTAGE 0
 
 #else /* NO_MMAP */
 
@@ -192,6 +194,8 @@ extern int git_munmap(void *start, size_t length);
 	(sizeof(void*) >= 8 \
 		?  1 * 1024 * 1024 * 1024 \
 		: 32 * 1024 * 1024)
+#define DYNAMIC_WINDOW_SIZE 1
+#define DYNAMIC_WINDOW_SIZE_PERCENTAGE 0.85
 
 #endif /* NO_MMAP */
 
-- 
