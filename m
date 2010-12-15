From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/21] Convert ce_path_match() to use match_pathspec_depth()
Date: Wed, 15 Dec 2010 22:02:50 +0700
Message-ID: <1292425376-14550-16-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:06:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvn-0001Nt-Fo
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab0LOPFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:05:51 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62322 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab0LOPFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:05:50 -0500
Received: by yxt3 with SMTP id 3so1085539yxt.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yy796qNXNs2m/KearJk0X6m7070PZRcKtHUAow3ZLAQ=;
        b=Ngz3mEXVYqWAV9E001iQ1rPQ+yoCVQEJ5W01aJS7mOOTNhw/sKocZA6H9Q1ZL5Zlug
         vafmSnbJViFmoUW55f6WbQ5CV4HNRyzObGQ0S2vYCR/yPOhg0eIeZS873ilNS6ub56py
         4eeuYwxfYY/qjzxBTciTPwHpYw0N8G703mSKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IjZNlT5DaNKiAYvZ3F2Phn7erC06qf9uwi3ukU+8ElCTL+IaCeTFfO4Z1LD77CGBPD
         cQQhsqeKM1Ij30KMkhEgtQWK+7b8jXe4pr1pS252oiB/xOythQ6vn+Vxau58MiNmOgiR
         vCn1wbB/Ko581Th7Qcu4i0d8spZiVQBFZMYbY=
Received: by 10.42.223.136 with SMTP id ik8mr6098830icb.484.1292425548495;
        Wed, 15 Dec 2010 07:05:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id 8sm1042904iba.10.2010.12.15.07.05.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:05:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:04:56 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163769>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f1141a3..7f51cd6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -685,29 +685,7 @@ int ce_same_name(struct cache_entry *a, struct cac=
he_entry *b)
=20
 int ce_path_match(const struct cache_entry *ce, const struct pathspec =
*pathspec)
 {
-	const char *match, *name;
-	const char **ps =3D pathspec->raw;
-	int len;
-
-	if (!pathspec->nr)
-		return 1;
-
-	len =3D ce_namelen(ce);
-	name =3D ce->name;
-	while ((match =3D *ps++) !=3D NULL) {
-		int matchlen =3D strlen(match);
-		if (matchlen > len)
-			continue;
-		if (memcmp(name, match, matchlen))
-			continue;
-		if (matchlen && name[matchlen-1] =3D=3D '/')
-			return 1;
-		if (name[matchlen] =3D=3D '/' || !name[matchlen])
-			return 1;
-		if (!matchlen)
-			return 1;
-	}
-	return 0;
+	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NU=
LL);
 }
=20
 /*
--=20
1.7.3.3.476.g10a82
