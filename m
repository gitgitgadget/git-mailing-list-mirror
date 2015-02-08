From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/24] untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
Date: Sun,  8 Feb 2015 15:55:39 +0700
Message-ID: <1423385748-19825-16-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNgA-0003Bn-Au
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbbBHI5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:18 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:63111 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbbBHI5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:57:16 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so26952882pad.4
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YU/OTwpU5LS9+7bR5gaNKKjBO5EOPJXK/g7T11KAMI0=;
        b=zIX9iDJtUZwue1v1IPCXLzwoTwxu/WukauZf6q6Rn5aRriLz5xDo3CJrCHyR+wI56A
         BltuKpnGWlLXqVeRg/ENNadsMt2hqIke8UPwPoIL02nef5NMZh3hF8OUf616/EJgvzD2
         QuyaN1lnUaHPNSlNGsKrM8MOojZZbIkVi2UtN2FXf5djyGYha4/4n1OSCm7uiN4QnN+9
         QR2RkDjd6kXG2A52SyIgYzonTDOgbsst6c0OCEuEOiPxfc2wzYT7wcSAgz2x5IbfuwMt
         FWIPHWyO8QCDlza4yBZnpJZhUpJcAFt9SVWW4lQE0BlErZBJdqB/SAjRj/cHjJpRq1En
         b/5A==
X-Received: by 10.70.34.177 with SMTP id a17mr19163315pdj.123.1423385836249;
        Sun, 08 Feb 2015 00:57:16 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id qc8sm12923565pdb.86.2015.02.08.00.57.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:57:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:23 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263477>

This could be used to verify correct behavior in tests

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dir.c b/dir.c
index 439ff22..c5ca5ce 100644
--- a/dir.c
+++ b/dir.c
@@ -1922,6 +1922,18 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
+	if (dir->untracked) {
+		static struct trace_key trace_untracked_stats =3D TRACE_KEY_INIT(UNT=
RACKED_STATS);
+		trace_printf_key(&trace_untracked_stats,
+				 "node creation: %u\n"
+				 "gitignore invalidation: %u\n"
+				 "directory invalidation: %u\n"
+				 "opendir: %u\n",
+				 dir->untracked->dir_created,
+				 dir->untracked->gitignore_invalidated,
+				 dir->untracked->dir_invalidated,
+				 dir->untracked->dir_opened);
+	}
 	return dir->nr;
 }
=20
--=20
2.3.0.rc1.137.g477eb31
