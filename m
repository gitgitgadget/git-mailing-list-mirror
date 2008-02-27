From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 14/40] Windows: Implement setitimer() and sigaction().
Date: Wed, 27 Feb 2008 19:54:37 +0100
Message-ID: <1204138503-6126-15-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVO-00022R-Dd
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbYB0Szl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756140AbYB0Szk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:40 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40440 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYB0SzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:08 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 47A169735D;
	Wed, 27 Feb 2008 19:55:06 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75268>

The timer is implemented using a thread that calls the signal handler
at regular intervals.

We also replace Windows's signal() function because we must intercept
that SIGALRM is set (which is used when a timer is canceled).

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 git-compat-util.h |    3 +
 2 files changed, 113 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 24f783b..4888a03 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -129,12 +129,121 @@ struct passwd *getpwuid(int uid)
 	return &p;
 }
 
-int setitimer(int type, struct itimerval *in, struct itimerval *out)
+static HANDLE timer_event;
+static HANDLE timer_thread;
+static int timer_interval;
+static int one_shot;
+static sig_handler_t timer_fn = SIG_DFL;
+
+/* The timer works like this:
+ * The thread, ticktack(), is basically a trivial routine that most of the
+ * time only waits to receive the signal to terminate. The main thread
+ * tells the thread to terminate by setting the timer_event to the signalled
+ * state.
+ * But ticktack() does not wait indefinitely; instead, it interrupts the
+ * wait state every now and then, namely exactly after timer's interval
+ * length. At these opportunities it calls the signal handler.
+ */
+
+static __stdcall unsigned ticktack(void *dummy)
+{
+	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
+		if (timer_fn == SIG_DFL)
+			die("Alarm");
+		if (timer_fn != SIG_IGN)
+			timer_fn(SIGALRM);
+		if (one_shot)
+			break;
+	}
+	return 0;
+}
+
+static int start_timer_thread(void)
 {
+	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
+	if (timer_event) {
+		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
+		if (!timer_thread )
+			return errno = ENOMEM,
+				error("cannot start timer thread");
+	} else
+		return errno = ENOMEM,
+			error("cannot allocate resources timer");
 	return 0;
 }
 
+static void stop_timer_thread(void)
+{
+	if (timer_event)
+		SetEvent(timer_event);	/* tell thread to terminate */
+	if (timer_thread) {
+		int rc = WaitForSingleObject(timer_thread, 1000);
+		if (rc == WAIT_TIMEOUT)
+			error("timer thread did not terminate timely");
+		else if (rc != WAIT_OBJECT_0)
+			error("waiting for timer thread failed: %lu",
+			      GetLastError());
+		CloseHandle(timer_thread);
+	}
+	if (timer_event)
+		CloseHandle(timer_event);
+	timer_event = NULL;
+	timer_thread = NULL;
+}
+
+static inline int is_timeval_eq(const struct timeval *i1, const struct timeval *i2)
+{
+	return i1->tv_sec == i2->tv_sec && i1->tv_usec == i2->tv_usec;
+}
+
+int setitimer(int type, struct itimerval *in, struct itimerval *out)
+{
+	static const struct timeval zero;
+	static int atexit_done;
+
+	if (out != NULL)
+		return errno = EINVAL,
+			error("setitmer param 3 != NULL not implemented");
+	if (!is_timeval_eq(&in->it_interval, &zero) &&
+	    !is_timeval_eq(&in->it_interval, &in->it_value))
+		return errno = EINVAL,
+			error("setitmer: it_interval must be zero or eq it_value");
+
+	if (timer_thread)
+		stop_timer_thread();
+
+	if (is_timeval_eq(&in->it_value, &zero) &&
+	    is_timeval_eq(&in->it_interval, &zero))
+		return 0;
+
+	timer_interval = in->it_value.tv_sec * 1000 + in->it_value.tv_usec / 1000;
+	one_shot = is_timeval_eq(&in->it_interval, &zero);
+	if (!atexit_done) {
+		atexit(stop_timer_thread);
+		atexit_done = 1;
+	}
+	return start_timer_thread();
+}
+
 int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 {
+	if (sig != SIGALRM)
+		return errno = EINVAL,
+			error("sigaction only implemented for SIGALRM");
+	if (out != NULL)
+		return errno = EINVAL,
+			error("sigaction: param 3 != NULL not implemented");
+
+	timer_fn = in->sa_handler;
 	return 0;
 }
+
+#undef signal
+sig_handler_t mingw_signal(int sig, sig_handler_t handler)
+{
+	if (sig != SIGALRM)
+		return signal(sig, handler);
+	sig_handler_t old = timer_fn;
+	timer_fn = handler;
+	return old;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index c576f5a..483ace2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -602,6 +602,9 @@ char *mingw_getcwd(char *pointer, int len);
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
+sig_handler_t mingw_signal(int sig, sig_handler_t handler);
+#define signal mingw_signal
+
 #endif /* __MINGW32__ */
 
 #endif
-- 
1.5.4.1.126.ge5a7d
