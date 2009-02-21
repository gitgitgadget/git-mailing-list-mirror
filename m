From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A v4 3/5] git_config(): not having a per-repo config file is not an error
Date: Sat, 21 Feb 2009 02:48:55 +0200
Message-ID: <1235177337-2532-4-git-send-email-felipe.contreras@gmail.com>
References: <1235177337-2532-1-git-send-email-felipe.contreras@gmail.com>
 <1235177337-2532-2-git-send-email-felipe.contreras@gmail.com>
 <1235177337-2532-3-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag4m-000784-BZ
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbZBUAtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbZBUAtJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:09 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42984 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbZBUAtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:07 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3160824bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4/ENwKB1luX8WguMVw/j6Z+LVmBgqtvchdQV0HX6P5c=;
        b=f1F2/7nLdmkohuAYEOHHkV/3F0DO4C+8wgG0hCWZOwZ8JmKhYoQxXTTQa/80QlBs5w
         6OMs3gyi3mrx5kmROtruaji2U3iihAYQArDwba+UPXNYMQRNfHxMepPBXxBCq//o4q42
         ffXxK0AnlZaTa7wHWuDVhPuKqFHPwyU6PgarU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tLfZuQPXNWL0KCvnCocuTKzo0iCIt1SJvbkkmJ2qH4LlnvDyCgFo5d2Mo7HNb996mM
         Byqbk4zcR2P9qseENz48oMzfNQ3FIMOLa+WfYgIHkJwfvAIu8GPTMvOYOVosLcRb7FxV
         qQnnr4DXfnI7QWG4RErzpBZT4VaY4GhwmBpZw=
Received: by 10.180.235.10 with SMTP id i10mr478900bkh.58.1235177346680;
        Fri, 20 Feb 2009 16:49:06 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id h2sm5720719fkh.29.2009.02.20.16.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:06 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177337-2532-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110909>

Currently git_config() returns an error if there is no repo config file
available (cwd is not a git repo); it will correctly parse the system
and global config files, but still return an error.

It doesn't affect anything else since almost nobody is checking for the
return code (with the exception of 'git remote update').

A reorganization in 'git config' would benefit from being able to
properly detect errors in git_config() without the noise generated when
cwd is not a git repo.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 config.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 7dc1b0f..68ce519 100644
--- a/config.c
+++ b/config.c
@@ -649,28 +649,37 @@ int git_config_global(void)
 
 int git_config(config_fn_t fn, void *data)
 {
-	int ret = 0;
+	int ret = 0, found = 0;
 	char *repo_config = NULL;
 	const char *home = NULL;
 
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
 	if (config_exclusive_filename)
 		return git_config_from_file(fn, config_exclusive_filename, data);
-	if (git_config_system() && !access(git_etc_gitconfig(), R_OK))
+	if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
+		found += 1;
+	}
 
 	home = getenv("HOME");
 	if (git_config_global() && home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-		if (!access(user_config, R_OK))
+		if (!access(user_config, R_OK)) {
 			ret += git_config_from_file(fn, user_config, data);
+			found += 1;
+		}
 		free(user_config);
 	}
 
 	repo_config = git_pathdup("config");
-	ret += git_config_from_file(fn, repo_config, data);
+	if (!access(repo_config, R_OK)) {
+		ret += git_config_from_file(fn, repo_config, data);
+		found += 1;
+	}
 	free(repo_config);
+	if (found == 0)
+		return -1;
 	return ret;
 }
 
-- 
1.6.1.3
