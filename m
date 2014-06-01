From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 9/9] sigchain.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:18 -0700
Message-ID: <06d9d4d29fc7ada8d6f4f3f1f1e3e2a764ba7c67.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:11:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrAE9-0007dx-SA
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbaFASLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:11:20 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:42127 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:11:18 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx10so3453997pab.28
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=7Kr3uSPXnRrGIGc/APq2VRvkvczFnO05uXfoFmYHkbc=;
        b=X0surFBx1eO4KuYI+kmcgCajzpiKhyZ++pTHtydCgvFertdWIOrnYQbERTGJqsxQgG
         YqIDxE9A095oQ4DKFT+KTKzGHhG7R5OR3GF59F2VQaX5TiYeJIy+XQKHEIghDz5RVVQv
         Nl/5OfAAhI/HDiClD33cR38a5LUkvi9xDYe2JzB3r2ZRv9Oie0dxHwrK8mm5d84rtkFZ
         gc2bLvjR6Qw+h+Siyu82Zavm3tpYqA+Y71LyHcAvSqtyGlky5JzUS2rMllYCSqn1sbcZ
         2+z/8M9zaXqgLglTPqchuri9ueAjDVNA+we2uMTe2JE9xv37WY5p9KhXGfkZbrkPRQ4T
         R+lQ==
X-Received: by 10.68.237.228 with SMTP id vf4mr34920383pbc.131.1401646278165;
        Sun, 01 Jun 2014 11:11:18 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id cj1sm51717030pac.40.2014.06.01.11.11.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:11:17 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:11:14 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250542>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in sigchain.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 sigchain.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sigchain.c b/sigchain.c
index 1118b99..deab262 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -19,11 +19,16 @@ static void check_signum(int sig)
 int sigchain_push(int sig, sigchain_fun f)
 {
 	struct sigchain_signal *s =3D signals + sig;
+	struct sigaction sa, sa_old;
+	int result;
 	check_signum(sig);
=20
 	ALLOC_GROW(s->old, s->n + 1, s->alloc);
-	s->old[s->n] =3D signal(sig, f);
-	if (s->old[s->n] =3D=3D SIG_ERR)
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D f;
+	result =3D sigaction(sig, &sa, &sa_old);
+	s->old[s->n] =3D sa_old.sa_handler;
+	if (result =3D=3D -1)
 		return -1;
 	s->n++;
 	return 0;
@@ -32,11 +37,14 @@ int sigchain_push(int sig, sigchain_fun f)
 int sigchain_pop(int sig)
 {
 	struct sigchain_signal *s =3D signals + sig;
+	struct sigaction sa, sa_old;
 	check_signum(sig);
 	if (s->n < 1)
 		return 0;
=20
-	if (signal(sig, s->old[s->n - 1]) =3D=3D SIG_ERR)
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D s->old[s->n - 1];
+	if (sigaction(sig, &sa, &sa_old) =3D=3D -1)
 		return -1;
 	s->n--;
 	return 0;
--=20
2.0.0.8.g7bf6e1f.dirty
