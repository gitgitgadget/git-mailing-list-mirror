From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 1/4] convert.c: refactor in order to skip conversion early without looking into file content
Date: Thu, 28 May 2009 15:29:07 +1000
Message-ID: <1243488550-15357-2-git-send-email-pclouds@gmail.com>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 07:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YBF-000273-M2
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 07:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181AbZE1F3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 01:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756302AbZE1F3F
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 01:29:05 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:32974 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbZE1F3D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 01:29:03 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so792455pxi.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=svKKnTiA6FY0IbNar1JJKQf21lTLtjyLtfd8E3DOp+s=;
        b=sZ6WDffOihB5z3FIL4fLOxGu56EEkc0pV3YalZRpQTUqLTE74D/oX77JNPakeTFH4Q
         abEPP+9jM6Fle14DjGYtF71HQ+1EACLXyJWqqRwpnqkIxeBEyN25mUFLih7iMJvcLm5k
         6bt7ULDFzHjTrhWTlhfJREwI83hdqd+h8AL5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fVx7Pmn2GJs1gMS9ygpkFpG76z3qli8ZIRtHOB74KYJ2DfcN9V8KCrDlODWqbB+Hr1
         4uxkvi3PPwIbIKC2+HOXh5Mf4Vh1/bFg0hjwVp0jnSgeXn3d1Q6P4SVHd9NixBHXj8OK
         gy/W08KjpBNTb3vgmk5P4q3Mm0pQNbO3DxjsM=
Received: by 10.114.175.16 with SMTP id x16mr535296wae.98.1243488544868;
        Wed, 27 May 2009 22:29:04 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id j26sm15019961waf.63.2009.05.27.22.29.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 22:29:02 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 28 May 2009 15:29:18 +1000
X-Mailer: git-send-email 1.6.3.1.257.gbd13
In-Reply-To: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120149>

convert_to_{git,working_tree} require the entire blob content in
memory. This is impossible for large files (especially files that
cannot be mapped into memory at all). Those files won't likely be
converted.

This patch moves out some condition checks that does not require file
content, then large file-related routines can do early check to see if
it's possible to skip conversion. If not, follow the common routes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |    2 +
 convert.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+------
 2 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index b8503ad..f3fc822 100644
--- a/cache.h
+++ b/cache.h
@@ -933,6 +933,8 @@ extern void trace_argv_printf(const char **argv, co=
nst char *format, ...);
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
                           struct strbuf *dst, enum safe_crlf checksafe=
);
 extern int convert_to_working_tree(const char *path, const char *src, =
size_t len, struct strbuf *dst);
+extern int convert_to_git_needed(const char *path, size_t len);
+extern int convert_to_working_tree_needed(const char *path, size_t len=
);
=20
 /* add */
 /*
diff --git a/convert.c b/convert.c
index 1816e97..809c3e8 100644
--- a/convert.c
+++ b/convert.c
@@ -120,13 +120,18 @@ static void check_safe_crlf(const char *path, int=
 action,
 	}
 }
=20
+static int crlf_to_git_noneed(const char *path, size_t len, int action=
)
+{
+	return (action =3D=3D CRLF_BINARY) || !auto_crlf || !len;
+}
+
 static int crlf_to_git(const char *path, const char *src, size_t len,
                        struct strbuf *buf, int action, enum safe_crlf =
checksafe)
 {
 	struct text_stat stats;
 	char *dst;
=20
-	if ((action =3D=3D CRLF_BINARY) || !auto_crlf || !len)
+	if (crlf_to_git_noneed(path, len, action))
 		return 0;
=20
 	gather_stats(src, len, &stats);
@@ -179,17 +184,19 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
 	return 1;
 }
=20
+static int crlf_to_worktree_noneed(const char *path, size_t len, int a=
ction)
+{
+	return 	(action =3D=3D CRLF_BINARY) || (action =3D=3D CRLF_INPUT) ||
+		auto_crlf <=3D 0 || !len;
+}
+
 static int crlf_to_worktree(const char *path, const char *src, size_t =
len,
                             struct strbuf *buf, int action)
 {
 	char *to_free =3D NULL;
 	struct text_stat stats;
=20
-	if ((action =3D=3D CRLF_BINARY) || (action =3D=3D CRLF_INPUT) ||
-	    auto_crlf <=3D 0)
-		return 0;
-
-	if (!len)
+	if (crlf_to_worktree_noneed(path, len, action))
 		return 0;
=20
 	gather_stats(src, len, &stats);
@@ -271,6 +278,11 @@ static int filter_buffer(int fd, void *data)
 	return (write_err || status);
 }
=20
+static int apply_filter_noneed(const char *path, const char *cmd)
+{
+	return cmd =3D=3D NULL;
+}
+
 static int apply_filter(const char *path, const char *src, size_t len,
                         struct strbuf *dst, const char *cmd)
 {
@@ -285,7 +297,7 @@ static int apply_filter(const char *path, const cha=
r *src, size_t len,
 	struct async async;
 	struct filter_params params;
=20
-	if (!cmd)
+	if (apply_filter_noneed(path, cmd))
 		return 0;
=20
 	memset(&async, 0, sizeof(async));
@@ -428,12 +440,20 @@ static int count_ident(const char *cp, unsigned l=
ong size)
 	return cnt;
 }
=20
+static int ident_conversion_noneed(const char *path, int ident)
+{
+	return !ident;
+}
+
 static int ident_to_git(const char *path, const char *src, size_t len,
                         struct strbuf *buf, int ident)
 {
 	char *dst, *dollar;
=20
-	if (!ident || !count_ident(src, len))
+	if (ident_conversion_noneed(path, ident))
+		return 0;
+
+	if (!count_ident(src, len))
 		return 0;
=20
 	/* only grow if not in place */
