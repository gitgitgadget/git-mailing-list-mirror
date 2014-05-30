From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 2/2] connect.c: replace signal() with sigaction()
Date: Fri, 30 May 2014 13:58:17 -0700
Message-ID: <1d11d5da7ebc3a6e0d4ab64802b601526c19113c.1401482787.git.jmmahler@gmail.com>
References: <cover.1401482787.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 30 22:59:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTtF-0004hz-5t
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934318AbaE3U65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2014 16:58:57 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:65035 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748AbaE3U64 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:58:56 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so2118266pbc.12
        for <git@vger.kernel.org>; Fri, 30 May 2014 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=0Szw9MrkW5zmbrIVKxS75DLQB+hSWXd6hKZm4GrRuts=;
        b=PGR7si3cDgYDf7K2P8xWwFrQSlTTTmdzP2mZ3cO4RmrP8FJFP+TcDs+QR7m+Pb9xMo
         wyiFipfyUkwegOsk6GHaHz9w5f1vNgrtv1CIiTI9JmPZcJt6kDsVA6Pn7sqyA4hLS/fh
         z2mlf+FzaVCL5ByqvOy5c9jkjHMa1OOiWOGv6aedlLlqkKRjox0iZvK6aui0/O+WVLCZ
         BMnO8uMjkrJGbytoY6YwomwoWDXVRFUaPVLR3HBeM3kLNty8iA9/hG/3N4x5IqktzTV2
         KHFTHv3Q1a5V3UE6JYmAjaLNECZeYx0+aTyIvSITQCLvvlqZt+SAr4AwYnMbRme1M5U7
         rItg==
X-Received: by 10.68.242.135 with SMTP id wq7mr21574376pbc.147.1401483536517;
        Fri, 30 May 2014 13:58:56 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bu1sm7894825pbb.54.2014.05.30.13.58.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 13:58:55 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Fri, 30 May 2014 13:58:52 -0700
X-Mailer: git-send-email 2.0.0.2.g1d11d5d
In-Reply-To: <cover.1401482787.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401482787.git.jmmahler@gmail.com>
References: <cover.1401482787.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250484>

=46rom signal(2) man page:

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
2.0.0.2.g1d11d5d
