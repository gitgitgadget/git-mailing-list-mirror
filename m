From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/25] setup.c: convert is_git_directory() to use strbuf
Date: Tue, 18 Feb 2014 20:40:03 +0700
Message-ID: <1392730814-19656-15-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvm-0007tj-R5
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbaBRNlk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:40 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:48046 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703AbaBRNli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:38 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so16586615pbc.8
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6gsGHMZmJjPSmGQSXWOZBeMs0eqU0t7iqZRoPHXFB0U=;
        b=z7283T9YOkOOYh71UDPMdf8NnqVuFRrEJqZzCbjlcq6BQSw0/IahQ4W2Hue6K6BF2z
         DQzkZ3/X6r1oDNnVS3BlnEcxr5sasLbtI5lzMN96p8K67MKRQckF+7XlPdqOAym7NRd4
         LhQoA3g0CAs4Ot4YjO93JEIP51aJg4QMgMjqdJKMcqESXhcW2q0Mwv7p8EDIsZu44N6s
         WfDQTAcp9HTOmRW/lKzEOLE57FWvwV4+jYfrv9CuL9qWXGq8VoRxXv05ji5tbZ8J8kaJ
         ykI+YuReMdmtLcO92uOUsZrldS0H2olkYVXedqzq8QoPixCplEw5dwNxJ09YgPQb/THa
         yS6g==
X-Received: by 10.68.93.132 with SMTP id cu4mr32930958pbb.129.1392730897964;
        Tue, 18 Feb 2014 05:41:37 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id qf7sm142621721pac.14.2014.02.18.05.41.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:51 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242313>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c  | 35 +++++++++++++++++++----------------
 strbuf.h |  4 ++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/setup.c b/setup.c
index 6c3f85f..999225b 100644
--- a/setup.c
+++ b/setup.c
@@ -184,31 +184,34 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
  */
 int is_git_directory(const char *suspect)
 {
-	char path[PATH_MAX];
-	size_t len =3D strlen(suspect);
+	struct strbuf path =3D STRBUF_INIT;
+	int ret =3D 0;
+	size_t len;
=20
-	if (PATH_MAX <=3D len + strlen("/objects"))
-		die("Too long path: %.*s", 60, suspect);
-	strcpy(path, suspect);
+	strbuf_addstr(&path, suspect);
+	len =3D path.len;
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
-			return 0;
+			goto done;
 	}
 	else {
-		strcpy(path + len, "/objects");
-		if (access(path, X_OK))
-			return 0;
+		strbuf_addstr(&path, "/objects");
+		if (access(path.buf, X_OK))
+			goto done;
 	}
=20
-	strcpy(path + len, "/refs");
-	if (access(path, X_OK))
-		return 0;
+	strbuf_addstr_at(&path, len, "/refs");
+	if (access(path.buf, X_OK))
+		goto done;
=20
-	strcpy(path + len, "/HEAD");
-	if (validate_headref(path))
-		return 0;
+	strbuf_addstr_at(&path, len, "/HEAD");
+	if (validate_headref(path.buf))
+		goto done;
=20
-	return 1;
+	ret =3D 1;
+done:
+	strbuf_release(&path);
+	return ret;
 }
=20
 int is_inside_git_dir(void)
diff --git a/strbuf.h b/strbuf.h
index 73e80ce..aec9fdb 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -116,6 +116,10 @@ extern void strbuf_add(struct strbuf *, const void=
 *, size_t);
 static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
 	strbuf_add(sb, s, strlen(s));
 }
+static inline void strbuf_addstr_at(struct strbuf *sb, size_t len, con=
st char *s) {
+	strbuf_setlen(sb, len);
+	strbuf_add(sb, s, strlen(s));
+}
 static inline void strbuf_addbuf(struct strbuf *sb, const struct strbu=
f *sb2) {
 	strbuf_grow(sb, sb2->len);
 	strbuf_add(sb, sb2->buf, sb2->len);
--=20
1.8.5.2.240.g8478abd
