From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 3/5] daemon.c child_handler(): replace signal() with sigaction()
Date: Tue, 27 May 2014 23:14:13 -0700
Message-ID: <1401257655-6043-4-git-send-email-jmmahler@gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 08:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpX93-0008Do-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 08:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaE1GPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 02:15:16 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:33297 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbaE1GPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 02:15:13 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so10609301pbc.38
        for <git@vger.kernel.org>; Tue, 27 May 2014 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xubNy9JQqyZW920wXkm5U/UUe5Lub5TfVcL3/TVqeYM=;
        b=Bn73BlCNy0kVm3NE9VsAyWyhUo8ZDxhou2pKvvYsKJHE+xwShQ47wm7Yq9oZJwdtVz
         1huTDLM+v/bmrkda0+hWDS8fVlkn/OlX+Wazu1McVjKuXF4XGf3oJLxE9ASJI6r2V8lW
         dyaR5uM9/g5KQn4eKcH4fJRq/4SUKeFSgNh2Vz+b2lBq0HP+siynEGqlZQI0i6t0gtSC
         /LhrVmYWWVyajiPihvi6AXnbGfZQgXhOHOx/qXcRUpPq2j7VT0TvAO9YrqJ0i/X2wKue
         0SVAeCOnWPbv54GYCiRO2BZ2Lbjw2vvbzfNqbxP6i4pD+st/koP4EFsEUK0uj1GaiSVL
         vmTw==
X-Received: by 10.66.161.69 with SMTP id xq5mr42615351pab.62.1401257712825;
        Tue, 27 May 2014 23:15:12 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ak1sm26449563pbc.58.2014.05.27.23.15.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 23:15:11 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 23:15:08 -0700
X-Mailer: git-send-email 2.0.0.rc4.6.g127602c
In-Reply-To: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250266>

=46rom signal(2)

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.  See Portability below.

Replaced signal() with sigaction() in daemon.c child_handler()

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 daemon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 78c4a1c..3c48dc0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -791,12 +791,15 @@ static void handle(int incoming, struct sockaddr =
*addr, socklen_t addrlen)
=20
 static void child_handler(int signo)
 {
+	struct sigaction sa;
 	/*
 	 * Otherwise empty handler because systemcalls will get interrupted
 	 * upon signal receipt
 	 * SysV needs the handler to be rearmed
 	 */
-	signal(SIGCHLD, child_handler);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D child_handler;
+	sigaction(SIGCHLD, &sa, 0);
 }
=20
 static int set_reuse_addr(int sockfd)
--=20
2.0.0.rc4.6.g127602c
