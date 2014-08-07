From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 07/11] builtin/gc.c: replace `git_config()` with `git_config_get_*()` family
Date: Thu,  7 Aug 2014 09:21:22 -0700
Message-ID: <1407428486-19049-8-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTP-0006D4-UT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbaHGQXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:21 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59168 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbaHGQXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:17 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so5703124pad.10
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHtNdGA7V5zXsERw+haGtL59IHk8/PLCNt/XcxSdQf8=;
        b=n0hQOswhRvTSSlB/m/IGJxhC1FLRJws881yUroaJnu/rehdsfEqvlRcoKBG8SJlW8P
         sY7gieMehJ1JAFk3ZOMcq7frUj4Pg6+za2KYWLyHY1R587UP4CezpLUpPDHmVnFc6qFH
         G4nx/mv5H+c8FAtdZszOd7K9qiSVTu/jJFNJKrWPgJQ9EvInmxlJfNd/bzsbx5pN63mL
         Ya8zVPg1t7FgZZmGDfpFkye1zS7IwRBvj7lDCcA2VJfOmKqfJYgYp4j2E1U3EUOTbtip
         +9rfGjvrlWbWGETMAxGtG/QrcysVZOznQ/XnW1mHlc3lpF2ThiKkTNF+zh8WdvxH0TI2
         EzbQ==
X-Received: by 10.70.128.164 with SMTP id np4mr2206019pdb.168.1407428596778;
        Thu, 07 Aug 2014 09:23:16 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254971>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 builtin/gc.c | 51 ++++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8d219d8..ced1456 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -55,44 +55,33 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
 
-static int gc_config(const char *var, const char *value, void *cb)
+static void gc_config(void)
 {
-	if (!strcmp(var, "gc.packrefs")) {
+	const char *value;
+
+	if (!git_config_get_value("gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
 			pack_refs = -1;
 		else
-			pack_refs = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "gc.aggressivewindow")) {
-		aggressive_window = git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "gc.aggressivedepth")) {
-		aggressive_depth = git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "gc.auto")) {
-		gc_auto_threshold = git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "gc.autopacklimit")) {
-		gc_auto_pack_limit = git_config_int(var, value);
-		return 0;
+			pack_refs = git_config_bool("gc.packrefs", value);
 	}
-	if (!strcmp(var, "gc.autodetach")) {
-		detach_auto = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "gc.pruneexpire")) {
-		if (value && strcmp(value, "now")) {
+
+	git_config_get_int("gc.aggressivewindow", &aggressive_window);
+	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
+	git_config_get_int("gc.auto", &gc_auto_threshold);
+	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
+	git_config_get_bool("gc.autodetach", &detach_auto);
+
+	if (!git_config_get_string_const("gc.pruneexpire", &prune_expire)) {
+		if (strcmp(prune_expire, "now")) {
 			unsigned long now = approxidate("now");
-			if (approxidate(value) >= now)
-				return error(_("Invalid %s: '%s'"), var, value);
+			if (approxidate(prune_expire) >= now) {
+				git_die_config("gc.pruneexpire", _("Invalid gc.pruneexpire: '%s'"),
+						prune_expire);
+			}
 		}
-		return git_config_string(&prune_expire, var, value);
 	}
-	return git_default_config(var, value, cb);
+	git_config(git_default_config, NULL);
 }
 
 static int too_many_loose_objects(void)
@@ -301,7 +290,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	argv_array_pushl(&prune, "prune", "--expire", NULL );
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
 
-	git_config(gc_config, NULL);
+	gc_config();
 
 	if (pack_refs < 0)
 		pack_refs = !is_bare_repository();
-- 
1.9.0.GIT
