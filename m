From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/20] worktree: elucidate environment variables intended for child processes
Date: Thu, 16 Jul 2015 04:20:19 -0400
Message-ID: <1437034825-32054-15-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:21:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFePv-0008MP-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbbGPIVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:05 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36664 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbbGPIVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:21:00 -0400
Received: by igbij6 with SMTP id ij6so8313939igb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jm5bmNy8oJN+8bLFW5425R7pSnUlcCSDaYOJXXOg8PU=;
        b=Nkucn/gJX/iyi7zD72rhbV/rAB14ZTJg6ajaaYqVSkppwTQiDT22bBJxKTQNmuVHAa
         la1mE2T/UOTb4e2Pp4SL1MSdf5RRrgqW2KHEY2Yn+lEOQARtkBPWe90kPuFbb1mc3fO7
         G/3GmF3zW9i7JAxeD2b/guM3k8YiJuB4fW1OA31ZvvJBwudaQ0A9LQvHBRzSTiQvjlnu
         jkRZR/3kjT/9sGx4bq5zd7SvfmkLxRVuqILCN16eGx0BjE8Qexb92geVGRESFq5TIzbZ
         VfY6pQlnSw0wYJX7W7b7+s3DMBwXbJOTNd+dms5HCoStNxACnp12zOshKszvEkPSAsHo
         HgSg==
X-Received: by 10.107.18.10 with SMTP id a10mr10844415ioj.98.1437034858892;
        Thu, 16 Jul 2015 01:20:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.58
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274014>

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

New in v2.

 builtin/worktree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9be1c74..7ae186f 100644
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
 	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
 
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
