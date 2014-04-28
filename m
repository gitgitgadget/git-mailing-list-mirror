From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/32] read-cache: store in-memory flags in the first 12 bits of ce_flags
Date: Mon, 28 Apr 2014 17:55:27 +0700
Message-ID: <1398682553-11634-7-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDR-0001If-3r
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbaD1KzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:10 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37087 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbaD1KzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:06 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so5573333pab.8
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cV8RLkYavAJCzjLsolglFBMnd1JmND1egZdAvPWSLQI=;
        b=K5qddyEXGewj6gzrz74uDITqfQkanIfXQ3Feu/Qfd+givE55+QHidVuNK2WX3KiTSI
         OsLat7hwMJshJesnmz8ENVFRObTagQgcAAsuz6XWWHgY0NmY4o64QQmCyTwa+/27TB0y
         9VyeWEJ1d4GjGIFZXFyelXHNA20Sch1YTOi90kDtM2iW3TIR4hEbAnRtNEwCy9QguBVH
         oPYg9JeTEApdtG6jCfTXDnNf1sa+8xu9qTFDj77z6GALGt+XRV79E3wXigPVSuMDNlg8
         ncEF8cAt3VUCMFPolMGgqV5PwXNilwtM5mcys7VJUhTdiAlLc+1Dk2UW8xuMaS42RaPP
         ggaQ==
X-Received: by 10.68.171.4 with SMTP id aq4mr2624098pbc.150.1398682504616;
        Mon, 28 Apr 2014 03:55:04 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id av2sm34228011pbc.16.2014.04.28.03.55.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:32 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247273>

We're running out of room for in-memory flags. But since b60e188
(Strip namelen out of ce_flags into a ce_namelen field - 2012-07-11),
we copy the namelen (first 12 bits) to ce_namelen field. So those bits
are free to use. Just make sure we do not accidentally write any
in-memory flags back.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      | 2 +-
 read-cache.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e44048c..57ad318 100644
--- a/cache.h
+++ b/cache.h
@@ -145,7 +145,7 @@ struct cache_entry {
 #define CE_STAGESHIFT 12
=20
 /*
- * Range 0xFFFF0000 in ce_flags is divided into
+ * Range 0xFFFF0FFF in ce_flags is divided into
  * two parts: in-memory flags and on-disk ones.
  * Flags in CE_EXTENDED_FLAGS will get saved on-disk
  * if you want to save a new flag, add it in
diff --git a/read-cache.c b/read-cache.c
index 576e506..5761b1f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1702,7 +1702,7 @@ static char *copy_cache_entry_to_ondisk(struct on=
disk_cache_entry *ondisk,
 	ondisk->size =3D htonl(ce->ce_stat_data.sd_size);
 	hashcpy(ondisk->sha1, ce->sha1);
=20
-	flags =3D ce->ce_flags;
+	flags =3D ce->ce_flags & ~CE_NAMEMASK;
 	flags |=3D (ce_namelen(ce) >=3D CE_NAMEMASK ? CE_NAMEMASK : ce_namele=
n(ce));
 	ondisk->flags =3D htons(flags);
 	if (ce->ce_flags & CE_EXTENDED) {
--=20
1.9.1.346.ga2b5940
