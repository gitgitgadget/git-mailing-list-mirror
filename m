From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 5/6] pager.c: replace `git_config()` with `git_config_get_value()`
Date: Mon, 21 Jul 2014 04:12:24 -0700
Message-ID: <1405941145-12120-6-git-send-email-tanayabh@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 13:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9BXQ-0008Lh-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 13:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbaGULNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 07:13:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33381 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbaGULNn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 07:13:43 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so9573480pab.5
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sqEYn7R/P5TH6cuZ0QaNbEGRbwYmm5W/+wgn6y527c=;
        b=Qxab8k8MZahCc1LpNHQufbNxO8VGDfYUtJmp0kieKy5Rz7u0+u9whldI9B3qaGvT7N
         3gy8CGBow8Dg72My0VUwr8dpYAyL6X9m56W5mCZ0WCCwOhYuihIlx9XbdlDs8ZeHZYve
         tFkG390jNUEceBQKGMlGEJEA+WX8pFEx4rLSNk8n8srsTHLPzM0Y4pXkr5XQD3LPiYvn
         yINUTZlkkKhNYY6OafUPtZ4ngB3bjU7YOtHflObHODSj17wjOgpXeVjU16a9Bwyv75L+
         LzOM/baMUUFMxFwZtLpDTFQQF1KDx/aRkdBEbuaawgGNIkf7oHa4nANKJ+5i2uqkKtbE
         x6vw==
X-Received: by 10.66.231.139 with SMTP id tg11mr24527211pac.87.1405941223556;
        Mon, 21 Jul 2014 04:13:43 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.202])
        by mx.google.com with ESMTPSA id bl12sm2603688pac.44.2014.07.21.04.13.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 04:13:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253953>

Use `git_config_get_value()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 pager.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/pager.c b/pager.c
index 8b5cbc5..b7eb7e7 100644
--- a/pager.c
+++ b/pager.c
@@ -6,12 +6,6 @@
 #define DEFAULT_PAGER "less"
 #endif
 
-struct pager_config {
-	const char *cmd;
-	int want;
-	char *value;
-};
-
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -155,30 +149,22 @@ int decimal_width(int number)
 	return width;
 }
 
-static int pager_command_config(const char *var, const char *value, void *data)
+/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
+int check_pager_config(const char *cmd)
 {
-	struct pager_config *c = data;
-	if (starts_with(var, "pager.") && !strcmp(var + 6, c->cmd)) {
-		int b = git_config_maybe_bool(var, value);
+	int want = -1;
+	struct strbuf key = STRBUF_INIT;
+	const char *value = NULL;
+	strbuf_addf(&key, "pager.%s", cmd);
+	if (!git_config_get_value(key.buf, &value)) {
+		int b = git_config_maybe_bool(key.buf, value);
 		if (b >= 0)
-			c->want = b;
+			want = b;
 		else {
-			c->want = 1;
-			c->value = xstrdup(value);
+			want = 1;
+			pager_program = xstrdup(value);
 		}
 	}
-	return 0;
-}
-
-/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
-int check_pager_config(const char *cmd)
-{
-	struct pager_config c;
-	c.cmd = cmd;
-	c.want = -1;
-	c.value = NULL;
-	git_config(pager_command_config, &c);
-	if (c.value)
-		pager_program = c.value;
-	return c.want;
+	strbuf_release(&key);
+	return want;
 }
-- 
1.9.0.GIT
