From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Use sigaction and SA_RESTART in read-tree.c; add option in Makefile.
Date: Sun, 02 Apr 2006 15:29:34 -0700
Message-ID: <17063.1144016974@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0604021312510.3050@g5.osdl.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 00:29:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQB4p-0003VN-A8
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 00:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWDBW3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 18:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDBW3k
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 18:29:40 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:11930 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932430AbWDBW3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 18:29:39 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k32MTYgH017065;
	Sun, 2 Apr 2006 15:29:34 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k32MTYCD017064;
	Sun, 2 Apr 2006 15:29:34 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
In-reply-to: <Pine.LNX.4.64.0604021312510.3050@g5.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18294>

Might as well ape the sigaction change in read-tree.c to avoid
the same potential problems.  The fprintf status output will
be overwritten in a second, so don't bother guarding it.  Do
move the fputc after disabling SIGALRM to ensure we go to the
next line, though.

Also add a NO_SA_RESTART option in the Makefile in case someone
doesn't have SA_RESTART but does restart (maybe older HP/UX?).
We want the builder to chose this specifically in case the
system both lacks SA_RESTART and does not restart stdio calls;
a compat #define in git-compat-utils.h would silently allow
broken systems.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 Makefile    |    7 +++++++
 read-tree.c |   28 +++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

521dc260ea90a23d58a4e920203af5035ca1a673
diff --git a/Makefile b/Makefile
index c79d646..f3b1d49 100644
--- a/Makefile
+++ b/Makefile
@@ -63,6 +63,9 @@
 # Define COLLISION_CHECK below if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # sufficient guarantee that no collisions between objects will ever happen.
+#
+# Define NO_SA_RESTART if your platform does not have SA_RESTART, _AND_ if
+# it automatically restarts interrupted stdio calls.
 
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
@@ -425,6 +428,10 @@
 endif
 ifdef NO_ACCURATE_DIFF
 	ALL_CFLAGS += -DNO_ACCURATE_DIFF
+endif
+
+ifdef NO_SA_RESTART
+	ALL_CFLAGS += -DSA_RESTART=0
 endif
 
 # Shell quote (do not use $(call) to accomodate ancient setups);
diff --git a/read-tree.c b/read-tree.c
index eaff444..4422dbf 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -273,10 +273,26 @@
 
 static void progress_interval(int signum)
 {
-	signal(SIGALRM, progress_interval);
 	progress_update = 1;
 }
 
+static void setup_progress_signal(void)
+{
+	struct sigaction sa;
+	struct itimerval v;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = progress_interval;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+
+	v.it_interval.tv_sec = 1;
+	v.it_interval.tv_usec = 0;
+	v.it_value = v.it_interval;
+	setitimer(ITIMER_REAL, &v, NULL);
+}
+
 static void check_updates(struct cache_entry **src, int nr)
 {
 	static struct checkout state = {
@@ -289,8 +305,6 @@
 	unsigned last_percent = 200, cnt = 0, total = 0;
 
 	if (update && verbose_update) {
-		struct itimerval v;
-
 		for (total = cnt = 0; cnt < nr; cnt++) {
 			struct cache_entry *ce = src[cnt];
 			if (!ce->ce_mode || ce->ce_flags & mask)
@@ -302,12 +316,8 @@
 			total = 0;
 
 		if (total) {
-			v.it_interval.tv_sec = 1;
-			v.it_interval.tv_usec = 0;
-			v.it_value = v.it_interval;
-			signal(SIGALRM, progress_interval);
-			setitimer(ITIMER_REAL, &v, NULL);
 			fprintf(stderr, "Checking files out...\n");
+			setup_progress_signal();
 			progress_update = 1;
 		}
 		cnt = 0;
@@ -341,8 +351,8 @@
 		}
 	}
 	if (total) {
-		fputc('\n', stderr);
 		signal(SIGALRM, SIG_IGN);
+		fputc('\n', stderr);
 	}
 }
 
-- 
1.3.0.rc1
