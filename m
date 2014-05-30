From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 1/2] compat/mingw.c: expand MinGW support for sigaction
Date: Fri, 30 May 2014 13:58:16 -0700
Message-ID: <d5fc7d72b2d51d1b90fb7f238eff120cb4c6d0e7.1401482787.git.jmmahler@gmail.com>
References: <cover.1401482787.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 30 22:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTt7-0004bL-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934190AbaE3U6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2014 16:58:50 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38039 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748AbaE3U6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:58:49 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so2114803pbb.31
        for <git@vger.kernel.org>; Fri, 30 May 2014 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Hp9sl35QVfQoNnJo5Psiqm5soi57KMDXnOAonhtpA/c=;
        b=OrU2Jw1fQudgWAb6hf9AlQHi77ordGIeyfc56jynpN3ahrIHZn5Ev+Tj6Ye17ap7QX
         0KIPp5/WW46YdhRVk1WyU8f1lu7tigaJAKrNoXguQw9rMDHUtUEbNAnWtgA0OHMrh/lo
         6Nc3Nq7WCdJsMtPSAybHC8OjdUCUkJT7gJofK4XCzyoE8Y3FcgspSxM3OqgId60qWc5A
         24MNvbvKf9xTTao0WUydB+tx5Zv7B3XIE2LBhBRZ7jxSe4ewrRVBpZE9R8JcGvwhxBBs
         aLI9oQmXbPz1PO6Zd8FEYGw8RtY+08Pac4WQwp4G1tPCAbQCdnXdYDCsucjLT1NkL2s5
         kUUA==
X-Received: by 10.66.162.103 with SMTP id xz7mr22124986pab.104.1401483529010;
        Fri, 30 May 2014 13:58:49 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xc1sm23469105pab.39.2014.05.30.13.58.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 13:58:47 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Fri, 30 May 2014 13:58:44 -0700
X-Mailer: git-send-email 2.0.0.2.g1d11d5d
In-Reply-To: <cover.1401482787.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401482787.git.jmmahler@gmail.com>
References: <cover.1401482787.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250483>

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
2.0.0.2.g1d11d5d
