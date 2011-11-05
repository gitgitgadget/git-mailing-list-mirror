From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] grep: detect number of CPUs for thread spawning
Date: Sat,  5 Nov 2011 14:16:08 +0000
Message-ID: <1320502568-14085-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 15:18:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMh4W-0004oI-9i
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 15:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab1KEOQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 10:16:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58213 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab1KEOQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 10:16:20 -0400
Received: by faao14 with SMTP id o14so3579702faa.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0n3q5NZyqUukb7NpryhZ89/m/qKL0VJNP9RG8bWO7WQ=;
        b=CEZ7JgWoWC7wg20DCa8ClUCKxhK0O8c/LHnzvwnJ5+sChVhb6cFSZYWuOgcY4NzHF8
         5Yp5a/btjW3E/NI+LH1CJIsJyh2rbdzICCKy1546/AqivASTrr2reyWFJjmu0FikhMcH
         awrjFi/ToGufVqie/Ag5+Mdahe9G6G3wbOcos=
Received: by 10.223.6.15 with SMTP id 15mr32253117fax.4.1320502579621;
        Sat, 05 Nov 2011 07:16:19 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id x19sm21864368fag.5.2011.11.05.07.16.18
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 07:16:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184849>

=46rom: Eric Herman <eric@freesa.org>

Change the number of threads that we spawn from a hardcoded value of
"8" to what online_cpus() returns.

Back in v1.7.0-rc1~19^2 when threaded grep was introduced the number
of threads was hardcoded at compile time to 8, but this value was only
used if online_cpus() returned greater than 1.

However just using 8 threads regardless of the actual number of CPUs
is inefficient if we have more than 8 CPUs, and potentially wasteful
if we have fewer than 8 CPUs.

The array holding the threads is now being allocated at runtime
instead of being allocated statically. We free the array further down
the line in the wait_all() function; this is OK since the allocation
and freeing is guarded by the global "use_threads" variable, which is
based on the return value of online_cpus().

Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
Signed-off-by: Eric Herman <eric@freesa.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/grep.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3d7329d..307a253 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -27,8 +27,8 @@ static char const * const grep_usage[] =3D {
 static int use_threads =3D 1;
=20
 #ifndef NO_PTHREADS
-#define THREADS 8
-static pthread_t threads[THREADS];
+static int nthreads;
+static pthread_t *threads;
=20
 static void *load_sha1(const unsigned char *sha1, unsigned long *size,
 		       const char *name);
@@ -36,7 +36,7 @@ static void *load_file(const char *filename, size_t *=
sz);
=20
 enum work_type {WORK_SHA1, WORK_FILE};
=20
-/* We use one producer thread and THREADS consumer
+/* We use one producer thread and online_cpus() consumer
  * threads. The producer adds struct work_items to 'todo' and the
  * consumers pick work items from the same array.
  */
@@ -254,6 +254,8 @@ static void start_threads(struct grep_opt *opt)
 {
 	int i;
=20
+	threads =3D xmalloc(nthreads * sizeof(pthread_t));
+
 	pthread_mutex_init(&grep_mutex, NULL);
 	pthread_mutex_init(&read_sha1_mutex, NULL);
 	pthread_cond_init(&cond_add, NULL);
@@ -264,7 +266,7 @@ static void start_threads(struct grep_opt *opt)
 		strbuf_init(&todo[i].out, 0);
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(threads); i++) {
+	for (i =3D 0; i < nthreads; i++) {
 		int err;
 		struct grep_opt *o =3D grep_opt_dup(opt);
 		o->output =3D strbuf_out;
@@ -295,7 +297,7 @@ static int wait_all(void)
 	pthread_cond_broadcast(&cond_add);
 	grep_unlock();
=20
-	for (i =3D 0; i < ARRAY_SIZE(threads); i++) {
+	for (i =3D 0; i < nthreads; i++) {
 		void *h;
 		pthread_join(threads[i], &h);
 		hit |=3D (int) (intptr_t) h;
@@ -307,6 +309,8 @@ static int wait_all(void)
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
=20
+	free(threads);
+
 	return hit;
 }
 #else /* !NO_PTHREADS */
@@ -1001,7 +1005,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		opt.regflags |=3D REG_ICASE;
=20
 #ifndef NO_PTHREADS
-	if (online_cpus() =3D=3D 1 || !grep_threads_ok(&opt))
+	nthreads =3D online_cpus();
+	if (nthreads =3D=3D 1 || !grep_threads_ok(&opt))
 		use_threads =3D 0;
=20
 	if (use_threads) {
--=20
1.7.7
