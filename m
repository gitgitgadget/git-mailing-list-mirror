From: David Turner <dturner@twopensource.com>
Subject: [PATCH 16/19] index-helper: rewrite pidfile after daemonizing
Date: Wed,  9 Mar 2016 13:36:19 -0500
Message-ID: <1457548582-28302-17-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adizC-0007it-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933883AbcCISh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:37:26 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35682 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933845AbcCISgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:49 -0500
Received: by mail-qg0-f48.google.com with SMTP id y89so49338910qge.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S55WAygfJhz9pUfbCHl1vHIyZxo8JBgiQucDLTiw/SM=;
        b=M5d/OUpEJLPtrFGgK8N6D9waHC2DfjMUr+qRvWihtY6/T/BHB8vW/PytUDxE14T96N
         FNCM4jfadzGsrOGZK4UH5i44XY27/KTnb82UmxO6k/XqGzb51oFjWrfrPkl4TaIlL62I
         GNSyssR/sBkOyjF5ig5akDAZ/d2X6gIdajoGHt0RBBR7M4D586qtZbGhBrDWUZfqHABT
         OymcHzOG0RL2hsIbUIaM+p+xYAF3k4QDwDmotJbWp2EFht3pwkgIL72hAftIO0HdeKRf
         Hp/B0e2t/7i6JPDxal24stlrdjr/+FxwG1kO6BS1Qq2RIfVuMiBMB94WGRMHzU91u1W0
         uNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S55WAygfJhz9pUfbCHl1vHIyZxo8JBgiQucDLTiw/SM=;
        b=fMUyKTSAGQaIpmVY9A49su//4C4Af8/mUx+W6pWqRjpzyepiMdCnaXVIJNoHwgM8Py
         NCVbspPVjeR2bJhUFGvNarHcOhrcq3WqztGlARX1r01evbrdCjY6Bjkfiboy1SUks0YK
         hBVNf5/BAmHufY8CA7pfwO+QHwh3Rq89/WJpdYADDKec/ga66mws2ql81d8TQsed3UYe
         AcnYeQbTq02SrdkaiMRF3rHu1rgqHDeOtpjZz64QtUI8XapSehFaDKvtHW5iQyovlJlG
         a8ZaYr5p67Si9lOdWOb2pZ5WJRdztAYIj1RL8Dhdu8L74HGo3AMtkGRCMF2Fbo50SaGc
         bhZg==
X-Gm-Message-State: AD7BkJLp9mcbYtfRl0C14rEW1eT+Sr+jLcHKXCIrN82sq6wl7PmArZozHWfBarvdxj4+mw==
X-Received: by 10.140.143.134 with SMTP id 128mr48667938qhp.25.1457548608083;
        Wed, 09 Mar 2016 10:36:48 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:47 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288564>

When we daemonize, our pid changes, so we need to rewrite the pid file.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/index-helper.c b/index-helper.c
index 7e7ce9b..dc03e1e 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -288,12 +288,33 @@ static const char * const usage_text[] = {
 	NULL
 };
 
-int main(int argc, char **argv)
+static const char *write_pid(void)
 {
+	static struct strbuf sb = STRBUF_INIT;
 	static struct lock_file lock;
-	struct strbuf sb = STRBUF_INIT;
+	int fd;
+
+	strbuf_reset(&sb);
+	fd = hold_lock_file_for_update(&lock,
+				       git_path("index-helper.pid"),
+				       LOCK_DIE_ON_ERROR);
+#ifdef GIT_WINDOWS_NATIVE
+	strbuf_addstr(&sb, "HWND");
+#elif defined(USE_WATCHMAN)
+	strbuf_addch(&sb, 'W');	/* see poke_daemon() */
+#endif
+	strbuf_addf(&sb, "%" PRIuMAX, (uintmax_t) getpid());
+	write_in_full(fd, sb.buf, sb.len);
+	commit_lock_file(&lock);
+
+	return sb.buf;
+}
+
+int main(int argc, char **argv)
+{
 	const char *prefix;
-	int fd, idle_in_minutes = 10, detach = 0;
+	int idle_in_minutes = 10, detach = 0;
+	const char *pid_file;
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
 			    N_("exit if not used after some minutes")),
@@ -314,17 +335,7 @@ int main(int argc, char **argv)
 			  options, usage_text, 0))
 		die(_("too many arguments"));
 
-	fd = hold_lock_file_for_update(&lock,
-				       git_path("index-helper.pid"),
-				       LOCK_DIE_ON_ERROR);
-#ifdef GIT_WINDOWS_NATIVE
-	strbuf_addstr(&sb, "HWND");
-#elif defined(USE_WATCHMAN)
-	strbuf_addch(&sb, 'W');	/* see poke_daemon() */
-#endif
-	strbuf_addf(&sb, "%" PRIuMAX, (uintmax_t) getpid());
-	write_in_full(fd, sb.buf, sb.len);
-	commit_lock_file(&lock);
+	write_pid();
 
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
@@ -332,9 +343,14 @@ int main(int argc, char **argv)
 	if (detach && daemonize(&daemonized))
 		die_errno("unable to detach");
 
+	/*
+	 * Now that we're daemonized, we need to rewrite the PID file
+	 * because we have a new PID.
+	 */
+	pid_file = write_pid();
+
 	if (!idle_in_minutes)
 		idle_in_minutes = 0xffffffff / 60;
-	loop(sb.buf, idle_in_minutes * 60);
-	strbuf_release(&sb);
+	loop(pid_file, idle_in_minutes * 60);
 	return 0;
 }
-- 
2.4.2.767.g62658d5-twtrsrc
