From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 02/11] http-backend.c: replace `git_config()` with `git_config_get_bool()` family
Date: Thu,  7 Aug 2014 09:21:17 -0700
Message-ID: <1407428486-19049-3-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQT5-0005na-TK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbaHGQXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:02 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54926 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbaHGQXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so5609046pab.19
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iPpBabInQcleONPImF77gNzRhVN1eSUPZx53DcpImcQ=;
        b=M8sO5kCmVZ3YgtEWGPoBMMDwQrEhejDgL7xyBXnthH0wrRGlu7GentNioUKPfzEboT
         wOYeCbUwrOk4nI/CVfSu2ys6/bruJi5q5sdrajm1p4jVIdtQtjRaWOPV9diJ9bMFS/N7
         644DEG2TqgD0cGD+1gcQPkNOEK4BvJDQ6DUowolt6hy8Z7DasvOUz60IzVVsrjk6LEnh
         Tla7nhhYW6IKJq/6694eM+QghHdRAIiiL9rTeOV0rrE6ZQBprtGjC19fusgkCy3vRgi5
         yvSbbfR/YcdInsIgEP5P0Je55d6HaWiWGi8EVtNJEfB9cjDSeVHl6DJzH9FwjISXad9v
         2CHQ==
X-Received: by 10.70.9.100 with SMTP id y4mr18927619pda.12.1407428580700;
        Thu, 07 Aug 2014 09:23:00 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.22.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254967>

Use `git_config_get_bool()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 http-backend.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 80790bb..106ca6b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -219,29 +219,22 @@ static void get_idx_file(char *name)
 	send_local_file("application/x-git-packed-objects-toc", name);
 }
 
-static int http_config(const char *var, const char *value, void *cb)
+static void http_config(void)
 {
-	const char *p;
+	int i, value = 0;
+	struct strbuf var = STRBUF_INIT;
 
-	if (!strcmp(var, "http.getanyfile")) {
-		getanyfile = git_config_bool(var, value);
-		return 0;
-	}
+	git_config_get_bool("http.getanyfile", &getanyfile);
 
-	if (skip_prefix(var, "http.", &p)) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
-			struct rpc_service *svc = &rpc_service[i];
-			if (!strcmp(p, svc->config_name)) {
-				svc->enabled = git_config_bool(var, value);
-				return 0;
-			}
-		}
+	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
+		struct rpc_service *svc = &rpc_service[i];
+		strbuf_addf(&var, "http.%s", svc->config_name);
+		if (!git_config_get_bool(var.buf, &value))
+			svc->enabled = value;
+		strbuf_reset(&var);
 	}
 
-	/* we are not interested in parsing any other configuration here */
-	return 0;
+	strbuf_release(&var);
 }
 
 static struct rpc_service *select_service(const char *name)
@@ -627,7 +620,7 @@ int main(int argc, char **argv)
 	    access("git-daemon-export-ok", F_OK) )
 		not_found("Repository not exported: '%s'", dir);
 
-	git_config(http_config, NULL);
+	http_config();
 	cmd->imp(cmd_arg);
 	return 0;
 }
-- 
1.9.0.GIT
