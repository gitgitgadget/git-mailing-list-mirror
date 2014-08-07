From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 08/11] pager.c: replace `git_config()` with `git_config_get_value()`
Date: Thu,  7 Aug 2014 09:21:23 -0700
Message-ID: <1407428486-19049-9-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTP-0006D4-E4
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbaHGQXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42114 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbaHGQXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:20 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so5506616pdb.27
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sqEYn7R/P5TH6cuZ0QaNbEGRbwYmm5W/+wgn6y527c=;
        b=IyRkMHiNfQ1bPrF0c+mDyFtt52INH4eSRxo8+7/m9odIZbMvOwW+c6/K4zZfQot2wt
         TWBPMmB5B/77FRLY8UFpQiLtGPzRQDds3w5yplDgbiZiCrZchRU0ZpkuUl1AOTQ7U7Kx
         PJ+S0014gLmm6VgsWMtGFvEvZ453kSN0WhLD01CAsrlWS2lGa5iVe2ZsQsFo76wpcuEt
         X+bf0HV0ctsDErTUPQ1XWMqH7Z8+BT1pAdQ+fkX5lMAG34MA7SSi2vAzyUmWNH9nl9mI
         +q9z09cPDtMC8WPeC6qfPSEWj1nf9C3lMVz9UBwPepRxE9ZAcRq3szhghLpo6CDH7o/z
         UfZQ==
X-Received: by 10.66.184.42 with SMTP id er10mr18538387pac.62.1407428600091;
        Thu, 07 Aug 2014 09:23:20 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254970>

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
