From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 2/4] use strbuf_getcwd() to get the current working directory
 without fixed-sized buffers
Date: Sun, 20 Jul 2014 18:49:54 +0200
Message-ID: <53CBF332.2050301@web.de>
References: <53CBF277.3090101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 18:50:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8uJq-0004gU-W0
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 18:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbaGTQuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 12:50:35 -0400
Received: from mout.web.de ([212.227.15.14]:51404 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbaGTQuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 12:50:35 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lm4PJ-1WZIRi18Ub-00Zdp1; Sun, 20 Jul 2014 18:50:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CBF277.3090101@web.de>
X-Provags-ID: V03:K0:+YcOYR1G/df28R35AWd5/IcKZsrVUKxQ/B9dwCs7X7RgN2ZYcAo
 7dOZpS+JPXg75Uot+dwo36/nNZEe49VgwK+1H5lEpXOoWYAaEu6PaClsffabdFcuSJ3voS7
 p0pq6s+Y9Cc1aIijOT8C4t7v3vW4iXQp9LjyS0gz77jfZl/vNBQkS0mXCh9De55hhtpmRRB
 oU6CoWMOZsryyiv27rqSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253932>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/init-db.c | 8 ++++----
 git.c             | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..c4958b6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -535,10 +535,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		usage(init_db_usage[0]);
 	}
 	if (is_bare_repository_cfg == 1) {
-		static char git_dir[PATH_MAX+1];
-
-		setenv(GIT_DIR_ENVIRONMENT,
-			getcwd(git_dir, sizeof(git_dir)), argc > 0);
+		struct strbuf cwd = STRBUF_INIT;
+		strbuf_getcwd(&cwd);
+		setenv(GIT_DIR_ENVIRONMENT, cwd.buf, argc > 0);
+		strbuf_release(&cwd);
 	}
 
 	if (init_shared_repository != -1)
diff --git a/git.c b/git.c
index 5b6c761..3f52c43 100644
--- a/git.c
+++ b/git.c
@@ -161,9 +161,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
-			static char git_dir[PATH_MAX+1];
+			struct strbuf cwd = STRBUF_INIT;
 			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
+			strbuf_getcwd(&cwd);
+			setenv(GIT_DIR_ENVIRONMENT, cwd.buf, 0);
+			strbuf_release(&cwd);
 			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
-- 
2.0.2
