From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Add some useful functions for strbuf manipulation.
Date: Sun, 13 Jul 2008 20:29:18 +0200
Organization: Chalmers
Message-ID: <487A497E.6030308@etek.chalmers.se>
References: <4876820D.4070806@etek.chalmers.se> <7vod55o0tx.fsf@gitster.siamese.dyndns.org> <48768F30.8070409@etek.chalmers.se> <7v3amhnwy9.fsf@gitster.siamese.dyndns.org> <48769E40.8030303@etek.chalmers.se> <48769E91.60205@etek.chalmers.se> <7vy747fx9x.fsf_-_@gitster.siamese.dyndns.org> <487A46C5.6000503@etek.chalmers.se> <487A4948.8080003@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI6Kz-0007CO-MR
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 20:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYGMS3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbYGMS3X
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 14:29:23 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:43152 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYGMS3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 14:29:23 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id 124B082B1;
	Sun, 13 Jul 2008 20:29:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <487A4948.8080003@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88319>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 strbuf.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 strbuf.h |    6 +++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 7767170..6294940 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -60,6 +60,18 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
 }
=20
+void strbuf_trim(struct strbuf *sb)
+{
+	char *b =3D sb->buf;
+	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
+		sb->len--;
+	while(sb->len > 0 && isspace(*b)) {
+		b++;
+		sb->len--;
+	}
+	memmove(sb->buf, b, sb->len);
+	sb->buf[sb->len] =3D '\0';
+}
 void strbuf_rtrim(struct strbuf *sb)
 {
 	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
@@ -67,6 +79,64 @@ void strbuf_rtrim(struct strbuf *sb)
 	sb->buf[sb->len] =3D '\0';
 }
=20
+void strbuf_ltrim(struct strbuf *sb)
+{
+	char *b =3D sb->buf;
+	while(sb->len > 0 && isspace(*b)) {
+		b++;
+		sb->len--;
+	}
+	memmove(sb->buf, b, sb->len);
+	sb->buf[sb->len] =3D '\0';
+}
+
+void strbuf_tolower(struct strbuf *sb)
+{
+	int i;
+	for (i =3D 0; i < sb->len; i++)
+		sb->buf[i] =3D tolower(sb->buf[i]);
+}
+
+struct strbuf ** strbuf_split(const struct strbuf *sb, int delim)
+{
+	int alloc =3D 2, pos =3D 0;
+	char *n, *p;
+	struct strbuf **ret;
+	struct strbuf *t;
+
+	ret =3D xcalloc(alloc, sizeof(struct strbuf *));
+	p =3D n =3D sb->buf;
+	while (n < sb->buf + sb->len) {
+		int len;
+		n =3D memchr(n, delim, sb->len - (n - sb->buf));
+		if (pos + 1 >=3D alloc) {
+			alloc =3D alloc * 2;
+			ret =3D xrealloc(ret, sizeof(struct strbuf *) * alloc);
+		}
+		if (!n)
+			n =3D sb->buf + sb->len - 1;
+		len =3D n - p + 1;
+		t =3D xmalloc(sizeof(struct strbuf));
+		strbuf_init(t, len);
+		strbuf_add(t, p, len);
+		ret[pos] =3D t;
+		ret[++pos] =3D NULL;
+		p =3D ++n;
+	}
+	return ret;
+}
+
+void strbuf_list_free(struct strbuf ** sbs)
+{
+	struct strbuf **s =3D sbs;
+
+	while(*s) {
+		strbuf_release(*s);
+		free(*s++);
+	}
+	free(sbs);
+}
+
 int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
 {
 	int cmp;
diff --git a/strbuf.h b/strbuf.h
index a1b0143..5e65a3f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -77,8 +77,14 @@ static inline void strbuf_setlen(struct strbuf *sb, =
size_t len) {
 #define strbuf_reset(sb)  strbuf_setlen(sb, 0)
=20
 /*----- content related -----*/
+extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
+extern void strbuf_ltrim(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
+extern void strbuf_tolower(struct strbuf *);
+
+extern struct strbuf ** strbuf_split(const struct strbuf*, int delim);
+extern void strbuf_list_free(struct strbuf **);
=20
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c) {
--=20
1.5.4.5
