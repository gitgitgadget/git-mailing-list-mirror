From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/24] untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
Date: Sun,  8 Mar 2015 17:12:38 +0700
Message-ID: <1425809567-25518-16-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:14:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYEI-0003mc-2L
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbbCHKOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:14:34 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:45349 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbCHKOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:14:33 -0400
Received: by padbj1 with SMTP id bj1so31117556pad.12
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DlTKm8fAWvUxub8DS2APwr+oSZDGF6t7K0MRpbE+Rus=;
        b=TQJyl8n5n68o/iUjSToWzB9wprLHmCSFK5nHjI38KIEnadpNisJfwk3ltiV8HC5+Lw
         mlSWo/Rka1NZcBCZWLXOc+swdauLmf40G5y7ocKhbQJ/GyhxyYWFbwKPfSvJJiPPYH3d
         isIXaBVbeDNlbN8JrkbkP+4nVx0npTI9IQEHnKXmkNkPmqmlLm5v3QquHlydimARxG2Q
         Rconi9lEVk9FsQtVwbwsaWBRvTRP1x/ajdcY4ADn+b69ad5c0uR4cEo2im9g4SCrX0om
         PB7lWBBHT+Wf5fr1OkGgxfDeM/1TaQ7FmbO7YVzBUxcKRj+5QTG/sZxLLvW6CNmqOh+d
         235Q==
X-Received: by 10.70.100.39 with SMTP id ev7mr23841652pdb.29.1425809672803;
        Sun, 08 Mar 2015 03:14:32 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id dj4sm12606440pbd.31.2015.03.08.03.14.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:14:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:14:28 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265069>

This could be used to verify correct behavior in tests

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dir.c b/dir.c
index 7d57623..01f0032 100644
--- a/dir.c
+++ b/dir.c
@@ -1923,6 +1923,18 @@ int read_directory(struct dir_struct *dir, const=
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
