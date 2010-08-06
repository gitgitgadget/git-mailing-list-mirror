From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pack-object: trim memory usage a tiny bit
Date: Sat,  7 Aug 2010 00:00:57 +0700
Message-ID: <1281114057-5982-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 07 01:54:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhWkW-0006H1-GU
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 01:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761303Ab0HFXys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 19:54:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33547 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0HFXyq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 19:54:46 -0400
Received: by pwj7 with SMTP id 7so716310pwj.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=LrMhdLkY5coApevj/icDy/KuXfC4AETORMuxKZaQA7s=;
        b=KDIiraUqNr3buyIoLMEloaZe41crzvpOouS2Q5xbWDd9Dw0pDc6Se/z5JwF1d2h0KU
         x9jVg/2uBpMKkv96lIOFUDax5ygLnl3aT/m5K9MZngcBOC8rQBidDkVo3DCbznF3Ak5+
         Es8YPohPfFGOw0Y1Ed5lanzTwdiOy6UhYvN50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=bZE0CnKcbeFRgtbLaXxRF1ySTyr35hWlv4EUNSF6vDJo7lWtUfG45RtMeZ1oRtmjjo
         yA+NL2XGLP7VDSITafvnt4a/YR6t0t16Ub4JJBTPIJ2fdY8lT1ZRTYbDjFYVkesE8xgy
         HNxDoGDvX7UPA4Ig6hiKZRpzhLMKwF7oIHYKw=
Received: by 10.142.172.17 with SMTP id u17mr10954717wfe.258.1281138885814;
        Fri, 06 Aug 2010 16:54:45 -0700 (PDT)
Received: from dektop ([121.91.125.209])
        by mx.google.com with ESMTPS id z1sm2084853wfd.3.2010.08.06.16.54.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 16:54:44 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat,  7 Aug 2010 00:00:59 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152825>

This shrinks struct object_entry from 88 bytes to 80 bytes on my 32
bit machine. So that would be 12M less on linux-2.6.git (1.6M objects)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Don't know if it's really worth a patch..

 builtin/pack-objects.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..398c0bb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -47,14 +47,14 @@ struct object_entry {
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	unsigned int hash;	/* name hint hash */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
+	enum object_type type:5;
+	enum object_type in_pack_type:5;	/* could be delta */
 	unsigned char in_pack_header_size;
-	unsigned char preferred_base; /* we do not pack this, but is availabl=
e
-				       * to be used as the base object to delta
-				       * objects against.
-				       */
-	unsigned char no_try_delta;
+	unsigned char preferred_base:1; /* we do not pack this, but is availa=
ble
+					 * to be used as the base object to delta
+					 * objects against.
+					 */
+	unsigned char no_try_delta:1;
 };
=20
 /*
@@ -1001,6 +1001,7 @@ static void check_object(struct object_entry *ent=
ry)
 		unsigned int avail;
 		off_t ofs;
 		unsigned char *buf, c;
+		enum object_type in_pack_type;
=20
 		buf =3D use_pack(p, &w_curs, entry->in_pack_offset, &avail);
=20
@@ -1009,8 +1010,9 @@ static void check_object(struct object_entry *ent=
ry)
 		 * since non-delta representations could still be reused.
 		 */
 		used =3D unpack_object_header_buffer(buf, avail,
-						   &entry->in_pack_type,
+						   &in_pack_type,
 						   &entry->size);
+		entry->in_pack_type =3D in_pack_type;
 		if (used =3D=3D 0)
 			goto give_up;
=20
--=20
1.7.1.rc1.69.g24c2f7
