From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 07/11] builtin/gc.c: replace `git_config()` with `git_config_get_*()` family
Date: Mon,  4 Aug 2014 11:33:45 -0700
Message-ID: <1407177229-30081-8-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:35:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN69-0007x9-9t
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbaHDSe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:59 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55850 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaHDSe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:58 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so10521974pac.31
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=APp3j5SNjEBPB8CWu/LIqgIhaV9W96kfzTJDO/H/Eso=;
        b=TUe7hXIlCg8hD9qTjGCB46o9v8sbvg5rMP99EuwutCUhx58z/xysdog96okRZIcA1K
         6VKCuy39fAUorhY+HxRMfg/9rCCxboW0VEyRBEueDGl7D00sw1r4qiYqnDOgQV4qctD3
         IRQTj8cgeEVkNbRefp46oHq3zJE+oC7Zhn7dT6BvOCCF4SNxfA0LQ/54x0TtyOp0B1CA
         hOftQwGFWhpNWOLpkh6pDbyB5FdvpUZUgkDWzhAJ0/NrP7mGF+Uhv0r720FfcgDwaTRX
         WLhQIWpSinN54tx5CKHhrbmWHnne22lNFiCMsjemtBTenz925dqVUerIr9Pv92ayMcce
         qRZg==
X-Received: by 10.70.48.175 with SMTP id m15mr25940224pdn.78.1407177297962;
        Mon, 04 Aug 2014 11:34:57 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254759>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 builtin/gc.c | 51 ++++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8d219d8..4612ef5 100644
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
+				error(_("Invalid %s: '%s'"), "gc.pruneexpire", prune_expire);
+				git_die_config("gc.pruneexpire");
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
