From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] builtin/index-pack.c: Fix some pthread_t misuse
Date: Thu, 8 Mar 2012 08:29:53 +0700
Message-ID: <20120308012953.GA8444@duynguyen-vnpc.dek-tpc.internal>
References: <4F57B04F.6050307@ramsay1.demon.co.uk>
 <7vvcmgmde3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 08 02:30:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5SBY-0001nD-De
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 02:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab2CHBaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 20:30:23 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59705 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab2CHBaW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 20:30:22 -0500
Received: by pbcun15 with SMTP id un15so1044111pbc.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 17:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZVsTa+bjAiVWm/CXt6m6g39yyB37U1QkBDrwOV0D0H4=;
        b=oqn5mQ53Q5134BzdJ1cYflr839BjJEmAUKBjkThvPfciK9bKfyd7gXjRWgkI6O8n26
         8LVWF5R32jOxZMYeub3obcCHl9ukFMhx1JOOJWwZxkn+cafnUbOE1PST0Hflog/+ntil
         bLMh/0AfvWr3/QCIoUeUK0Mp/5EQ6DWn2jNtC2gl17oxMHbn18zOEGmHgH1vhgyErTvc
         HhHcfsa9QAftFBRMniVQ2QcmS26chmdj4jX4yUoxoA3uShm8i0+pnRF6RbWAGTVEVfb+
         hxUqkTvmssrRAjP8yHAhi70bOzcnBdYn4BRCJ0nhtLsWZOl0ox4GhKomt0uG+TM9gBHp
         tNuA==
Received: by 10.68.211.168 with SMTP id nd8mr6667674pbc.25.1331170221348;
        Wed, 07 Mar 2012 17:30:21 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id e3sm1715045pbr.15.2012.03.07.17.30.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 17:30:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Mar 2012 08:29:53 +0700
Content-Disposition: inline
In-Reply-To: <7vvcmgmde3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192514>

On Wed, Mar 07, 2012 at 11:15:00AM -0800, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
> > However, pthread_t is intended to be an opaque (implementation defined)
> > type. For example, an implementation may choose to use a structure to
> > implement the type.  Therefore, assigning zero (or any other constant)
> > to a pthread_t is not supported in general.
> > ...
> > Note that, for the same reason given above, you can not, in general,
> > directly compare pthread_t handles with the built-in equality operator.
> > In order to compare pthread_t's for equality, the POSIX standard requires
> > the use of pthread_equal().
> 
> Thanks, the above analysis all sound sensible.
> 
> I do not think it matters in *this* case, but if a loop iterates
> over an array of things with a field of type pthread_t in it, whose
> element may or may not be valid, and wants to mark the validity of
> an element with the value of its pthread_t field, what is the proper
> way to do so?  I.e.
> 
> 	for (i = 0; i < ARRAY_SIZE(thread_data); i++) {
> 		if (pthread_invalid(thread_data[i].thread)
> 			continue; /* not used */
>         	if (!pthread_equal(self, thread_data[i].thread))
>                 	continue; /* not me */
> 		/* ah, this is mine! */
>                 ...
> 	}
> 
> Perhaps the answer is "Don't do it" and that is perfectly fine, but
> does Nguyen's code rely on the final clean-up (assignment with 0 you
> are removing with this patch) to mark that these elements are no
> longer relevant?

The 0 assignment is not strictly needed. Shortly after that,
nr_threads is set back to 1, which makes thread_data[1..]
inaccessible, and thread_data[0] is dedicated for the main thread
already.

We can get rid of pthread_t comparison by using TLS (I avoided this
because this would be the first time pthread_getspecific is used in
git).

Does this help your crash Ramsay? It also moves down cleanup_thread()
so counter_mutex is always valid when it's used. Seems to work with
linux-2.6.git.

-- 8< --
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index edd7cbd..098f350 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -104,6 +104,8 @@ static pthread_mutex_t work_mutex;
 #define work_lock()		pthread_mutex_lock(&work_mutex)
 #define work_unlock()		pthread_mutex_unlock(&work_mutex)
 
+static pthread_key_t key;
+
 /*
  * Mutex and conditional variable can't be statically-initialized on Windows.
  */
@@ -111,6 +113,7 @@ static void init_thread(void)
 {
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&work_mutex, NULL);
+	pthread_key_create(&key, NULL);
 }
 
 static void cleanup_thread(void)
@@ -284,31 +287,19 @@ static NORETURN void bad_object(unsigned long offset, const char *format, ...)
 static struct thread_local *get_thread_data(void)
 {
 #ifndef NO_PTHREADS
-	int i;
-	pthread_t self = pthread_self();
-	for (i = 1; i < nr_threads; i++)
-		if (self == thread_data[i].thread)
-			return &thread_data[i];
+	if (nr_threads > 1)
+		return pthread_getspecific(key);
 #endif
+	assert(nr_threads == 1 &&
+	       "This should only be reached when all threads are gone");
 	return &thread_data[0];
 }
 
 static void resolve_one_delta(void)
 {
-#ifndef NO_PTHREADS
-	int i;
-	pthread_t self = pthread_self();
-	for (i = 1; i < nr_threads; i++)
-		if (self == thread_data[i].thread) {
-			counter_lock();
-			nr_resolved_deltas++;
-			counter_unlock();
-			return;
-		}
-#endif
-	assert(nr_threads == 1 &&
-	       "This should only be reached when all threads are gone");
+	counter_lock();
 	nr_resolved_deltas++;
+	counter_unlock();
 }
 
 static struct base_data *alloc_base_data(void)
@@ -796,6 +787,7 @@ static void second_pass(struct object_entry *obj)
 
 static void *threaded_second_pass(void *arg)
 {
+	pthread_setspecific(key, arg);
 	for (;;) {
 		int i, nr = 16;
 		work_lock();
@@ -883,15 +875,12 @@ static void parse_pack_objects(unsigned char *sha1)
 		init_thread();
 		for (i = 1; i < nr_threads; i++) {
 			int ret = pthread_create(&thread_data[i].thread, NULL,
-						 threaded_second_pass, NULL);
+						 threaded_second_pass, thread_data + i);
 			if (ret)
 				die("unable to create thread: %s", strerror(ret));
 		}
-		for (i = 1; i < nr_threads; i++) {
+		for (i = 1; i < nr_threads; i++)
 			pthread_join(thread_data[i].thread, NULL);
-			thread_data[i].thread = 0;
-		}
-		cleanup_thread();
 
 		/* stop get_thread_data() from looking up beyond the
 		   first item, when fix_unresolved_deltas() runs */
@@ -1411,6 +1400,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			die("pack has %d unresolved deltas",
 			    nr_deltas - nr_resolved_deltas);
 	}
+#ifndef NO_PTHREADS
+	cleanup_thread();
+#endif
 	free(deltas);
 	if (strict)
 		check_objects();
-- 8< --
