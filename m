From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH] imap-send.c: replace git_config with git_config_get_string
Date: Mon, 23 Jun 2014 03:41:42 -0700
Message-ID: <1403520105-23250-3-git-send-email-tanayabh@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:42:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1hx-00024F-P4
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbaFWKmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:42:37 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:48695 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaFWKmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:42:36 -0400
Received: by mail-pb0-f41.google.com with SMTP id ma3so5766220pbc.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VxaSORJiLVppwzQRxzflNMxcjAgmG6AUyu/GWXxowRI=;
        b=u8Bwgk4GHb2+9CewYDScuxVbkLLGnYbbp8qgW1jLTMmjZ9NIayLAbj9RgrxPLbRvUV
         jZ8ySVSxq3qB7ghjAs3s5qBdMyTOE2g048VxoFkGZlAzx6r1I2GaoG20NdezvtXl16aF
         lx2lJmhL2pFZ2iFeLFbVh31YxFkd4cFyjCdzbHLqOclaSrYNvwRzAJUgFJ7cB8acXOPR
         YenIIR+W2cd3aw00lOuV/JaAP/qYQzImKDXImrr1OBm0xce6MY78x3GoeR0cgHJT02Ob
         aeNzubbCYimc1To+3N7Sm+pry3vD4UG1Wt1qomnRAq1Mxx8O+IODk5xtT99rP48YouMM
         2zRw==
X-Received: by 10.68.242.135 with SMTP id wq7mr27862705pbc.147.1403520156060;
        Mon, 23 Jun 2014 03:42:36 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id zc10sm91487896pac.46.2014.06.23.03.42.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:42:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252336>

Use git_config_get_string instead of git_config to take advantage of
the config hash-table api which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 imap-send.c | 68 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 83a6ed2..87bd418 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1326,47 +1326,37 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 
 static char *imap_folder;
 
-static int git_imap_config(const char *key, const char *val, void *cb)
+static void git_imap_config(void)
 {
-	char imap_key[] = "imap.";
-
-	if (strncmp(key, imap_key, sizeof imap_key - 1))
-		return 0;
-
-	key += sizeof imap_key - 1;
-
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
+	const char *value;
+
+	if (!git_config_get_string("imap.sslverify", &value))
+		server.ssl_verify = git_config_bool("sslverify", value);
+	if (!git_config_get_string("imap.preformattedhtml", &value))
+		server.use_html = git_config_bool("preformattedhtml", value);
+	if (!git_config_get_string("imap.folder", &value))
+		imap_folder = xstrdup(value);
+	if (!git_config_get_string("imap.host", &value)) {
+		if (starts_with(value, "imap:"))
+			value += 5;
+		else if (starts_with(value, "imaps:")) {
+			value += 6;
 			server.use_ssl = 1;
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
-
-	return 0;
+		if (starts_with(value, "//"))
+			value += 2;
+		server.host = xstrdup(value);
+	}
+	if (!git_config_get_string("imap.user", &value))
+		server.user = xstrdup(value);
+	if (!git_config_get_string("imap.pass", &value))
+		server.pass = xstrdup(value);
+	if (!git_config_get_string("imap.port", &value))
+		server.port = git_config_int("port", value);
+	if (!git_config_get_string("imap.tunnel", &value))
+		server.tunnel = xstrdup(value);
+	if (!git_config_get_string("imap.authmethod", &value))
+		server.auth_method = xstrdup(value);
 }
 
 int main(int argc, char **argv)
@@ -1387,7 +1377,7 @@ int main(int argc, char **argv)
 		usage(imap_send_usage);
 
 	setup_git_directory_gently(&nongit_ok);
-	git_config(git_imap_config, NULL);
+	git_imap_config();
 
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
-- 
1.9.0.GIT
