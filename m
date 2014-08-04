From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 02/11] http-backend.c: replace `git_config()` with `git_config_get_bool()` family
Date: Mon,  4 Aug 2014 11:33:40 -0700
Message-ID: <1407177229-30081-3-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:34:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN5q-0007UB-45
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaHDSem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:42 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50086 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaHDSel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:41 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so10066775pdj.40
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iPpBabInQcleONPImF77gNzRhVN1eSUPZx53DcpImcQ=;
        b=IBbXrhge02payLH+rE0ClPRbmo2Ao8ls5C1kr+K1Z99S9MNHxlLd+0GVnZAqVOCj5j
         SDzt7RSDLstClo1GYPGZeIRJ3Krr2J0sKC14zCrO3BkZWJWSvBRUa4XOaAF6t7rEBY5c
         V3j7R9Kmzx/jHlgzEXM3JoKav5G24V12iQLrYVjgwZl2DceJlXTXGnEk2DXps8Bx1L5/
         Zhyl/revQDufxQyAM6uqSxgOi9DoII1qg1I/b0pleRAPQkeCo5wBiFChO1BsXsrnUEJ8
         VVQRE9DM6nvEcvCHVxCHgbMdt3YchNM/pFlH0txuKUIwm0PGXwNTRTMwAIgypx/Vbhnq
         AHRg==
X-Received: by 10.68.113.133 with SMTP id iy5mr4146524pbb.135.1407177281332;
        Mon, 04 Aug 2014 11:34:41 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254754>

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
