From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 21/22] worktree: populate via "git reset --hard" rather than "git checkout"
Date: Fri, 17 Jul 2015 19:00:16 -0400
Message-ID: <1437174017-81687-22-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdW-0002UY-JU
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbbGQXBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:42 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34706 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbbGQXBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:32 -0400
Received: by igvi1 with SMTP id i1so45055656igv.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1FNzoRezobH88cQ5y0wbPLuzndRMf3PgV0TL3BL7v3s=;
        b=T5qEK+vsAjPN6CiVEstnnKL/UEs+8wn+/sRixGgBSy+xzjRVdciyWpmuYBsfTVQO4/
         WdlqcvDGJe3N1ej7a46PAqZ5JrXUIpCUklFButHFmigsFnd9xXeE9oRWHQrKHa3azAOx
         bNaQpKaqdQh5h4j0hT6nuilmlmI/af7saGJT0mP8VaJqdhIaGDlKz/3gkPs+8pKvOrtc
         nGNkh8OkFZv8XSxHAZhRB0IKLjrL4/3vndy3Jwo9/e4KS/fIJy+GyO1kL5QGnzpGNUhc
         MbIfYnjmdvtg3gHf4XlBw8BqsGo0YWf7fEkyLPwKfOiFUdBr4nlfcQ3AshlfveYirTn1
         Nc2Q==
X-Received: by 10.50.36.101 with SMTP id p5mr957190igj.58.1437174091832;
        Fri, 17 Jul 2015 16:01:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274139>

Now that git-worktree handles all functionality (--force, --detach,
-b/-B) previously delegated to git-checkout, actual population of the
new worktree can be accomplished more directly and lightweight with
"git reset --hard" in place of "git checkout".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/worktree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4619308..5d9371c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -266,7 +266,6 @@ static int add_worktree(const char *path, const char *refname,
 
 	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
 
-	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	memset(&cp, 0, sizeof(cp));
@@ -285,7 +284,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	cp.argv = NULL;
 	argv_array_clear(&cp.args);
-	argv_array_push(&cp.args, "checkout");
+	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
 	cp.env = child_env.argv;
 	ret = run_command(&cp);
 	if (!ret) {
-- 
2.5.0.rc2.378.g0af52e8
