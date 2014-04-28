From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/32] read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
Date: Mon, 28 Apr 2014 17:55:51 +0700
Message-ID: <1398682553-11634-31-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejFR-0003tZ-U1
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbaD1K5Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:16 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34798 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaD1K5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:57:13 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so1304291pde.41
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xj9uN5wW71gFHaRVyiyxc9/VHfW3fCul5YJsyrVMGBY=;
        b=itq7HHU8puv5a/vQna3FHqkwsY1Ho4INpSEXRrcFWpyIkczJ+AopimxrGcjsnKWMny
         CSUv037X+8rM/ihbVA8z6ZoInqJ975Q9R3pBBoh7ACjxLx+IUz8aNyqaPEhFVBc7OKSG
         txyif41cH+H+i8xsFK72KpbHQpVqTkQHpznFIUc9G4WJnHjA08KXnTxeAkaIoVrqAF+4
         dUO+iX9M3fSto3kV0WM8jfkS5UAwZBOfrVZ40Rm0kTKi1etBlD+rzSRYyNrFUyE3d8J3
         GP3u4yM5fgKVMjWbBjUAZxKQDSvdnLh/QsyBcCHHzUHy+9lLwNOZ1lXa5cRxGurFhMuM
         4JJw==
X-Received: by 10.66.141.109 with SMTP id rn13mr22609333pab.117.1398682632387;
        Mon, 28 Apr 2014 03:57:12 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id ey5sm89637805pab.22.2014.04.28.03.57.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:57:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:40 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247292>

This could be used to run the whole test suite with split
indexes. Index splitting is carried out at random. "git read-tree"
also resets the index and forces splitting at the next update.

I had a lot of headaches with the test suite, which proves it
exercises split index pretty good.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 568bc20..831b67e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1885,8 +1885,11 @@ static int do_write_index(struct index_state *is=
tate, int newfd,
 		}
 	}
=20
-	if (!istate->version)
+	if (!istate->version) {
 		istate->version =3D get_index_format_default();
+		if (getenv("GIT_TEST_SPLIT_INDEX"))
+			init_split_index(istate);
+	}
=20
 	/* demote version 3 to version 2 when the latter suffices */
 	if (istate->version =3D=3D 3 || istate->version =3D=3D 2)
@@ -2077,6 +2080,11 @@ int write_locked_index(struct index_state *istat=
e, struct lock_file *lock,
 		return do_write_locked_index(istate, lock, flags);
 	}
=20
+	if (getenv("GIT_TEST_SPLIT_INDEX")) {
+		int v =3D si->base_sha1[0];
+		if ((v & 15) < 6)
+			istate->cache_changed |=3D SPLIT_INDEX_ORDERED;
+	}
 	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
 		int ret =3D write_shared_index(istate, lock, flags);
 		if (ret)
--=20
1.9.1.346.ga2b5940
