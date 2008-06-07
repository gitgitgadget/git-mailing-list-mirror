From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH] Use SUDO_UID to guess committer identity
Date: Sat, 7 Jun 2008 03:11:30 -0400
Message-ID: <20080607071130.GZ12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 09:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sbD-0005aX-EP
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 09:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbYFGHLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 03:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbYFGHLf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 03:11:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38022 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbYFGHLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 03:11:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K4saI-0007FA-UB
	for git@vger.kernel.org; Sat, 07 Jun 2008 03:11:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E077520FBAE; Sat,  7 Jun 2008 03:11:30 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84179>

When invoking Git commands though sudo against a bare repository
with reflogs enabled we should attempt to record the actual user's
information in the reflog, not the identity of the user sudo entered.

For example when executing:

	sudo -u gitadm git --git-dir=/srv/git.git branch -f pu master

We want record information about the caller of sudo, not gitadm.

Relying on $SUDO_UID in this case isn't as bad as it might seem.
Under sudo $HOME is left as the real user's home directory and
$HOME/.gitconfig is used to supply user.name and user.email.
However if the real user does not have ~/.gitconfig or did not set
user.name/email we need to guess it from their GECOS information.

NO SBO - FOR DISCUSSION ONLY
---
 ident.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index b35504a..c821d5f 100644
--- a/ident.c
+++ b/ident.c
@@ -7,6 +7,21 @@
  */
 #include "cache.h"
 
+static uid_t caller_uid(void)
+{
+	const char *sudo_uid = getenv("SUDO_UID");
+	char *end;
+	unsigned long who;
+
+	if (!sudo_uid || !*sudo_uid)
+		return getuid();
+
+	who = strtoul(sudo_uid, &end, 10)
+	if (*end)
+		return getuid();
+	return (uid_t)who;
+}
+
 static char git_default_date[50];
 
 static void copy_gecos(const struct passwd *w, char *name, size_t sz)
@@ -76,7 +91,7 @@ static void setup_ident(void)
 
 	/* Get the name ("gecos") */
 	if (!git_default_name[0]) {
-		pw = getpwuid(getuid());
+		pw = getpwuid(caller_uid());
 		if (!pw)
 			die("You don't exist. Go away!");
 		copy_gecos(pw, git_default_name, sizeof(git_default_name));
@@ -90,7 +105,7 @@ static void setup_ident(void)
 				sizeof(git_default_email));
 		else {
 			if (!pw)
-				pw = getpwuid(getuid());
+				pw = getpwuid(caller_uid());
 			if (!pw)
 				die("You don't exist. Go away!");
 			copy_email(pw);
@@ -208,7 +223,7 @@ const char *fmt_ident(const char *name, const char *email,
 		}
 		if (error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);
-		pw = getpwuid(getuid());
+		pw = getpwuid(caller_uid());
 		if (!pw)
 			die("You don't exist. Go away!");
 		strlcpy(git_default_name, pw->pw_name,
-- 
Shawn.
