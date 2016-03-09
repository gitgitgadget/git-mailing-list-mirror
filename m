From: David Turner <dturner@twopensource.com>
Subject: [PATCH 17/19] index-helper: process management
Date: Wed,  9 Mar 2016 13:36:20 -0500
Message-ID: <1457548582-28302-18-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiz7-0007g4-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933878AbcCIShU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:37:20 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35701 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932950AbcCISgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:49 -0500
Received: by mail-qg0-f52.google.com with SMTP id y89so49339403qge.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jxEO1jg8yH0Ya9k7IrMlfLHiP9U2xG0HNwqTlb0tpHo=;
        b=kVXlTpXFAw0t6Awa1wwAIlrtnzcV80B9b0DFFDxo8SC3FfcaSklTfZfZlPdzsd8KxS
         5aPqmc6Pmw7H/L+m3xWNCtzpHEQWEgNDNw91KFNMA83JQs2H4rLIkTsc5+1BL+R49TmI
         0ysCu8CZpdtSKetkxxbwPPjko+EocMyMKuvfpzE+QHpiNjPOV4B+VwfRxLUmdvekt/4C
         Ka+Y2jAGE/K8hgdM/5gH2mSjXb8Tlzv4hnr5GQcAMejC8ynGsomiehkUgXSBGP6TSps7
         i1hEmS4nAAR4WkN91Iuy8jWazRodwuDgDHWgJRF7v5u0wceekPZgxqlLaO/UoFyKCBzi
         RBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jxEO1jg8yH0Ya9k7IrMlfLHiP9U2xG0HNwqTlb0tpHo=;
        b=TOFCPBazAJSBEbn3IVeI+m0peLlcGTYHIwf1p9KFfMQJtGArC3QfbQAakq9XKruTnJ
         T9teVUuD2O7aU/0Vms/xIVUm8LMZuOJ0MlVipdjK+k7S1wWahZSudgQaDnTkRROdDyAU
         BkC+japHSoCzq4+vKPFsDU8GDOfDaE6KwBa3k2J+fxiCGhRLF6NCmvdL98SRfVwy4Pl/
         HkoMdtnSi9MooRrc418DzHSsVptV1rbCuVF+gAvHreCgtbCdy1roArfk/2tLcQf42rMw
         K15ZIhgq4mmU7XyAo8M8ZR11kJmQEhgEqvra3sSsgQ4Ikme+tKdd2KlJM46xjT5zhS9P
         E2Jg==
X-Gm-Message-State: AD7BkJLvMG8dO24B3GAAtiv4kzQObSayHLX0L0uwE+01VZjJ6U1t10oVrPu0Yj08usdkWg==
X-Received: by 10.140.92.180 with SMTP id b49mr35995339qge.81.1457548609029;
        Wed, 09 Mar 2016 10:36:49 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:48 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288563>

Don't start index-helper when it is already running for a repository.

Keep the index-helper pid file's mtime up-to-date.  Before starting
index-helper, check that (a) the pid file's mtime is recent and (b)
there is some process with that pid.  Of course, it's possible that
the mtime is recent but the index-helper has died anyway (and some other
process has taken its pid), but that's pretty unlikely.

