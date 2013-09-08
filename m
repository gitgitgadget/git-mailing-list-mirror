From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/11] pack-objects: exclude commits out of delta objects in v4
Date: Sun,  8 Sep 2013 22:04:19 +0700
Message-ID: <1378652660-6731-11-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:02:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgVO-0003pv-Ki
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab3IHPCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:02:22 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61024 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3IHPCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:02:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so5165764pdj.18
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FnheAdwAgAwiOH3rtjEzoZLJmpfjDadCSu0oy4iWc14=;
        b=WPeOS5FVgaNsknRJBxnICPs/NQl6OTZzhmYUTLVoXWkspahNlOtMLJQS+pYvIsV3I6
         /jbsltPlMQz+STLq6pTHcJm7rnG/lPPgeHf//LIZ9921d+sNgjMkzy7LFWHEUdWhQHZR
         l2r3/EesFd3/CFEABpNaVzQtYDS1qOyORT/ecaaqe0DVv4h+v8YL5YgUxq9SqO2PlB8R
         blemyMr1MtpABz/0KPn+A9KWpDUTZrKkFb24StLNbcA4sdL12uXgyFWfIxmyFf/5LClK
         aJds11jJyEDu4ctfDgXW0Ga614lj7MkYC8v4hbKwSbbZ++h/kCD6WbFvmRkq/MiPxL71
         uYZw==
X-Received: by 10.66.146.42 with SMTP id sz10mr15224114pab.100.1378652541073;
        Sun, 08 Sep 2013 08:02:21 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id 7sm11433561paf.22.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:02:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:05:29 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234249>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 665853d..daa4349 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1332,7 +1332,8 @@ static void check_object(struct object_entry *ent=
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
@@ -1416,6 +1417,8 @@ static void get_object_details(void)
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
