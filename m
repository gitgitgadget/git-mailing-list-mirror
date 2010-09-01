From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC PATCH] git-help: find library man pages again
Date: Wed,  1 Sep 2010 18:02:14 +0200
Message-ID: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 18:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqplU-0000xN-NR
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 18:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab0IAQCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 12:02:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36171 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752142Ab0IAQCM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 12:02:12 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AFF3D4AA;
	Wed,  1 Sep 2010 12:02:11 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 01 Sep 2010 12:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=sYuuKODbXlEj/MZqqX2h9FF/HY8=; b=tUZZcAdKB+i+6DJTDEQ5t4+Io2CT1kzG8eN8q8kvOomRGmKSgEioUeqNDB+pMzfdpJEKmmyQIG1B1hk0JFUo/tGYakny3MJQBTRUOUT+tDWwhinPbfghLBmuSzkz0z1Xhy5GSqECjj/s2VqJ6Oy/pDQ9040C3FiZDhraqFEbHVs=
X-Sasl-enc: WVEihqW9I0Zw4nyHxP9gG30n2sZMm8gc0eajW8IjmCFb 1283356931
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2D01A400698;
	Wed,  1 Sep 2010 12:02:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.2.540.g9d56f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155055>

46bac90 (Do not install shell libraries executable, 2010-01-31) changed
the executable bits of shell variables in order to avoid false reports
from valgrind. As a side effect, this inhibits "git help" from finding
the corresponding man pages because list_command_in_dir() (called by
load_command_list()) checks that bit.

Short of reverting that and appeasing  valgrind in another way, make
list_command_in_dir() ignore the executable bit when looking in the exec
dir, so that the following man pages are found again by "git-help":

git-mergetool--lib
git-parse-remote
git-sh-setup

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    This does not help with the man page for git-remote-helpers which is installed
    but not found by git-help either. That is a different issue, though.

 help.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/help.c b/help.c
index 7f4928e..451899c 100644
--- a/help.c
+++ b/help.c
@@ -146,8 +146,9 @@ static int is_executable(const char *name)
 }
 
 static void list_commands_in_dir(struct cmdnames *cmds,
-					 const char *path,
-					 const char *prefix)
+					const char *path,
+					const char *prefix,
+					int checkexec)
 {
 	int prefix_len;
 	DIR *dir = opendir(path);
@@ -172,7 +173,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 
 		strbuf_setlen(&buf, len);
 		strbuf_addstr(&buf, de->d_name);
-		if (!is_executable(buf.buf))
+		if (checkexec && !is_executable(buf.buf))
 			continue;
 
 		entlen = strlen(de->d_name) - prefix_len;
@@ -193,7 +194,7 @@ void load_command_list(const char *prefix,
 	const char *exec_path = git_exec_path();
 
 	if (exec_path) {
-		list_commands_in_dir(main_cmds, exec_path, prefix);
+		list_commands_in_dir(main_cmds, exec_path, prefix, 0);
 		qsort(main_cmds->names, main_cmds->cnt,
 		      sizeof(*main_cmds->names), cmdname_compare);
 		uniq(main_cmds);
@@ -206,7 +207,7 @@ void load_command_list(const char *prefix,
 			if ((colon = strchr(path, PATH_SEP)))
 				*colon = 0;
 			if (!exec_path || strcmp(path, exec_path))
-				list_commands_in_dir(other_cmds, path, prefix);
+				list_commands_in_dir(other_cmds, path, prefix, 1);
 
 			if (!colon)
 				break;
-- 
1.7.2.2.540.g9d56f.dirty
