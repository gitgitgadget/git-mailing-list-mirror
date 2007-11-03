From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/3] Don't always require working tree for git-rm
Date: Sat,  3 Nov 2007 12:23:13 +0100
Message-ID: <1194088993-25692-3-git-send-email-mh@glandium.org>
References: <1194088993-25692-1-git-send-email-mh@glandium.org>
 <1194088993-25692-2-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 12:24:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoH7M-0003JZ-E2
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbXKCLY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXKCLY0
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:24:26 -0400
Received: from vawad.err.no ([85.19.200.177]:57396 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbXKCLYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:24:24 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoH6n-0007sm-Ic; Sat, 03 Nov 2007 12:24:12 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoH5u-0006gi-IK; Sat, 03 Nov 2007 12:23:14 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194088993-25692-2-git-send-email-mh@glandium.org>
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63237>

This allows to do git rm --cached -r directory, instead of
git ls-files -z directory | git update-index --remove -z --stdin.
This can be particularly useful for git-filter-branch users.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

This replaces the patch from
http://article.gmane.org/gmane.comp.version-control.git/63227

 builtin-rm.c |    3 +++
 git.c        |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index bca2bd9..a3d25e6 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -155,6 +155,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!argc)
 		usage_with_options(builtin_rm_usage, builtin_rm_options);
 
+	if (!index_only)
+		setup_work_tree();
+
 	pathspec = get_pathspec(prefix, argv);
 	seen = NULL;
 	for (i = 0; pathspec[i] ; i++)
diff --git a/git.c b/git.c
index eb31c93..4a250f7 100644
--- a/git.c
+++ b/git.c
@@ -340,7 +340,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
+		{ "rm", cmd_rm, RUN_SETUP },
 		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
-- 
1.5.3.5
