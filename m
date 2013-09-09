From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/16] pack-objects: exclude commits out of delta objects in v4
Date: Mon,  9 Sep 2013 20:58:01 +0700
Message-ID: <1378735087-4813-11-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1x1-0003aD-ID
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3IIN4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:56:18 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58237 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab3IIN4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:56:17 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so6300391pab.12
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6X3vAWrnnc2KeByarSq9sOTIxCqdbLEY/KWHa7WBMiE=;
        b=fIb1++e3GzZO+bu52cn6hGOxEPOLMsnLS7U03cinwv9UggY0f1cl9b6/9Ywqwiatfv
         uhrXNLPWDbkkYa2anxgwK0kb1FcESTmgp5fztlaUvMo9X+mvNYEN+3+/F/2hOSjIvP++
         W2qojDSRVsiy7TzzOjhqZtU305d94zQPR3TNQ8xEyRZZqNMiXOs8t4Dsz+mCRFuzqoyD
         RE8f1K+BmRe7Da8AHB0YGkqhEhFcC/g4pYh8Yd/J0BqctyNPwjmNDJWtFNm40VOmnSGc
         YhV9yh8WIQCwgOzkPBB3/s13oVCRlPsdgrw8iW7kCyRikmH1YtSJIZG8N0Bt+s4F3AOX
         09kg==
X-Received: by 10.66.196.168 with SMTP id in8mr20083203pac.18.1378734977093;
        Mon, 09 Sep 2013 06:56:17 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id py4sm16445324pbc.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:56:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:59:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234338>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9613732..fb2394d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1329,7 +1329,8 @@ static void check_object(struct object_entry *ent=
ry)
 			break;
 		}
=20
-		if (base_ref && (base_entry =3D locate_object_entry(base_ref))) {
+		if (base_ref && (base_entry =3D locate_object_entry(base_ref)) &&
+		    (pack_version < 4 || entry->type !=3D OBJ_COMMIT)) {
 			/*
 			 * If base_ref was set above that means we wish to
 			 * reuse delta data, and we even found that base
@@ -1413,6 +1414,8 @@ static void get_object_details(void)
 		check_object(entry);
 		if (big_file_threshold < entry->size)
 			entry->no_try_delta =3D 1;
+		if (pack_version =3D=3D 4 && entry->type =3D=3D OBJ_COMMIT)
+			entry->no_try_delta =3D 1;
 	}
=20
 	free(sorted_by_offset);
--=20
1.8.2.83.gc99314b
