From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] sha1_file: refuse to write tags referring to external objects
Date: Thu, 24 Jan 2013 15:42:18 +0700
Message-ID: <1359016940-18849-5-git-send-email-pclouds@gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:43:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIPI-0002uT-3k
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 09:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab3AXInP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 03:43:15 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:63707 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab3AXInN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 03:43:13 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so5387100pad.9
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 00:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=JSDe9tkiDk7gnX9V2RPE+rImAGVou+Etp57Ki70AROI=;
        b=elhy07lZvaYxY3QR13vn7GZtVx7hyV5X+xc+n4Opae5/eWOWqQMkARQGxFX2H3Q0jI
         vwLSJc07l3r1fuxLA2hWx6yQEvriIJQC6hGXseNjOA6riMov26cD0qVgwT6uu9exp+yE
         +T07/F4zHFUJNdofrAw9XSXeDzwlP9huoZ8hcUhQ0UhDQJDUHN8YlWqW2DfcJ+kKhY9j
         eOCGOhMy9YCSuiMPTthzxvODI0ttNxE2v2NFPKlsWv3CCaSyrwz/66R6XcTeVDUwS12a
         +cw76s6Dz7bP/b0g2SZ/UYsj627zlHNyB0Yc8IJBCqXjt91lZnzSLuLj3wde9YjkqllW
         H1ew==
X-Received: by 10.68.204.103 with SMTP id kx7mr2951767pbc.33.1359016993027;
        Thu, 24 Jan 2013 00:43:13 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id vx2sm14489026pbc.33.2013.01.24.00.43.09
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 00:43:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2013 15:42:49 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
In-Reply-To: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214416>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index ec3a040..01681e5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2666,6 +2666,12 @@ static void check_sha1_file_for_external_source(=
const char *buf,
 					    sha1_to_hex(entry.sha1));
 				break;
 			}
+	} else if (!strcmp(type, "tag")) {
+		if (get_sha1_hex(buf + 7, sha1) < 0 ||
+		    sha1_object_info_extended(sha1, &oi) !=3D OBJ_TREE ||
+		    (oi.alt && oi.alt->external))
+			die("cannot create a tag with external tree %s",
+			    sha1_to_hex(sha1));
 	}
 }
=20
--=20
1.8.0.rc3.18.g0d9b108
