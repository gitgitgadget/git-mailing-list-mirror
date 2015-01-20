From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/24] untracked cache: invalidate dirs recursively if .gitignore changes
Date: Tue, 20 Jan 2015 20:03:13 +0700
Message-ID: <1421759013-8494-5-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:04:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYTR-0003Nd-VR
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbbATND5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:03:57 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47296 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbbATND4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:03:56 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so3321750pdj.7
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OfCX17yW5ZWucLlPsEsI/tufIGHHj2F7kUj7nBhgPNs=;
        b=c/xonb8o8GhESPUnikmooPBIqEfjMIXlEfkNHVoDpMGFD1ClwbIb+9j3kQ0MUwDiH0
         1qrfzozgs8PKwssJ0Q5rAvQSTaGwP423qXFoLQW7XzG3Qi8QFvsNxHVpL2/1vrpi0cqG
         pej80G2YzTr7wfaY9YGdjV1+UjKjy3w+PhD4JbEQU2AdP9M3vBk3xdaefGwcHWVkaXpN
         Jn4BaDUyCFxGDm+6A2gjmb+xRFdEHPNFsaCRlTV5dS5xWKlfe+jB+Ozs63igKixn1eGs
         CIGhrXPNoPNLfPylWQU3ZFu7gWIec8zsAkTzVguqdDOZGNWGgjUPUe9WcsxQsj5RyXFj
         pzoA==
X-Received: by 10.67.22.162 with SMTP id ht2mr53849184pad.49.1421759036462;
        Tue, 20 Jan 2015 05:03:56 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id sl5sm2935198pbc.45.2015.01.20.05.03.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:03:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:04:05 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262655>

It's easy to see that if an existing .gitignore changes, its SHA-1
would be different and invalidate_gitignore() is called.

If .gitignore is removed, add_excludes() will treat it like an empty
=2Egitignore, which again should invalidate the cached directory data.

if .gitignore is added, lookup_untracked() already fills initial
=2Egitignore SHA-1 as "empty file", so again invalidate_gitignore() is
called.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 44ed9f2..6e91315 100644
--- a/dir.c
+++ b/dir.c
@@ -1010,7 +1010,23 @@ static void prep_exclude(struct dir_struct *dir,=
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
2.2.0.84.ge9c7a8a
