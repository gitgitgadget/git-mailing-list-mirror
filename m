From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 08/10] use xgetcwd() to set $GIT_DIR
Date: Mon, 28 Jul 2014 20:31:57 +0200
Message-ID: <53D6971D.80107@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:32:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpiU-0004rt-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbaG1ScG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:32:06 -0400
Received: from mout.web.de ([212.227.17.12]:57885 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbaG1ScE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:32:04 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M2dg1-1WK8d91Ut3-00sKTi; Mon, 28 Jul 2014 20:31:58
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:5GFMewiZXeW5/z9NYvAWw67tMONPz4922vjPStW0ncD7uAdCzBE
 vKWScUAMtDVjWVeWfwpp2mCTsUQIlEOU//l6tjexErvfk9f9ePzBoX8bJJ8lH5dCTTfp1sf
 x1jxzAXyRtcRnP+eaedSJk2QqK8V+Ft3dyjfsJbJH/otZqxV/GDuRxXrfErJg9tFuqCZkUL
 i26nTe6olknDKAj/nrBiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254341>

Instead of dying of a segmentation fault if getcwd() returns NULL, use
xgetcwd() to make sure to write a useful error message and then exit
in an orderly fashion.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/init-db.c | 7 +++----
 git.c             | 5 +++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f6dd172..ab0ea02 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -537,10 +537,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		usage(init_db_usage[0]);
 	}
 	if (is_bare_repository_cfg == 1) {
-		static char git_dir[PATH_MAX+1];
-
-		setenv(GIT_DIR_ENVIRONMENT,
-			getcwd(git_dir, sizeof(git_dir)), argc > 0);
+		char *cwd = xgetcwd();
+		setenv(GIT_DIR_ENVIRONMENT, cwd, argc > 0);
+		free(cwd);
 	}
 
 	if (init_shared_repository != -1)
diff --git a/git.c b/git.c
index 47137db..210f1ae 100644
--- a/git.c
+++ b/git.c
@@ -161,9 +161,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
-			static char git_dir[PATH_MAX+1];
+			char *cwd = xgetcwd();
 			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
+			setenv(GIT_DIR_ENVIRONMENT, cwd, 0);
+			free(cwd);
 			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged = 1;
-- 
2.0.2
