From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 01/11] daemon.c: replace `git_config()` with `git_config_get_bool()` family
Date: Thu,  7 Aug 2014 09:21:16 -0700
Message-ID: <1407428486-19049-2-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQT1-0005aC-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbaHGQW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:22:58 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58395 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757414AbaHGQW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:22:57 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so5593341pab.26
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F1Wf+cMTq5VfRlQcmxR3apfc2hOGpJt40zYO8TJr++4=;
        b=uJx/PuLtjVqjDj+3DvmdyeQWNZ2nPLQucgOGgbvMa7U3LxCSkXdZD2PD/NggCSlZbb
         8V1Vu0s3uZZUQwsS/Fz6e2CHMdt4lrYHo+t721nDf1Zd1IFmT0I06gwiKeUiGtR4SGda
         gRQb7gA+7JfB4h6qvKmEPtuScNJSQSdufylTffnPeOwAOTedKt3PPD83tN4fGY6nxi/9
         Ujtbtx6YJr0X7UrrlhMLoIQ2hMJmXw+rs+1OFY/dLxp0dWy2qbM2n8NmEv6ZZipEa/i6
         P5dQds5T1nqTBc/Wpbd0CjAfDOULscWQgcIUSyToPhntSFI3CXPnQx1T17W2mItq+zao
         abKg==
X-Received: by 10.70.129.162 with SMTP id nx2mr10853936pdb.73.1407428577389;
        Thu, 07 Aug 2014 09:22:57 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.22.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:22:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254964>

Use `git_config_get_bool()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 daemon.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/daemon.c b/daemon.c
index e6b51ed..6f78b61 100644
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
 
@@ -354,11 +338,9 @@ static int run_service(const char *dir, struct daemon_service *service)
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
 	if (!enabled) {
 		logerror("'%s': service not enabled for '%s'",
-- 
1.9.0.GIT
