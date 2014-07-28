From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] init: avoid superfluous real_path() calls
Date: Mon, 28 Jul 2014 20:42:05 +0200
Message-ID: <53D6997D.10603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpsH-0000RE-NM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbaG1SmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:42:12 -0400
Received: from mout.web.de ([212.227.17.12]:60402 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaG1SmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:42:10 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MXpdL-1WxLuT0eWN-00WmlE; Mon, 28 Jul 2014 20:42:06
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:cKwx9Z9kTlgPlRaL1q4tlx4Fk6DmpB1kGsdY7l4mn7lDJuHPK2y
 D+FnshZe0mozBthOK8GG4WPUOvMbJlVqROVY+TfKpA9ozg3wBNHQ+aq4HRsIOxS/aInjA/e
 UXMUENQp5JKv6Z8oUIOdlwd5EYrs+6z1aRiYQ9tKts0+pDCx180zoKkm6eIXYfP46b78vfE
 T8sKDR7fVQQvgxAnzb3Eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254345>

Feeding the result of a real_path() call to real_path() again doesn't
change that result -- the returned path won't get any more real.  Avoid
such a double call in set_git_dir_init() and for the same reason stop
calling real_path() before feeding paths to set_git_work_tree(), as the
latter already takes care of that.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/init-db.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..6d8ac2c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -330,12 +330,12 @@ int set_git_dir_init(const char *git_dir, const char *real_git_dir,
 		 * moving the target repo later on in separate_git_dir()
 		 */
 		git_link = xstrdup(real_path(git_dir));
+		set_git_dir(real_path(real_git_dir));
 	}
 	else {
-		real_git_dir = real_path(git_dir);
+		set_git_dir(real_path(git_dir));
 		git_link = NULL;
 	}
-	set_git_dir(real_path(real_git_dir));
 	return 0;
 }
 
@@ -578,7 +578,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				die_errno (_("Cannot access current working directory"));
 		}
 		if (work_tree)
-			set_git_work_tree(real_path(work_tree));
+			set_git_work_tree(work_tree);
 		else
 			set_git_work_tree(git_work_tree_cfg);
 		if (access(get_git_work_tree(), X_OK))
@@ -587,7 +587,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 	else {
 		if (work_tree)
-			set_git_work_tree(real_path(work_tree));
+			set_git_work_tree(work_tree);
 	}
 
 	set_git_dir_init(git_dir, real_git_dir, 1);
-- 
2.0.2
