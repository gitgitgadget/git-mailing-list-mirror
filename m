From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] setup_git_directory: fix segfault if repository is found in cwd
Date: Wed, 6 Jun 2007 23:29:59 +0200
Message-ID: <20070606212959.GA8800@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:30:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw35B-0000LC-CU
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbXFFVaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756017AbXFFVaS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:30:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:33851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964840AbXFFVaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:30:16 -0400
Received: (qmail invoked by alias); 06 Jun 2007 21:30:00 -0000
Received: from pd9ebb5b0.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.176]
  by mail.gmx.net (mp053) with SMTP; 06 Jun 2007 23:30:00 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/PGI5fF5nPZNeovUndrXkyh2wkzGyZiCcECEPojK
	Exk2ETJf7ZWfzE
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49318>

Additionally there was a similar part calling setenv and getenv
in the same way which missed a check if getenv succeeded.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
There seems to be no easy way to test this case.  We'd have to run the
test in a directory which never has a .git directory in any parent.
---
 setup.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 14a4d95..dba8012 100644
--- a/setup.c
+++ b/setup.c
@@ -251,6 +251,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			die("Not a git repository");
 		}
 		setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+		gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+		if (!gitdirenv)
+			die("getenv after setenv failed");
 	}
 
 	if (PATH_MAX - 40 < strlen(gitdirenv)) {
@@ -290,6 +293,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	if (gitdirenv[0] != '/') {
 		setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
 		gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+		if (!gitdirenv)
+			die("getenv after setenv failed");
 		if (PATH_MAX - 40 < strlen(gitdirenv)) {
 			if (nongit_ok) {
 				*nongit_ok = 1;
-- 
1.5.2.1.887.ge344-dirty
