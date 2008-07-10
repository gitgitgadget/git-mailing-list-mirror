From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Add some useful functions for strbuf manipulation.
Date: Fri, 11 Jul 2008 01:41:52 +0200
Organization: Chalmers
Message-ID: <48769E40.8030303@etek.chalmers.se>
References: <4876820D.4070806@etek.chalmers.se> <7vod55o0tx.fsf@gitster.siamese.dyndns.org> <48768F30.8070409@etek.chalmers.se> <7v3amhnwy9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:44:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5oN-00020M-I8
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283AbYGJXl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755900AbYGJXl4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:41:56 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:54878 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbYGJXlz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:41:55 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id 73FFC8749;
	Fri, 11 Jul 2008 01:41:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7v3amhnwy9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88058>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

Junio C Hamano wrote:
> Heh, after getting burned by that NUL thingy, I was waiting for someb=
ody
> to step up.  Thanks.

Here we go then. Two freshly baked patches.

Note that this is a pretty straight buffers -> strbuf's conversion,
but I think it will be a good start for further hardening of mailinfo.


 strbuf.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 strbuf.h |    6 +++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 4aed752..28d6776 100644
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
+struct strbuf ** strbuf_split(struct strbuf *sb, int delim)
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
 int strbuf_cmp(struct strbuf *a, struct strbuf *b)
 {
 	int cmp;
diff --git a/strbuf.h b/strbuf.h
index faec229..577d14e 100644
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
 extern int strbuf_cmp(struct strbuf *, struct strbuf *);
+extern void strbuf_tolower(struct strbuf *);
+
+extern struct strbuf ** strbuf_split(struct strbuf*, int delim);
+extern void strbuf_list_free(struct strbuf **);
=20
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c) {
--=20
1.5.4.5
