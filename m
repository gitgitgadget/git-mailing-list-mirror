From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 9/9] Use timer_settime for new platforms
Date: Fri, 29 Aug 2014 09:42:41 -0700
Message-ID: <1409330561-11806-9-git-send-email-jacob.e.keller@intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 18:43:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPGr-0007dw-Gb
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbaH2Qn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:43:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:14972 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997AbaH2QnY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:43:24 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Aug 2014 09:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="378757900"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2014 09:38:38 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256154>

From: Jonas 'Sortie' Termansen <sortie@maxsi.org>

setitimer() is an obsolescent XSI interface and may be removed in a
future standard. Applications should use the core POSIX timer_settime()
instead.

It's important that code doesn't simply check if timer_settime is
available as it can give false positives. Some systems like contemporary
OpenBSD provides the function, but it unconditionally fails with ENOSYS
at runtime.

Clean up the progress reporting and change it to use timer_settime,
which will fall back to setitimer automatically if timer_settime is not
supported. (see git-compat-util.h for how it does this). If both
functions are not present, then git-compat-util.h provides replacements
which will always fail with ENOSYS.

The approach used here enables us to use a single API (timer_settime)
without having to worry about checking for #ifdefs or if blocks which
make it an unreadable nightmare. The major downside is for systems
without timer_settime support, they may fall back on a wrapped
implementation which could have subtle differences. This should be a
minor issue as almost all modern systems provide timer_settime support.

Note that this change means that git should never use setitimer on its
own now, as the fallback implementation of timer_settime assumes that it
is the sole user of ITIMER_REAL, and timer_delete will reset the
ITIMER_REAL.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 builtin/log.c | 27 ++++++++++++++++++++-------
 progress.c    | 20 +++++++++++++-------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4389722b4b1e..a39e82d67eb3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -229,7 +229,7 @@ static void show_early_header(struct rev_info *rev, const char *stage, int nr)
 	printf(_("Final output: %d %s\n"), nr, stage);
 }
 
-static struct itimerval early_output_timer;
+static timer_t early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
@@ -271,9 +271,12 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 	 * trigger every second even if we're blocked on a
 	 * reader!
 	 */
-	early_output_timer.it_value.tv_sec = 0;
-	early_output_timer.it_value.tv_usec = 500000;
-	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	struct itimerspec value;
+	value.it_value.tv_sec = 0;
+	value.it_value.tv_nsec = 500000L * 1000L;
+	value.it_interval.tv_sec = 0;
+	value.it_interval.tv_nsec = 0;
+	timer_settime(early_output_timer, 0, &value, NULL);
 }
 
 static void early_output(int signal)
@@ -284,6 +287,7 @@ static void early_output(int signal)
 static void setup_early_output(struct rev_info *rev)
 {
 	struct sigaction sa;
+	struct sigevent sev;
 
 	/*
 	 * Set up the signal handler, minimally intrusively:
@@ -305,14 +309,23 @@ static void setup_early_output(struct rev_info *rev)
 	 *
 	 * This is a one-time-only trigger.
 	 */
-	early_output_timer.it_value.tv_sec = 0;
-	early_output_timer.it_value.tv_usec = 100000;
-	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGALRM;
+	timer_create(CLOCK_MONOTONIC, &sev, &early_output_timer);
+
+	struct itimerspec value;
+	value.it_value.tv_sec = 0;
+	value.it_value.tv_nsec = 100000L * 1000L;
+	value.it_interval.tv_sec = 0;
+	value.it_interval.tv_nsec = 0;
+	timer_settime(early_output_timer, 0, &value, NULL);
 }
 
 static void finish_early_output(struct rev_info *rev)
 {
 	int n = estimate_commit_count(rev, rev->commits);
+	timer_delete(early_output_timer);
 	signal(SIGALRM, SIG_IGN);
 	show_early_header(rev, "done", n);
 }
diff --git a/progress.c b/progress.c
index 412e6b1ecc36..7fe73df35625 100644
--- a/progress.c
+++ b/progress.c
@@ -38,6 +38,7 @@ struct progress {
 	struct throughput *throughput;
 };
 
+static timer_t progress_timer;
 static volatile sig_atomic_t progress_update;
 
 static void progress_interval(int signum)
@@ -48,7 +49,7 @@ static void progress_interval(int signum)
 static void set_progress_signal(void)
 {
 	struct sigaction sa;
-	struct itimerval v;
+	struct sigevent sev;
 
 	progress_update = 0;
 
@@ -58,16 +59,21 @@ static void set_progress_signal(void)
 	sa.sa_flags = SA_RESTART;
 	sigaction(SIGALRM, &sa, NULL);
 
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGALRM;
+	timer_create(CLOCK_MONOTONIC, &sev, &progress_timer);
+
+	struct itimerspec value;
+	value.it_interval.tv_sec = 1;
+	value.it_interval.tv_nsec = 0;
+	value.it_value = value.it_interval;
+	timer_settime(progress_timer, 0, &value, NULL);
 }
 
 static void clear_progress_signal(void)
 {
-	struct itimerval v = {{0,},};
-	setitimer(ITIMER_REAL, &v, NULL);
+	timer_delete(progress_timer);
 	signal(SIGALRM, SIG_IGN);
 	progress_update = 0;
 }
-- 
2.0.1.475.g9b8d714
