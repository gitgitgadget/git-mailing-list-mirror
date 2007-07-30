From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 3/5] Add strbuf_printf() to do formatted printing to a strbuf.
Date: Mon, 30 Jul 2007 17:28:44 -0400
Message-ID: <11858309322006-git-send-email-krh@redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
 <11858309311728-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:34:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFcsr-0003em-Sz
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968149AbXG3VeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 17:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967953AbXG3VeD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:34:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51430 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967903AbXG3Vd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:33:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXuob015557
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:33:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXtwx026642;
	Mon, 30 Jul 2007 17:33:55 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXs9x018718;
	Mon, 30 Jul 2007 17:33:55 -0400
X-Mailer: git-send-email 1.5.3.rc3.848.g198b7-dirty
In-Reply-To: <11858309311728-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54275>

=46rom: Kristian H=C3=B8gsberg <krh@redhat.com>

Also, expose strbuf_add() and strbuf_add_char() to add raw data to the =
buffer.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 strbuf.c |   37 +++++++++++++++++++++++++++++++------
 strbuf.h |    3 +++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index e33d06b..a0539db 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,16 +11,28 @@ static void strbuf_begin(struct strbuf *sb) {
 	strbuf_init(sb);
 }
=20
-static void inline strbuf_add(struct strbuf *sb, int ch) {
-	if (sb->alloc <=3D sb->len) {
+static void inline strbuf_grow(struct strbuf *sb, size_t extra)
+{
+	while (sb->alloc < sb->len + extra)
 		sb->alloc =3D sb->alloc * 3 / 2 + 16;
-		sb->buf =3D xrealloc(sb->buf, sb->alloc);
-	}
+	sb->buf =3D xrealloc(sb->buf, sb->alloc);
+}
+
+void strbuf_add(struct strbuf *sb, const char *data, size_t len)
+{
+	strbuf_grow(sb, len);
+	memcpy(sb->buf + sb->len, data, len);
+	sb->len +=3D len;
+}
+
+void strbuf_add_char(struct strbuf *sb, int ch)
+{
+	strbuf_grow(sb, 1);
 	sb->buf[sb->len++] =3D ch;
 }
=20
 static void strbuf_end(struct strbuf *sb) {
-	strbuf_add(sb, 0);
+	strbuf_add_char(sb, 0);
 }
=20
 void read_line(struct strbuf *sb, FILE *fp, int term) {
@@ -33,9 +45,22 @@ void read_line(struct strbuf *sb, FILE *fp, int term=
) {
 	while ((ch =3D fgetc(fp)) !=3D EOF) {
 		if (ch =3D=3D term)
 			break;
-		strbuf_add(sb, ch);
+		strbuf_add_char(sb, ch);
 	}
 	if (ch =3D=3D EOF && sb->len =3D=3D 0)
 		sb->eof =3D 1;
 	strbuf_end(sb);
 }
+
+void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
+{
+	char one_line[2048];
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len =3D vsnprintf(one_line, sizeof(one_line), fmt, args);
+	va_end(args);
+	strbuf_add(sb, one_line, len);
+}
+
diff --git a/strbuf.h b/strbuf.h
index 74cc012..1e5d09e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -9,5 +9,8 @@ struct strbuf {
=20
 extern void strbuf_init(struct strbuf *);
 extern void read_line(struct strbuf *, FILE *, int);
+extern void strbuf_add(struct strbuf *sb, const char *data, size_t len=
);
+extern void strbuf_add_char(struct strbuf *sb, int ch);
+extern void strbuf_printf(struct strbuf *sb, const char *fmt, ...);
=20
 #endif /* STRBUF_H */
--=20
1.5.2.GIT
