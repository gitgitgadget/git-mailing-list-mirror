From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/21] strbuf: allow "buf" to point to the middle of the allocated buffer
Date: Wed, 15 Dec 2010 22:02:53 +0700
Message-ID: <1292425376-14550-19-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:06:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvp-0001Nt-3V
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab0LOPGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:06:13 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37229 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0LOPGM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:06:12 -0500
Received: by ywl5 with SMTP id 5so1084142ywl.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LEodcYe+bdTF0n2sx9PyJQN+80rPOuUXOTDW1gY+oXI=;
        b=H6+N6dxqhEN5VGHKbV+FnjbUARTtWRd/XDAKftwiaqDYUwr2SbO8T3fMNxaXVy++zx
         6/hBDicuaCYx444Z4r8icj5lIhgfeyqP2eObwa+g9XK4py9EWyqRd7dGj06fyz8WD94i
         RKF0FN90/hqYS6nySg0NyXYMTAUPFh2ZDQpvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HQdkA1nHP1c0kv0/tA/Dj/fPoD2tJNNsFT/XmFJsCnCUwzU3vr1obK0PZcnlqMcB+6
         CY24qsajAFvD9qwLY1EvkKjfV1gHUUzANpbAMmpR+9wA10ddOHHSdiLBuGuMWhKhJUOy
         QS6mX0+AaLmpYRgNZSt8aSXq9WwEGdm27Ip8w=
Received: by 10.42.175.74 with SMTP id az10mr6010068icb.230.1292425571471;
        Wed, 15 Dec 2010 07:06:11 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id y8sm848850ica.14.2010.12.15.07.06.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:06:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:05:19 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163772>

This allows offseting buf forward by neglen bytes. This patch makes
sure that reallocation works even when buf is not at the top of
allocated region.

Many functions are not aware that there could be data before buf. Use
with care.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 strbuf.c |   36 ++++++++++++++++++++++++++----------
 strbuf.h |   10 ++++++----
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index bc3a080..12cda6f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -28,8 +28,10 @@ char strbuf_slopbuf[1];
=20
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
-	sb->alloc =3D sb->len =3D 0;
-	sb->buf =3D strbuf_slopbuf;
+	sb->alloc  =3D 0;
+	sb->len	   =3D 0;
+	sb->neglen =3D 0;
+	sb->buf	   =3D strbuf_slopbuf;
 	if (hint)
 		strbuf_grow(sb, hint);
 }
@@ -37,7 +39,7 @@ void strbuf_init(struct strbuf *sb, size_t hint)
 void strbuf_release(struct strbuf *sb)
 {
 	if (sb->alloc) {
-		free(sb->buf);
+		free(sb->buf - sb->neglen);
 		strbuf_init(sb, 0);
 	}
 }
@@ -45,6 +47,8 @@ void strbuf_release(struct strbuf *sb)
 char *strbuf_detach(struct strbuf *sb, size_t *sz)
 {
 	char *res =3D sb->alloc ? sb->buf : NULL;
+	if (sb->neglen)
+		die("shift buf back before detaching");
 	if (sz)
 		*sz =3D sb->len;
 	strbuf_init(sb, 0);
@@ -54,20 +58,23 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t al=
loc)
 {
 	strbuf_release(sb);
-	sb->buf   =3D buf;
-	sb->len   =3D len;
-	sb->alloc =3D alloc;
+	sb->buf    =3D buf;
+	sb->len    =3D len;
+	sb->neglen =3D 0;
+	sb->alloc  =3D alloc;
 	strbuf_grow(sb, 0);
 	sb->buf[sb->len] =3D '\0';
 }
=20
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
-	if (sb->len + extra + 1 <=3D sb->len)
+	char *buf =3D !sb->alloc ? NULL : sb->buf - sb->neglen;
+	int len =3D sb->neglen + sb->len;
+
+	if (len + extra + 1 <=3D len)
 		die("you want to use way too much memory");
-	if (!sb->alloc)
-		sb->buf =3D NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	ALLOC_GROW(buf, len + extra + 1, sb->alloc);
+	sb->buf =3D buf + sb->neglen;
 }
=20
 void strbuf_trim(struct strbuf *sb)
@@ -402,3 +409,12 @@ int strbuf_check_branch_ref(struct strbuf *sb, con=
st char *name)
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 	return check_ref_format(sb->buf);
 }
+
+void strbuf_offset(struct strbuf *sb, int offset)
+{
+	if (offset > sb->len || offset < sb->neglen)
+		die("you cannot offset out of allocated buffer");
+	sb->buf	   +=3D offset;
+	sb->neglen +=3D offset;
+	sb->len	   -=3D offset;
+}
diff --git a/strbuf.h b/strbuf.h
index fac2dbc..3c3b146 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -43,11 +43,11 @@
 extern char strbuf_slopbuf[];
 struct strbuf {
 	size_t alloc;
-	size_t len;
+	size_t len, neglen;
 	char *buf;
 };
=20
-#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
+#define STRBUF_INIT  { 0, 0, 0, strbuf_slopbuf }
=20
 /*----- strbuf life cycle -----*/
 extern void strbuf_init(struct strbuf *, size_t);
@@ -62,7 +62,7 @@ static inline void strbuf_swap(struct strbuf *a, stru=
ct strbuf *b) {
=20
 /*----- strbuf size related -----*/
 static inline size_t strbuf_avail(const struct strbuf *sb) {
-	return sb->alloc ? sb->alloc - sb->len - 1 : 0;
+	return sb->alloc ? sb->alloc - sb->len - sb->neglen - 1 : 0;
 }
=20
 extern void strbuf_grow(struct strbuf *, size_t);
@@ -70,7 +70,7 @@ extern void strbuf_grow(struct strbuf *, size_t);
 static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 	if (!sb->alloc)
 		strbuf_grow(sb, 0);
-	assert(len < sb->alloc);
+	assert(sb->neglen + len < sb->alloc);
 	sb->len =3D len;
 	sb->buf[len] =3D '\0';
 }
@@ -136,4 +136,6 @@ extern int launch_editor(const char *path, struct s=
trbuf *buffer, const char *co
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name=
);
=20
+extern void strbuf_offset(struct strbuf *sb, int offset);
+
 #endif /* STRBUF_H */
--=20
1.7.3.3.476.g10a82
