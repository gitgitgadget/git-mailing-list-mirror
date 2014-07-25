From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] strbuf.c: keep errno in strbuf_read_file()
Date: Fri, 25 Jul 2014 17:43:56 +0700
Message-ID: <1406285039-22469-2-git-send-email-pclouds@gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAcz5-00042A-0H
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 12:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760092AbaGYKoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 06:44:14 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51724 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaGYKoO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 06:44:14 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so5880378pad.21
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2s30o0Ttf2iBMU8l+o9ogHDAX9MDrjH2OmsUsE+D90g=;
        b=07DF077q/8d/eu56udKMHZNHQ0PrhMdfyIUKY/IdAS5ZMJPy2Hzlp3aFto7aljkxVq
         E907rwNBf6Gv+3BeMfC6bfoBP3DJcJGh5uJUR7W8pu9ImrUg2c/wp8sVNFEgB5pldPrW
         2xsyHEvwn5BMbWXk3gjTs8ixyfZ92lzU2DaiDfErNCo5OK0MAvhc9v2QCHKIgZc942ok
         cN3pH3++8xMs0aM62tDF2lHNPyToJZ87S5V1zyGj3vIc2bgd6uEYiZv312lqZoevcedz
         BjK08NRVe8GsXrnEozYRG1viZK0y+VI6zw76EEfDXH9OudORjEVMek5AxjvQQaAV6K4T
         dChQ==
X-Received: by 10.68.139.36 with SMTP id qv4mr17738676pbb.82.1406285053506;
        Fri, 25 Jul 2014 03:44:13 -0700 (PDT)
Received: from lanh ([115.73.251.194])
        by mx.google.com with ESMTPSA id xc1sm31306406pab.39.2014.07.25.03.44.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jul 2014 03:44:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jul 2014 17:44:10 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254204>

This function is used to replaced some code in the next patch that
does this (i.e. keep the errno when read() fails)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 strbuf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 33018d8..61d685d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -454,15 +454,18 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int=
 fd, int term)
=20
 int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
-	int fd, len;
+	int fd, len, saved_errno;
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
 	len =3D strbuf_read(sb, fd, hint);
+	saved_errno =3D errno;
 	close(fd);
-	if (len < 0)
+	if (len < 0) {
+		errno =3D saved_errno;
 		return -1;
+	}
=20
 	return len;
 }
--=20
1.9.1.346.ga2b5940
