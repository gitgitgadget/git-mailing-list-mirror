From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 5/9] Introduce strbuf_read_fd().
Date: Wed,  5 Sep 2007 20:23:34 -0400
Message-ID: <11890382252522-git-send-email-krh@redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com>
 <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5Lg-0001k6-Bk
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231AbXIFAfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbXIFAfw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:35:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757166AbXIFAfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:46 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zjox005432
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:45 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZjMN032609;
	Wed, 5 Sep 2007 20:35:45 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZhbZ016503;
	Wed, 5 Sep 2007 20:35:44 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
In-Reply-To: <11890382253220-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57782>

This function reads from a given fd into a strbuf until end of file.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 strbuf.c |   19 +++++++++++++++++++
 strbuf.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 2805c11..fcfc05e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -50,6 +50,25 @@ void read_line(struct strbuf *sb, FILE *fp, int term=
) {
 	strbuf_end(sb);
 }
=20
+int strbuf_read_fd(struct strbuf *sb, int fd)
+{
+	int len, total =3D 0;
+
+	do {
+		strbuf_grow(sb, 1024);
+		len =3D xread(fd, sb->buf + sb->len, sb->alloc - sb->len);
+		if (len > 0) {
+			total +=3D len;
+			sb->len +=3D len;
+		}
+	} while (len > 0);
+
+	if (len < 0)
+		return len;
+
+	return total;
+}
+
 void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
 {
 	char buffer[2048];
diff --git a/strbuf.h b/strbuf.h
index 1e5d09e..6e630ea 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -12,5 +12,6 @@ extern void read_line(struct strbuf *, FILE *, int);
 extern void strbuf_add(struct strbuf *sb, const char *data, size_t len=
);
 extern void strbuf_add_char(struct strbuf *sb, int ch);
 extern void strbuf_printf(struct strbuf *sb, const char *fmt, ...);
+extern int strbuf_read_fd(struct strbuf *sb, int fd);
=20
 #endif /* STRBUF_H */
--=20
1.5.2.GIT
