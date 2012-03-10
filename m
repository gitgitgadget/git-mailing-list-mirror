From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] builtin/index-pack.c: Fix some pthread_t misuse
Date: Sat, 10 Mar 2012 21:20:58 +0000
Message-ID: <4F5BC5BA.9000404@ramsay1.demon.co.uk>
References: <4F57B04F.6050307@ramsay1.demon.co.uk> <7vvcmgmde3.fsf@alter.siamese.dyndns.org> <20120308012953.GA8444@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 19:33:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6naF-00005k-VL
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 19:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab2CKSdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 14:33:15 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:39203 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753622Ab2CKSdO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 14:33:14 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1S6nZw-0000DB-hH; Sun, 11 Mar 2012 18:33:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20120308012953.GA8444@duynguyen-vnpc.dek-tpc.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192819>

Nguyen Thai Ngoc Duy wrote:
> Does this help your crash Ramsay? It also moves down cleanup_thread()
> so counter_mutex is always valid when it's used. Seems to work with
> linux-2.6.git.

[ patch snipped ]

No this does not help, because it doesn't address the fundamental problem.

The problem is simply that mutex variables are being used when they are
not in a usable state; either they are not initialised at all (counter_mutex),
or they are being used *before* they are initialised (in init_thread()) or
*after* they are destroyed (in cleanup_thread()).

If I apply the patch below on top of your patch (it should look familiar!),
then everything works fine. (This time I only tested on MinGW and cygwin).

Also, I would move the call to cleanup_thread() back up to it's original
location, since the move down serves no useful purpose.

I don't know that using TLS here is an improvement or not (it's probably a
wash). ;-)

[BTW, using an uninitialised mutex on cygwin and Linux *seems* to work without
problem, but I can't be sure that's true (I haven't looked at the code). :-P ]

ATB,
Ramsay Jones

-- 8< --
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 098f350..31f923c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -74,6 +74,7 @@ static int nr_processed;
 static int nr_deltas;
 static int nr_resolved_deltas;
 static int nr_threads;
+static int threads_active;
 
 static int from_stdin;
 static int strict;
@@ -93,16 +94,16 @@ static int input_fd, output_fd, pack_fd;
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
 
 static pthread_key_t key;
 
@@ -112,13 +113,17 @@ static pthread_key_t key;
 static void init_thread(void)
 {
 	init_recursive_mutex(&read_mutex);
+	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
 	pthread_key_create(&key, NULL);
+	threads_active = 1;
 }
 
 static void cleanup_thread(void)
 {
+	threads_active = 0;
 	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
 }
 
-- 8< --
