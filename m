From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/28] update-server-info: do not publish shallow clones
Date: Mon, 25 Nov 2013 10:55:30 +0700
Message-ID: <1385351754-9954-5-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDM-0001fT-ED
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab3KYDv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:51:56 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62381 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:51:52 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so4613604pdj.30
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LFHYFLhRDBsaNXYC5L83j5gcNJsFfcTQAxB1bZNKpwc=;
        b=LjYOLX5O9+Cq6usmr5Lzj3tI7RVCOjsL1mPX+WJE4TMf8yV66FVZHC5SaHURN1Xfij
         iAcNCilf90L2tzQVQF6HSt5jVlS0pN2jNhHhsyxFriEcdjdSyQcmaiK9YNFin6DbUbgt
         KKtuEsVRZEkChaPGV/xhsYCJBxOwTlYGtNpym+Gz4NZRSsowyRHQMluvIaRP1uTTkIfl
         Ag3i254ptAmuL5FHyZW4KygmoD8rUxlSNGOP85eZk1x34kD8eWAq6YBPuV8gmfkXT/yU
         Dk+iq+z75/XTR0ayOsfJi09f6Pz8KrpF//sGy1MlBnl4/mU6ypxf/hn7Swb3NAt198qZ
         UKgQ==
X-Received: by 10.68.236.133 with SMTP id uu5mr561388pbc.153.1385351511851;
        Sun, 24 Nov 2013 19:51:51 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id gg10sm69688896pbc.46.2013.11.24.19.51.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:51:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238273>

Dumb commit walker does not care about .git/shallow and until someone
steps up to make it happen, let's not publish shallow clones using
dumb protocols.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 server-info.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/server-info.c b/server-info.c
index 9ec744e..a8df6a5 100644
--- a/server-info.c
+++ b/server-info.c
@@ -33,6 +33,10 @@ static int update_info_refs(int force)
 	strcpy(path1 + len, "+");
=20
 	safe_create_leading_directories(path0);
+	if (is_repository_shallow()) {
+		unlink(path0);
+		return error("info/refs not updated for shallow clone");
+	}
 	info_ref_fp =3D fopen(path1, "w");
 	if (!info_ref_fp)
 		return error("unable to update %s", path1);
@@ -217,6 +221,11 @@ static int update_info_packs(int force)
 	strcpy(name, infofile);
 	strcpy(name + namelen, "+");
=20
+	if (is_repository_shallow()) {
+		unlink(infofile);
+		return error("info/packs not updated for shallow clone");
+	}
+
 	init_pack_info(infofile, force);
=20
 	safe_create_leading_directories(name);
--=20
1.8.2.83.gc99314b
