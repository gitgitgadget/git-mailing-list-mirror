From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/6] unpack-objects: continue when fail to malloc due to large objects
Date: Wed, 13 Aug 2014 17:57:31 +0700
Message-ID: <1407927454-9268-4-git-send-email-pclouds@gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:58:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWFq-0000SR-Bu
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 12:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbaHMK6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 06:58:00 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36181 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaHMK56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 06:57:58 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so14345267pdj.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9Ezlm0Vfg+wFGKwYnQ9IVyihfCd45QODIq+OZnAMkA0=;
        b=BrCGI/DejF24WUwQP8tU38vGLevFyXlX0OsY/jSlns7LXcXLNLnjKpdlLAjtHG1oAv
         94fUVPPxyFdPbogs/65LIBITefwiBZmzCZbbs45iw3pDSixfYDtK5H39tIXJbghSfP+K
         AM9gA9VK7gqaRbu2ox6jWro0xHWq/u+lTck6/FTrfzgHC7gnued/hS8ONtI9cBaKh0qq
         qV1wZjWvYJIPiLg3UfNYChA454ZJfStf0ZBty3LVAw1rtKk2rxn9NQsfAPms4eegr/rI
         DnhBBXu21GFuyiQgVz+6qeNY1rEm/Q+eWgwkju2/0j9Us8G4oPrNtHBjcCS7ehCf7D2V
         1bGQ==
X-Received: by 10.66.163.164 with SMTP id yj4mr3260533pab.91.1407927478202;
        Wed, 13 Aug 2014 03:57:58 -0700 (PDT)
Received: from lanh ([115.73.196.146])
        by mx.google.com with ESMTPSA id h10sm5761010pat.11.2014.08.13.03.57.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 03:57:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Aug 2014 17:57:54 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255195>

As a recovery tool, unpack-objects should go on unpacking as many
objects as it can.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 42 ++++++++++++++++++++++++++++++++++++++++=
+-
 t/t1050-large.sh         |  7 +++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 99cde45..8b5c67e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -88,10 +88,50 @@ static void use(int bytes)
 	consumed_bytes +=3D bytes;
 }
=20
+static void inflate_and_throw_away(unsigned long size)
+{
+	git_zstream stream;
+	char buf[8192];
+
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out =3D (unsigned char *)buf;
+	stream.avail_out =3D sizeof(buf);
+	stream.next_in =3D fill(1);
+	stream.avail_in =3D len;
+	git_inflate_init(&stream);
+
+	for (;;) {
+		int ret =3D git_inflate(&stream, 0);
+		use(len - stream.avail_in);
+		if (stream.total_out =3D=3D size && ret =3D=3D Z_STREAM_END)
+			break;
+		if (ret !=3D Z_OK) {
+			error("inflate returned %d", ret);
+			if (!recover)
+				exit(1);
+			has_errors =3D 1;
+			break;
+		}
+		stream.next_out =3D (unsigned char *)buf;
+		stream.avail_out =3D sizeof(buf);
+		stream.next_in =3D fill(1);
+		stream.avail_in =3D len;
+	}
+	git_inflate_end(&stream);
+}
+
 static void *get_data(unsigned long size)
 {
 	git_zstream stream;
-	void *buf =3D xmalloc(size);
+	void *buf =3D xmalloc_gentle(size);
+
+	if (!buf) {
+		if (!recover)
+			exit(1);
+		has_errors =3D 1;
+		inflate_and_throw_away(size);
+		return NULL;
+	}
=20
 	memset(&stream, 0, sizeof(stream));
=20
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 5642f84..eec2cca 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -169,4 +169,11 @@ test_expect_success 'fsck' '
 	test "$n" -gt 1
 '
=20
+test_expect_success 'unpack-objects' '
+	P=3D`ls .git/objects/pack/*.pack` &&
+	git unpack-objects -n -r <$P 2>err
+	test $? =3D 1 &&
+	grep "error: attempting to allocate .* over limit" err
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
