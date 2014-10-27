From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/19] read-cache.c: split racy stat test to a separate function
Date: Mon, 27 Oct 2014 19:10:39 +0700
Message-ID: <1414411846-4450-13-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij9L-000341-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaJ0MLr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:47 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37096 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbaJ0MLq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:46 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so5324489pad.7
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zPhTlbz5e2Yjk8NmhQ0PQbIEFJ2vdipnlgT1jTMbRYc=;
        b=RU45mboLajHvv7WvRVDNIveqg2dl4ql1mBsakncxlqNgTB+v1oBT6ZxTcipk9/gFrE
         4LeshR51RP/G6R36vvBXG9BRxYiSlDqLZ7stVT4NAMnPAkQ14zh2yQl5WCgLeEv9N38p
         DKQP6V9ukfuwnq+R8CD811BAC9sITyDv9tE1QXtvVcii7i4MJUJ8sDbHrGiXdNTEmAQG
         7tEns1XBHMhlU5ze5ljbhkmcs96sbNxhyAv+oiokBiJEFupaP8CpuoUNWOxMEUlO8mvF
         cV19mojyaeryjjzv7U9P2zI+a5sSmPPc/yYTiBYNoghYLyL2QhGbGVVt6rFXzz31j88g
         fWvg==
X-Received: by 10.70.92.68 with SMTP id ck4mr23958473pdb.28.1414411906482;
        Mon, 27 Oct 2014 05:11:46 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id u6sm10782526pdi.61.2014.10.27.05.11.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:49 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index feb10b0..a14646b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -271,20 +271,26 @@ static int ce_match_stat_basic(const struct cache=
_entry *ce, struct stat *st)
 	return changed;
 }
=20
-static int is_racy_timestamp(const struct index_state *istate,
-			     const struct cache_entry *ce)
+static int is_racy_stat(const struct index_state *istate,
+			const struct stat_data *sd)
 {
-	return (!S_ISGITLINK(ce->ce_mode) &&
-		istate->timestamp.sec &&
+	return (istate->timestamp.sec &&
 #ifdef USE_NSEC
 		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < ce->ce_stat_data.sd_mtime.sec ||
-		 (istate->timestamp.sec =3D=3D ce->ce_stat_data.sd_mtime.sec &&
-		  istate->timestamp.nsec <=3D ce->ce_stat_data.sd_mtime.nsec))
+		(istate->timestamp.sec < sd->sd_mtime.sec ||
+		 (istate->timestamp.sec =3D=3D sd->sd_mtime.sec &&
+		  istate->timestamp.nsec <=3D sd->sd_mtime.nsec))
 #else
-		istate->timestamp.sec <=3D ce->ce_stat_data.sd_mtime.sec
+		istate->timestamp.sec <=3D sd->sd_mtime.sec
 #endif
-		 );
+		);
+}
+
+static int is_racy_timestamp(const struct index_state *istate,
+			     const struct cache_entry *ce)
+{
+	return (!S_ISGITLINK(ce->ce_mode) &&
+		is_racy_stat(istate, &ce->ce_stat_data));
 }
=20
 int ie_match_stat(const struct index_state *istate,
--=20
2.1.0.rc0.78.gc0d8480
