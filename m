From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 2/9] connect.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:11 -0700
Message-ID: <01f78358696a7d9a6a45176018d1c5c72ba99a46.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:10:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrADc-0007HO-7Q
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaFASKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:10:50 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38399 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:10:49 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so2662196pdb.38
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=7J+22xcomh5jdZIURnno2ICBMz94ud0j4+zC7sQ+2CE=;
        b=T8pJO6tlBjLNlrFdcHXy4Ltom7rEAZblGYNLybVq7kW4QygevsHFSd/JB+NDs8x33L
         rwDGCS7Gj0PATqYMikC5C37e/BtFgK9RQuIfAkI+Gz4ipaGjZokAbHhCC5ipFoHmcqvC
         kWsu8MdQ4nwfEDxvczNIal5nH5Yrs0z2hW8HV9W5cugzj4d+yib3mHX0kCFtUDUfCjom
         hfi+K1EC4FrSUwRasYik5fmmZb2OOWtF3aTm5MvJNoM1gM2tKSfV9Fp+Kpp4TdW4AUGO
         1Axsx+hBXagkNPd7i965vCUs1LhghJlA5ykYW6BI1ChmMrFOmDPZFbC4UQUPNLT18kYu
         gkLA==
X-Received: by 10.68.200.133 with SMTP id js5mr35232072pbc.138.1401646248287;
        Sun, 01 Jun 2014 11:10:48 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id io6sm51701056pac.44.2014.06.01.11.10.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:10:47 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:10:44 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250535>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in connect.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 connect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index a983d06..1dc51b2 100644
--- a/connect.c
+++ b/connect.c
@@ -665,11 +665,14 @@ struct child_process *git_connect(int fd[2], cons=
t char *url,
 	enum protocol protocol;
 	const char **arg;
 	struct strbuf cmd =3D STRBUF_INIT;
+	struct sigaction sa;
=20
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
 	 */
-	signal(SIGCHLD, SIG_DFL);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_DFL;
+	sigaction(SIGCHLD, &sa, NULL);
=20
 	protocol =3D parse_connect_url(url, &hostandport, &path);
 	if (flags & CONNECT_DIAG_URL) {
--=20
2.0.0.8.g7bf6e1f.dirty
