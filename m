From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 4/5] daemon.c service_loop(): replace signal() with sigaction()
Date: Tue, 27 May 2014 23:14:14 -0700
Message-ID: <1401257655-6043-5-git-send-email-jmmahler@gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 08:15:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpX94-0008Do-88
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 08:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbaE1GPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 02:15:19 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:52247 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbaE1GPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 02:15:17 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so10539734pbc.16
        for <git@vger.kernel.org>; Tue, 27 May 2014 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/JnZ1bWbxd1UqqMMODyPspr5LrU8WOO9X2g97upxngQ=;
        b=zGJfQENcHg+rciixqN4G1MU+APV0Ki0QUTLRsK2s4L3m2cq/jYKVFwz3YfVnfgIr8/
         3B0zHOSJOVe4lUyJWngnVh9SWWMNk80vDVI72ItKO6kM+KpM7j96yrNOVoB8hsLDQTVB
         rsdCkhzg8DPIba6dr6+bsTkAQVFh0HoD62UY15iRrXDkJ6bMpW0sSJMNSRveFhajLmhu
         ycDdwjzGm4mbiwRA26EB1tV4HEU7+L3V3bCVybSsQFqslbEy/TVM7RFvS8/R+NfPk+WP
         WSQy+0/NJRXNTEDOD1g/XDq0j99gjuA184GmKFXLXXEHHgSPQRiruu/SSNmAAsoOwLDk
         pULQ==
X-Received: by 10.68.133.229 with SMTP id pf5mr43714838pbb.115.1401257717465;
        Tue, 27 May 2014 23:15:17 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bs17sm83839783pac.28.2014.05.27.23.15.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 23:15:16 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 23:15:12 -0700
X-Mailer: git-send-email 2.0.0.rc4.6.g127602c
In-Reply-To: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250265>

=46rom signal(2)

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.  See Portability below.

Replaced signal() with sigaction() in daemon.c service_loop()

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 daemon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 3c48dc0..8c28b3d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1002,6 +1002,7 @@ static int service_loop(struct socketlist *sockli=
st)
 {
 	struct pollfd *pfd;
 	int i;
+	struct sigaction sa;
=20
 	pfd =3D xcalloc(socklist->nr, sizeof(struct pollfd));
=20
@@ -1010,7 +1011,9 @@ static int service_loop(struct socketlist *sockli=
st)
 		pfd[i].events =3D POLLIN;
 	}
=20
-	signal(SIGCHLD, child_handler);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D child_handler;
+	sigaction(SIGCHLD, &sa, 0);
=20
 	for (;;) {
 		int i;
--=20
2.0.0.rc4.6.g127602c
