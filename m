From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/5] Call git_pathdup() rather than xstrdup(git_path("..."))
Date: Tue, 04 Sep 2012 18:30:21 +0100
Message-ID: <50463AAD.7060107@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8ySy-0001Zt-BP
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab2IDTHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:09 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40936 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932617Ab2IDTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:07 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id BE2F2128076;
	Tue,  4 Sep 2012 20:07:06 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 169AB128075;	Tue,  4 Sep 2012 20:07:06 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:05 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204771>


In addition to updating the two xstrdup(git_path("...")) call sites
with git_pathdup(), we also fix a memory leak by freeing the memory
allocated to the ADD_EDIT.patch 'file' in the edit_patch() function.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 bisect.c      | 2 +-
 builtin/add.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 48acf73..1aad49b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -833,7 +833,7 @@ static int check_ancestors(const char *prefix)
  */
 static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
-	char *filename = xstrdup(git_path("BISECT_ANCESTORS_OK"));
+	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
 	int fd;
 
diff --git a/builtin/add.c b/builtin/add.c
index 89dce56..2fc2677 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -260,7 +260,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 
 static int edit_patch(int argc, const char **argv, const char *prefix)
 {
-	char *file = xstrdup(git_path("ADD_EDIT.patch"));
+	char *file = git_pathdup("ADD_EDIT.patch");
 	const char *apply_argv[] = { "apply", "--recount", "--cached",
 		NULL, NULL };
 	struct child_process child;
@@ -303,6 +303,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 		die (_("Could not apply '%s'"), file);
 
 	unlink(file);
+	free(file);
 	return 0;
 }
 
-- 
1.7.12
