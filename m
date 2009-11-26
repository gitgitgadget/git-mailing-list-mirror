From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH (resend)] Let core.excludesfile default to ~/.gitexcludes.
Date: Thu, 26 Nov 2009 11:35:26 +0100
Message-ID: <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 26 11:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDbhY-0002Nu-1B
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 11:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760264AbZKZKfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 05:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760261AbZKZKfk
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 05:35:40 -0500
Received: from mx2.imag.fr ([129.88.30.17]:60794 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760164AbZKZKfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 05:35:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAQAYHI6031255
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Nov 2009 11:34:19 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NDbhE-0006yN-DS; Thu, 26 Nov 2009 11:35:32 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NDbhE-0001Mm-B3; Thu, 26 Nov 2009 11:35:32 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Nov 2009 11:34:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAQAYHI6031255
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1259836460.41602@cVC7mRx+/b738TDnE8izkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133779>

Most users will set it to ~/.gitsomething. ~/.gitignore would conflict
with per-directory ignore file if ~/ is managed by Git, so ~/.gitexcludes
is a sane default.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
(just resending since the patch seems to have got lost in the process)

 Documentation/config.txt |    1 +
 dir.c                    |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7ff2d1d..9fc527c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -408,6 +408,7 @@ core.excludesfile::
 	of files which are not meant to be tracked.  "{tilde}/" is expanded
 	to the value of `$HOME` and "{tilde}user/" to the specified user's
 	home directory.  See linkgit:gitignore[5].
+	Default: ~/.gitexcludes.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/dir.c b/dir.c
index 3a8d3e6..a6a6291 100644
--- a/dir.c
+++ b/dir.c
@@ -944,9 +944,16 @@ void setup_standard_excludes(struct dir_struct *dir)
 
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
