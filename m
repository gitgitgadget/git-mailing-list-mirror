From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 5/5] is_submodule_modified(): clear environment properly
Date: Thu, 25 Feb 2010 00:34:18 +0100
Message-ID: <1267054458-11877-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 00:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQlO-0003Cd-2n
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587Ab0BXXep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 18:34:45 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61827 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758572Ab0BXXeo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 18:34:44 -0500
Received: by mail-ww0-f46.google.com with SMTP id 26so1593994wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PRwFTsPEfVEiExBagD8TXUodRI3wybNKH2uorFR2UR0=;
        b=QEr9zvKzZu+cN8vmib+lrpKCN9+bT6pf0cOq6KFKn/x9+xDFV+n+whP5XVNqp96HzO
         3Yby7DO8tR3oEO/8m9FUBM5x1dTOV0+n3sCoiaOjgHuyHPEDU/hSkGBtx/DN9kvkvgjz
         wJ5pQJnBNG/5q/0bYBjaMoYvgEOuFn7bKAw9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K9qBUTKJgH9Bf67k3BXc4GkvpVZati60dI+eeYNpeYsgwRaQIWo1CYP12SJj5wzWLM
         kSPveXPmA5SnTEE1/S1duc0GUCB1vnkYDJ/j3Jzascngl8dQ3Zwbuqlw+PsStos/gXX3
         fbDtnp9uHHq9Ut3Lz22bV9WdvryM7aq7KSYP0=
Received: by 10.216.88.202 with SMTP id a52mr271528wef.101.1267054483432;
        Wed, 24 Feb 2010 15:34:43 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id i34sm23877165gve.14.2010.02.24.15.34.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 15:34:42 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g5b851b.dirty
In-Reply-To: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141008>

Rather than only clearing GIT_INDEX_FILE, take the list of environment
variables to clear from local_repo_env, appending the settings for
GIT_DIR and GIT_WORK_TREE.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 submodule.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7d70c4f..3c34d39 100644
--- a/submodule.c
+++ b/submodule.c
@@ -124,15 +124,19 @@ void show_submodule_summary(FILE *f, const char *path,
 int is_submodule_modified(const char *path)
 {
 	int len;
+	unsigned int i = 0;
 	struct child_process cp;
 	const char *argv[] = {
 		"status",
 		"--porcelain",
 		NULL,
 	};
-	char *env[4];
+	const char *env[local_repo_env_size+3];
 	struct strbuf buf = STRBUF_INIT;
 
+	for ( ; i < local_repo_env_size; ++i)
+		env[i] = local_repo_env[i];
+
 	strbuf_addf(&buf, "%s/.git/", path);
 	if (!is_directory(buf.buf)) {
 		strbuf_release(&buf);
@@ -143,16 +147,14 @@ int is_submodule_modified(const char *path)
 	strbuf_reset(&buf);
 
 	strbuf_addf(&buf, "GIT_WORK_TREE=%s", path);
-	env[0] = strbuf_detach(&buf, NULL);
+	env[i++] = strbuf_detach(&buf, NULL);
 	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
-	env[1] = strbuf_detach(&buf, NULL);
-	strbuf_addf(&buf, "GIT_INDEX_FILE");
-	env[2] = strbuf_detach(&buf, NULL);
-	env[3] = NULL;
+	env[i++] = strbuf_detach(&buf, NULL);
+	env[i] = NULL;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
-	cp.env = (const char *const *)env;
+	cp.env = env;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
@@ -165,9 +167,8 @@ int is_submodule_modified(const char *path)
 	if (finish_command(&cp))
 		die("git status --porcelain failed");
 
-	free(env[0]);
-	free(env[1]);
-	free(env[2]);
+	free((char *)env[--i]);
+	free((char *)env[--i]);
 	strbuf_release(&buf);
 	return len != 0;
 }
-- 
1.7.0.212.g5b851b.dirty
