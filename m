From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 1/5] progress.c: replace signal() with sigaction()
Date: Tue, 27 May 2014 23:14:11 -0700
Message-ID: <1401257655-6043-2-git-send-email-jmmahler@gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 08:15:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpX8q-0007lt-1b
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 08:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbaE1GPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 02:15:03 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48226 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbaE1GPA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 02:15:00 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so10558337pbc.12
        for <git@vger.kernel.org>; Tue, 27 May 2014 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bd9tBpMmpIG95Iw3jL0XIXLyQAzew384lrRA5F8zwCM=;
        b=EFt4kqbaPTObRKQDswWLWTL4vNCjVVZ/b6hxbzUa819f2LlokLKbJXPv5ElTbfzhjd
         BwiJ7rZr/xLtFvhnhwcEeiLGbfDMhrFmTu8goFkhgP0H7YbYqPGZ5YYhJvhoeCKfN9Df
         0C3oJVDFoqNCCfa5s/IUj1rz7tgw4fnrcn2dTNTHcVWWCsh1+N0Jkuy+snUiP0MX6L2c
         shM1tQHuvUvVCuYL0ylSyA3WzaadzLWi4jSMn1KCVUUbnHqp0aa7bZ+WH+nH6WKNDqhZ
         fE3DhjAlcJs/FHe3Pp4LSC3KC/EIm7qN7yWEBQBB8vIkCtyrWxW7KsFvsChw5edpKArM
         CkPw==
X-Received: by 10.68.173.65 with SMTP id bi1mr43061192pbc.130.1401257699964;
        Tue, 27 May 2014 23:14:59 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bq4sm26447504pbb.60.2014.05.27.23.14.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 23:14:58 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 23:14:55 -0700
X-Mailer: git-send-email 2.0.0.rc4.6.g127602c
In-Reply-To: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250263>

=46rom signal(2)

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.  See Portability below.

Replaced signal() with sigaction() in progress.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 progress.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 261314e..24df263 100644
--- a/progress.c
+++ b/progress.c
@@ -66,8 +66,12 @@ static void set_progress_signal(void)
 static void clear_progress_signal(void)
 {
 	struct itimerval v =3D {{0,},};
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_IGN;
 	setitimer(ITIMER_REAL, &v, NULL);
-	signal(SIGALRM, SIG_IGN);
+	sigaction(SIGALRM, &sa, 0);
 	progress_update =3D 0;
 }
=20
--=20
2.0.0.rc4.6.g127602c
