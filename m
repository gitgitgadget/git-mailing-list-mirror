From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/5] sha1_file.c: do not die failing to malloc in unpack_compressed_entry
Date: Sat, 16 Aug 2014 10:08:03 +0700
Message-ID: <1408158486-7328-3-git-send-email-pclouds@gmail.com>
References: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
 <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 05:08:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIUM0-0000vV-1d
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 05:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaHPDIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 23:08:23 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50204 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaHPDIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 23:08:22 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so4299879pdj.16
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zFEPljoV35PApA1Yhg8wxKUeU04iLmVGuirNb/D8vVA=;
        b=k3wb7oJNAEs+1iMMWNU+qr/u5pOUqzcqvx7VSSK1rL7O1FhkD1caW0V1w2YfzVpkvS
         bCumfANDdMHze8WptYn9a4JNo+DabPaNYgASQsyj8sR7ErZ9Svk6vgsJkxpbDaDx4gmO
         bMiAV1z7l0PqTgkSjKMbXKTHSJj26eiEaPsVOlgafbng7fS7iQUhVEaJsyc9ZJu81Pny
         5pYNB9RAyEIQ9sdYE+jvPcuEQF/36YWLvGYogD4UYW1sSKfZTZTq4JN80kHJ9jIUd/d1
         ztFqvqTwcYieqTYI0mOCBx31QRkFseFht3bkDg8snFTojQP0ilqJ5FrHzOlZ9Ii39Jdy
         GRbw==
X-Received: by 10.66.129.139 with SMTP id nw11mr17271716pab.16.1408158502387;
        Fri, 15 Aug 2014 20:08:22 -0700 (PDT)
Received: from lanh ([115.73.215.192])
        by mx.google.com with ESMTPSA id ex1sm14210264pdb.26.2014.08.15.20.08.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 20:08:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Aug 2014 10:08:20 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255314>

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
index 3f70b1d..8db73f0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1923,7 +1923,9 @@ static void *unpack_compressed_entry(struct packe=
d_git *p,
 	git_zstream stream;
 	unsigned char *buffer, *in;
=20
-	buffer =3D xmallocz(size);
+	buffer =3D xmallocz_gently(size);
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
