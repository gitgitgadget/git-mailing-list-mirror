From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 9/9] Use timer_settime for new platforms
Date: Thu, 28 Aug 2014 03:04:22 +0200
Message-ID: <1409187862-21257-10-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoKN-0005rv-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbaH1BQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:16:36 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59723 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354AbaH1BQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:16:25 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 58F0840001D6D;
	Thu, 28 Aug 2014 01:06:15 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256068>

setitimer() is an obsolescent XSI interface and may be removed in a
future standard. Applications should use the core POSIX timer_settime()
instead.

This patch cleans up the progress reporting and changes it to try using
timer_settime, or if that fails, setitimer. If either function is not
provided by the system, then git-compat-util.h provides replacements
that always fail with ENOSYS.

It's important that code doesn't simply check if timer_settime is
available as it can give false positives. Some systems like contemporary
OpenBSD provides the function, but it unconditionally fails with ENOSYS
at runtime.

This approach allows the code using timer_settime() and setitimer() to
be simple and readable. My first attempt used #ifdef around each use of
timer_settime(), this quickly turned a into unmaintainable maze of
preprocessor conditionals.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 builtin/log.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 progress.c    | 34 +++++++++++++++++++++++++++-------
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4389722..54c85a6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -229,7 +229,8 @@ static void show_early_header(struct rev_info *rev, const char *stage, int nr)
 	printf(_("Final output: %d %s\n"), nr, stage);
 }
 
-static struct itimerval early_output_timer;
+static int is_using_timer_settime;
+static timer_t early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
@@ -271,9 +272,21 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 	 * trigger every second even if we're blocked on a
 	 * reader!
 	 */
-	early_output_timer.it_value.tv_sec = 0;
-	early_output_timer.it_value.tv_usec = 500000;
-	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	if (is_using_timer_settime) {
+		struct itimerspec value;
+		value.it_value.tv_sec = 0;
+		value.it_value.tv_nsec = 500000L * 1000L;
+		value.it_interval.tv_sec = 0;
+		value.it_interval.tv_nsec = 0;
+		timer_settime(early_output_timer, 0, &value, NULL);
+	} else {
+		struct itimerval value;
+		value.it_value.tv_sec = 0;
+		value.it_value.tv_usec = 500000;
+		value.it_interval.tv_sec = 0;
+		value.it_interval.tv_usec = 0;
+		setitimer(ITIMER_REAL, &value, NULL);
+	}
 }
 
 static void early_output(int signal)
@@ -284,6 +297,7 @@ static void early_output(int signal)
 static void setup_early_output(struct rev_info *rev)
 {
 	struct sigaction sa;
+	struct sigevent sev;
 
 	/*
 	 * Set up the signal handler, minimally intrusively:
@@ -305,14 +319,33 @@ static void setup_early_output(struct rev_info *rev)
 	 *
 	 * This is a one-time-only trigger.
 	 */
-	early_output_timer.it_value.tv_sec = 0;
-	early_output_timer.it_value.tv_usec = 100000;
-	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGALRM;
+	if (!timer_create(CLOCK_MONOTONIC, &sev, &early_output_timer)) {
+		struct itimerspec value;
+		value.it_value.tv_sec = 0;
+		value.it_value.tv_nsec = 100000L * 1000L;
+		value.it_interval.tv_sec = 0;
+		value.it_interval.tv_nsec = 0;
+		timer_settime(early_output_timer, 0, &value, NULL);
+		is_using_timer_settime = 1;
+	} else {
+		struct itimerval value;
+		value.it_value.tv_sec = 0;
+		value.it_value.tv_usec = 100000;
+		value.it_interval.tv_sec = 0;
+		value.it_interval.tv_usec = 0;
+		setitimer(ITIMER_REAL, &value, NULL);
+		is_using_timer_settime = 0;
+	}
 }
 
 static void finish_early_output(struct rev_info *rev)
 {
 	int n = estimate_commit_count(rev, rev->commits);
+	if (is_using_timer_settime)
+		timer_delete(early_output_timer);
 	signal(SIGALRM, SIG_IGN);
 	show_early_header(rev, "done", n);
 }
diff --git a/progress.c b/progress.c
index 412e6b1..b396ee1 100644
--- a/progress.c
+++ b/progress.c
@@ -38,6 +38,8 @@ struct progress {
 	struct throughput *throughput;
 };
 
+static int is_using_timer_settime;
+static timer_t progress_timer;
 static volatile sig_atomic_t progress_update;
 
 static void progress_interval(int signum)
@@ -48,7 +50,7 @@ static void progress_interval(int signum)
 static void set_progress_signal(void)
 {
 	struct sigaction sa;
-	struct itimerval v;
+	struct sigevent sev;
 
 	progress_update = 0;
 
@@ -58,16 +60,34 @@ static void set_progress_signal(void)
 	sa.sa_flags = SA_RESTART;
 	sigaction(SIGALRM, &sa, NULL);
 
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGALRM;
+	if (!timer_create(CLOCK_MONOTONIC, &sev, &progress_timer)) {
+		struct itimerspec value;
+		value.it_interval.tv_sec = 1;
+		value.it_interval.tv_nsec = 0;
+		value.it_value = value.it_interval;
+		timer_settime(progress_timer, 0, &value, NULL);
+		is_using_timer_settime = 1;
+	} else {
+		struct itimerval value;
+		value.it_interval.tv_sec = 1;
+		value.it_interval.tv_usec = 0;
+		value.it_value = value.it_interval;
+		setitimer(ITIMER_REAL, &value, NULL);
+		is_using_timer_settime = 0;
+	}
 }
 
 static void clear_progress_signal(void)
 {
-	struct itimerval v = {{0,},};
-	setitimer(ITIMER_REAL, &v, NULL);
+	if (is_using_timer_settime) {
+		timer_delete(progress_timer);
+	} else {
+		struct itimerval v = {{0,},};
+		setitimer(ITIMER_REAL, &v, NULL);
+	}
 	signal(SIGALRM, SIG_IGN);
 	progress_update = 0;
 }
-- 
2.1.0
