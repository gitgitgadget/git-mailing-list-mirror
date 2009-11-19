From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] expand_user_path: expand ~ to $HOME, not to the actual homedir.
Date: Thu, 19 Nov 2009 16:21:15 +0100
Message-ID: <1258644075-16191-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1258534693-7220-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 19 16:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB8q6-0006Tn-VP
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 16:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbZKSPWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 10:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbZKSPWB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 10:22:01 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52239 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104AbZKSPWB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 10:22:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nAJFJwtk005410
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Nov 2009 16:19:58 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NB8p1-0007xO-M5; Thu, 19 Nov 2009 16:21:23 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NB8p1-0004Dk-LI; Thu, 19 Nov 2009 16:21:23 +0100
X-Mailer: git-send-email 1.6.5.2.152.gbbe9e
In-Reply-To: <1258534693-7220-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 19 Nov 2009 16:19:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAJFJwtk005410
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1259248799.21566@Kxt9pMD7fHzq6h8T95EWoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133232>

In 395de250d (Expand ~ and ~user in core.excludesfile, commit.template),
we introduced the mechanism. But expanding ~ using getpw is not what
people overriding $HOME would usually expect. In particular, git looks
for the user's .gitconfig using $HOME, so it's better to be consistent.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is basically my patch v4, but since an earlier version is already
in next, I resend the last bits of it, based on next.

 Documentation/config.txt |    9 +++++----
 path.c                   |   13 +++++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 468e285..39d1226 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -381,9 +381,9 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.  "~/" and "~user/"
-	are expanded to the specified user's home directory.  See
-	linkgit:gitignore[5].
+	of files which are not meant to be tracked.  "~/" is expanded
+	to the value of `$HOME` and "~user/" to the specified user's
+	home directory.  See linkgit:gitignore[5].
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
@@ -683,7 +683,8 @@ color.ui::
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
-	"~/" and "~user/" are expanded to the specified user's home directory.
+	"~/" is expanded to the value of `$HOME` and "~user/" to the
+	specified user's home directory.
 
 diff.autorefreshindex::
 	When using 'git-diff' to compare with work tree
diff --git a/path.c b/path.c
index b4a8075..2ec950b 100644
--- a/path.c
+++ b/path.c
@@ -235,10 +235,15 @@ char *expand_user_path(const char *path)
 	if (path[0] == '~') {
 		const char *username = path + 1;
 		size_t username_len = first_slash - username;
-		struct passwd *pw = getpw_str(username, username_len);
-		if (!pw)
-			goto return_null;
-		strbuf_add(&user_path, pw->pw_dir, strlen(pw->pw_dir));
+		if (username_len == 0) {
+			const char *home = getenv("HOME");
+			strbuf_add(&user_path, home, strlen(home));
+		} else {
+			struct passwd *pw = getpw_str(username, username_len);
+			if (!pw)
+				goto return_null;
+			strbuf_add(&user_path, pw->pw_dir, strlen(pw->pw_dir));
+		}
 		to_copy = first_slash;
 	}
 	strbuf_add(&user_path, to_copy, strlen(to_copy));
-- 
1.6.5.2.152.gbbe9e
