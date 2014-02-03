From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/26] pkt-line.c: add packet_read_line_timeout()
Date: Mon,  3 Feb 2014 11:28:51 +0700
Message-ID: <1391401754-15347-4-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:29:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAB-0000tC-NL
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbaBCE3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:35 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46066 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbaBCE3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:34 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so6583584pad.22
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F96W1qTIU47NVw5g+BsoFXEZhOfTFvKbxXZJjBewK9I=;
        b=xXtmw+Z/pi2Q55RwJgJaUVFpzilkQfbJ2UJFjRW4GCYNtzFfDBIhfRGmSFYEKNrqbT
         YgiRhy+djTAlxsXp9IL2MXq4ZJRpCayYq663nb1HVtbLI1Sn3/j+SlhYEwSU6VkBO0xQ
         s6sljzQfKuj37FuT1gDtR3hIOILHOeuX70VMtRcKRuyQuOLE4oXCKbVFQpYqmqO9PU5a
         ccQLYllUFIf23HdEBuG69REAWpyPANgmugKojGfPB5eiWCSsTxBf0F+SxfUXpLls2ESz
         qv8Jmw6xlU092iFYNyEGqF2n3oLnhIMNnDvNQv//GlNrwTnT5bZUOelXhAUizu33qdHK
         NffQ==
X-Received: by 10.66.221.199 with SMTP id qg7mr35326828pac.88.1391401773989;
        Sun, 02 Feb 2014 20:29:33 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id lh13sm134203547pab.4.2014.02.02.20.29.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:32 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241398>

This version is also gentler than its friend packet_read_line()
because it's designed for side channel I/O that should not abort the
program even if the channel is broken.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h    |  1 +
 pkt-line.c | 35 +++++++++++++++++++++++++++++++++++
 pkt-line.h |  1 +
 wrapper.c  | 21 +++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/cache.h b/cache.h
index 718e32b..939db46 100644
--- a/cache.h
+++ b/cache.h
@@ -1230,6 +1230,7 @@ extern int write_or_whine_pipe(int fd, const void=
 *buf, size_t count, const char
 extern void fsync_or_die(int fd, const char *);
=20
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
+extern ssize_t read_in_full_timeout(int fd, void *buf, size_t count, i=
nt timeout);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern ssize_t write_in_full_timeout(int fd, const void *buf, size_t c=
ount, int timeout);
 static inline ssize_t write_str_in_full(int fd, const char *str)
diff --git a/pkt-line.c b/pkt-line.c
index cf681e9..5a07e97 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -229,3 +229,38 @@ char *packet_read_line_buf(char **src, size_t *src=
_len, int *dst_len)
 {
 	return packet_read_line_generic(-1, src, src_len, dst_len);
 }
+
+char *packet_read_line_timeout(int fd, int timeout, int *len_p)
+{
+	char *buf =3D packet_buffer;
+	int ret, len, buf_len =3D sizeof(packet_buffer);
+	char linelen[4];
+
+	if (fd =3D=3D -1)
+		return NULL;
+	if ((ret =3D read_in_full_timeout(fd, linelen, 4, timeout)) < 0)
+		return NULL;
+	len =3D packet_length(linelen);
+	if (len < 0) {
+		error("protocol error: bad line length character: %.4s", linelen);
+		return NULL;
+	}
+	if (!len) {
+		packet_trace("0000", 4, 0);
+		if (len_p)
+			*len_p =3D 0;
+		return "";
+	}
+	len -=3D 4;
+	if (len >=3D buf_len) {
+		error("protocol error: bad line length %d", len);
+		return NULL;
+	}
+	if ((ret =3D read_in_full_timeout(fd, buf, len, timeout)) < 0)
+		return NULL;
+	buf[len] =3D '\0';
+	if (len_p)
+		*len_p =3D len;
+	packet_trace(buf, len, 0);
+	return buf;
+}
diff --git a/pkt-line.h b/pkt-line.h
index 4b93a0c..d47dca5 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -69,6 +69,7 @@ int packet_read(int fd, char **src_buffer, size_t *sr=
c_len, char
  * packet is written to it.
  */
 char *packet_read_line(int fd, int *size);
+char *packet_read_line_timeout(int fd, int timeout, int *size);
=20
 /*
  * Same as packet_read_line, but read from a buf rather than a descrip=
tor;
diff --git a/wrapper.c b/wrapper.c
index 9a0e289..9cf10b2 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -193,6 +193,27 @@ ssize_t read_in_full(int fd, void *buf, size_t cou=
nt)
 	return total;
 }
=20
+ssize_t read_in_full_timeout(int fd, void *buf, size_t count, int time=
out)
+{
+	char *p =3D buf;
+	ssize_t total =3D 0;
+	struct pollfd pfd;
+
+	pfd.fd =3D fd;
+	pfd.events =3D POLLIN;
+	while (count > 0 && poll(&pfd, 1, timeout) > 0 &&
+	       (pfd.revents & POLLIN)) {
+		ssize_t loaded =3D xread(fd, p, count);
+		if (loaded <=3D 0)
+			return -1;
+		count -=3D loaded;
+		p +=3D loaded;
+		total +=3D loaded;
+	}
+
+	return count ? -1 : total;
+}
+
 ssize_t write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p =3D buf;
--=20
1.8.5.2.240.g8478abd