Provide index-helper --kill (to kill the running index-helper) and
index-helper --ignore-existing (to start up a new index-helper even
if we believe that there's one already running).

Add a test for index-helper's pid-file writing and for --kill.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 95 +++++++++++++++++++++++++++++++++++++++++++++----
 t/t7900-index-helper.sh | 23 ++++++++++++
 2 files changed, 111 insertions(+), 7 deletions(-)
 create mode 100755 t/t7900-index-helper.sh

diff --git a/index-helper.c b/index-helper.c
index dc03e1e..a75da60 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -152,6 +152,17 @@ static void refresh(int sig)
 
 #ifdef HAVE_SHM
 
+static void touch_pid_file(void)
+{
+	/*
+	 * If we fail to update the times on index-helper.pid, we've
+	 * probably had the repo deleted out from under us or otherwise
+	 * lost access; might as well give up.
+	 */
+	if (utimes(git_path("index-helper.pid"), NULL))
+		exit(0);
+}
+
 #ifdef USE_WATCHMAN
 static void share_watchman(struct index_state *istate,
 			   struct shm *is, pid_t pid)
@@ -211,9 +222,10 @@ static void prepare_index(int sig, siginfo_t *si, void *context)
 
 #endif
 
-static void loop(const char *pid_file, int idle_in_seconds)
+static void loop(const char *pid_file, int idle_in_minutes)
 {
 	struct sigaction sa;
+	int timeout_count = 0;
 
 	sigchain_pop(SIGHUP);	/* pushed by sigchain_push_common */
 	sigchain_push(SIGHUP, refresh);
@@ -225,19 +237,25 @@ static void loop(const char *pid_file, int idle_in_seconds)
 	sigaction(SIGUSR1, &sa, NULL);
 
 	refresh(0);
-	while (sleep(idle_in_seconds))
-		; /* do nothing, all is handled by signal handlers already */
+	while (timeout_count < idle_in_minutes) {
+		if (sleep(60) == EINTR)
+			timeout_count = 0;
+		else
+			timeout_count ++;
+		touch_pid_file();
+	}
 }
 
 #elif defined(GIT_WINDOWS_NATIVE)
 
-static void loop(const char *pid_file, int idle_in_seconds)
+static void loop(const char *pid_file, int idle_in_minutes)
 {
 	HWND hwnd;
 	UINT_PTR timer = 0;
 	MSG msg;
 	HINSTANCE hinst = GetModuleHandle(NULL);
 	WNDCLASS wc;
+	int timeout_count = 0;
 
 	/*
 	 * Emulate UNIX signals by sending WM_USER+x to a
@@ -258,11 +276,18 @@ static void loop(const char *pid_file, int idle_in_seconds)
 
 	refresh(0);
 	while (1) {
-		timer = SetTimer(hwnd, timer, idle_in_seconds * 1000, NULL);
+		timer = SetTimer(hwnd, timer, 60 * 1000, NULL);
 		if (!timer)
 			die(_("no timer!"));
-		if (!GetMessage(&msg, hwnd, 0, 0) || msg.message == WM_TIMER)
+		if (!GetMessage(&msg, hwnd, 0, 0))
 			break;
+		if (msg.message == WM_TIMER) {
+			timeout_count ++;
+			if (timeout_count == idle_in_minutes)
+				break;
+		}
+		timeout_count = 0;
+		touch_pid_file();
 		switch (msg.message) {
 		case WM_USER:
 			refresh(0);
@@ -288,6 +313,44 @@ static const char * const usage_text[] = {
 	NULL
 };
 
+static int already_running(void)
+{
+	char contents[20] = {0};
+	char *end;
+	int fd, dead, i = 0;
+	time_t now;
+	pid_t pid;
+	struct stat st;
+
+	fd = open(git_path("index-helper.pid"), O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	if (fstat(fd, &st) < 0)
+		return 0;
+
+	now = time(&now);
+
+	/*
+	 * We touch the pid file every minute, so if a pid file hasn't
+	 * been updated in two minutes, it's out-of-date.
+	 */
+	if (st.st_mtime + 120 < now)
+		return 0;
+
+	read_in_full(fd, &contents, sizeof(contents));
+
+	while (!isdigit(contents[i]) && contents[i])
+		i++;
+	pid = strtoll(contents + i, &end, 10);
+	if (contents == end)
+		return 0;
+	dead = kill(pid, 0);
+	if (!dead)
+		return pid;
+	return 0;
+}
+
 static const char *write_pid(void)
 {
 	static struct strbuf sb = STRBUF_INIT;
@@ -314,6 +377,8 @@ int main(int argc, char **argv)
 {
 	const char *prefix;
 	int idle_in_minutes = 10, detach = 0;
+	int ignore_existing = 0;
+	int kill_existing = 0;
 	const char *pid_file;
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
@@ -321,6 +386,8 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "ignore-existing", &ignore_existing, "run even if another index-helper seems to be running for this repo"),
+		OPT_BOOL(0, "kill", &kill_existing, "kill any running index-helper for this repo"),
 		OPT_END()
 	};
 
@@ -335,6 +402,20 @@ int main(int argc, char **argv)
 			  options, usage_text, 0))
 		die(_("too many arguments"));
 
+	if (ignore_existing && kill_existing)
+		die(_("--ignore-existing and --kill don't make sense together"));
+
+	if (!ignore_existing) {
+		pid_t pid = already_running();
+		if (pid) {
+			if (kill_existing)
+				exit(kill(pid, SIGKILL));
+			else if (!detach)
+				warning("index-helper is apparently already running with pid %d", (int)pid);
+			exit(0);
+		}
+	}
+
 	write_pid();
 
 	atexit(cleanup);
@@ -351,6 +432,6 @@ int main(int argc, char **argv)
 
 	if (!idle_in_minutes)
 		idle_in_minutes = 0xffffffff / 60;
-	loop(pid_file, idle_in_minutes * 60);
+	loop(pid_file, idle_in_minutes);
 	return 0;
 }
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
new file mode 100755
index 0000000..6708180
--- /dev/null
+++ b/t/t7900-index-helper.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+#
+# Copyright (c) 2016, Twitter, Inc
+#
+
+test_description='git-index-helper
+
+Testing git index-helper
+'
+
+. ./test-lib.sh
+
+test_expect_success 'index-helper creates usable pid file and can be killed' '
+	test_path_is_missing .git/index-helper.pid &&
+	git index-helper --detach &&
+	test_path_is_file .git/index-helper.pid &&
+	pid=$(sed s/[^0-9]//g .git/index-helper.pid) &&
+	kill -0 $pid &&
+	git index-helper --kill &&
+	! kill -0 $pid
+'
+
+test_done
-- 
2.4.2.767.g62658d5-twtrsrc
