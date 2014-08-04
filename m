From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 01/11] daemon.c: replace `git_config()` with `git_config_get_bool()` family
Date: Mon,  4 Aug 2014 11:33:39 -0700
Message-ID: <1407177229-30081-2-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN5p-0007UB-34
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaHDSej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:39 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:59358 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbaHDSei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:38 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so10132229pdb.13
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZqJrmXvCibqhlSX5Eky7+YMN4K8CYETubsp6xQs/5+c=;
        b=YD4+CcVbY4gMbjMVSO6DILwY8FYEmOuXRhLgt/L4sTDMGGLb7FHOYhfVJ1kRlVp1t2
         1H0uxopiLtEXBqeOLJrsaH9avRK3Avofxz4mN8YEfqX4WQl9nZUgWqZSGjx8VHd4OsMs
         qV9BEZR9mbtM/xHWud91TErkqrx66SCtw6ufPHObVItg70MdxoXflj6DB6UZq8fTkWcT
         Pmoi5Mo9iVPYhJgggBQdtTM0j7r93flaL62RFd6GjRsQms3UEQitU0SkwH6vAG2e6/xo
         6EdH5N6QZ/7m9QO6ineQ+YnXsRZCQDSQYuFEsEsk6WBkj6OGKd7zlD+TsLYtHzx1lhEo
         CfpA==
X-Received: by 10.68.233.68 with SMTP id tu4mr21888614pbc.65.1407177278182;
        Mon, 04 Aug 2014 11:34:38 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254753>

Use `git_config_get_bool()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 daemon.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/daemon.c b/daemon.c
index e6b51ed..fb16664 100644
--- a/daemon.c
+++ b/daemon.c
@@ -230,23 +230,6 @@ struct daemon_service {
 	int overridable;
 };
 
-static struct daemon_service *service_looking_at;
-static int service_enabled;
-
-static int git_daemon_config(const char *var, const char *value, void *cb)
-{
-	const char *service;
-
-	if (skip_prefix(var, "daemon.", &service) &&
-	    !strcmp(service, service_looking_at->config_name)) {
-		service_enabled = git_config_bool(var, value);
-		return 0;
-	}
-
-	/* we are not interested in parsing any other configuration here */
-	return 0;
-}
-
 static int daemon_error(const char *dir, const char *msg)
 {
 	if (!informative_errors)
@@ -324,6 +307,7 @@ static int run_service(const char *dir, struct daemon_service *service)
 {
 	const char *path;
 	int enabled = service->enabled;
+	struct strbuf var = STRBUF_INIT;
 
 	loginfo("Request %s for '%s'", service->name, dir);
 
@@ -354,12 +338,11 @@ static int run_service(const char *dir, struct daemon_service *service)
 	}
 
 	if (service->overridable) {
-		service_looking_at = service;
-		service_enabled = -1;
-		git_config(git_daemon_config, NULL);
-		if (0 <= service_enabled)
-			enabled = service_enabled;
+		strbuf_addf(&var, "daemon.%s", service->config_name);
+		git_config_get_bool(var.buf, &enabled);
+		strbuf_release(&var);
 	}
+
 	if (!enabled) {
 		logerror("'%s': service not enabled for '%s'",
 			 service->name, path);
-- 
1.9.0.GIT
