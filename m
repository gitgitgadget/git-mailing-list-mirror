From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Keep "git --git-dir" from causing a bus error.
Date: Fri, 22 Dec 2006 08:56:25 -0500
Message-ID: <20061222135625.GA26084@179.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 22 14:56:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxksx-0005OX-PA
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 14:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbWLVN41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 08:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbWLVN41
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 08:56:27 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:43132 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbWLVN40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 08:56:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 9E6231FFC02B
	for <git@vger.kernel.org>; Fri, 22 Dec 2006 13:56:25 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35175>

The option checking code for --git-dir had an off by 1 error that
would cause it to access uninitialized memory if it was the last
argument.  This causes it to display an error and display the usage
string instead.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 I would have made this display the git directory, but the code to
 do that seems to be unique to rev-parse and involve more set up than is
 done at the time the option is parsed.

 git.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 73cf4d4..2b3c9f9 100644
--- a/git.c
+++ b/git.c
@@ -59,11 +59,14 @@ static int handle_options(const char*** argv, int* argc)
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			setup_pager();
 		} else if (!strcmp(cmd, "--git-dir")) {
-			if (*argc < 1)
-				return -1;
-			setenv("GIT_DIR", (*argv)[1], 1);
-			(*argv)++;
-			(*argc)--;
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for --git-dir.\n" );
+				usage(git_usage_string);
+			} else {
+				setenv("GIT_DIR", (*argv)[1], 1);
+				(*argv)++;
+				(*argc)--;
+			}
 		} else if (!strncmp(cmd, "--git-dir=", 10)) {
 			setenv("GIT_DIR", cmd + 10, 1);
 		} else if (!strcmp(cmd, "--bare")) {
-- 
1.4.4.GIT
