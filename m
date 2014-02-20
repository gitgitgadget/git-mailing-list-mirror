From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] sha1_file: fix delta_stack memory leak in unpack_entry
Date: Fri, 21 Feb 2014 06:47:47 +0700
Message-ID: <1392940067-4830-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 21 00:47:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGdL8-0003kH-9b
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 00:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbaBTXre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 18:47:34 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37516 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbaBTXrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 18:47:33 -0500
Received: by mail-pd0-f171.google.com with SMTP id g10so2479057pdj.16
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=LT1Q6OYzAptxO8hT1L1l7nc03t1D1+51PW6iKsJ/CbQ=;
        b=Ir4d7d429+4R01peYI9EB5Vdl6+1gAp2vypWDzMoVLDdTX4e4jDECYeFQ8HfrDO9gx
         /0B9nLpxwmk37yW/dcymiymHzAOly/yRsHx85IbVGgGluVUOuUKaZSbYIa/E9qvKU1GD
         q0FSI3JGyGzNkJKKC+R73Tc01YN28upIOkgEIljGv+5Sajt+DfBg8g4/u6s0vQtb6L3s
         8H26ohMcT/qIVKrzqWdASeMSj7yix/Kb/6x9zQhG9pXc4vs/tEbF/F/K2vSJpOipYiuI
         Iy2mwJR4IGbqUNBNt7SDwtgmLXOObGTJ5ztR5Dj7ez96yT0Oiemfqwl1W4YJbRV76pGk
         kxWA==
X-Received: by 10.68.162.66 with SMTP id xy2mr5402022pbb.46.1392940052751;
        Thu, 20 Feb 2014 15:47:32 -0800 (PST)
Received: from lanh ([115.73.201.165])
        by mx.google.com with ESMTPSA id fk4sm35611639pab.23.2014.02.20.15.47.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Feb 2014 15:47:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Feb 2014 06:47:48 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242452>

This delta_stack array can grow to any length depending on the actual
delta chain, but we forget to free it. Normally it does not matter
because we use small_delta_stack[] from stack and small_delta_stack
can hold 64-delta chains, more than standard --depth=3D50 in pack-objec=
ts.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Found when trying to see if making some objects loose at this phase
 could help git-blame and how many objects will be loosened. Gotta go
 soon, didn't really test it, but I bet it'll work.

 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 6e8c05d..57ab15d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2289,6 +2289,10 @@ void *unpack_entry(struct packed_git *p, off_t o=
bj_offset,
 	*final_size =3D size;
=20
 	unuse_pack(&w_curs);
+
+	if (delta_stack !=3D small_delta_stack)
+		free(delta_stack);
+
 	return data;
 }
=20
--=20
1.9.0.40.gaa8c3ea
