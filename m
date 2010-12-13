From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/19] pathspec: mark wildcard pathspecs from the beginning
Date: Mon, 13 Dec 2010 16:46:45 +0700
Message-ID: <1292233616-27692-9-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:49:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS51h-0004rO-NL
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab0LMJs5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:48:57 -0500
Received: from mail-iw0-f170.google.com ([209.85.214.170]:37332 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0LMJsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:48:55 -0500
Received: by mail-iw0-f170.google.com with SMTP id 6so8884031iwn.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2NpP8j/qnTgTBL8JUTUdoLiQHhYKukumx+rBGVdJs3Q=;
        b=PI3jiDtIPnXm9pTpQF9c29/gxkrvScIKZw9bQ8WnXMTi/HKq2ETPEKsMpxCXtyYWi9
         w7WnIa5PmM1df4vwnjFtcBhaREuh3H4TYSgBnBsnKe9fqfEXEOYqjIQ5O9rT6lgKscJ4
         J//vCg0awYov06RpqrRjtar2caeLiYbGzXIFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nSLexoOVFmhAzDAK6Sk4qfdUT9PuUcvCeTNLNpS76xdHA44xzouAuZeYSjXwwXjjqW
         8x6XLDXENt7oFBin91k8vLigpAL2apYzP6tXI8LKqq0WU/UXAdNR5W1xOBDGxSyZt/Va
         +33/lbYJ3X3j2ATdR+DvOaH0r22xf2o5w2AsM=
Received: by 10.42.165.136 with SMTP id k8mr2533907icy.456.1292233735518;
        Mon, 13 Dec 2010 01:48:55 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id gy41sm6056044ibb.23.2010.12.13.01.48.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:48:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:02 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163537>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 prefix_len was used, but no longer. Still hesitate to remove it. It
 might get used again..

 cache.h |    4 +++-
 dir.c   |   13 +++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 36819b6..3a1acf1 100644
--- a/cache.h
+++ b/cache.h
@@ -496,8 +496,10 @@ extern int ie_modified(const struct index_state *,=
 struct cache_entry *, struct
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
+	int has_wildcard:1;
 	struct pathspec_item {
-		int len;
+		int len, prefix_len;
+		int has_wildcard:1;
 	} *items;
 };
=20
diff --git a/dir.c b/dir.c
index 646c79f..0987d0c 100644
--- a/dir.c
+++ b/dir.c
@@ -1089,8 +1089,17 @@ int init_pathspec(struct pathspec *pathspec, con=
st char **paths)
 	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->nr=
);
 	for (i =3D 0; i < pathspec->nr; i++) {
 		struct pathspec_item *item =3D pathspec->items+i;
-
-		item->len =3D strlen(paths[i]);
+		const char *path =3D paths[i];
+
+		item->len =3D strlen(path);
+		item->has_wildcard =3D !no_wildcard(path);
+		if (item->has_wildcard) {
+			pathspec->has_wildcard =3D 1;
+			item->prefix_len =3D 0;
+			while (item->prefix_len < item->len &&
+			       strchr("*?[{\\", path[item->prefix_len]) =3D=3D NULL)
+				item->prefix_len++;
+		}
 	}
 	return 0;
 }
--=20
1.7.3.3.476.g10a82
