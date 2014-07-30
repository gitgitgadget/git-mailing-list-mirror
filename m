From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 3/5] imap-send.c: replace `git_config()` with `git_config_get_*()` family
Date: Wed, 30 Jul 2014 06:39:07 -0700
Message-ID: <1406727549-22334-4-git-send-email-tanayabh@gmail.com>
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
	id 1XCU7M-0000pi-GK
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 15:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbaG3Nk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 09:40:27 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57077 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaG3NkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 09:40:25 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so1532085pab.40
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JiMNPFhjkXatRknl1h4bRyexpFnRY9wgcelnR+CouQU=;
        b=ubI/EyujBdoJkg8MsBDJ0rOBJ5JYplaJYqHqJnLSCTOlIVsi548W5nWb8b+IdXZSq2
         n8KTse44xcD1sVYzxsGkk9V8NcFJzY9hjuJzBbG9woc15N8Qu6+irSvLkhXf+4DvID2W
         USpVY4EUgcWc/mlZvs95WSaPGClNmamBnUuzPhfZPPVeI25Y2YEZXONyf4BVQBg+oNrC
         lSD3ISCv/ADtT5PhawzGx/G/zwXhlJiXsQKrFsxPA26aF1wUzM0GfpMDhHue3vfbykeX
         JUurYQwiFac6yzIw00YZpSqBiJK8rtWOzts3g4ts3gCiNZFBlZFs+jhSCu+yACzQuFYD
         CFlQ==
X-Received: by 10.68.173.65 with SMTP id bi1mr4828636pbc.130.1406727624242;
        Wed, 30 Jul 2014 06:40:24 -0700 (PDT)
Received: from localhost.localdomain ([223.184.63.185])
        by mx.google.com with ESMTPSA id y4sm2397686pbt.60.2014.07.30.06.40.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 06:40:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254491>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 imap-send.c | 61 +++++++++++++++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 524fbab..586bdd8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1326,43 +1326,36 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 
 static char *imap_folder;
 
-static int git_imap_config(const char *key, const char *val, void *cb)
+static void git_imap_config(void)
 {
-	if (!skip_prefix(key, "imap.", &key))
-		return 0;
+	const char *val = NULL;
+
+	git_config_get_bool("imap.sslverify", &server.ssl_verify);
+	git_config_get_bool("imap.preformattedhtml", &server.use_html);
+	git_config_get_string("imap.folder", &imap_folder);
 
-	/* check booleans first, and barf on others */
-	if (!strcmp("sslverify", key))
-		server.ssl_verify = git_config_bool(key, val);
-	else if (!strcmp("preformattedhtml", key))
-		server.use_html = git_config_bool(key, val);
-	else if (!val)
-		return config_error_nonbool(key);
-
-	if (!strcmp("folder", key)) {
-		imap_folder = xstrdup(val);
-	} else if (!strcmp("host", key)) {
-		if (starts_with(val, "imap:"))
-			val += 5;
-		else if (starts_with(val, "imaps:")) {
-			val += 6;
-			server.use_ssl = 1;
+	if (!git_config_get_value("imap.host", &val)) {
+		if (!val) {
+			config_error_nonbool("imap.host");
+			git_die_config("imap.host");
+		} else {
+			if (starts_with(val, "imap:"))
+				val += 5;
+			else if (starts_with(val, "imaps:")) {
+				val += 6;
+				server.use_ssl = 1;
+			}
+			if (starts_with(val, "//"))
+				val += 2;
+			server.host = xstrdup(val);
 		}
-		if (starts_with(val, "//"))
-			val += 2;
-		server.host = xstrdup(val);
-	} else if (!strcmp("user", key))
-		server.user = xstrdup(val);
-	else if (!strcmp("pass", key))
-		server.pass = xstrdup(val);
-	else if (!strcmp("port", key))
-		server.port = git_config_int(key, val);
-	else if (!strcmp("tunnel", key))
-		server.tunnel = xstrdup(val);
-	else if (!strcmp("authmethod", key))
-		server.auth_method = xstrdup(val);
+	}
 
-	return 0;
+	git_config_get_string("imap.user", &server.user);
+	git_config_get_string("imap.pass", &server.pass);
+	git_config_get_int("imap.port", &server.port);
+	git_config_get_string("imap.tunnel", &server.tunnel);
+	git_config_get_string("imap.authmethod", &server.auth_method);
 }
 
 int main(int argc, char **argv)
@@ -1383,7 +1376,7 @@ int main(int argc, char **argv)
 		usage(imap_send_usage);
 
 	setup_git_directory_gently(&nongit_ok);
-	git_config(git_imap_config, NULL);
+	git_imap_config();
 
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
-- 
1.9.0.GIT
