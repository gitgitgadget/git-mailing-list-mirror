From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/32] read-cache: store in-memory flags in the first 12 bits of ce_flags
Date: Fri, 13 Jun 2014 19:19:25 +0700
Message-ID: <1402661991-14977-7-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:20:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTR-0002o7-RT
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbaFMMUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:20:43 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:49893 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaFMMUl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:20:41 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so314877pad.9
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MPjCaEzaX2eDHRq2DzimdM8QyCXSbYqUqS8PtxmJcpo=;
        b=ThJ7TlKYorvlvDM5hjrQPytodNVBs72ncyz/ErWyBMWvVj6YoA7VvP6a9ySHRHV2rw
         ca5pydHPVOtqwIP9XRAqbuQhLl7vt8EX06a2NVLeA+t9w9aljbKbXJJ7X81uNOj3CGOp
         ROTqnVtQFnv3kqHyhVlVE45X/ggcLAaYVvHjGUeUOSIrwY+8av9NzQKniG40EcTUBkzb
         cwSwba1AuWgGDnCoLXq3FOxNzz3U+CazEx5u5JiHU6vkTX1PEIW/9juj2WXgzyWL/NCF
         kuWD+bW2pAdg7c4ouYE/7XHUo7P2HcPKkMVxPfkQ2wpKdwdELNMcA70il602sZKpJ1Bp
         p8kA==
X-Received: by 10.68.143.231 with SMTP id sh7mr2842471pbb.7.1402662041503;
        Fri, 13 Jun 2014 05:20:41 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id zq5sm3394460pbb.37.2014.06.13.05.20.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:20:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:20:41 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251562>

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
index a7b48a9..5e8c06c 100644
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
