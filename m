From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 5/5] diff: shortcut for diff'ing two binary SHA-1 objects
Date: Sat, 16 Aug 2014 10:08:06 +0700
Message-ID: <1408158486-7328-6-git-send-email-pclouds@gmail.com>
References: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
 <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 05:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIUMF-00014w-Mr
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 05:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbaHPDIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 23:08:39 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35910 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaHPDIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 23:08:38 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so4454576pab.20
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 20:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qeyCXC84TgSBgxd1VGk43PciBt/UMZS238qOuy2z9ZQ=;
        b=H45C+sqJe6sNmp16axgvOjCw8Yht4camgM58YHu2TADcAM7nBqRvKsUfdsEM7u/fg8
         Z2dpsBEoLNfmx0zRslDfDCnpn0Wt13U3ynVA8T69jec/FIALB189AtXZ3yi2lD79V+j8
         zmjn3WXyIrC/x1rBgAmxQWDx59TG7O9nqpD2OSIT1rATvPOFyHwYBeXoP8H48vdm1aQU
         4T+nGjRGQNlPfI5FUTpcBahH7+nH//183ZieSnQ9wr5yw0NZF49psRQdixUfTD935cos
         rAek2gWIkrv2m5prldpFf/xWCrQYBiiIioSebbW5c/Mj9OUuwftME8MqfQoLpBEUPn/D
         1agg==
X-Received: by 10.70.96.165 with SMTP id dt5mr23341474pdb.71.1408158518366;
        Fri, 15 Aug 2014 20:08:38 -0700 (PDT)
Received: from lanh ([115.73.215.192])
        by mx.google.com with ESMTPSA id np15sm14187881pdb.84.2014.08.15.20.08.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 20:08:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Aug 2014 10:08:36 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255318>

If we are given two SHA-1 and asked to determine if they are different
(but not _what_ differences), we know right away by comparing SHA-1.

A side effect of this patch is, because large files are marked binary,
diff-tree will not need to unpack them. 'diff-index --cached' will not
either. But 'diff-files' still does.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c           | 13 +++++++++++++
 t/t1050-large.sh | 10 ++++++++++
 2 files changed, 23 insertions(+)

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
index 00d2f33..05a1e1d 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -116,6 +116,16 @@ test_expect_success 'diff --stat' '
 	git diff --stat HEAD^ HEAD
 '
=20
+test_expect_success 'diff' '
+	git diff HEAD^ HEAD >actual &&
+	grep "Binary files.*differ" actual
+'
+
+test_expect_success 'diff --cached' '
+	git diff --cached HEAD^ >actual &&
+	grep "Binary files.*differ" actual
+'
+
 test_expect_success 'hash-object' '
 	git hash-object large1
 '
--=20
2.1.0.rc0.78.gc0d8480
