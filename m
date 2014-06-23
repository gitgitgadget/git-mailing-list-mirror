From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Mon, 23 Jun 2014 03:41:45 -0700
Message-ID: <1403520105-23250-6-git-send-email-tanayabh@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1iA-0002Fn-EV
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbaFWKmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:42:50 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:33991 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaFWKmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:42:49 -0400
Received: by mail-pb0-f45.google.com with SMTP id rr13so5708713pbb.18
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FINmAH5dVzXkIgEli7Xj/FJ5LhLbxS6WBR6ASGYqgt0=;
        b=BOkO1OgtSaT0HE4Zts7HElQH0KBSvfv/82ofENnRXoXKyUZSXls6IpT6nx+7JODNED
         EGI1GpemMpWcuFvJ0UPfSJ1O1tFTztBMc/pRL1lkLJX0gR9xwFvYSDdsqh5+0CA/y5H0
         CYT9t6OX1ov2H5nAckvtGCkMvYgGD68D+eM/hKsiqeDkjy7Ze6J/lJYu1LFGUkOLTsjA
         AlzySieEvTAs0Km4NU4RjBbyezxe4Y/gypRIpBfVSVp+8kiGLJWU4n1IzUSxxCOdH1uD
         1JYe50JRcr/H6DG8LgtU/o/dlvSW2wdXEyd+RVfI5PAR1krDwDQbC2Z4ubmW3yTSoEG1
         9KgA==
X-Received: by 10.66.150.169 with SMTP id uj9mr27578028pab.148.1403520168829;
        Mon, 23 Jun 2014 03:42:48 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id zc10sm91487896pac.46.2014.06.23.03.42.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:42:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252339>

Use git_config_get_string instead of git_config to take advantage of
the config hash-table api which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 pager.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/pager.c b/pager.c
index 8b5cbc5..96abe6d 100644
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
-{
-	struct pager_config *c = data;
-	if (starts_with(var, "pager.") && !strcmp(var + 6, c->cmd)) {
-		int b = git_config_maybe_bool(var, value);
-		if (b >= 0)
-			c->want = b;
-		else {
-			c->want = 1;
-			c->value = xstrdup(value);
-		}
-	}
-	return 0;
-}
-
 /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
 int check_pager_config(const char *cmd)
 {
-	struct pager_config c;
-	c.cmd = cmd;
-	c.want = -1;
-	c.value = NULL;
-	git_config(pager_command_config, &c);
-	if (c.value)
-		pager_program = c.value;
-	return c.want;
+	struct strbuf key = STRBUF_INIT;
+	int want = -1;
+	const char *value = NULL;
+	strbuf_addf(&key, "pager.%s", cmd);
+	if (!git_config_get_string(key.buf, &value)) {
+		int b = git_config_maybe_bool(key.buf, value);
+		if (b >= 0)
+			want = b;
+		else
+			want = 1;
+	}
+	if (value)
+		pager_program = value;
+	strbuf_release(&key);
+	return want;
 }
-- 
1.9.0.GIT
