From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] is_submodule_modified(): clear environment properly
Date: Tue, 23 Feb 2010 22:47:51 +0100
Message-ID: <4B844D07.8070406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2bm-0004nm-8f
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab0BWVrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:47:53 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:42165 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab0BWVrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:47:53 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id EED6D148C829F;
	Tue, 23 Feb 2010 22:47:51 +0100 (CET)
Received: from [80.128.55.61] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nk2bf-0000gJ-00; Tue, 23 Feb 2010 22:47:51 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+kvngmWR8MP0NoHvxzGFKuChQ6rAOLdVhmJSjy
	JFpdR7pWHLLAHDCZOAjw+bZKc8YffBVCX30mKJEpOhQqNG3R+y
	wfVthT4XWjeF9064FFOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140845>

Only GIT_INDEX_FILE was cleared until now, but other environment variables
have to be cleared too before running git status in a submodule.

And while at it, don't allocate a new strbuf for GIT_INDEX_FILE but use
a string constant instead.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


I think it makes sense to clear the same environment variables here
as Giuseppe Bilotta's patch did for the git shell commands, even
though i am not aware of any bug reports yet.


 submodule.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7d70c4f..f5707c2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -130,7 +130,7 @@ int is_submodule_modified(const char *path)
 		"--porcelain",
 		NULL,
 	};
-	char *env[4];
+	char *env[9];
 	struct strbuf buf = STRBUF_INIT;

 	strbuf_addf(&buf, "%s/.git/", path);
@@ -146,9 +146,17 @@ int is_submodule_modified(const char *path)
 	env[0] = strbuf_detach(&buf, NULL);
 	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
 	env[1] = strbuf_detach(&buf, NULL);
-	strbuf_addf(&buf, "GIT_INDEX_FILE");
-	env[2] = strbuf_detach(&buf, NULL);
-	env[3] = NULL;
+	/*
+	 * Clear repo-local GIT_* environment variables (Also see
+	 * clear_local_git_env() in git-sh-setup.sh)
+	 */
+	env[2] = "GIT_ALTERNATE_OBJECT_DIRECTORIES";
+	env[3] = "GIT_CONFIG";
+	env[4] = "GIT_GRAFT_FILE";
+	env[5] = "GIT_INDEX_FILE";
+	env[6] = "GIT_NO_REPLACE_OBJECTS";
+	env[7] = "GIT_OBJECT_DIRECTORY";
+	env[8] = NULL;

 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
@@ -167,7 +175,6 @@ int is_submodule_modified(const char *path)

 	free(env[0]);
 	free(env[1]);
-	free(env[2]);
 	strbuf_release(&buf);
 	return len != 0;
 }
-- 
1.7.0.199.g508d1.dirty
