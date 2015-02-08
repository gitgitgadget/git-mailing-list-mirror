From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/24] untracked cache: invalidate dirs recursively if .gitignore changes
Date: Sun,  8 Feb 2015 15:55:28 +0700
Message-ID: <1423385748-19825-5-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:56:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNfC-0002VK-6Y
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbbBHI4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:56:17 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:45680 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbbBHI4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:56:15 -0500
Received: by pdbnh10 with SMTP id nh10so21741516pdb.12
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PrPzc/0lNqRbF/SjfwsimZBKqUU1dq+qOmfod9aEDrs=;
        b=N5ee4VUk8y85yCufFTnXzRsA96Ogt9iJKD8DB5zxrvUQUQhO7SltkOVuqC861BBbW3
         tpkaJtPv/lo8gBI+OC8z3NwnjaCpplLOGDsMEvzPdGnX7WYSh/7pGY8xJUazuLHqWPJE
         pu2ZskuME1hnmtQaJrh6EVe7AzH5PX6yvDyKYk+MywgdA7zpUkEJJDVddG5rrYUtloMb
         nR5QTOlGOOp5vDhAEAguWJeYryatb0WboGIff4RTCskRQ9fxjB2kJHPxijXbbLBzR0Jo
         SsuUqlQ8t67ytzZ75r7kzsHrW/gUxEpSk/ztl9FYsbhcBcoM/CuIYZjATleQqOJTWUK8
         /Jvg==
X-Received: by 10.69.20.10 with SMTP id gy10mr19156514pbd.76.1423385774646;
        Sun, 08 Feb 2015 00:56:14 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id u5sm12941727pdh.54.2015.02.08.00.56.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:56:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:56:22 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263467>

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
2.3.0.rc1.137.g477eb31
