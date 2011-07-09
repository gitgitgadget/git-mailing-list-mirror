From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not trust PWD blindly
Date: Sat, 9 Jul 2011 19:38:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1107091935210.1985@bonsai2>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@gmail.com>, gitster@pobox.com, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Sat Jul 09 19:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfbTt-0007iM-WC
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 19:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab1GIRiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jul 2011 13:38:12 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:49340 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752810Ab1GIRiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2011 13:38:12 -0400
Received: (qmail invoked by alias); 09 Jul 2011 17:38:09 -0000
Received: from pD9EB0336.dip0.t-ipconnect.de (EHLO noname) [217.235.3.54]
  by mail.gmx.net (mp030) with SMTP; 09 Jul 2011 19:38:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZmIkrlB4ZtHB5k/bOhY/HT/+7omJMiILd+qYdpG
	MrZ1kLiDRaxz6Y
X-X-Sender: gene099@bonsai2
In-Reply-To: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176819>


At least on Windows, chdir() does not update PWD. Unfortunately, stat()
does not fill any ino or dev fields anymore, so get_pwd_cwd() is not
able to tell.

But there is a telltale: both ino and dev are 0 when they are not filled
correctly, so let's be extra cautious.

This happens to fix a bug in "get-receive-pack working_directory/" when
the GIT_DIR would not be set correctly due to absolute_path(".")
returning the wrong value.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 8 Jul 2011, Pat Thoyts wrote:

	> ! t5516-fetch-push      (60 receive.denyCurrentBranch = updateInstead)

	This patch fixes that.

	Hannes, I have no idea whether you meant 10c4c881 to fix anything 
	on Windows.

 abspath.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/abspath.c b/abspath.c
index 01858eb..37287f8 100644
--- a/abspath.c
+++ b/abspath.c
@@ -102,7 +102,8 @@ static const char *get_pwd_cwd(void)
 	pwd = getenv("PWD");
 	if (pwd && strcmp(pwd, cwd)) {
 		stat(cwd, &cwd_stat);
-		if (!stat(pwd, &pwd_stat) &&
+		if ((cwd_stat.st_dev || cwd_stat.st_ino) &&
+		    !stat(pwd, &pwd_stat) &&
 		    pwd_stat.st_dev == cwd_stat.st_dev &&
 		    pwd_stat.st_ino == cwd_stat.st_ino) {
 			strlcpy(cwd, pwd, PATH_MAX);
-- 
1.7.6.rc0.4047.g15f89
