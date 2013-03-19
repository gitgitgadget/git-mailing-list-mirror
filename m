From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: protect deepest_delta in multithread code
Date: Tue, 19 Mar 2013 20:01:15 +0700
Message-ID: <1363698075-12452-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8DgQZFewPjLSXSkdHHWqhQDqExoVq-pBGpKr1G8w06uvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Stefan Zager <szager@google.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 19 14:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHwB0-00035N-Ru
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 14:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab3CSNBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 09:01:36 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:59306 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab3CSNBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 09:01:35 -0400
Received: by mail-pd0-f175.google.com with SMTP id r11so170912pdi.20
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RJaYCIypDsauJjm08HfPyEKrbG/55u6t2NwfW8YVVRQ=;
        b=f/piyYPk2fRLGgyq/QtSvAMelqb/mVQ6nPpIHfEmVExXuUZxm5IfFyUIRqLfHKIwYS
         kO8tLW5ME3nZMqEKGJZwChk1j7+2N7hBzhcJXMWcScNEZNUXiLzSNOkXXl56gYvUuN2X
         IAKMp2RA5xBZcBzSYlGJk0Lpuxl5zYd4b06a51ybk5SP2HctGYugi4SG2RO4UoC+GIJj
         vSut1eJXLSOhG7ifg7Gy/piq9/Uh35upkucMNXMVYH1r0aIYQhf5uLazcClwAg4Wo4w7
         RErrmwrAOOEj7APQmyXAbPyV4rMlgdst59YOEGtO3pUfHnXoVAPqd0brcgLThF0dlN/N
         WFsQ==
X-Received: by 10.66.162.195 with SMTP id yc3mr3209601pab.11.1363698094661;
        Tue, 19 Mar 2013 06:01:34 -0700 (PDT)
Received: from lanh ([115.74.58.36])
        by mx.google.com with ESMTPS id ky17sm12587917pab.23.2013.03.19.06.01.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 06:01:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 19 Mar 2013 20:01:25 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <CACsJy8DgQZFewPjLSXSkdHHWqhQDqExoVq-pBGpKr1G8w06uvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218510>

deepest_delta is a global variable but is updated without protection
in resolve_delta(), a multithreaded function. Add a new mutex for it,
but only protect and update when it's actually used (i.e. show_stat is
non-zero).

Another variable that will not be updated is delta_depth in "struct
object_entry" as it's only useful when show_stat is 1. Putting it in
"if (show_stat)" makes it clearer.

The local variable "stat" is renamed to "show_stat" after moving to
global scope because the name "stat" conflicts with stat(2) syscall.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 43d364b..9cfd6e7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -78,6 +78,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int verbose;
+static int show_stat;
=20
 static struct progress *progress;
=20
@@ -108,6 +109,10 @@ static pthread_mutex_t work_mutex;
 #define work_lock()		lock_mutex(&work_mutex)
 #define work_unlock()		unlock_mutex(&work_mutex)
=20
+static pthread_mutex_t deepest_delta_mutex;
+#define deepest_delta_lock()	lock_mutex(&deepest_delta_mutex)
+#define deepest_delta_unlock()	unlock_mutex(&deepest_delta_mutex)
+
 static pthread_key_t key;
=20
 static inline void lock_mutex(pthread_mutex_t *mutex)
@@ -130,6 +135,8 @@ static void init_thread(void)
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
+	if (show_stat)
+		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
 	thread_data =3D xcalloc(nr_threads, sizeof(*thread_data));
 	threads_active =3D 1;
@@ -143,6 +150,8 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
+	if (show_stat)
+		pthread_mutex_destroy(&deepest_delta_mutex);
 	pthread_key_delete(key);
 	free(thread_data);
 }
@@ -158,6 +167,9 @@ static void cleanup_thread(void)
 #define work_lock()
 #define work_unlock()
=20
+#define deepest_delta_lock()
+#define deepest_delta_unlock()
+
 #endif
=20
=20
@@ -833,9 +845,13 @@ static void resolve_delta(struct object_entry *del=
ta_obj,
 	void *base_data, *delta_data;
=20
 	delta_obj->real_type =3D base->obj->real_type;
-	delta_obj->delta_depth =3D base->obj->delta_depth + 1;
-	if (deepest_delta < delta_obj->delta_depth)
-		deepest_delta =3D delta_obj->delta_depth;
+	if (show_stat) {
+		delta_obj->delta_depth =3D base->obj->delta_depth + 1;
+		deepest_delta_lock();
+		if (deepest_delta < delta_obj->delta_depth)
+			deepest_delta =3D delta_obj->delta_depth;
+		deepest_delta_unlock();
+	}
 	delta_obj->base_object_no =3D base->obj - objects;
 	delta_data =3D get_data_from_pack(delta_obj);
 	base_data =3D get_base_data(base);
@@ -1462,7 +1478,7 @@ static void show_pack_info(int stat_only)
=20
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0, stat =3D 0=
;
+	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0;
 	const char *curr_pack, *curr_index;
 	const char *index_name =3D NULL, *pack_name =3D NULL;
 	const char *keep_name =3D NULL, *keep_msg =3D NULL;
@@ -1495,10 +1511,10 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 				verify =3D 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
 				verify =3D 1;
-				stat =3D 1;
+				show_stat =3D 1;
 			} else if (!strcmp(arg, "--verify-stat-only")) {
 				verify =3D 1;
-				stat =3D 1;
+				show_stat =3D 1;
 				stat_only =3D 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg =3D "";
@@ -1606,7 +1622,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	if (strict)
 		check_objects();
=20
-	if (stat)
+	if (show_stat)
 		show_pack_info(stat_only);
=20
 	idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_entry *=
));
--=20
1.8.2.83.gc99314b
