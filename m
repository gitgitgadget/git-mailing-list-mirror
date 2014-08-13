From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/6] sha1_file.c: do not die failing to malloc in unpack_compressed_entry
Date: Wed, 13 Aug 2014 17:57:30 +0700
Message-ID: <1407927454-9268-3-git-send-email-pclouds@gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:58:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWFp-0000SR-QP
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 12:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbaHMK5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 06:57:55 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:61316 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaHMK5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 06:57:53 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so8388911pde.10
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J7QGPhWE74JeBTzHRUdSccHxKppw7OqU6ciLInCG1vw=;
        b=Od1ExbDnROnBbdQG4KcwDrrCZIm8jFA4otASrAySaECP4YdCaT6+9kLYTQO+WWoyb6
         +BUwcHGH7UmoWdgR5a/ICC4W2C5zSz8rzT/z/lC5IJIIr0b0UT04b1UpGbYoZywVmPNs
         s8L7qbXROzIYBa6SKj32gJ6TrJmyuacjImSc6TceMrQAqCbt9h8cXPkhACxTpDNb0PrQ
         wo4EvZjF5kmS8ghytGFtzmQxnCBUISRHX7Pop39cNBIiTKeJgtQVTOSED++E/M/ziwCk
         t2T2cIVSnn6Fxb9gvPx/YUlc6ilo3kbTd6x1igYFSajhXIxsValhfbp9mBXTyo3xiruC
         nJGA==
X-Received: by 10.70.38.203 with SMTP id i11mr533827pdk.162.1407927472618;
        Wed, 13 Aug 2014 03:57:52 -0700 (PDT)
Received: from lanh ([115.73.196.146])
        by mx.google.com with ESMTPSA id v9sm2559738pdp.15.2014.08.13.03.57.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 03:57:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Aug 2014 17:57:48 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255194>

=46ewer die() gives better control to the caller, provided that the
caller _can_ handle it. And in unpack_compressed_entry() case, it can,
because unpack_compressed_entry() already returns NULL if it fails to
inflate data.

A side effect from this is fsck continues to run when very large blobs
are present (and do not fit in memory).

Noticed-by: Dale R. Worley <worley@alum.mit.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c      | 4 +++-
 t/t1050-large.sh | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3f70b1d..330862b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1923,7 +1923,9 @@ static void *unpack_compressed_entry(struct packe=
d_git *p,
 	git_zstream stream;
 	unsigned char *buffer, *in;
=20
-	buffer =3D xmallocz(size);
+	buffer =3D xmallocz_gentle(size);
+	if (!buffer)
+		return NULL;
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out =3D buffer;
 	stream.avail_out =3D size + 1;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index aea4936..5642f84 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -163,4 +163,10 @@ test_expect_success 'zip achiving, deflate' '
 	git archive --format=3Dzip HEAD >/dev/null
 '
=20
+test_expect_success 'fsck' '
+	test_must_fail git fsck 2>err &&
+	n=3D$(grep "error: attempting to allocate .* over limit" err | wc -l)=
 &&
+	test "$n" -gt 1
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
