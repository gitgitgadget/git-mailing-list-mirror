From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] pathspec: mark wildcard pathspecs from the beginning
Date: Mon, 20 Sep 2010 09:29:56 +1000
Message-ID: <1284939000-16907-2-git-send-email-pclouds@gmail.com>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 01:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTLB-0001WE-Mt
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab0ISXaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:30:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0ISXaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:30:16 -0400
Received: by pvg2 with SMTP id 2so1011131pvg.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uIedazRTJyJAa2azTyTKTcCy2CaOe29bVoTjanOJuS8=;
        b=sYc4tbtWTCvoLQ+kFbJxoVB0TTFeySHPIksD6vxkFILkw8YaRLQ/2WmDYa0nEjZZRb
         hYAVE+F7uUa5QMmp2YNw4Hbm6XdXm3FsXuIs8IOzR2kAVNlAdcgZe1DegNwlu1NABbZZ
         EaBa+GjgCEMptO+V7oVVGIvBVTP79au8IFEhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s3kJt/oiJnmDXRdjgEqtC55CL4Rfw+LebswlW151n/qUhVTYdibtPMej/Q3XSwC3ZF
         c14s7rsdZz9A/vtOApHoVjIZbrDQRr10VzrfMKc4jPNg0l7f9dzt+3DGgfJKxVZv/gkM
         EA1eKtHtBSfUmF6tMZ5whh3/Z+4dJJR9MlTw4=
Received: by 10.143.8.3 with SMTP id l3mr6960929wfi.125.1284939016148;
        Sun, 19 Sep 2010 16:30:16 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id y36sm5969423wfd.6.2010.09.19.16.30.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:30:15 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:30:10 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156532>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 match_pathspec() should be converted to use this as well. Not now
 though.

 cache.h |    2 ++
 dir.c   |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 045c9fc..7a3e0a0 100644
--- a/cache.h
+++ b/cache.h
@@ -495,8 +495,10 @@ extern int ie_modified(const struct index_state *,=
 struct cache_entry *, struct
 struct pathspec {
 	const char **raw;
 	int nr;
+	int has_wildcard:1;
 	struct pathspec_item {
 		int len;
+		int has_wildcard:1;
 	} *items;
 };
=20
diff --git a/dir.c b/dir.c
index 80b2df2..a44c7b3 100644
--- a/dir.c
+++ b/dir.c
@@ -1088,7 +1088,12 @@ int init_pathspec(struct pathspec *pathspec, con=
st char **paths)
=20
 	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->nr=
);
 	for (i =3D 0; i < pathspec->nr; i++) {
-		pathspec->items[i].len =3D strlen(paths[i]);
+		struct pathspec_item *item =3D pathspec->items+i;
+
+		item->len =3D strlen(paths[i]);
+		item->has_wildcard =3D !no_wildcard(paths[i]);
+		if (item->has_wildcard)
+			pathspec->has_wildcard =3D 1;
 	}
 	return 0;
 }
--=20
1.7.1.rc1.70.g788ca
