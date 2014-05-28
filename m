From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 5/5] connect.c: replace signal() with sigaction()
Date: Tue, 27 May 2014 23:14:15 -0700
Message-ID: <1401257655-6043-6-git-send-email-jmmahler@gmail.com>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 08:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpX9A-0008KQ-Nw
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 08:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbaE1GPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 02:15:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50507 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbaE1GPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 02:15:23 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so10414926pad.23
        for <git@vger.kernel.org>; Tue, 27 May 2014 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V1/A/qZDMbSWyLVYGtkExNqrgWZBg1GBWPSrIcVK4Wc=;
        b=nWtqDSsoMvEZZjjQ932WDA5uc8QjGEXelhA9s53QgkGdoHWu6WfAGoltl5+yevxs0V
         WAnYf4ItlEIiI/QLcv9eHpfVoXI5LbIUiCxIWLO1QOwY1oL6qUfoORguBddF7RLMLAC9
         cjDdA7MHJBQi5yKRkneTzFV/o33Z8/hJt9v02wxRN+3+9NkYQz/C3V0Z2f0ShL0+2pnh
         NNth8SGbcE6ivgbkCrjHeuRk9xmOTbuCo8rAjbBrPPnGQUrT29/ODsC6hBO9VelwPbeb
         nCdaRdwI3UFSr8X0n710gIuN7wUplq8E2km/1RV5g5dIi7gNPddRoXsaHatcHUJvKpki
         i9yw==
X-Received: by 10.68.103.165 with SMTP id fx5mr43421189pbb.118.1401257723175;
        Tue, 27 May 2014 23:15:23 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id yv7sm83828339pac.33.2014.05.27.23.15.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 23:15:22 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 23:15:17 -0700
X-Mailer: git-send-email 2.0.0.rc4.6.g127602c
In-Reply-To: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250267>

=46rom signal(2)

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.  See Portability below.

Replaced signal() with sigaction() in connect.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 connect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index a983d06..b2a33c9 100644
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
+	sigaction(SIGCHLD, &sa, 0);
=20
 	protocol =3D parse_connect_url(url, &hostandport, &path);
 	if (flags & CONNECT_DIAG_URL) {
--=20
2.0.0.rc4.6.g127602c
