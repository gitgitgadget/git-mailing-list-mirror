From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] fsck: do not die when not enough memory to examine a pack entry
Date: Tue, 24 Jun 2014 18:45:34 +0700
Message-ID: <1403610336-27761-2-git-send-email-pclouds@gmail.com>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
 <1403610336-27761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 13:45:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzPAj-0004I2-AI
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 13:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbaFXLpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2014 07:45:53 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:41082 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaFXLpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 07:45:52 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so151406pbc.30
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=36ij4gk0NyAnAQQYlHqvFALXx9oiTa4S6M7QNmBxWdo=;
        b=o47IBQ5eW4yOnYvAt2jQoCgHHPsZOYD+nLR+FEGooTbQj8HrTULAFUiB5KHQjgYd9C
         hsc866u5rujNKIJDgWKS4k1D3hIhNm7iEflQ+HrS/mPgmAaaFNhy5Mavq+sDhqjiJCI+
         r4vCt999hCrgYMUFz8bCELKGQI9qOBomqvnJ0yhwW2Squ9skR4c+6Zs2T3MkiHViMTI3
         FM2WzYRwA8Q4IUuQI6g1TLvJQXV6gGeBvw7Z0lpo6Leji6iLfqyE5qAX/hWbaC1Ac6XE
         ZDZAmt66tb8nLKzp2KYIXFliExkakL8P8h5H3pmlwFoUDR5S+gt4Tih9vw7qPD/ZTMzH
         Q0lA==
X-Received: by 10.68.235.100 with SMTP id ul4mr580346pbc.15.1403610352102;
        Tue, 24 Jun 2014 04:45:52 -0700 (PDT)
Received: from lanh ([115.73.210.12])
        by mx.google.com with ESMTPSA id kn1sm72363pbd.13.2014.06.24.04.45.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jun 2014 04:45:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 24 Jun 2014 18:45:49 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252398>

fsck is a tool that error() is more preferred than die(), but many
functions embed die() inside beyond fsck's control.
unpack_compressed_entry()'s using xmallocz is such a function,
triggered from verify_packfile() -> unpack_entry(). Make it use
xmallocz_gentle() instead.

Noticed-by: Dale R. Worley <worley@alum.mit.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c      | 4 +++-
 t/t1050-large.sh | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 34d527f..eb69c78 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1925,7 +1925,9 @@ static void *unpack_compressed_entry(struct packe=
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
1.9.1.346.ga2b5940
