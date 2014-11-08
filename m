From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/22] untracked cache: invalidate dirs recursively if .gitignore changes
Date: Sat,  8 Nov 2014 16:39:37 +0700
Message-ID: <1415439595-469-5-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:40:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2VI-0000ZT-Pu
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbaKHJkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:40:14 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35494 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbaKHJkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:40:11 -0500
Received: by mail-pd0-f171.google.com with SMTP id r10so4792927pdi.30
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W6jurTPtR3Sp7mrivjQNgLVEEoydXFELeP26QdhgVns=;
        b=QJNdCNk/okQyTCEcFj0G9atl8X1UhdPwmVCSv07PwmYGDHGbjJwc68yxJDz++NrlCb
         /LCYsqD9av7Tkuje+jLbFj7mA8B8thC6MTAATsOIRecfm9vLtRSFWKgaj4L8QRfwrwxf
         IR1DKrVclCBUXOh7VCOfV1YZ/k5KbZcuyRKWqGfhdimra3sa4DrJ5hX5793NmNeTBz9W
         jl2IwH2n07UiwSMW6F5Crlv9DlvSSK3w3iy0TiyxeHusBbdzaRdsH680ZqFBPP1eJzZr
         Rm1gSbKyEJ5DO6Aw9UpSRdToWwuvgF9rGclLuuy29Rleye+w3gzEyDp0F2R/yY7ZSOQb
         JtNg==
X-Received: by 10.70.138.104 with SMTP id qp8mr17752902pdb.99.1415439610277;
        Sat, 08 Nov 2014 01:40:10 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id s7sm10977384pdi.72.2014.11.08.01.40.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:40:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:40:24 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easy to see that if an existing .gitignore changes, its SHA-1
would be different and invalidate_gitignore() is called.

If .gitignore is removed, add_excludes() will treat it like an empty
=2Egitignore, which again should invalidate the cached directory data.

if .gitignore is added, lookup_untracked() already fills initial
=2Egitignore SHA-1 as "empty file", so again invalidate_gitignore() is
called.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 4f4f302..d5e35ea 100644
--- a/dir.c
+++ b/dir.c
@@ -1009,7 +1009,23 @@ static void prep_exclude(struct dir_struct *dir,=
 const char *base, int baselen)
 			add_excludes(el->src, el->src, stk->baselen, el, 1,
 				     untracked ? &sha1_stat : NULL);
 		}
-		if (untracked) {
+		/*
+		 * NEEDSWORK: when untracked cache is enabled, prep_exclude()
+		 * will first be called in valid_cached_dir() then maybe many
+		 * times more in last_exclude_matching(). When the cache is
+		 * used, last_exclude_matching() will not be called and
+		 * reading .gitignore content will be a waste.
+		 *
+		 * So when it's called by valid_cached_dir() and we can get
+		 * .gitignore SHA-1 from the index (i.e. .gitignore is not
+		 * modified on work tree), we could delay reading the
+		 * .gitignore content until we absolutely need it in
+		 * last_exclude_matching(). Be careful about ignore rule
+		 * order, though, if you do that.
+		 */
+		if (untracked &&
+		    hashcmp(sha1_stat.sha1, untracked->exclude_sha1)) {
+			invalidate_gitignore(dir->untracked, untracked);
 			hashcpy(untracked->exclude_sha1, sha1_stat.sha1);
 		}
 		dir->exclude_stack =3D stk;
--=20
2.1.0.rc0.78.gc0d8480
