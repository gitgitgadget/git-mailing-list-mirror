From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/24] read-cache.c: split racy stat test to a separate function
Date: Sun,  8 Mar 2015 17:12:36 +0700
Message-ID: <1425809567-25518-14-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYE6-0003YU-Ou
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbbCHKOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:14:22 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38526 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbCHKOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:14:22 -0400
Received: by pdbfl12 with SMTP id fl12so56281094pdb.5
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mq951DenREY98dYQdiczt6ostvoWWyzg5f4SATHBLrI=;
        b=gYc3Gp1HWqSN8wG6annq+Kx1sESw4Jkf+w6Ur0AOtmqutBcQFBIKyBL9r+WPLf4Ep8
         AnkCe7k2AacsgdvKfwDY9vPSolCsj+ZBxDsvwSLqYT23xxTBydIQwsC3vFzbeBPYNNgr
         +Dbt6Q6LlWkoNeeLyEBE9e2JksVFaOOmOlpSoal/hYmmq7iAefv4rvu2claf6uvLlEkr
         UgsLW+xSz+YNolHuurQa34wV8PRK7Mo+Z7N7C8wuye/erS0diMfXk00B6s7hz11wkKTp
         z32mFC3W5RuCUSDEG3w5++8d1lmuYLP0T5tfTkdwUnpKWUQuDIh8n7Zyhe8AgElPXJUj
         y9Qg==
X-Received: by 10.67.8.73 with SMTP id di9mr40792184pad.107.1425809661504;
        Sun, 08 Mar 2015 03:14:21 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id di10sm14481940pad.41.2015.03.08.03.14.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:14:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:14:17 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265067>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d643a3f..f12a185 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -270,20 +270,26 @@ static int ce_match_stat_basic(const struct cache=
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
2.3.0.rc1.137.g477eb31
