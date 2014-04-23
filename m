From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 2/3] run-command: make sure hooks have always GIT_DIR
Date: Wed, 23 Apr 2014 14:42:39 -0500
Message-ID: <1398282160-26151-3-git-send-email-felipe.contreras@gmail.com>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:53:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3EP-0006c2-6h
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757860AbaDWTxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:53:18 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:58370 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622AbaDWTxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:53:14 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so1581831oah.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KjWprN75upLRa04LPNRXLp2WzGczBwfnkzDTe0aPkdw=;
        b=BZ/8eXjTmhg0AOty1oDovRJxCAs6dS/QHTVGrH+lVUhQrQL6tr+AKRZbaG102PB0hW
         usFPQEc5H9tMrYR5odD6Cy/lOocxysrQVAJbUmse/Ok9lhRCytP7s7swIriL2pAVeina
         49gdOGHJMy4HrNpPR02znFCrsPgjNOW6FTX73RZ0QK+3hbRFqXeTEPb6YvhRiQg+WxxG
         705gjl3rnMg6zQSLjXBeng0ZZZYHInIqFjU8KSDu+3rNmgvCMBFh9goFT3bK4I0ppmAf
         udRDmYYQpmKO27tqNAV2oKirt582eLHeBC44GHgC4VO61WuCrqj5c47eFmpXM8rfHQOQ
         kTXg==
X-Received: by 10.60.178.41 with SMTP id cv9mr9262754oec.53.1398282793767;
        Wed, 23 Apr 2014 12:53:13 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm3690303obb.8.2014.04.23.12.53.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 12:53:12 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246877>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 75abc47..8e188f6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -765,12 +765,29 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	struct child_process hook;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	const char *p;
-	int ret;
+	const char **mod_env = NULL;
+	int ret, i = 0;
+	struct strbuf buf = STRBUF_INIT;
 
 	p = find_hook(name);
 	if (!p)
 		return 0;
 
+	if (!getenv(GIT_DIR_ENVIRONMENT)) {
+		if (env)
+			for (i = 0; env[i]; i++);
+
+		mod_env = xcalloc(i + 2, sizeof(*mod_env));
+
+		if (env)
+			for (i = 0; env[i]; i++)
+				mod_env[i] = env[i];
+
+		strbuf_addf(&buf, "GIT_DIR=%s", get_git_dir());
+		mod_env[i++] = buf.buf;
+		mod_env[i++] = NULL;
+	}
+
 	argv_array_push(&argv, p);
 
 	while ((p = va_arg(args, const char *)))
@@ -778,12 +795,15 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 
 	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv.argv;
-	hook.env = env;
+	hook.env = mod_env ? mod_env : env;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
 
 	ret = run_command(&hook);
 	argv_array_clear(&argv);
+	strbuf_release(&buf);
+	free(mod_env);
+
 	return ret;
 }
 
-- 
1.9.2+fc1.1.g5c924db
