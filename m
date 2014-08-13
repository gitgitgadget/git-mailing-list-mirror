From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 6/6] diff: shortcut for diff'ing two binary SHA-1 objects
Date: Wed, 13 Aug 2014 17:57:34 +0700
Message-ID: <1407927454-9268-7-git-send-email-pclouds@gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:58:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWGC-0000ch-AL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 12:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbaHMK6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 06:58:17 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:51006 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbaHMK6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 06:58:14 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so14119154pdi.6
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IInTvDaBYLs0lN7CN6Ps7D1P6XZt+Di0HxcNsWHMafo=;
        b=FjR0mZ6/8AqxA5zVq0SMVknl6sC8eQczKb+h6gd8dzVrKINtIXPOS3ZGE581nGG7tc
         2ar9Y7yrUufwT/V1AEcpotpyIApQ04KvIkFF6ttRFSG3TDP2JOc5DT5ojyqcphVPAV8p
         7QQCD6kBj08qIjEJ9RPnOjbQreRm3fVTH5Ch1F1yHpzFsyBLe0W/thWYU+gnyWwWneTT
         G4Fxfa9j7Duqh1s9GcMlKP7Znixf6iBr5I24c6mzZFosnePlH6feTYf2b/UuKnd6Zp3S
         99QhL042truW/6zVQ/OFuErmj652SGqHDs02hETrr558p8H+hM88Ou86lqvsoX3MXC2X
         9cBw==
X-Received: by 10.66.235.1 with SMTP id ui1mr3494764pac.28.1407927494463;
        Wed, 13 Aug 2014 03:58:14 -0700 (PDT)
Received: from lanh ([115.73.196.146])
        by mx.google.com with ESMTPSA id ov4sm1727710pbc.86.2014.08.13.03.58.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 03:58:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Aug 2014 17:58:10 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255197>

If we are given two SHA-1 and asked to determine if they are different
(but not _what_ differences), we know right away by comparing SHA-1.

A side effect of this patch is, because large files are marked binary,
diff-tree will not need to unpack them. 'diff-index --cached' will not
either. But 'diff-files' still does.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c           | 13 +++++++++++++
 t/t1050-large.sh |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/diff.c b/diff.c
index d381a6f..b85bcfb 100644
--- a/diff.c
+++ b/diff.c
@@ -2324,6 +2324,19 @@ static void builtin_diff(const char *name_a,
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
+		if (!one->data && !two->data &&
+		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
+		    !DIFF_OPT_TST(o, BINARY)) {
+			if (!hashcmp(one->sha1, two->sha1)) {
+				if (must_show_header)
+					fprintf(o->file, "%s", header.buf);
+				goto free_ab_and_return;
+			}
+			fprintf(o->file, "%s", header.buf);
+			fprintf(o->file, "%sBinary files %s and %s differ\n",
+				line_prefix, lbl[0], lbl[1]);
+			goto free_ab_and_return;
+		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 			die("unable to read files to diff");
 		/* Quite common confusing case */
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 711f22c..b294963 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -116,6 +116,14 @@ test_expect_success 'diff --stat' '
 	git diff --stat HEAD^ HEAD
 '
=20
+test_expect_success 'diff' '
+	git diff HEAD^ HEAD
+'
+
+test_expect_success 'diff --cached' '
+	git diff --cached HEAD^
+'
+
 test_expect_success 'hash-object' '
 	git hash-object large1
 '
--=20
2.1.0.rc0.78.gc0d8480
