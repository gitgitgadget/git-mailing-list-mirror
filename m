From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] utf8.c: fix strbuf_utf8_replace() consuming data beyond input string
Date: Sun, 10 Aug 2014 14:05:21 +0700
Message-ID: <1407654321-7509-1-git-send-email-pclouds@gmail.com>
References: <1406639429-28748-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 09:09:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGNG0-00043J-1r
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 09:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbaHJHFU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2014 03:05:20 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:40487 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaHJHFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 03:05:19 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so9429947pab.15
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 00:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Tr6oQrIFEUHtDdSFjQrSQSKhKcxtlf6kK2aqBQxaP/g=;
        b=tdMmBp8umsctsjeEI3HVeH9klTGdYm8erAaQ21HzRZB064/wnHRWFMXLrjnreviPJJ
         xPVU5sVhBa4PZCMsMaswB4rguPyLOU6tbiHkWnVFNUPzW2CtpNKWNC1dQZhjJbVZDMhp
         P0Df+rYKB5BlByayJWp+V217VB2QK+eRAiyxah68MTPwlsSS3VN2OkYOW5f6sXpuVvTd
         +U7OfsCRXaP/B2IWw4GncVEWhnEqIbJ4nZTZWgUUw5U77Zxfvxrw1uS97vBTazDFa42V
         wrKjtk49a8Ale//x0DD8bb4qY+HqdesK4Sk/dV/P/lBpGT23muaX3eVhsZJG6Xi4pStr
         mMgA==
X-Received: by 10.68.163.100 with SMTP id yh4mr986930pbb.122.1407654319155;
        Sun, 10 Aug 2014 00:05:19 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id jb5sm7714596pbd.73.2014.08.10.00.05.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2014 00:05:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 14:05:22 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406639429-28748-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255086>

The main loop in strbuf_utf8_replace() could summed up as:

  while ('src' is still valid) {
    1) advance 'src' to copy ANSI escape sequences
    2) advance 'src' to copy/replace visible characters
  }

The problem is after #1, 'src' may have reached the end of the string
(so 'src' points to NUL) and #2 will continue to copy that NUL as if
it's a normal character. Because the output is stored in a strbuf,
this NULL accounted in the 'len' field as well. Check after #1 and
break the loop if necessary.

The test does not look obvious, but the combination of %>>() should
make a call trace like this

  show_log()
  pretty_print_commit()
  format_commit_message()
  strbuf_expand()
  format_commit_item()
  format_and_pad_commit()
  strbuf_utf8_replace()

where %C(auto)%d would insert a color reset escape sequence in the end
of the string given to strbuf_utf8_replace() and show_log() uses
fwrite() to send everything to stdout (including the incorrect NUL
inserted by strbuf_utf8_replace)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4205-log-pretty-formats.sh | 7 +++++++
 utf8.c                        | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 349c531..de0cc4a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -431,6 +431,13 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'strbuf_utf8_replace() not producing NUL' '
+	git log --color --pretty=3D"tformat:%<(10,trunc)%s%>>(10,ltrunc)%C(au=
to)%d" |
+		test_decode_color |
+		nul_to_q >actual &&
+	! grep Q actual
+'
+
 # get new digests (with no abbreviations)
 head1=3D$(git rev-parse --verify HEAD~0) &&
 head2=3D$(git rev-parse --verify HEAD~1) &&
diff --git a/utf8.c b/utf8.c
index b30790d..401a6a5 100644
--- a/utf8.c
+++ b/utf8.c
@@ -382,6 +382,9 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int=
 pos, int width,
 			dst +=3D n;
 		}
=20
+		if (src >=3D end)
+			break;
+
 		old =3D src;
 		n =3D utf8_width((const char**)&src, NULL);
 		if (!src) 	/* broken utf-8, do nothing */
--=20
2.1.0.rc0.78.gc0d8480
