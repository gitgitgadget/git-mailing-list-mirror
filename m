From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] sha1_file: refuse to write trees referring to external objects
Date: Thu, 24 Jan 2013 15:42:17 +0700
Message-ID: <1359016940-18849-4-git-send-email-pclouds@gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIPC-0002tk-A3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 09:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab3AXInJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 03:43:09 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:56615 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3AXInH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 03:43:07 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so4154206dak.16
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Uv0vIgDJkX7cGzsCXyit4xmAPCCPpHo+iAzRj+3gDxI=;
        b=gScTP7X7Cde6YKBSgtSc1rFXCpAHyzSYZqXPAXH8uNDE5OrGiDGJXEgSSvAS5FR5zl
         iD/AzhaZdf4KKTZkvOXLs2cxZsBmg/Oer++j7wFQ7eO+3/Zw8X5yMZLa919psQtjlCOt
         0Feo5R155FOkRM1J7/0ursi/GixvxaP1SgwYm3AnIerFFaDRo10S87BHQUv0K6J/P3it
         K0o9CdMiPr2EAnRwlgid3zkqTkk2Sf2fDuli9w8PL+AzZ+MqHUJpozYmomIPh72toQ72
         t0FjbxQLuerrxq5As1zfktz/zX/w6AG29wvKSjmpJNAzTRq+HNEmzVgcse6jM9tgzJRh
         BiGw==
X-Received: by 10.68.216.201 with SMTP id os9mr2918450pbc.36.1359016986497;
        Thu, 24 Jan 2013 00:43:06 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pm8sm14490284pbb.29.2013.01.24.00.43.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 00:43:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2013 15:42:42 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
In-Reply-To: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214415>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 5948dcb..ec3a040 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2643,6 +2643,29 @@ static void check_sha1_file_for_external_source(=
const char *buf,
 				    sha1_to_hex(sha1));
 			buf +=3D 48; /* "parent " + hex sha1 + "\n" */
 		}
+	} else if (!strcmp(type, "tree")) {
+		struct tree_desc desc;
+		struct name_entry entry;
+
+		init_tree_desc(&desc, buf, len);
+		while (tree_entry(&desc, &entry))
+			switch (entry.mode) {
+			case S_IFGITLINK:
+				/* we already know we probably don't have this SHA-1 */
+				break;
+			case S_IFDIR:
+				if (sha1_object_info_extended(entry.sha1, &oi) !=3D OBJ_TREE ||
+				    (oi.alt && oi.alt->external))
+					die("cannot create a tree with external tree %s",
+					    sha1_to_hex(entry.sha1));
+				break;
+			default:
+				if (sha1_object_info_extended(entry.sha1, &oi) !=3D OBJ_BLOB ||
+				    (oi.alt && oi.alt->external))
+					die("cannot create a tree with external blob %s",
+					    sha1_to_hex(entry.sha1));
+				break;
+			}
 	}
 }
=20
--=20
1.8.0.rc3.18.g0d9b108
