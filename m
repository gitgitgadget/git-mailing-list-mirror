From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Add strbuf_printf() to do formatted printing to a strbuf.
Date: Tue, 31 Jul 2007 15:54:23 -0400
Message-ID: <11859116632279-git-send-email-krh@redhat.com>
References: <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 22:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFxyx-0005iT-Om
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 22:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624AbXGaUGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 16:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbXGaUGL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 16:06:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47851 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281AbXGaUGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 16:06:09 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6VJxaKs004333;
	Tue, 31 Jul 2007 15:59:36 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VJxZMJ003662;
	Tue, 31 Jul 2007 15:59:35 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VJxY18028981;
	Tue, 31 Jul 2007 15:59:35 -0400
X-Mailer: git-send-email 1.5.3.rc3.847.g0286-dirty
In-Reply-To: <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54373>

Also, expose strbuf_add() and strbuf_add_char() to add raw data to the =
buffer.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

Ok, this gets uglier as we try to work around different versions of
vsnprintf.  On windows, vsnprintf returns -1 if the output doesn't fit =
in
the given buffer.  What we do is to keep doubling the buffer size until=
 it
fits.  Not sure this is the best idea.

The old hardcoded limitation of just 2048 bytes wasn't too bad, conside=
ring
that it's just the limit for one strbuf_printf invocation, not the tota=
l
size of the strbuf contents.

I dunno...
Kristian

 strbuf.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+------
 strbuf.h |    3 ++
 2 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index e33d06b..2805c11 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,16 +11,26 @@ static void strbuf_begin(struct strbuf *sb) {
 	strbuf_init(sb);
 }
=20
-static void inline strbuf_add(struct strbuf *sb, int ch) {
-	if (sb->alloc <=3D sb->len) {
-		sb->alloc =3D sb->alloc * 3 / 2 + 16;
-		sb->buf =3D xrealloc(sb->buf, sb->alloc);
-	}
+static void inline strbuf_grow(struct strbuf *sb, size_t extra)
+{
+	ALLOC_GROW(sb->buf, sb->len + extra, sb->alloc);
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
@@ -33,9 +43,54 @@ void read_line(struct strbuf *sb, FILE *fp, int term=
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
+	char buffer[2048];
+	va_list args;
+	int len, size =3D 2 * sizeof buffer;
+
+	va_start(args, fmt);
+	len =3D vsnprintf(buffer, sizeof(buffer), fmt, args);
+	va_end(args);
+
+	if (len > sizeof(buffer)) {
+		/*
+		 * Didn't fit in the buffer, but this vsnprintf at
+		 * least gives us the required length back.  Grow the
+		 * buffer acccordingly and try again.
+		 */
+		strbuf_grow(sb, len);
+		va_start(args, fmt);
+		len =3D vsnprintf(sb->buf + sb->len,
+				sb->alloc - sb->len, fmt, args);
+		va_end(args);
+	} else if (len >=3D 0) {
+		/*
+		 * The initial vsnprintf fit in the temp buffer, just
+		 * copy it to the strbuf.
+		 */
+		strbuf_add(sb, buffer, len);
+	} else {
+		/*
+		 * This vnsprintf sucks and just returns -1 when the
+		 * buffer is too small.  Keep doubling the size until
+		 * it fits.
+		 */
+		while (len < 0) {
+			strbuf_grow(sb, size);
+			va_start(args, fmt);
+			len =3D vsnprintf(sb->buf + sb->len,
+					sb->alloc - sb->len, fmt, args);
+			va_end(args);
+			size *=3D 2;
+		}
+	}
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
