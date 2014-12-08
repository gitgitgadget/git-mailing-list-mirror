From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/23] read-cache.c: split racy stat test to a separate function
Date: Mon,  8 Dec 2014 21:04:57 +0700
Message-ID: <1418047507-22892-15-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxyn7-0004nB-Re
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbaLHNzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:55:54 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49598 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbaLHNzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:55:53 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so5240117pad.24
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xSvjrwT9yml8o2+T2Z1CG1FzHWLqLJ8RRhbHD3bF3Fg=;
        b=DVIcmRPTCNkr0JQY9gp7pOz5FYGWxS3JP+RfK6sUIB5JHViy/3UXzvviIbSu959Tvd
         7PWAFRUAYtXUIpSxkaCc7pEoSOYzqNRqTvQ2o8twOjPscXkzjqzzoEecYmH8fYqQ2uH3
         NFbB9dBbnyLD6MOdo/42D9zY81sRBFik7LVLzbmWx1SSfd7qHgwUTc6CBE46qB9r3dcn
         br/QxkHDKLgA99/rqq5Ur3CkryaUtJA5W3wZsN5U54i2jP9d7auc+RpYoYJh5ZozKEo0
         ZRjt9OTkE0AgifjESD25dmWHL4D6GroUbws/d8B6QoyeuUG6AP32GAzwoJL6vuR8BtCN
         lvJA==
X-Received: by 10.66.182.130 with SMTP id ee2mr54256073pac.22.1418046952871;
        Mon, 08 Dec 2014 05:55:52 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id j5sm36665966pdp.9.2014.12.08.05.55.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:55:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:28 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261031>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.2.0.60.gb7b3c64
