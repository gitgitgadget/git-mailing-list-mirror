From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 16/22] worktree: elucidate environment variables intended for child processes
Date: Fri, 17 Jul 2015 19:00:11 -0400
Message-ID: <1437174017-81687-17-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdK-0002NX-PZ
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbbGQXBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:31 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38798 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbbGQXB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:28 -0400
Received: by iggf3 with SMTP id f3so47296207igg.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aLoqHkZNet4nJuV1lZX3lQtMs7Emy+MfCSWpgG9uirQ=;
        b=A27b46uc2P02McOiTOaVaITTcstZbz0AyboH+Y/FJN1B6l8m7bYbe/m6plUIFhUYqu
         jGDOex1EfWayzS6kXYS5UA3Nta5SB1JjT7JrEVFvttKXaoBSipkeiyv0lFDj4oL9KNxy
         NvK6yKwtyCA8D3Yd3Shpr6om+nIb/SpLmHMsoRlNgWs8UF2fjv/PPIGNwOYrIBZhJyXg
         oJ3a+ANd4nZtA8/PS+kqz48z+Q5d6XylGqe8ncy1PvflsIA5gzAJKLfXp+CsgZ4k+Y+s
         Yfb2tfRJJUEiYzu9cjvB19kLCRJmaPJpyabOFl5yKgZLDYIeNt+saGJbuxoG55TfIU/T
         d/Nw==
X-Received: by 10.107.166.72 with SMTP id p69mr23809271ioe.65.1437174087562;
        Fri, 17 Jul 2015 16:01:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.26
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274138>

Take advantage of 'struct child_process.env' to make it obvious that
environment variables set by add_worktree() are intended specifically
for sub-commands it invokes to operate in the new worktree.

We assign a local 'struct argv_array' to child_process.env, rather than
utilizing the child_process.env_array 'struct argv_array', because
future patches will make add_worktree() invoke additional sub-commands,
and it's simpler to populate the environment array just once, whereas
child_process.env_array gets cleared after each invocation, thus would
require re-population for each sub-command.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/worktree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8225468..7bd6f17 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -186,6 +186,7 @@ static int add_worktree(const char *path, const char **child_argv,
 	const char *name;
 	struct stat st;
 	struct child_process cp;
+	struct argv_array child_env = ARGV_ARRAY_INIT;
 	int counter = 0, len, ret;
 	unsigned char rev[20];
 
@@ -256,11 +257,12 @@ static int add_worktree(const char *path, const char **child_argv,
 	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
 
 	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
-	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
+	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
+	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
 	cp.argv = child_argv;
+	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (!ret) {
 		is_junk = 0;
@@ -272,6 +274,7 @@ static int add_worktree(const char *path, const char **child_argv,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
+	argv_array_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
-- 
2.5.0.rc2.378.g0af52e8
