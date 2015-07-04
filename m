From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 20/23] worktree: extract basename computation to new function
Date: Fri,  3 Jul 2015 20:17:29 -0400
Message-ID: <1435969052-540-21-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBB4-0000Sl-Mc
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbbGDATZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:25 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36757 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771AbbGDASp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:45 -0400
Received: by igrv9 with SMTP id v9so124750740igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TnGGL9rMMW+6Cv8NnwyS2YtpAFa5DHc1r1fCBsT+D80=;
        b=P1mjUGCVggXAWoSysov4mCbltlfDzeMxu0SXohnPL00gxVM8Z8lvr+lTk0aJ9czKXQ
         gfnPOswK+QyO6xZNXkMuNgTKwG0VyxNR9SbWw5LCDm363QwJHEY4YAGaNT4RI1zs/7xn
         IxS2MazbMn7e49PxcEIPkwazcAsxN7jLpqLp6mfDS5kEeEpT1aNxmsmYHjaNqC/D/5Mw
         VRHIMRVPkJd0FeHgFqde4NN4AS5y/UIbZt/esG8QjcTa0gHX3buPfdJkAOTfeI3yycWa
         9hCCvceK/w948BnkJzbwIUddtNAh/NJgcad3dIMIoXy4YGlwrtJDwISuTGBCbigns2p/
         028A==
X-Received: by 10.42.216.199 with SMTP id hj7mr21865538icb.11.1435969124144;
        Fri, 03 Jul 2015 17:18:44 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.43
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273330>

A subsequent patch will also need to compute the basename of the new
worktree, so factor out this logic into a new function.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cfaec6..a1d863d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -152,6 +152,25 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
+static const char *worktree_basename(const char *path, int *olen)
+{
+	const char *name;
+	int len;
+
+	len = strlen(path);
+	while (len && is_dir_sep(path[len - 1]))
+		len--;
+
+	for (name = path + len - 1; name > path; name--)
+		if (is_dir_sep(*name)) {
+			name++;
+			break;
+		}
+
+	*olen = len;
+	return name;
+}
+
 static int add_worktree(const char *path, const char **child_argv)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
@@ -165,15 +184,7 @@ static int add_worktree(const char *path, const char **child_argv)
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
-	len = strlen(path);
-	while (len && is_dir_sep(path[len - 1]))
-		len--;
-
-	for (name = path + len - 1; name > path; name--)
-		if (is_dir_sep(*name)) {
-			name++;
-			break;
-		}
+	name = worktree_basename(path, &len);
 	strbuf_addstr(&sb_repo,
 		      git_path("worktrees/%.*s", (int)(path + len - name), name));
 	len = sb_repo.len;
-- 
2.5.0.rc1.197.g417e668
