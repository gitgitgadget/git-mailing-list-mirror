From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] dir.c: get rid of the wildcard symbol set in no_wildcard()
Date: Thu,  7 Jun 2012 14:53:35 +0700
Message-ID: <1339055617-23028-2-git-send-email-pclouds@gmail.com>
References: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 09:54:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScXXk-0005zt-5m
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 09:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761Ab2FGHyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 03:54:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36260 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab2FGHyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 03:54:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so706664pbb.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UXJO2KyDHMSbiAijNtjPxANFkRs0u9KZPufm9FgUdPU=;
        b=c9pylVpAhQLvlbGFr6kxZOZAFyxZ7A1UJbi2OpNpXOd7y5WMnRPs+wGurYlEXbHtz9
         QkjM2hkMCg1d9GvR7zBm2cdDVAoAu5Wgw5IbTwp3uA9CBYDd+Ij6Sb78i6w+HXB9I5Wb
         OK4W9N1wbc4puEhfGXFqlTNH5UmihBx8oMGQRv3uWVuYLRoBpKlk2jlEYZQNwqAN/Bfb
         fFqeSDKvnD3wj9CLn2yV1ql9HsGwxXe3WctAelpy5MBYFSUDooW1dWTGY+l7lkuRKn/s
         taCZ9KV7OT6f0gMyC4aBufDsa3ux1Nk+IKPzNIygrn4Bs8vLPsTLVwIKMTUcZI73a8M1
         D/Jw==
Received: by 10.68.201.195 with SMTP id kc3mr6846175pbc.33.1339055641656;
        Thu, 07 Jun 2012 00:54:01 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wn3sm3245707pbc.74.2012.06.07.00.53.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 00:54:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 14:53:47 +0700
X-Mailer: git-send-email 1.7.11.rc1.185.g281ad67
In-Reply-To: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199377>

Elsewhere in this file is_glob_special() is also used to check for
wildcards, which is defined in ctype. Make no_wildcard() also use this
function (indirectly via simple_length())

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index e756de1..bbf958c 100644
--- a/dir.c
+++ b/dir.c
@@ -288,9 +288,24 @@ int match_pathspec_depth(const struct pathspec *ps=
,
 	return retval;
 }
=20
+/*
+ * Return the length of the "simple" part of a path match limiter.
+ */
+static int simple_length(const char *match)
+{
+	int len =3D -1;
+
+	for (;;) {
+		unsigned char c =3D *match++;
+		len++;
+		if (c =3D=3D '\0' || is_glob_special(c))
+			return len;
+	}
+}
+
 static int no_wildcard(const char *string)
 {
-	return string[strcspn(string, "*?[{\\")] =3D=3D '\0';
+	return string[simple_length(string)] =3D=3D '\0';
 }
=20
 void add_exclude(const char *string, const char *base,
@@ -997,21 +1012,6 @@ static int cmp_name(const void *p1, const void *p=
2)
 				  e2->name, e2->len);
 }
=20
-/*
- * Return the length of the "simple" part of a path match limiter.
- */
-static int simple_length(const char *match)
-{
-	int len =3D -1;
-
-	for (;;) {
-		unsigned char c =3D *match++;
-		len++;
-		if (c =3D=3D '\0' || is_glob_special(c))
-			return len;
-	}
-}
-
 static struct path_simplify *create_simplify(const char **pathspec)
 {
 	int nr, alloc =3D 0;
--=20
1.7.11.rc1.185.g281ad67
