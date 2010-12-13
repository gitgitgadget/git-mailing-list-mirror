From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/19] Convert ce_path_match() use to match_pathspec()
Date: Mon, 13 Dec 2010 16:46:51 +0700
Message-ID: <1292233616-27692-15-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS59t-0007tP-8i
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0LMJ5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:57:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48846 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0LMJ5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:57:24 -0500
Received: by iyi12 with SMTP id 12so773764iyi.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=y+izM+ZPYN0QJIlpSJZ5em24yIvO0crWlaLNYQqFu/Q=;
        b=KOmtZk2pGUK9mewe7vVE4kx+mw6hBP0Mt30/j0vHoaNIP3iwsbqlWmzg48buUTXrGZ
         gHTfZraerwP/YeeJKEIk3aIwLYwDMWNYAQGn5/KtUf+zj52mIfKDeVytrnrqylFIdRdp
         H6HwOPJ2Iw1jaQa33U4SoOSrfkHoaitsI1O7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=laWQb61ioQOm2oXRjeayE+lLvfW0jR+d6f+97bKpP/EPk9fEMYkGjeNoG9uYtEZ452
         yJG2APOw7paBgZR0TeRLCd3zbdH4XQQfBasuiKd9OBZMrwCc5xZBRuHYv0gDk9KbsCoq
         hQt9VUyZ9P6mu9XbE1PSfgzt+MUowyE2zLmbU=
Received: by 10.42.229.7 with SMTP id jg7mr2559958icb.211.1292233779860;
        Mon, 13 Dec 2010 01:49:39 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id gy41sm6048732ibb.5.2010.12.13.01.49.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:46 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163551>

Previously ce_path_match() is used together with tree_entry_interesting=
().
Both do not support wildcards. tree_entry_interesting() understands
wildcards now, so it's time to teach ce_path_match() to do the same.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1f42473..cbabd8b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -685,28 +685,10 @@ int ce_same_name(struct cache_entry *a, struct ca=
che_entry *b)
=20
 int ce_path_match(const struct cache_entry *ce, const char **pathspec)
 {
-	const char *match, *name;
-	int len;
-
 	if (!pathspec)
 		return 1;
=20
-	len =3D ce_namelen(ce);
-	name =3D ce->name;
-	while ((match =3D *pathspec++) !=3D NULL) {
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
+	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL);
 }
=20
 /*
--=20
1.7.3.3.476.g10a82
