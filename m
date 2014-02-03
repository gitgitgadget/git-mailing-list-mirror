From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/26] pkt-line.c: add packet_write_timeout()
Date: Mon,  3 Feb 2014 11:28:50 +0700
Message-ID: <1391401754-15347-3-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:29:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABA6-0000qg-FI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbaBCE33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:29 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34756 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbaBCE32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:28 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so6631703pab.33
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=A4QxHYlGeLVk9DBUREdAXygUCIy1k+g95pYcKNdA2vc=;
        b=TTaMnpytphVA8Oay2ZpRe26ee7KB/QgsJCAEHPn/TDtdlTSclj7oefU+iPkVUIltFt
         gwdtQ6/MIvuySpjJIbfxkVCqhtQvdod2G2NjoCcZqbf3VC1RWm6Rr2OWgXlgUjOqrN2r
         4byrs7laMQLIR7SOgS87cyTP8+Td0pOpuf5Ve0lToLj/7bk8/Ft7tvtN6bmEBQSttW4U
         pUmxIFjA79v4q9jEyOg7e49GUUfiCaj4H9hp7ICQZJXLDC7G04+/pikmlCrto1QQap52
         PJ7B0XKI8xxaCC9O7r8uszfDGkErMA1BKQa3kMhdJm02j9THM+JguURr9w8NHwWgokz/
         MznQ==
X-Received: by 10.68.201.163 with SMTP id kb3mr154158pbc.168.1391401768432;
        Sun, 02 Feb 2014 20:29:28 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id i10sm134240505pat.11.2014.02.02.20.29.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:26 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241397>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h    |  1 +
 pkt-line.c | 15 +++++++++++++++
 pkt-line.h |  1 +
 wrapper.c  | 26 ++++++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/cache.h b/cache.h
index dc040fb..718e32b 100644
--- a/cache.h
+++ b/cache.h
@@ -1231,6 +1231,7 @@ extern void fsync_or_die(int fd, const char *);
=20
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
+extern ssize_t write_in_full_timeout(int fd, const void *buf, size_t c=
ount, int timeout);
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
diff --git a/pkt-line.c b/pkt-line.c
index eac45ad..cf681e9 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -94,6 +94,21 @@ void packet_write(int fd, const char *fmt, ...)
 	write_or_die(fd, write_buffer, n);
 }
=20
+int packet_write_timeout(int fd, int timeout, const char *fmt, ...)
+{
+	static struct strbuf sb =3D STRBUF_INIT;
+	va_list args;
+	unsigned n;
+
+	if (fd =3D=3D -1)
+		return -1;
+	va_start(args, fmt);
+	strbuf_reset(&sb);
+	n =3D format_packet(fmt, args);
+	va_end(args);
+	return write_in_full_timeout(fd, write_buffer, n, timeout);
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 0a838d1..4b93a0c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -21,6 +21,7 @@
  */
 void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format =
(printf, 2, 3)));
+int packet_write_timeout(int fd, int timeout, const char *fmt, ...) __=
attribute__((format (printf, 3, 4)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attr=
ibute__((format (printf, 2, 3)));
=20
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..9a0e289 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -214,6 +214,32 @@ ssize_t write_in_full(int fd, const void *buf, siz=
e_t count)
 	return total;
 }
=20
+ssize_t write_in_full_timeout(int fd, const void *buf,
+			      size_t count, int timeout)
+{
+	struct pollfd pfd;
+	const char *p =3D buf;
+	ssize_t total =3D 0;
+
+	pfd.fd =3D fd;
+	pfd.events =3D POLLOUT;
+	while (count > 0 && poll(&pfd, 1, timeout) > 0 &&
+	       (pfd.revents & POLLOUT)) {
+		ssize_t written =3D xwrite(fd, p, count);
+		if (written < 0)
+			return -1;
+		if (!written) {
+			errno =3D ENOSPC;
+			return -1;
+		}
+		count -=3D written;
+		p +=3D written;
+		total +=3D written;
+	}
+
+	return count ? -1 : total;
+}
+
 int xdup(int fd)
 {
 	int ret =3D dup(fd);
--=20
1.8.5.2.240.g8478abd
