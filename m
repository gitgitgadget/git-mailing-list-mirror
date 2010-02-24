From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 6/6] is_submodule_modified(): clear environment properly
Date: Wed, 24 Feb 2010 08:23:16 +0100
Message-ID: <1266996196-25978-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBb9-0003WY-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab0BXHXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:23:50 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49322 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab0BXHXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:23:48 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so1021590wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dzcjw3v3x4UhmeLi1jLrKkMllkv5V/MkcE9unxv0nIs=;
        b=B2th2kh11iA+MFzLHtG/3EMi95bR729KUc2v2Zi/d1VqU/PxB7bmwdbHhmdKeP3P97
         6/Fi6HgCSZMdcqAxpEwlupq5Jy5mUb/+6mk8ycMq8UexE4R+PfsivRobYYjfhRCfH0sp
         MZk6MhfjKRtXPBEVFywgd9PODTINC2Shyypsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hpvtKvoNUI5YJTHAXDdgM1/yAaoBy/AVyf/nlUEgIkpmmRpH+mW2iA3SShF+UTdP4A
         Jp2hWOCplmZyZ2DSoifT51S6B/Q1y5T5IwqR/I+AtC9oWZMv321WS9ydUlHK5B/axsd2
         dciGzH4LmOCHhVKhVCs9iT8XUS9C3CNFRf6Ps=
Received: by 10.216.87.146 with SMTP id y18mr1240172wee.127.1266996227486;
        Tue, 23 Feb 2010 23:23:47 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id t2sm21450582gve.1.2010.02.23.23.23.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:23:46 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g4e217.dirty
In-Reply-To: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140913>

Rather than only clearing GIT_INDEX_FILE, take the list of environment
variables to clear from local_repo_env, appending the settings for
GIT_DIR and GIT_WORK_TREE.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 submodule.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7d70c4f..81cf05a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -124,15 +124,21 @@ void show_submodule_summary(FILE *f, const char *path,
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
+	const char *env[local_repo_env_size+2];
 	struct strbuf buf = STRBUF_INIT;
 
+	/* Copy local_repo_env to env, letting i
+	   rest at the last NULL */
+	while (env[i] = local_repo_env[i])
+		++i; /* do nothing */
+
 	strbuf_addf(&buf, "%s/.git/", path);
 	if (!is_directory(buf.buf)) {
 		strbuf_release(&buf);
@@ -143,16 +149,14 @@ int is_submodule_modified(const char *path)
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
@@ -165,9 +169,8 @@ int is_submodule_modified(const char *path)
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
1.7.0.212.g4e217.dirty
