From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 1/9] compat/mingw.c: expand MinGW support for sigaction
Date: Sun,  1 Jun 2014 11:10:10 -0700
Message-ID: <d5fc7d72b2d51d1b90fb7f238eff120cb4c6d0e7.1401645403.git.jmmahler@gmail.com>
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
	id 1WrADb-0007HO-N7
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbaFASKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:10:45 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:38306 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbaFASKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:10:44 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so3450752pbc.16
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=IN9GBEcmntAb2Nj6S7HOD0hN6OZVvuipwLYuc2EuYOo=;
        b=hu/VKabOZ49Y52Uv0qyFh3xfXjWNuYOhvR0o6cmHShDvhVjHG79YOdUW+hfjON9ODU
         umWbUiA5HrHs0kwPE+XCFGrAEbHZwRzPKTSsvc6zak9V895sBufOaUp8el8cNPbqy7qb
         QUlY3E+bP+LoZWVYzlmsjpPi2htwmLQzmMUEo4vsFE/m+J7GQTHXsRU1uxFaYKLc5xmK
         k/oxJbTKMHfUlC+vBNXLa/O90q5AV+F+cybXmQv6JIo4ZzBY0ZA+eGqcoqBllZYEOFrO
         YYMv9BALu/Wl5qFYvGFZRk1XCG+7ziuL8c4eP2ymGPs0FJkvlb0nTjf6a8V/hGwZc53k
         gNCQ==
X-Received: by 10.68.163.197 with SMTP id yk5mr34788870pbb.57.1401646244191;
        Sun, 01 Jun 2014 11:10:44 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id su8sm16469138pbc.72.2014.06.01.11.10.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:10:43 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:10:40 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250534>

Due to portability issues across UNIX versions sigaction(2) should be u=
sed
instead of signal(2).

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Unfortunately MinGW under Windows has limited support for signal and no
support for sigaction.  And this prevents sigaction from being used acr=
oss
the entire Git project.

In compat/mingw.c there is a faux sigaction function but it only suppor=
ts
SIGALARM.  Hence the need for continuing to use signal() in other cases=
=2E

This patch expands the faux sigaction function so that it calls signal =
in
cases other than SIGALRM.  Now sigaction can be used across the entire =
Git
project and MinGW will still work with signal as it did before.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 compat/mingw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e9892f8..e504cef 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1651,14 +1651,15 @@ int setitimer(int type, struct itimerval *in, s=
truct itimerval *out)
=20
 int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 {
-	if (sig !=3D SIGALRM)
-		return errno =3D EINVAL,
-			error("sigaction only implemented for SIGALRM");
 	if (out !=3D NULL)
 		return errno =3D EINVAL,
 			error("sigaction: param 3 !=3D NULL not implemented");
=20
-	timer_fn =3D in->sa_handler;
+	if (sig =3D=3D SIGALRM)
+		timer_fn =3D in->sa_handler;
+	else
+		signal(sig, in->sa_handler);
+
 	return 0;
 }
=20
--=20
2.0.0.8.g7bf6e1f.dirty
