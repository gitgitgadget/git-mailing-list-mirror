From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/7] builtin-help: change the current directory back in list_commands_in_dir()
Date: Sat, 26 Jul 2008 13:54:46 +0200
Message-ID: <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
 <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiN9-0002Vg-V0
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbYGZLy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYGZLy0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:54:26 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54446 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYGZLyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:54:25 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id 56A2D1DDC5E
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:54:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9EBBB1AB591; Sat, 26 Jul 2008 13:54:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
In-Reply-To: <cover.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90218>

That function used to do a chdir() without switching back to the
original directory. That was not a problem till this function was used
only inside builtin-help, but once other builtins use it as well, this
is a problem, for example when the object database path is relative.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 help.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/help.c b/help.c
index fb93df0..d71937e 100644
--- a/help.c
+++ b/help.c
@@ -425,7 +425,9 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	int prefix_len;
 	DIR *dir = opendir(path);
 	struct dirent *de;
+	static char old_path[PATH_MAX+1];
 
+	getcwd(old_path, sizeof(old_path));
 	if (!dir || chdir(path))
 		return 0;
 
@@ -452,6 +454,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	}
 	closedir(dir);
 
+	chdir(old_path);
 	return longest;
 }
 
-- 
1.6.0.rc0.14.g95f8.dirty