@@ -471,7 +491,7 @@ static int ident_to_worktree(const char *path, cons=
t char *src, size_t len,
 	char *to_free =3D NULL, *dollar;
 	int cnt;
=20
-	if (!ident)
+	if (ident_conversion_noneed(path, ident))
 		return 0;
=20
 	cnt =3D count_ident(src, len);
@@ -597,6 +617,28 @@ int convert_to_git(const char *path, const char *s=
rc, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ident);
 }
=20
+int convert_to_git_needed(const char *path, size_t len)
+{
+	struct git_attr_check check[3];
+	int crlf =3D CRLF_GUESS;
+	int ident =3D 0;
+	const char *filter =3D NULL;
+
+	setup_convert_check(check);
+	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+		struct convert_driver *drv;
+		crlf =3D git_path_check_crlf(path, check + 0);
+		ident =3D git_path_check_ident(path, check + 1);
+		drv =3D git_path_check_convert(path, check + 2);
+		if (drv && drv->clean)
+			filter =3D drv->clean;
+	}
+
+	return !apply_filter_noneed(path, filter) ||
+		!crlf_to_git_noneed(path, len, crlf) ||
+		!ident_conversion_noneed(path, ident);
+}
+
 int convert_to_working_tree(const char *path, const char *src, size_t =
len, struct strbuf *dst)
 {
 	struct git_attr_check check[3];
@@ -626,3 +668,29 @@ int convert_to_working_tree(const char *path, cons=
t char *src, size_t len, struc
 	}
 	return ret | apply_filter(path, src, len, dst, filter);
 }
+
+int convert_to_working_tree_needed(const char *path, size_t len)
+{
+	struct git_attr_check check[3];
+	int crlf =3D CRLF_GUESS;
+	int ident =3D 0;
+	const char *filter =3D NULL;
+
+	/*
+	 * any additional conversion should be added to
+	 * convert_to_working_tree_needed() as well
+	 */
+	setup_convert_check(check);
+	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
+		struct convert_driver *drv;
+		crlf =3D git_path_check_crlf(path, check + 0);
+		ident =3D git_path_check_ident(path, check + 1);
+		drv =3D git_path_check_convert(path, check + 2);
+		if (drv && drv->smudge)
+			filter =3D drv->smudge;
+	}
+
+	return !ident_conversion_noneed(path, ident) ||
+		!crlf_to_worktree_noneed(path, len, crlf) ||
+		!apply_filter_noneed(path, filter);
+}
--=20
1.6.3.1.257.gbd13
