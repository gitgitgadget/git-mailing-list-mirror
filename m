From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/index-pack.c: Fix crash on MinGW caused by uninitialised
 mutex
Date: Fri, 09 Mar 2012 18:44:36 +0000
Message-ID: <4F5A4F94.1060309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 19:46:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S64pc-0001Vl-Rw
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 19:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758676Ab2CISqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 13:46:18 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:61066 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758675Ab2CISqR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 13:46:17 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1S64pS-0006Uj-lR; Fri, 09 Mar 2012 18:46:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192735>


On MinGW, the pthread emulation code uses a CRITICAL_SECTION in
it's implementation of an pthread_mutex_t. Any attempt to use an
uninitialised CRITICAL_SECTION results in a crash (in ntddl.dll).
On cygwin (and Linux), using an uninitialised pthread_mutex_t looks
like a no-op, or at least it does not seem to cause a problem.

In addition to not initialising and destroying the 'counter_mutex',
in the init_thread() and cleanup_thread() routines, several code
paths attempt to lock/unlock a mutex when not correctly initialised.

For example, in the parse_pack_objects() function, the 'first pass'
code contains calls to the sha1_object() function which, in turn,
attempts to lock the 'read_mutex' via read_lock(). At this point in
the function, no threads are active and none of the mutex variables
have been initialised (since init_thread() has not been called).

In order to avoid the crash on MinGW, we guard all calls to the
mutex (un-)locking functions to ensure that the mutex variables are
in a valid state to be operated on. We introduce an 'threads_active'
global variable which we set appropriately in the init_thread() and
cleanup_thread() routines to reflect the current threading state.
Also, we add the missing initialisation and destruction of the
'counter_mutex' to init_thread() and cleanup_thread().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

This patch, on top of my earlier one, fixes the problem on MinGW.
I am assuming that the tests t5300-pack-object.sh, t5302-pack-index.sh,
t5510-fetch.sh and t6050-replace.sh are sufficient to test the new
threaded version of git-index-pack. In any event, I have tested this
on MinGW, cygwin and Linux and all of the above tests pass.

While writing this mail, I had second thoughts on the 'threads_active'
name, but then (for similar reasons) init_thread() and cleanup_thread()
are not exactly right either. So, in the end, I decided not to re-name
that variable ... ;-)

When I'm away from home (and email), I sometimes use my isp's web-mail
interface to squint at the emails I will have waiting for me when I get home.
This afternoon I noticed that you had sent a patch (addressing this MinGW
problem) for me to try out. I won't get your mail into my MUA until after
I've sent this out. Since it will be one of approximately 450, I probably
won't get to it tonight ... :-D

ATB,
Ramsay Jones

 builtin/index-pack.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f8d93b8..ef81676 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -74,6 +74,7 @@ static int nr_processed;
 static int nr_deltas;
 static int nr_resolved_deltas;
 static int nr_threads;
+static int threads_active;
 
 static int from_stdin;
 static int strict;
@@ -93,16 +94,17 @@ static int input_fd, output_fd, pack_fd;
 #ifndef NO_PTHREADS
 
 static pthread_mutex_t read_mutex;
-#define read_lock()		pthread_mutex_lock(&read_mutex)
-#define read_unlock()		pthread_mutex_unlock(&read_mutex)
+#define read_lock()		if (threads_active) pthread_mutex_lock(&read_mutex)
+#define read_unlock()		if (threads_active) pthread_mutex_unlock(&read_mutex)
 
 static pthread_mutex_t counter_mutex;
-#define counter_lock()		pthread_mutex_lock(&counter_mutex)
-#define counter_unlock()		pthread_mutex_unlock(&counter_mutex)
+#define counter_lock()		if (threads_active) pthread_mutex_lock(&counter_mutex)
+#define counter_unlock()	if (threads_active) pthread_mutex_unlock(&counter_mutex)
 
 static pthread_mutex_t work_mutex;
-#define work_lock()		pthread_mutex_lock(&work_mutex)
-#define work_unlock()		pthread_mutex_unlock(&work_mutex)
+#define work_lock()		if (threads_active) pthread_mutex_lock(&work_mutex)
+#define work_unlock()		if (threads_active) pthread_mutex_unlock(&work_mutex)
+
 
 /*
  * Mutex and conditional variable can't be statically-initialized on Windows.
@@ -110,12 +112,16 @@ static pthread_mutex_t work_mutex;
 static void init_thread(void)
 {
 	init_recursive_mutex(&read_mutex);
+	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
+	threads_active = 1;
 }
 
 static void cleanup_thread(void)
 {
+	threads_active = 0;
 	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
 }
 
-- 
1.7.9
