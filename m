X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Default GIT_COMMITTER_NAME to login name in recieve-pack.
Date: Sun, 17 Dec 2006 03:15:14 -0500
Message-ID: <20061217081514.GA17423@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 08:15:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34678>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvrBH-0003qL-0E for gcvg-git@gmane.org; Sun, 17 Dec
 2006 09:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752219AbWLQIPV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 03:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWLQIPV
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 03:15:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57756 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752218AbWLQIPV (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 03:15:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvrAe-0007Jm-95; Sun, 17 Dec 2006 03:14:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1316B20FB65; Sun, 17 Dec 2006 03:15:15 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

If GIT_COMMITTER_NAME is not available in receive-pack but reflogs
are enabled we would normally die out with an error message asking
the user to correct their environment settings.

Now that reflogs are enabled by default in (what we guessed to be)
non-bare Git repositories this may cause problems for some users
who don't have their full name in the gecos field and who don't
have access to the remote system to correct the problem.

So rather than die()'ing out in receive-pack when we try to log a
ref change and have no committer name we default to the username,
as obtained from the host's password database.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h        |    1 +
 ident.c        |   15 +++++++++++++++
 receive-pack.c |    2 ++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index bfab4f9..8ad5920 100644
--- a/cache.h
+++ b/cache.h
@@ -309,6 +309,7 @@ void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
 
 extern int setup_ident(void);
+extern void ignore_missing_committer_name();
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 
diff --git a/ident.c b/ident.c
index e415fd3..d7faba6 100644
--- a/ident.c
+++ b/ident.c
@@ -221,3 +221,18 @@ const char *git_committer_info(int error_on_no_name)
 			 getenv("GIT_COMMITTER_DATE"),
 			 error_on_no_name);
 }
+
+void ignore_missing_committer_name()
+{
+	/* If we did not get a name from the user's gecos entry then
+	 * git_default_name is empty; so instead load the username
+	 * into it as a 'good enough for now' approximation of who
+	 * this user is.
+	 */
+	if (!*git_default_name) {
+		struct passwd *pw = getpwuid(getuid());
+		if (!pw)
+			die("You don't exist. Go away!");
+		strlcpy(git_default_name, pw->pw_name, sizeof(git_default_name));
+	}
+}
diff --git a/receive-pack.c b/receive-pack.c
index ec3bab3..c9eaf55 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -420,6 +420,8 @@ int main(int argc, char **argv)
 		die("'%s': unable to chdir or not a git archive", dir);
 
 	setup_ident();
+	/* don't die if gecos is empty */
+	ignore_missing_committer_name();
 	git_config(receive_pack_config);
 
 	write_head_info();
-- 
