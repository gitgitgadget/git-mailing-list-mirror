From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] Let core.excludesfile default to ~/.gitexcludes.
Date: Sat, 21 Nov 2009 23:00:32 +0100
Message-ID: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
References: <4B06A7EE.2090801@atlas-elektronik.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 21 23:03:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBy3L-0000Gu-LE
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 23:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbZKUWDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 17:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756828AbZKUWDT
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 17:03:19 -0500
Received: from imag.imag.fr ([129.88.30.1]:43241 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756821AbZKUWDS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 17:03:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nALM0heU023071
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 21 Nov 2009 23:00:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBy0Z-0004rx-ML; Sat, 21 Nov 2009 23:00:43 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBy0Z-0005mB-LJ; Sat, 21 Nov 2009 23:00:43 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <4B06A7EE.2090801@atlas-elektronik.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 21 Nov 2009 23:00:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133415>

Most users will set it to ~/.gitsomething. ~/.gitignore would conflict
with per-directory ignore file if ~/ is managed by Git, so ~/.gitexcludes
is a sane default.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Change since v1 : just changed gitignore -> gitexcludes.

 Documentation/config.txt |    1 +
 dir.c                    |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 39d1226..13871a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -384,6 +384,7 @@ core.excludesfile::
 	of files which are not meant to be tracked.  "~/" is expanded
 	to the value of `$HOME` and "~user/" to the specified user's
 	home directory.  See linkgit:gitignore[5].
+	Default: ~/.gitexcludes.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/dir.c b/dir.c
index d0999ba..cf3d8b4 100644
--- a/dir.c
+++ b/dir.c
@@ -914,9 +914,16 @@ void setup_standard_excludes(struct dir_struct *dir)
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
+	if (!excludes_file) {
+		const char *home = getenv("HOME");
+		char *user_gitignore = malloc(strlen(home) + strlen("/.gitexcludes") + 1);
+		strcpy(user_gitignore, home);
+		strcat(user_gitignore, "/.gitexcludes");
+		excludes_file = user_gitignore;
+	}
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
-	if (excludes_file && !access(excludes_file, R_OK))
+	if (!access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
 
-- 
1.6.5.3.435.g5f2e3.dirty
