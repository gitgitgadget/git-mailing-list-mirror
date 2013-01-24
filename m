From: =?UTF-8?q?S=C3=A9bastien=20Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
Subject: [PATCH] don't use timers if NO_SETITIMER is set
Date: Wed, 23 Jan 2013 20:38:18 -0500
Message-ID: <1358991498-14371-1-git-send-email-sebastien.boisvert@calculquebec.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 02:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyBn2-0003AD-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 02:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab3AXBjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 20:39:20 -0500
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:46219 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752531Ab3AXBjS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 20:39:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtoGAG6Zu09FpcD8/2dsb2JhbABEgXuDMq5kgQiCPw8BIx4FNQImAjs3iA6nDoQ6jkGBJo4KgRQDiEKVd4ZSgwc
X-IronPort-AV: E=Sophos;i="4.75,637,1330923600"; 
   d="scan'208";a="213429102"
Received: from 69-165-192-252.cable.teksavvy.com (HELO localhost.localdomain) ([69.165.192.252])
  by ironport2-out.teksavvy.com with ESMTP; 23 Jan 2013 20:39:17 -0500
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214386>

With NO_SETITIMER, the user experience on legacy Lustre is fixed,
but there is no early progress.

The patch has no effect on the resulting git executable if NO_SETITIMER=
 is
not set (the default). So by default this patch has no effect at all, w=
hich
is good.

git tests:

$ make clean
$ make NO_SETITIMER=3DYesPlease
$ make test NO_SETITIMER=3DYesPlease &> make-test.log

$ grep "^not ok" make-test.log |grep -v "# TODO known breakage"|wc -l
0
$ grep "^ok" make-test.log |wc -l
9531
$ grep "^not ok" make-test.log |wc -l
65

No timers with NO_SETITIMER:

$ objdump -d ./git|grep setitimer|wc -l
0
$ objdump -d ./git|grep alarm|wc -l
0

Timers without NO_SETITIMER:

$ objdump -d /software/apps/git/1.8.1/bin/git|grep setitimer|wc -l
5
$ objdump -d /software/apps/git/1.8.1/bin/git|grep alarm|wc -l
0

Signed-off-by: S=C3=A9bastien Boisvert <sebastien.boisvert@calculquebec=
=2Eca>
---
 builtin/log.c |    7 +++++++
 daemon.c      |    6 ++++++
 progress.c    |    8 ++++++++
 upload-pack.c |    2 ++
 4 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..f8321c7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -198,7 +198,9 @@ static void show_early_header(struct rev_info *rev,=
 const char *stage, int nr)
 	printf(_("Final output: %d %s\n"), nr, stage);
 }
=20
+#ifndef NO_SETITIMER
 static struct itimerval early_output_timer;
+#endif
=20
 static void log_show_early(struct rev_info *revs, struct commit_list *=
list)
 {
@@ -240,9 +242,12 @@ static void log_show_early(struct rev_info *revs, =
struct commit_list *list)
 	 * trigger every second even if we're blocked on a
 	 * reader!
 	 */
+
+	#ifndef NO_SETITIMER
 	early_output_timer.it_value.tv_sec =3D 0;
 	early_output_timer.it_value.tv_usec =3D 500000;
 	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	#endif
 }
=20
 static void early_output(int signal)
@@ -274,9 +279,11 @@ static void setup_early_output(struct rev_info *re=
v)
 	 *
 	 * This is a one-time-only trigger.
 	 */
+	#ifndef NO_SETITIMER
 	early_output_timer.it_value.tv_sec =3D 0;
 	early_output_timer.it_value.tv_usec =3D 100000;
 	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	#endif
 }
=20
 static void finish_early_output(struct rev_info *rev)
diff --git a/daemon.c b/daemon.c
index 4602b46..eb82c19 100644
--- a/daemon.c
+++ b/daemon.c
@@ -611,9 +611,15 @@ static int execute(void)
 	if (addr)
 		loginfo("Connection from %s:%s", addr, port);
=20
+	#ifndef NO_SETITIMER
 	alarm(init_timeout ? init_timeout : timeout);
+	#endif
+
 	pktlen =3D packet_read_line(0, line, sizeof(line));
+
+	#ifndef NO_SETITIMER
 	alarm(0);
+	#endif
=20
 	len =3D strlen(line);
 	if (pktlen !=3D len)
diff --git a/progress.c b/progress.c
index 3971f49..b84ccc7 100644
--- a/progress.c
+++ b/progress.c
@@ -45,7 +45,10 @@ static void progress_interval(int signum)
 static void set_progress_signal(void)
 {
 	struct sigaction sa;
+
+	#ifndef NO_SETITIMER
 	struct itimerval v;
+	#endif
=20
 	progress_update =3D 0;
=20
@@ -55,16 +58,21 @@ static void set_progress_signal(void)
 	sa.sa_flags =3D SA_RESTART;
 	sigaction(SIGALRM, &sa, NULL);
=20
+	#ifndef NO_SETITIMER
 	v.it_interval.tv_sec =3D 1;
 	v.it_interval.tv_usec =3D 0;
 	v.it_value =3D v.it_interval;
 	setitimer(ITIMER_REAL, &v, NULL);
+	#endif
 }
=20
 static void clear_progress_signal(void)
 {
+	#ifndef NO_SETITIMER
 	struct itimerval v =3D {{0,},};
 	setitimer(ITIMER_REAL, &v, NULL);
+	#endif
+
 	signal(SIGALRM, SIG_IGN);
 	progress_update =3D 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index 95d8313..e0b8b32 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -47,7 +47,9 @@ static int stateless_rpc;
=20
 static void reset_timeout(void)
 {
+	#ifndef NO_SETITIMER
 	alarm(timeout);
+	#endif
 }
=20
 static int strip(char *line, int len)
--=20
1.7.4.1
