From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 03/10] config: Make git_config() more flexible.
Date: Tue, 17 Feb 2009 15:52:49 +0200
Message-ID: <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPl-0001sQ-Ji
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZBQNxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZBQNxN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:13 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:38712 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbZBQNxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:11 -0500
Received: by ewy14 with SMTP id 14so2285088ewy.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TCdJH7IluXYRpWBAMty3ZmQEqhyJM4GPVuoz9ZzJcRA=;
        b=bVqqbrrhwDfPiSI3vtg6VDWnIGMNVJUnSpeTUWykRKcwhsnNSCuxo5ga0I4NTJOuk1
         FZlla2+whCoKvnJoYJ1J+ranzCB62gqwdZ+J7+iSQsK/7Cf4CtEV5r9mYbO9eQfPIB0u
         c6/Vle+kPrYtUXZx3+UkXlp8Aqr6QzTtu2pY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rev2hOym5NWQE1ajemqh9s6K+kwfYIHfdg7R6S4KKq80AIDmZ/jpiCKgabSNYS6S6x
         WOb6BIOcouEt1eD7JlY/lfW74MR8S6iuCN+MhlsM8667HH1iFXrRX/NOzM9h0fMxxLCG
         wITObU2ZgIgdfQH1f6m5nLYxEXDVuKZWXXhow=
Received: by 10.210.36.10 with SMTP id j10mr2305772ebj.4.1234878789102;
        Tue, 17 Feb 2009 05:53:09 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id m5sm4325497gve.10.2009.02.17.05.53.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:08 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110371>

Currently git_config() returns an error if there is no repo config file
available (cwd is not a git repo); it will correctly parse the system
and global config files, but still return an error.

It doesn't affect anything else since almost nobody is checking for the
return code (with the exception of 'git remote update').

A reorganization in 'git config' would benefit from being able to
properly detect errors in git_config without the noise generated when
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
