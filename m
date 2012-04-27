From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: avoid false sharing on multicore systems
Date: Fri, 27 Apr 2012 23:52:41 +0700
Message-ID: <1335545561-933-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 18:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNoSq-0004K0-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 18:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760779Ab2D0Q4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Apr 2012 12:56:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56161 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab2D0Q4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 12:56:04 -0400
Received: by obbta14 with SMTP id ta14so1277872obb.19
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bQWnMQgzyfKxnH+558Cydm/qLLB1yEaqUYRvRtBqb9E=;
        b=w1VG+G8fGl1hjIEmkJxsuK7gczxurQH7P1dQWLEEUfyPhFaNtup//oMAVjp3lAhvBm
         0Hssp4qBwmPLhDmuXYM44raf1BSf92GRn3KZlj2KnJX8sTJ99enokcDZllfiPFtl+Gw8
         VXuiqNsroJYRqQqLEkQv9lWyj/7MyZRE01OA+SmVWuojmnV6fp5kl2tEKC3JCdoD7cM0
         BQiDfwImkQ2n8oBeJcGqUW26Mi+9rAIJdWbH+5w3kPFO2T9sZmg06miGPZ74R9vqs6yY
         0mNl02aZ85lbFGnShF8yrokMnN+odyUNcLdtooCKfXXbR9OTJK3kjTNwUNnHs8/cg3cd
         7rbA==
Received: by 10.182.179.68 with SMTP id de4mr15577270obc.13.1335545764348;
        Fri, 27 Apr 2012 09:56:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.58.219])
        by mx.google.com with ESMTPS id xb7sm7719833obb.10.2012.04.27.09.56.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 09:56:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 27 Apr 2012 23:52:43 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196480>

thread_data[] is frequently accessed by all threads and it's
packed tight. If two threads running on two different processors,
updating one "struct thread_local" may invalidate the cache line that
also contains struct thread_local of the other thread, leading to
cache misses (aka false sharing [1])

Pad it properly. Make sure each "struct thread_local" is on a separate
cache line.

This only works with real processors though. Multithread on single
processor may be harmed by this change. Keep the tight layout in that
case.

[1] http://software.intel.com/en-us/articles/avoiding-and-identifying-f=
alse-sharing-among-threads/

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 My laptop has one physical core with hyperthread, so this patch does
 no good for me. I won't have access to a multicore system until the
 middle of next week, so I'm not sure if it actually helps at the
 moment.

 builtin/index-pack.c |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c1c3c81..598b18e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -93,7 +93,8 @@ static int input_fd, output_fd, pack_fd;
=20
 #ifndef NO_PTHREADS
=20
-static struct thread_local *thread_data;
+static struct thread_local **thread_data;
+static char *thread_data_buffer;
=20
 static pthread_mutex_t read_mutex;
 #define read_lock()		lock_mutex(&read_mutex)
@@ -126,11 +127,38 @@ static inline void unlock_mutex(pthread_mutex_t *=
mutex)
  */
 static void init_thread(void)
 {
+	int i, stripe;
+
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
 	pthread_key_create(&key, NULL);
 	thread_data =3D xcalloc(nr_threads, sizeof(*thread_data));
+
+
+	if (online_cpus() && !getenv("GIT_ONE_CPU_CORE")) {
+		/*
+		 * A typical cache line is 64 byte long. Avoid false
+		 * sharing by putting thread data of each thread on a
+		 * separate cache line
+		 */
+		stripe =3D 64;
+		assert(sizeof(struct thread_local) <=3D stripe);
+		thread_data_buffer =3D xmalloc((nr_threads + 1) * stripe);
+#define ALIGN(x, stripe) (((x) + (stripe) - 1) & ~((stripe) - 1))
+		thread_data[0] =3D (struct thread_local *)ALIGN((unsigned int)thread=
_data_buffer, stripe);
+	} else {
+		/*
+		 * On the other hand, on single physical cpu, padding
+		 * wastes cache for nothing. Don't do it.
+		 */
+		stripe =3D sizeof(struct thread_local);
+		thread_data_buffer =3D xmalloc(nr_threads * stripe);
+		thread_data[0] =3D (struct thread_local *)thread_data_buffer;
+	}
+	memset(thread_data[0], 0, stripe * nr_threads);
+	for (i =3D 1; i < nr_threads; i++)
+		thread_data[i] =3D (struct thread_local*)((char*)(thread_data[0]) + =
i * stripe);
 	threads_active =3D 1;
 }
=20
@@ -143,6 +171,7 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
 	pthread_key_delete(key);
+	free(thread_data_buffer);
 	free(thread_data);
 }
=20
@@ -890,13 +919,13 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
 		for (i =3D 0; i < nr_threads; i++) {
-			int ret =3D pthread_create(&thread_data[i].thread, NULL,
-						 threaded_second_pass, thread_data + i);
+			int ret =3D pthread_create(&thread_data[i]->thread, NULL,
+						 threaded_second_pass, thread_data[i]);
 			if (ret)
 				die("unable to create thread: %s", strerror(ret));
 		}
 		for (i =3D 0; i < nr_threads; i++)
-			pthread_join(thread_data[i].thread, NULL);
+			pthread_join(thread_data[i]->thread, NULL);
=20
 		cleanup_thread();
 		return;
--=20
1.7.8.36.g69ee2
