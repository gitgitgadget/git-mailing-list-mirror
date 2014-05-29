From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] fsck: do not die when not enough memory to examine a pack entry
Date: Thu, 29 May 2014 19:57:05 +0700
Message-ID: <1401368227-14469-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
 <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worley@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 14:49:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpzmJ-00045e-WA
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 14:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757350AbaE2Mtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2014 08:49:47 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:45139 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbaE2Mtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 08:49:47 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so5034838wib.0
        for <git@vger.kernel.org>; Thu, 29 May 2014 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FfSfQfniak6RA/vA6dHiKfugWggI1JC0inN7o10hVCs=;
        b=wdgwR/E9IL8QYZoc+rWcc71awZLzt+TkHi0GOHND65mJ5opl+gxSb5E0qeDWJ1o+hH
         44vtuPgva++ddGSeZkQfe5nuGqXklQkTmB4LACr4a1XP2jUnKEHSp3YWqHJU1T+Fy24b
         3w3yvnjFCYVDUfYShBdLk/HRTB94/U+vsimD6p9cTrk4gODpMskeigt/n/XdAKocJVaN
         cXGEjwQyNwpeLefIStlnl0KbNdCazVuQUAu8nYS1qJe4p1MLggBpYc4EhRhq1sjCcU8Y
         SMmzsxQFcnqgzHOw95EuR88y3pVTbMxh4nu0kJVMLbhL/HrlIQV8GvNEk8ZeZkyr0YX7
         r37g==
X-Received: by 10.180.76.6 with SMTP id g6mr11316589wiw.34.1401367784175;
        Thu, 29 May 2014 05:49:44 -0700 (PDT)
Received: from lanh ([115.73.231.189])
        by mx.google.com with ESMTPSA id lq14sm25519576wic.7.2014.05.29.05.49.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 May 2014 05:49:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 29 May 2014 19:57:25 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250367>

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
 t/t1050-large.sh | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3e9f55f..8ad906a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1921,7 +1921,9 @@ static void *unpack_compressed_entry(struct packe=
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
index fd10528..333909b 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -163,4 +163,9 @@ test_expect_success 'zip achiving, deflate' '
 	git archive --format=3Dzip HEAD >/dev/null
 '
=20
+test_expect_success 'fsck' '
+	test_must_fail git fsck 2>err &&
+	grep "attempting to allocate .* over limit" err
+'
+
 test_done
--=20
1.9.1.346.ga2b5940
