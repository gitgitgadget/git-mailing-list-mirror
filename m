From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] Move diffcore_skip_stat_unmatch core logic out for reuse later
Date: Sat, 25 Jan 2014 13:46:49 +0700
Message-ID: <1390632411-3596-1-git-send-email-pclouds@gmail.com>
References: <20140123024525.B726248918@mail.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: iwamoto@valinux.co.jp, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 07:41:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6ww5-0000F0-71
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 07:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbaAYGlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jan 2014 01:41:19 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57913 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaAYGlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 01:41:18 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so3928632pde.35
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 22:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AcVq9O1p0ovx/jyR0Fz4JbjqCgF7r975jzhMNpmWOEc=;
        b=u9QTuaW3Qtg1DYnWku2TNjoOfG1CyBdHRCaWGNtn6YTYOii4W1PkhFUEcG++nEbxSc
         jsfvp4rdxz+WgW0ko+Q7zN/K4xsv4nMg5EUbc3Vz1y/sJ6FzxIjJJKVbaHBGtzUQwvsg
         +0y6f5OMB21eO0sOuYm5EmPda/AP9lLwa6RFOAmzEMy4ni2wg8S3q7a3aSArQ63BY5vI
         VnMiyShvshRKVDH/KzOwu1S3Ac/eDohBLCwEQa5AO/yVQ0AOeYl2Gm1RIP/AJtUEYtJ7
         GqvVJ3oPmJTmOKE8INOIP0opo/qets8Yw7DEpSqmq5ucu4QuXoXqNu8w330LmQyDks/Z
         eIcg==
X-Received: by 10.68.130.130 with SMTP id oe2mr18327147pbb.135.1390632077727;
        Fri, 24 Jan 2014 22:41:17 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id oa3sm9655464pbb.15.2014.01.24.22.41.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 22:41:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 25 Jan 2014 13:46:52 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <20140123024525.B726248918@mail.valinux.co.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241062>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index 6b4cd0e..19460ff 100644
--- a/diff.c
+++ b/diff.c
@@ -4697,6 +4697,33 @@ static int diff_filespec_is_identical(struct dif=
f_filespec *one,
 	return !memcmp(one->data, two->data, one->size);
 }
=20
+static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
+{
+	/*
+	 * 1. Entries that come from stat info dirtiness
+	 *    always have both sides (iow, not create/delete),
+	 *    one side of the object name is unknown, with
+	 *    the same mode and size.  Keep the ones that
+	 *    do not match these criteria.  They have real
+	 *    differences.
+	 *
+	 * 2. At this point, the file is known to be modified,
+	 *    with the same mode and size, and the object
+	 *    name of one side is unknown.  Need to inspect
+	 *    the identical contents.
+	 */
+	if (!DIFF_FILE_VALID(p->one) || /* (1) */
+	    !DIFF_FILE_VALID(p->two) ||
+	    (p->one->sha1_valid && p->two->sha1_valid) ||
+	    (p->one->mode !=3D p->two->mode) ||
+	    diff_populate_filespec(p->one, 1) ||
+	    diff_populate_filespec(p->two, 1) ||
+	    (p->one->size !=3D p->two->size) ||
+	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
+		return 1;
+	return 0;
+}
+
 static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 {
 	int i;
@@ -4707,27 +4734,7 @@ static void diffcore_skip_stat_unmatch(struct di=
ff_options *diffopt)
 	for (i =3D 0; i < q->nr; i++) {
 		struct diff_filepair *p =3D q->queue[i];
=20
-		/*
-		 * 1. Entries that come from stat info dirtiness
-		 *    always have both sides (iow, not create/delete),
-		 *    one side of the object name is unknown, with
-		 *    the same mode and size.  Keep the ones that
-		 *    do not match these criteria.  They have real
-		 *    differences.
-		 *
-		 * 2. At this point, the file is known to be modified,
-		 *    with the same mode and size, and the object
-		 *    name of one side is unknown.  Need to inspect
-		 *    the identical contents.
-		 */
-		if (!DIFF_FILE_VALID(p->one) || /* (1) */
-		    !DIFF_FILE_VALID(p->two) ||
-		    (p->one->sha1_valid && p->two->sha1_valid) ||
-		    (p->one->mode !=3D p->two->mode) ||
-		    diff_populate_filespec(p->one, 1) ||
-		    diff_populate_filespec(p->two, 1) ||
-		    (p->one->size !=3D p->two->size) ||
-		    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
+		if (diff_filespec_check_stat_unmatch(p))
 			diff_q(&outq, p);
 		else {
 			/*
--=20
1.8.5.2.240.g8478abd
