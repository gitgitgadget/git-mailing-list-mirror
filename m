From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 3/9] progress.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:12 -0700
Message-ID: <87574ab0b6951616ab8ce78c8d9da1b5f0a3fddc.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:11:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrADi-0007MT-VX
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbaFASKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:10:54 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33860 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:10:53 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so2673409pde.28
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=XyagvOoGAwOevaXqKilg+EKf9KwIi7SL8v1lZAQwj3Y=;
        b=t8SPMnIFJhZvBvWDr4VFuYtz/Bd4mG0Vxx1DaaJeWV8xKz2bA2LFz0H3YjiV+Bto1V
         F83rDwC1uaqlO99W/fmshFAs+pH95ftSITAlDSlz8sKqLDs5ulKa8t1jCD7U1ePRNApi
         83FmoK3vZG4pcs+/XYUxPn2nL9qRsqHvtLM/p7CPBODsciFL1WWQPxXpsQ/fZLPauvJe
         PLVRvyHAuUqJ84Qy6aQDlgnsJo2FkZRs6hpFlndAVB0DsoLy9wiG/6YNm6Db0Z+K0zdO
         kbZ1QwIxDDefYCw8BhKLG22fjtoas8nzMMXhqjai9tLu1H1/DaQYPNUfswo4vzna+MW3
         yVJA==
X-Received: by 10.66.66.72 with SMTP id d8mr35481947pat.8.1401646252750;
        Sun, 01 Jun 2014 11:10:52 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bi15sm51739096pac.31.2014.06.01.11.10.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:10:51 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:10:48 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250537>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in progress.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 progress.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 261314e..ff676bc 100644
--- a/progress.c
+++ b/progress.c
@@ -66,8 +66,12 @@ static void set_progress_signal(void)
 static void clear_progress_signal(void)
 {
 	struct itimerval v =3D {{0,},};
+	struct sigaction sa;
+
 	setitimer(ITIMER_REAL, &v, NULL);
-	signal(SIGALRM, SIG_IGN);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_IGN;
+	sigaction(SIGALRM, &sa, NULL);
 	progress_update =3D 0;
 }
=20
--=20
2.0.0.8.g7bf6e1f.dirty
