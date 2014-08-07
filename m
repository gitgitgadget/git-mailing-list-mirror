From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 09/11] imap-send.c: replace `git_config()` with `git_config_get_*()` family
Date: Thu,  7 Aug 2014 09:21:24 -0700
Message-ID: <1407428486-19049-10-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTX-0006Ut-82
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbaHGQX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:26 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63081 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbaHGQXX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:23 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5492172pdj.12
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XPAEMLozJkN8/p/1mz2KbM8mfJkhP3FPT/N4jUNWaxY=;
        b=S8/rYF4GdodhpS09QDiNy5zs2cjL79tsjeRcUHx6TAdWcs3datpy8TsATacyDASwEa
         fS2DEnJ2gJePG12/MjnxjmwAhsTSM5yRFGlkoVwabSSORxa9038Ds+mJyKXfMMwtnkm2
         GUMIm1YjTK/MP0XB1B0k8MKCrIPxKXi5L87nvV5243ip2qXM85ZxQRTYFTXdoU+A0M/k
         gipOkYK2TeiIdUgF5AAP6cvlnc27DmMpq4ZxbahfVbF0pBHpT965PU9fTiXIVAJ09pZU
         S0fo8J8fi+mD3tHdGzUWlpfUDPboziayLh6jPqC2oq+0bpI9P2uii3BfmGEc0934qj1K
         4ajA==
X-Received: by 10.66.252.161 with SMTP id zt1mr18447390pac.41.1407428603405;
        Thu, 07 Aug 2014 09:23:23 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254973>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 imap-send.c | 60 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 524fbab..618d75b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1326,43 +1326,35 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 
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
+			git_die_config("imap.host", "Missing value for 'imap.host'");
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
@@ -1383,7 +1375,7 @@ int main(int argc, char **argv)
 		usage(imap_send_usage);
 
 	setup_git_directory_gently(&nongit_ok);
-	git_config(git_imap_config, NULL);
+	git_imap_config();
 
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
-- 
1.9.0.GIT
