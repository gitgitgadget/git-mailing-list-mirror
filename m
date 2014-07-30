From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 1/5] pager.c: replace `git_config()` with `git_config_get_value()`
Date: Wed, 30 Jul 2014 06:39:05 -0700
Message-ID: <1406727549-22334-2-git-send-email-tanayabh@gmail.com>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 15:40:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCU7L-0000pi-Fz
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 15:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbaG3NkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 09:40:20 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53539 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbaG3NkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 09:40:18 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so1467587pdj.22
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sqEYn7R/P5TH6cuZ0QaNbEGRbwYmm5W/+wgn6y527c=;
        b=KjRV1ZLFcl8p3kU2c7sVhcvvlujLltZ10htCvae4gpq6sFMjEgHA8BJsy0NdbXe/W2
         ac/gGhfEHAKAcE1VgxKzRDe0Rh/mybmo14uPJm16JTwZUqZxQOiR0RvqtIEjVAkWb9bq
         wLaObXsFYUwtfv92yrVOfajdTifo9u306PaM2OjvT2J0jeXYnSmapYp2wt8ochCDYsJb
         WKVIDP3ySU0nHnLQCOpaCVF1XE9sJzh6BjoWZWjFYAOBQHjXaNWHJu+UwNLhTc9+FQXP
         qx+QLtU8djQiAO++gzoKBvhwxfqfNF29Yd0FTlwyROf1ws/gHEhGAcgpffzpvXn1t0w6
         la9g==
X-Received: by 10.68.192.106 with SMTP id hf10mr4873401pbc.30.1406727617997;
        Wed, 30 Jul 2014 06:40:17 -0700 (PDT)
Received: from localhost.localdomain ([223.184.63.185])
        by mx.google.com with ESMTPSA id y4sm2397686pbt.60.2014.07.30.06.40.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 06:40:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254492>

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
