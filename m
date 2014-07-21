From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 3/6] imap-send.c: replace `git_config()` with `git_config_get_*()` family
Date: Mon, 21 Jul 2014 04:12:22 -0700
Message-ID: <1405941145-12120-4-git-send-email-tanayabh@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 13:13:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9BXP-0008Lh-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 13:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbaGULNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 07:13:39 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35695 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaGULNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 07:13:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so9633201pab.15
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QmwBMvvNVShM8WhkMoHkAkOUwb/9tPT/gf0FxjgoME=;
        b=zItq6LYpMwNgFgZjn+GHt/f9RF8wMTJ6kmeq7eBybfvaJ0cwf+QQsg1WGu4nHgg0D2
         FdYEc6DuoEy67lX2wVQsbYrW93/s8t9ozATJaL8l6JcY6RGn3CXFRd7TSTop1iwsBKio
         8D5g8kGZvlo0SrYu/OW4aJw9yf8/vh9IQh3Ivxi460WSt4z4Womq5LtVFD3iYjMTM7T9
         TOmKUcOx6gMXhTZ17EsJr7iIvhm7QDjn+8l4JnoJP0fTuPYpqS6/uHaN5eArQ6n388VJ
         64Ys0LWjCHp4tEYzMRTDGwS4gL3lZ/2mF5yJmK9vGiZ84yoA8C8S1+JCRWbgqHEHaFy7
         IzhA==
X-Received: by 10.68.57.232 with SMTP id l8mr13677556pbq.79.1405941216418;
        Mon, 21 Jul 2014 04:13:36 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.202])
        by mx.google.com with ESMTPSA id bl12sm2603688pac.44.2014.07.21.04.13.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 04:13:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253950>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.
The function now raises an error instead of dying in cases where a NULL value is
not allowed.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 imap-send.c | 62 +++++++++++++++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 524fbab..b7ec98a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1326,43 +1326,35 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 
 static char *imap_folder;
 
-static int git_imap_config(const char *key, const char *val, void *cb)
+static void git_imap_config(void)
 {
-	if (!skip_prefix(key, "imap.", &key))
-		return 0;
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
-			server.use_ssl = 1;
+	const char *val = NULL;
+
+	git_config_get_bool("imap.sslverify", &server.ssl_verify);
+	git_config_get_bool("imap.preformattedhtml", &server.use_html);
+	git_config_get_string("imap.folder", (const char**)&imap_folder);
+
+	if (!git_config_get_value("imap.host", &val)) {
+		if(!val)
+			config_error_nonbool("imap.host");
+		else {
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
+	git_config_get_string("imap.user", (const char**)&server.user);
+	git_config_get_string("imap.pass", (const char**)&server.pass);
+	git_config_get_string("imap.port", (const char**)&server.port);
+	git_config_get_string("imap.tunnel", (const char**)&server.tunnel);
+	git_config_get_string("imap.authmethod", (const char**)&server.auth_method);
 }
 
 int main(int argc, char **argv)
@@ -1383,7 +1375,7 @@ int main(int argc, char **argv)
 		usage(imap_send_usage);
 
 	setup_git_directory_gently(&nongit_ok);
-	git_config(git_imap_config, NULL);
+	git_imap_config();
 
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
-- 
