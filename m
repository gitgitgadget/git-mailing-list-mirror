From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 5/9] daemon.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:14 -0700
Message-ID: <77e2c9ce430a7682371ab76d151aab25201c68dd.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:11:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrADs-0007Tc-Ba
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbaFASLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:11:04 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:51759 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:11:01 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so2662289pdb.38
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=xUBP5EmIxjb8JVsUTKECsmsSbIf4QBoBXlallOP/mtk=;
        b=BSYsluYj2tVv78OQF9is0myraHIu4thtGAau+EPz3H6dil2MqOGxGEJdU6EeQ1vYT3
         D7foLjEoqIJFpagfHV4ypTnM166J6GddECEytrEQf8EYyNYOQpc7ypTCbf8vjb78EnSJ
         NtLCkyI8BSvwx2v4Np3AGDXklLPv1V3FGHvL6TEConuJNGiF+iZbVjUp842AAIE7C4f4
         2AjwBOKF59nGTJeM6BQcpljQwafPJo2bwVLyS351WZZcDExiqTCa1yzJCL5SQ93R14nS
         /nYEmNMm9F4Uj7A5/pt1zi2fuNMrXLaq08C1wA9hNt0pvsyS/2e9C2rlPjYUV6CbaoFS
         2OWw==
X-Received: by 10.68.242.135 with SMTP id wq7mr34792833pbc.147.1401646261644;
        Sun, 01 Jun 2014 11:11:01 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id gz11sm16531424pbd.1.2014.06.01.11.10.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:11:00 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:10:57 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250538>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in daemon.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 daemon.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index eba1255..615426e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -322,6 +322,7 @@ static int run_service(char *dir, struct daemon_ser=
vice *service)
 {
 	const char *path;
 	int enabled =3D service->enabled;
+	struct sigaction sa;
=20
 	loginfo("Request %s for '%s'", service->name, dir);
=20
@@ -376,7 +377,9 @@ static int run_service(char *dir, struct daemon_ser=
vice *service)
 	 * We'll ignore SIGTERM from now on, we have a
 	 * good client.
 	 */
-	signal(SIGTERM, SIG_IGN);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_IGN;
+	sigaction(SIGTERM, &sa, NULL);
=20
 	return service->fn();
 }
@@ -788,12 +791,16 @@ static void handle(int incoming, struct sockaddr =
*addr, socklen_t addrlen)
=20
 static void child_handler(int signo)
 {
+	struct sigaction sa;
+
 	/*
 	 * Otherwise empty handler because systemcalls will get interrupted
 	 * upon signal receipt
 	 * SysV needs the handler to be rearmed
 	 */
-	signal(SIGCHLD, child_handler);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D child_handler;
+	sigaction(SIGCHLD, &sa, NULL);
 }
=20
 static int set_reuse_addr(int sockfd)
@@ -996,6 +1003,7 @@ static int service_loop(struct socketlist *socklis=
t)
 {
 	struct pollfd *pfd;
 	int i;
+	struct sigaction sa;
=20
 	pfd =3D xcalloc(socklist->nr, sizeof(struct pollfd));
=20
@@ -1004,7 +1012,9 @@ static int service_loop(struct socketlist *sockli=
st)
 		pfd[i].events =3D POLLIN;
 	}
=20
-	signal(SIGCHLD, child_handler);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D child_handler;
+	sigaction(SIGCHLD, &sa, NULL);
=20
 	for (;;) {
 		int i;
--=20
2.0.0.8.g7bf6e1f.dirty
