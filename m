From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 2/5] daemon.c run_service(): replace signal() with sigaction()
Date: Tue, 27 May 2014 23:14:12 -0700
Message-ID: <1401257655-6043-3-git-send-email-jmmahler@gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 08:15:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpX8y-00081V-6r
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 08:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbaE1GPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 02:15:13 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:58659 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbaE1GPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 02:15:08 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so10558221pbc.23
        for <git@vger.kernel.org>; Tue, 27 May 2014 23:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=40ZEqL9qI/H6elgQ54rTqJeNE3/SLZiOxNaPkxvfEa4=;
        b=hn/5YqJgq6G8JYX6uzRGi9/mhbgtoOXwP8dWp8Nd02I+Kd3mdmkmDsWEsoqUYhKp6O
         ChVKjkHnlpddaRTo9pPIN7ZE2N31QZvWz4lqJzZmynX7FUUslQLaiM4eOnM+kfnxvRDH
         0ZEopMvUwcbOLwEUZGGX/MtAAHzP7rya+GXfaw6bKbMh7lZt1HX7BYxcoVCBbO7wm9bE
         t9UX6PIbny3quMKaEAIyuboqwWO3Fey++pSwZ7p9DyluHF3w52eOg2gLjrYXHZ3dkD53
         7I3TLQ/KS8/kTlpy63RnnjkVx81egpAE4w8A0xv8wGka4uKTPGzInzkNGeSxUgha7lPO
         n6QA==
X-Received: by 10.67.14.69 with SMTP id fe5mr44159289pad.120.1401257708555;
        Tue, 27 May 2014 23:15:08 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id vm3sm26459455pbc.45.2014.05.27.23.15.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 23:15:07 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 23:15:04 -0700
X-Mailer: git-send-email 2.0.0.rc4.6.g127602c
In-Reply-To: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250264>

=46rom signal(2)

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.  See Portability below.

Replaced signal() with sigaction() in daemon.c run_service()

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 daemon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index eba1255..78c4a1c 100644
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
+	sigaction(SIGTERM, &sa, 0);
=20
 	return service->fn();
 }
--=20
2.0.0.rc4.6.g127602c
