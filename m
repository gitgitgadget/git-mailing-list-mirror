From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/19] untracked cache: invalidate dirs recursively if .gitignore changes
Date: Mon, 27 Oct 2014 19:10:31 +0700
Message-ID: <1414411846-4450-5-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8j-0002fv-2r
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbaJ0MLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:08 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:45161 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaJ0MLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:07 -0400
Received: by mail-pd0-f172.google.com with SMTP id r10so5533000pdi.17
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AA6Ks9W3IhQtYd5MdhuhpG/8+8D+ze/b3AyZnGjh+/Q=;
        b=ZFMOM0EL7aTb4+rlTWUJMEco/JN2LM8qNIpYxtARV82MvPOBdM4sOvPgFVUmgf+YMB
         JJdjx9teQhmYP5SJMABHCD/nvx2qq8x1wjqT1SK0FyhPJo93HBURSAlJi3urO2fqs8dE
         N237CmKlhw9CFdpnu5DODrjjarEdgoADX47gkvb7PlAqa/IbAfNvFavn0hSKiXXG4Lb+
         3A94MjFiqC2iZIfiq1XCtEF4gzzH4M4GDFLDWbzDARsrGta5xpOFgF8JW70X+wySj4e0
         PJF+88b8+f784Dv7ypVdPfBqTd/G80X/5yc0szdcjPpe8UdEyy6dpDxejAvhqwgogdlK
         sckA==
X-Received: by 10.66.253.164 with SMTP id ab4mr23683545pad.59.1414411866039;
        Mon, 27 Oct 2014 05:11:06 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id mj5sm10765452pdb.88.2014.10.27.05.11.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
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
 dir.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 5161f74..a0a0fa8 100644
--- a/dir.c
+++ b/dir.c
@@ -1005,7 +1005,22 @@ static void prep_exclude(struct dir_struct *dir,=
 const char *base, int baselen)
 			add_excludes(el->src, el->src, stk->baselen, el, 1,
 				     untracked ? &ss : NULL, 0);
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
+		if (untracked && hashcmp(ss.sha1, untracked->exclude_sha1)) {
+			invalidate_gitignore(dir->untracked, untracked);
 			hashcpy(untracked->exclude_sha1, ss.sha1);
 		}
 		dir->exclude_stack =3D stk;
--=20
2.1.0.rc0.78.gc0d8480
