From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 36/45] builtin-am: invoke pre-applypatch hook
Date: Mon, 20 Jul 2015 00:10:28 +0800
Message-ID: <1437322237-29863-37-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCf-0006km-8a
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbbGSQMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:33 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34660 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbbGSQMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:17 -0400
Received: by pacan13 with SMTP id an13so89912828pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xdYkpQoOjyZQwR/0V1zHyE29CZZwdpZjcx0obeavb4=;
        b=DvkAtftkE21EPDYClbUOJ8g706UqpfQVZAKNbVyfsZDLltkUFckKPXwVOLtSlme/A7
         QIQFuiem4s0lTOICpKkYsj4Zec9+kj9mUQvdUAa56yD1x7puykw6AWi2zgkNUoxuQDYq
         omfqRpqba8q5mLJqb/8WnN3z5ku9dJgqOS8IOnKYz8cyf4qNORVMrGLy81Yk80RjBOku
         lp9/wLERzhlyZLmJaTzZXbzuMNY27//tjZSV7zH94D68SxtlFahqD2rYsyjKY0E2OsXc
         vwHfw47lmzYVZLrisWlk2c3LKOXWyXh5qwIuqCMmXrY00KgDlQLKdxvEORXRqW35fSdy
         s0kw==
X-Received: by 10.66.159.1 with SMTP id wy1mr50652738pab.103.1437322337127;
        Sun, 19 Jul 2015 09:12:17 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274258>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sg will invoke the pre-applypatch hook after applying the patch
to the index, but before a commit is made. Should the hook exit with a
non-zero status, git am will exit.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 764e955..fdba3b0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1336,6 +1336,9 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author;
 	struct strbuf sb = STRBUF_INIT;
 
+	if (run_hook_le(NULL, "pre-applypatch", NULL))
+		exit(1);
+
 	if (write_cache_as_tree(tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-- 
2.5.0.rc2.110.gb39b692
