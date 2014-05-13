From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] unix-socket: stub impl. for platforms with no unix socket support
Date: Tue, 13 May 2014 18:15:30 +0700
Message-ID: <1399979737-8577-4-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAgl-0008Jn-21
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760419AbaEMLPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:15:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59976 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760357AbaEMLPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:15:51 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so162270pbb.33
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ioHy5VpPOmrFBTLUBWAl6XEszRcbpKJ8WcVrKki/Nhc=;
        b=NTr5H4hj53DOu/VcMwMNNsO8m280fy+/65lfr7rBJRhf/xEoQMNN0A32hq34PrD1yV
         jKUaD5p3ivLFZ1CTId5xljFix006KoJ90DToNTYsab8XlxqV42VxPEaoJBAaNbskdUAI
         gisn1KYTs4g6kHyhXHM4xWVk4MysMy8t37syid/rYjdDz67CkWmF0Soge2ecZYQknaIv
         XP5ZC94ZzV61f+zv9vhvmZuMd/LIAJ8AoMibgoLANa53J/uDQp01onbIfCM/OSTXCM6J
         fANsIajyID0Cu4aihIX60al7/+fHyxiAPa7NGIVX7P5lU3cQB1mpiQ0QojEZQv4uH6h4
         GWRw==
X-Received: by 10.66.139.168 with SMTP id qz8mr26808886pab.3.1399979750759;
        Tue, 13 May 2014 04:15:50 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id xr9sm60482015pab.5.2014.05.13.04.15.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:15:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:15:56 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248763>

With this we can make unix_stream_* calls without #ifdef.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile      |  2 ++
 unix-socket.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Makefile b/Makefile
index 028749b..d0a2b4b 100644
--- a/Makefile
+++ b/Makefile
@@ -1417,6 +1417,8 @@ ifndef NO_UNIX_SOCKETS
 	LIB_H +=3D unix-socket.h
 	PROGRAM_OBJS +=3D credential-cache.o
 	PROGRAM_OBJS +=3D credential-cache--daemon.o
+else
+	BASIC_CFLAGS +=3D -DNO_UNIX_SOCKETS
 endif
=20
 ifdef NO_ICONV
diff --git a/unix-socket.h b/unix-socket.h
index e271aee..f1cba70 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -1,7 +1,25 @@
 #ifndef UNIX_SOCKET_H
 #define UNIX_SOCKET_H
=20
+#ifndef NO_UNIX_SOCKETS
+
 int unix_stream_connect(const char *path);
 int unix_stream_listen(const char *path);
=20
+#else
+
+static inline int unix_stream_connect(const char *path)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+
+static inline int unix_stream_listen(const char *path)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+
+#endif
+
 #endif /* UNIX_SOCKET_H */
--=20
1.9.1.346.ga2b5940
