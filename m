From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/index-pack.c: Fix some pthread_t misuse
Date: Wed, 07 Mar 2012 19:00:31 +0000
Message-ID: <4F57B04F.6050307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 20:03:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5M8Y-0001HZ-Op
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 20:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700Ab2CGTCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 14:02:46 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:64731 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932608Ab2CGTCn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 14:02:43 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1S5M8G-0002Pq-iK; Wed, 07 Mar 2012 19:02:41 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192472>


On cygwin, sparse complains as follows:

        SP builtin/index-pack.c
    builtin/index-pack.c:892:49: warning: Using plain integer as \
        NULL pointer

The warning refers to code which assigns zero to a pthread_t thread
handle. In this case, the pthread_t handle type is a pointer type,
which results in the above warning. On Linux a pthread_t is defined
as an integer type (unsigned long int for me) and so sparse does not
issue any such warning.

However, pthread_t is intended to be an opaque (implementation defined)
type. For example, an implementation may choose to use a structure to
implement the type.  Therefore, assigning zero (or any other constant)
to a pthread_t is not supported in general.

As a case in point, the pthread emulation code on MinGW defines the
pthread_t type using a structure (see compat/win32/pthread.h:57), which
results in gcc complaining as follows:

        CC builtin/index-pack.o
    builtin/index-pack.c: In function 'get_thread_data':
    builtin/index-pack.c:290: error: invalid operands to binary == \
        (have 'pthread_t' and 'pthread_t')
    builtin/index-pack.c: In function 'resolve_one_delta':
    builtin/index-pack.c:302: error: invalid operands to binary == \
        (have 'pthread_t' and 'pthread_t')
    builtin/index-pack.c: In function 'parse_pack_objects':
    builtin/index-pack.c:892: error: incompatible types when assigning \
        to type 'pthread_t' from type 'int'
    make: *** [builtin/index-pack.o] Error 1

Note that, for the same reason given above, you can not, in general,
directly compare pthread_t handles with the built-in equality operator.
In order to compare pthread_t's for equality, the POSIX standard requires
the use of pthread_equal().

In order to fix the warnings and errors, we replace the use of the
'==' operator with corresponding calls to pthread_equal() and remove
the statement which assigns zero to the thread handle.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

commit ee66dabd ("index-pack: support multithreaded delta resolving",
02-03-2012) causes a build failure on MinGW. This patch makes a small
improvement - it at least builds.

The only testing I have done is to run the testsuite on Linux (it passes)
and tests t5300-pack-object.sh, t5302-pack-index.sh, t5510-fetch.sh and
t6050-replace.sh on cygwin (running the full testsuite on cygwin takes
*hours*) and again it passes.

On MinGW, however, the above tests all fail miserably! (They crash with
that irritating 'git.exe failed do you want to send error report to
Microsoft' dialog). I noticed that the 'counter_mutex' is not initialised
or destroyed, and have (literally) just tested a patch which does this
and ... it made no difference! :(

So, more debugging needs to be done on windows ...

ATB,
Ramsay Jones

 builtin/index-pack.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index edd7cbd..f8d93b8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -287,7 +287,7 @@ static struct thread_local *get_thread_data(void)
 	int i;
 	pthread_t self = pthread_self();
 	for (i = 1; i < nr_threads; i++)
-		if (self == thread_data[i].thread)
+		if (pthread_equal(self, thread_data[i].thread))
 			return &thread_data[i];
 #endif
 	return &thread_data[0];
@@ -299,7 +299,7 @@ static void resolve_one_delta(void)
 	int i;
 	pthread_t self = pthread_self();
 	for (i = 1; i < nr_threads; i++)
-		if (self == thread_data[i].thread) {
+		if (pthread_equal(self, thread_data[i].thread)) {
 			counter_lock();
 			nr_resolved_deltas++;
 			counter_unlock();
@@ -887,10 +887,8 @@ static void parse_pack_objects(unsigned char *sha1)
 			if (ret)
 				die("unable to create thread: %s", strerror(ret));
 		}
-		for (i = 1; i < nr_threads; i++) {
+		for (i = 1; i < nr_threads; i++)
 			pthread_join(thread_data[i].thread, NULL);
-			thread_data[i].thread = 0;
-		}
 		cleanup_thread();
 
 		/* stop get_thread_data() from looking up beyond the
-- 
1.7.9
