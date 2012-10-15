From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/12] dir.c: refactor is_excluded()
Date: Mon, 15 Oct 2012 13:28:00 +0700
Message-ID: <1350282486-4646-6-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:29:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeAw-00018p-BF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab2JOG3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:29:07 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab2JOG3F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:29:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4544170pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TG5WhZmJVrlP/VgD0Zznj6luzyOvGvsenmP4/LoUojA=;
        b=i7BzOIY7NIXy7/DXcGfL85Bku3pluXpdsTEhkE9UjDC5TWTyLFIKugFIMiixl5mXw7
         Ua64FCPz8vTYL/6saP5Uu5Or1DRkbYnLuvX2p79+RMn7mV2ATCI6eoPEvIJssQa8m9xH
         D8XdKxSGJ8CXenf9YwEJE05aHut9WNwm4ms1IDlFznvuo4wZKX9DGXCibB8ct0/7gusj
         qwTx1AK73hRUyM2gIjFSaKCLVntxksY7B2clrHgClsSqZXT+V6kmXG+hTlUmkhne5Csd
         p20Efu0AX1HQdGQi1W7rwXDBOpcpUbJQ7CyfQysBNgm12Bq0WP7+4oxsJJXhbES4Ouyy
         yecA==
Received: by 10.66.83.9 with SMTP id m9mr30376701pay.22.1350282545772;
        Sun, 14 Oct 2012 23:29:05 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ox5sm8570837pbc.75.2012.10.14.23.29.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:29:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:28:55 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207717>

=46rom: Adam Spiers <git@adamspiers.org>

In a similar way to the previous commit, this extracts a new helper
function last_exclude_matching() which returns the last exclude_list
element which matched, or NULL if no match was found.  is_excluded()
becomes a wrapper around this, and just returns 0 or 1 depending on
whether any matching exclude_list element was found.

This allows callers to find out _why_ a given path was excluded,
rather than just whether it was or not, paving the way for a new git
sub-command which allows users to test their exclude lists from the
command line.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 859e0f9..c91a2f6 100644
--- a/dir.c
+++ b/dir.c
@@ -658,24 +658,44 @@ int is_excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
=20
-static int is_excluded(struct dir_struct *dir, const char *pathname, i=
nt *dtype_p)
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded.
+ * Returns the exclude_list element which matched, or NULL for
+ * undecided.
+ */
+static struct exclude *last_exclude_matching(struct dir_struct *dir,
+					     const char *pathname,
+					     int *dtype_p)
 {
 	int pathlen =3D strlen(pathname);
 	int st;
+	struct exclude *exclude;
 	const char *basename =3D strrchr(pathname, '/');
 	basename =3D (basename) ? basename+1 : pathname;
=20
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st =3D EXC_CMDL; st <=3D EXC_FILE; st++) {
-		switch (is_excluded_from_list(pathname, pathlen,
-					      basename, dtype_p,
-					      &dir->exclude_list[st])) {
-		case 0:
-			return 0;
-		case 1:
-			return 1;
-		}
+		exclude =3D last_exclude_matching_from_list(
+			pathname, pathlen, basename, dtype_p,
+			&dir->exclude_list[st]);
+		if (exclude)
+			return exclude;
 	}
+	return NULL;
+}
+
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded.
+ * Returns 1 if true, otherwise 0.
+ */
+static int is_excluded(struct dir_struct *dir, const char *pathname, i=
nt *dtype_p)
+{
+	struct exclude *exclude =3D
+		last_exclude_matching(dir, pathname, dtype_p);
+	if (exclude)
+		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
 }
=20
--=20
1.8.0.rc0.29.g1fdd78f
