From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] dir.c: clean the entire struct in clear_exclude_list()
Date: Sun, 27 Dec 2015 08:54:34 +0700
Message-ID: <1451181274-26213-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 02:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0Xb-0001Cg-8R
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 02:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbL0Byb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 20:54:31 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35304 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbL0Bya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 20:54:30 -0500
Received: by mail-pa0-f47.google.com with SMTP id jx14so149620556pad.2
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 17:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=wzDImx/MU5BDgxXVJQIoqkYpq/186qw9/s6WMXE3/AI=;
        b=PDDek5x5pXbzule61x+S63SfdKLiRRVt5e5MXXtomv5I+gHmz8Z2D72diqLnGAEx13
         w8V5eOvox5nIIsUmKAiJYXGOO3og3b1NTsTOlXgQPbuSMVsPXOKvqLpPzbcfA6zM5UUs
         GezQRArtvqYZlnFF/kRZlq7DgjG7E5PN2IewwJ8dRIKqyLSQPZvv+lIpQ9W9bYeLFqfR
         fz2PbCjgTDjyDKD82E0rBtRpgICe91+NqdkCOtwUlGPQUPju0aa9fqo7hF8fpE/Nlyef
         lXMbP52cH1NwsnyxwM77u6n4Ad4QfRv5oNdA4DsATDqSlglqa6rehTH1FPtCgTCkAyoD
         s9HA==
X-Received: by 10.66.180.48 with SMTP id dl16mr67800443pac.39.1451181270284;
        Sat, 26 Dec 2015 17:54:30 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id 19sm31616463pfj.16.2015.12.26.17.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 17:54:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 08:54:36 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283008>

Make sure "el" can be reuseable again. The problem was el->alloc is
not cleared and may cause segfaults next time because add_exclude()
thinks el->excludes (being NULL) has enough space. Just clear the
entire struct to be safe.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This was needed in the worktree config split series because the same
 exclude_list could be reused. But that series is changing and will not
 need exclude_list any more. So instead of dropping this patch, I
 submit it separately. It's a good fix anyway.

 dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d2a8f06..b8b4576 100644
--- a/dir.c
+++ b/dir.c
@@ -564,9 +564,7 @@ void clear_exclude_list(struct exclude_list *el)
 	free(el->excludes);
 	free(el->filebuf);
=20
-	el->nr =3D 0;
-	el->excludes =3D NULL;
-	el->filebuf =3D NULL;
+	memset(el, 0, sizeof(*el));
 }
=20
 static void trim_trailing_spaces(char *buf)
--=20
2.3.0.rc1.137.g477eb31
