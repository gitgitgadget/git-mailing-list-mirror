From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/10] archive-tar: allow to accumulate writes before writing 512-byte blocks
Date: Wed,  2 May 2012 20:25:17 +0700
Message-ID: <1335965122-17458-6-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:29:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZcs-0000uz-NY
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab2EBN3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:29:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab2EBN3p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:29:45 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1097342pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hSr2rAI74zOEbzsEGrdJpMxuVO0RjVRm6PRJXW2t/5g=;
        b=MgIy/odIyhmjjQNY2jxVKm8Bgi3Icd7IjJczL/FH/7PAnBB4ZezyeYGFJYHvEaaUfe
         e71354Eywqm/OHft71z6fm1QwlbCsQNASir9JKCJn+wagi+6bOjX6iJ7M7jkEwwe+Dy3
         S1KD/mYr25lEeiIzQuQt4DyVqIqJDrJ7hClgnCoKNaQi9LIWMn9VvzKdObkvKtV7Rjq5
         s67Mj9BShoyRFPNwBwq1x3JAUoFPBgFXAsOn5jYUZFgaQtbriVTQoLbTHvVFFq7Z9cup
         cBSPXFad7amOrTGWgapEDAIkAiQ47zA9q5Nc+aaLCR5C7t8c8DWccAMBM7clvi7AiWpa
         HLtg==
Received: by 10.68.223.227 with SMTP id qx3mr41882410pbc.1.1335965385219;
        Wed, 02 May 2012 06:29:45 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id q5sm1992906pbp.28.2012.05.02.06.29.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:29:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:26:15 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196808>

This allows to split single write_blocked(buf, 123) call into multiple
calls

write_blocked(buf, 100, 1);
write_blocked(buf,  23, 1);
write_blocked(buf,   0, 0);

No call sites do this yet though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3be0cdf..9060f9a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -30,7 +30,7 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void write_blocked(const void *data, unsigned long size)
+static void write_blocked(const void *data, unsigned long size, int pa=
rtial)
 {
 	const char *buf =3D data;
 	unsigned long tail;
@@ -54,6 +54,8 @@ static void write_blocked(const void *data, unsigned =
long size)
 		memcpy(block + offset, buf, size);
 		offset +=3D size;
 	}
+	if (partial)
+		return;
 	tail =3D offset % RECORDSIZE;
 	if (tail)  {
 		memset(block + offset, 0, RECORDSIZE - tail);
@@ -155,8 +157,8 @@ static int write_extended_header(struct archiver_ar=
gs *args,
 	mode =3D 0100666;
 	sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
 	prepare_header(args, &header, mode, size);
-	write_blocked(&header, sizeof(header));
-	write_blocked(buffer, size);
+	write_blocked(&header, sizeof(header), 0);
+	write_blocked(buffer, size, 0);
 	return 0;
 }
=20
@@ -234,9 +236,9 @@ static int write_tar_entry(struct archiver_args *ar=
gs,
 		}
 	}
 	strbuf_release(&ext_header);
-	write_blocked(&header, sizeof(header));
+	write_blocked(&header, sizeof(header), 0);
 	if (S_ISREG(mode) && buffer && size > 0)
-		write_blocked(buffer, size);
+		write_blocked(buffer, size, 0);
 	free(buffer);
 	return err;
 }
@@ -255,8 +257,8 @@ static int write_global_extended_header(struct arch=
iver_args *args)
 	mode =3D 0100666;
 	strcpy(header.name, "pax_global_header");
 	prepare_header(args, &header, mode, ext_header.len);
-	write_blocked(&header, sizeof(header));
-	write_blocked(ext_header.buf, ext_header.len);
+	write_blocked(&header, sizeof(header), 0);
+	write_blocked(ext_header.buf, ext_header.len, 0);
 	strbuf_release(&ext_header);
 	return err;
 }
--=20
1.7.8.36.g69ee2
