From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/11] pack-objects: do not cache delta for v4 trees
Date: Sun,  8 Sep 2013 22:04:18 +0700
Message-ID: <1378652660-6731-10-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:02:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgVJ-0003ih-MB
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab3IHPCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:02:17 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39524 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3IHPCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:02:16 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so5200291pdi.27
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D7h7P/Pvwkw4Ux5kWxWGf75xvcUWod5sbAQYxzTkx0U=;
        b=ps6e/pmttyoRN2u5zhwBcVsCth9cqrHvwPGTJoHt+AX2GNZI+3v0UgMTCzvHsiC+l9
         IKY/zR4lcOxJZ1D4oHDhaI88uQmBXAY1RkMROyv8U/ygmGV6awm1BbNtSWmkk8SrQ8Xz
         PCdkGNUY4Ug7JqLofT36IDudwOaD8b8Ok/NYkVszpIBNOQEbdZeQTeyoOrD5uLsqvKnR
         sxR8kBa8wxE1AXG4lyyKctmgrhqYjShWi8HmT2O5Erdw7PDBPQ4vewLVGOliQVPoJ04V
         /hp1XgOTIRmSm+Q36H8p3P/Lks3HU+edHGpJC+YvRomcjBCmzq53DhFaN0Ta7+27uPOL
         sg5A==
X-Received: by 10.66.216.234 with SMTP id ot10mr3052976pac.122.1378652535254;
        Sun, 08 Sep 2013 08:02:15 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id py4sm10482651pbc.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:02:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:05:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234248>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 69a22c1..665853d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1759,8 +1759,12 @@ static void find_deltas(struct object_entry **li=
st, unsigned *list_size,
 		 * and therefore it is best to go to the write phase ASAP
 		 * instead, as we can afford spending more time compressing
 		 * between writes at that moment.
+		 *
+		 * For v4 trees we'll need to delta differently anyway
+		 * so no cache. v4 commits simply do not delta.
 		 */
-		if (entry->delta_data && !pack_to_stdout) {
+		if (entry->delta_data && !pack_to_stdout &&
+		    (pack_version < 4 || entry->type =3D=3D OBJ_BLOB)) {
 			entry->z_delta_size =3D do_compress(&entry->delta_data,
 							  entry->delta_size);
 			cache_lock();
--=20
1.8.2.83.gc99314b
