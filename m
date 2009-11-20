From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] let core.excludesfile default to ~/.gitignore.
Date: Fri, 20 Nov 2009 14:23:50 +0100
Message-ID: <1258723430-31684-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 20 14:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBTT4-0003gE-QW
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 14:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbZKTNXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 08:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbZKTNXz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 08:23:55 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38394 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbZKTNXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 08:23:54 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAKDMgY1002550
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Nov 2009 14:22:42 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBTSq-0007Ik-21; Fri, 20 Nov 2009 14:23:52 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBTSp-0008Fl-Vt; Fri, 20 Nov 2009 14:23:51 +0100
X-Mailer: git-send-email 1.6.5.2.152.gbbe9e
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Nov 2009 14:22:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAKDMgY1002550
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1259328163.46784@uTL9tx29sljq0j9baKaLkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133343>

It seems this is the value most users set, so let's make it the default.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
A funny experiment:

http://www.google.com/search?q=core.excludesfile+-%22~/.gitignore%22
Results 1 - 10 of about 3,890 for core.excludesfile -"~/.gitignore"

http://www.google.com/search?q=core.excludesfile+%22~/.gitignore%22
Results 1 - 10 of about 7,990 for core.excludesfile "~/.gitignore"

So, most of the time someone mentions core.excludesfile on the web,
~/.gitignore is mentionned right after.


I'd have expected a place near config.c to set the default value for
any config variable, but I can't find such thing, so I guess the
caller is the one that should set the default, which is what I do in
the patch.

 Documentation/config.txt |    1 +
 dir.c                    |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 39d1226..0c55e52 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -384,6 +384,7 @@ core.excludesfile::
 	of files which are not meant to be tracked.  "~/" is expanded
 	to the value of `$HOME` and "~user/" to the specified user's
 	home directory.  See linkgit:gitignore[5].
+	Default: ~/.gitignore.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/dir.c b/dir.c
index d0999ba..dcea6ad 100644
--- a/dir.c
+++ b/dir.c
@@ -914,9 +914,16 @@ void setup_standard_excludes(struct dir_struct *dir)
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
+	if (!excludes_file) {
+		const char *home = getenv("HOME");
+		char *user_gitignore = malloc(strlen(home) + strlen("/.gitignore") + 1);
+		strcpy(user_gitignore, home);
+		strcat(user_gitignore, "/.gitignore");
+		excludes_file = user_gitignore;
+	}
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
-	if (excludes_file && !access(excludes_file, R_OK))
+	if (!access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
 
-- 
1.6.5.2.152.gbbe9e
