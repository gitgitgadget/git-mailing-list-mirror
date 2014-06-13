From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/32] read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
Date: Fri, 13 Jun 2014 19:19:49 +0700
Message-ID: <1402661991-14977-31-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:23:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQVY-0004xI-NW
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbaFMMW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:56 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64299 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaFMMW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:56 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so2105233pab.22
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gsO6yZGd35MdaoyyCQZVo37/lRSY/I/aUlkvGEUBXKk=;
        b=noKkaaefGKTZhInAyfUQI+CoF1kCryGaOgCiNikbN/epp38CHyDsDJ5idlAeG3MIHX
         no6xMKcRX1MspZvRFY0yCDb2YxqZAJw6DThWl3MaOkb/Mjy0IMgX3+oL1YwzxEXy2JlP
         5PkWOsDyHLB1exP4D8R+ZJthpAx/gQbcmZso8/t9LKvrAEUzkTr19y6XDr+4QDBPgsmG
         fma07p/sTm1Bz/ISN2gxh+5PJOHVR0QU97ulYnnk7ORtGGIKGbZof5j4UQGJr9o9FZ+V
         /hwNkqYybt0hEBY2P0w9cqG/Zws7DPaO+6NdGFLGa1BxI0yVoWH6SykVjHHOQnFBD37j
         OW8Q==
X-Received: by 10.68.215.68 with SMTP id og4mr2945001pbc.112.1402662175834;
        Fri, 13 Jun 2014 05:22:55 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id pl10sm3396993pbb.56.2014.06.13.05.22.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:55 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251587>

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
index b1027f7..12335a3 100644
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
