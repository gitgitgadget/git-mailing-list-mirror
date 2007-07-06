From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 06 Jul 2007 10:03:15 -0500
Message-ID: <468E59B3.7080007@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: torvalds@linux-foundation.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 17:04:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pM0-0000MR-Kq
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbXGFPEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbXGFPEO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:04:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55138 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbXGFPEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:04:13 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l66F1XXP027300;
	Fri, 6 Jul 2007 10:01:36 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Jul 2007 10:03:16 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
X-OriginalArrivalTime: 06 Jul 2007 15:03:16.0104 (UTC) FILETIME=[C7EAB080:01C7BFDE]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15280000
X-TM-AS-Result: : Yes--10.790500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQ0LTE1MDY3MC03MDA2?=
	=?us-ascii?B?MTgtNzAzNDM2LTcwMzc4OC03MDM5NjktNzAxNTc2LTcwMDc1Ni03?=
	=?us-ascii?B?MDAxNjAtNzAwMDc1LTEzOTAxMC03MDE0NTUtNzAyMDQ0LTcwNDAz?=
	=?us-ascii?B?NC03MDEyMzYtNzAyNjA5LTcwODE3OS03MDcwNjYtMTg4MDE5LTcw?=
	=?us-ascii?B?NjI5MC03MDQ3NDctNzAwMzI0LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51760>


This makes $EMAIL the second to last resort ahead of
username@hostname rather than the last resort when
GIT_AUTHOR_EMAIL or GIT_COMMITER_EMAIL and user.email
are not set.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---

Linus Torvalds wrote:
>If you want it to prefer $EMAIL, you'd need to change the initialization 
>of git_default_email, methinks.

How about this?


 ident.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 3d49608..dc13510 100644
--- a/ident.c
+++ b/ident.c
@@ -73,6 +73,7 @@ static void copy_email(const struct passwd *pw)
 static void setup_ident(void)
 {
 	struct passwd *pw = NULL;
+        char *email;
 
 	/* Get the name ("gecos") */
 	if (!git_default_name[0]) {
@@ -82,6 +83,9 @@ static void setup_ident(void)
 		copy_gecos(pw, git_default_name, sizeof(git_default_name));
 	}
 
+	if (!git_default_email[0] && (email = getenv("EMAIL")) != NULL)
+                strlcpy(git_default_email, email, sizeof(git_default_email));
+
 	if (!git_default_email[0]) {
 		if (!pw)
 			pw = getpwuid(getuid());
@@ -197,8 +201,6 @@ const char *fmt_ident(const char *name, const char *email,
 		name = git_default_name;
 	if (!email)
 		email = git_default_email;
-	if (!email)
-		email = getenv("EMAIL");
 
 	if (!*name) {
 		struct passwd *pw;
-- 
1.5.3.rc0.30.g114f-dirty
