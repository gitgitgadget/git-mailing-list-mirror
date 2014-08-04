From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 08/11] pager.c: replace `git_config()` with `git_config_get_value()`
Date: Mon,  4 Aug 2014 11:33:46 -0700
Message-ID: <1407177229-30081-9-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:35:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN6F-00087c-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbaHDSfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:35:05 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:60672 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbaHDSfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:35:03 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so10460543pab.16
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sqEYn7R/P5TH6cuZ0QaNbEGRbwYmm5W/+wgn6y527c=;
        b=uyT6WQOnvg0HG41a1/9n6lWtKewhcO7k+EYF+AL1aMbxnfc18NO87pPWO3jaMv9HaM
         HQuz6PDT2rhpkeCzRdtJ8CCRaWWZSTvm/jA+28HRGkmPYEanXfvBWhZT5qelje71Vuum
         ZV7z89PDeBLSDLu96d70nIPBvreH9hZgcSfTHYHAbeMxlQ085H6eVEpB2nWQyllprpLP
         rTKP+IwmD3cJMnlNa/jYq6353IX52Ds7nkHCrByXHkqv2LoJWBhySZxZWyN5FB8AFFXR
         tCt+pCVePEdz3kTYSn36dm8OEwUOFj90MLYbFDGxWJA9cLp+gGjFZ7Vf1v8lvC7uN+0/
         idEQ==
X-Received: by 10.66.170.171 with SMTP id an11mr3656454pac.146.1407177303390;
        Mon, 04 Aug 2014 11:35:03 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:35:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254761>

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
