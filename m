From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/21] reflog: use avoid constructing .lock path with git_path
Date: Sat, 14 Dec 2013 17:54:51 +0700
Message-ID: <1387018507-21999-6-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmp2-0000uB-0S
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3LNKvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:42 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:42357 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:40 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so3597276pbb.32
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MKU85IFn1IyBw6isgg08F7Gw/OOUCULzMopVvuUkFg8=;
        b=gvTqWZC0GxB4YUjdmxanpCUAfQZ6nGhapeo/zkr/Vn2ipgxmlQlj57jghT0ahRBDng
         ojbq8Wdg6y3ehhSWilWxrLe465Jw1vZyknuS8+3U2gT9BYHEmN8v9Sz/ayv/rlfEocb/
         /7z9mKAnxjf0V9j8byj9KLqBUpoyj/f7rM50RWbFMv81HWhfxUBJayaSzf9Wzb7qbvR5
         QA1sp3fkeW73U6iqzZ5zygIkk4l+kw76sKNuNdJW58R55UydOyYTOuhFsD+TgSTQfrJo
         fv4rJ3hx0GtI/jfLPbinG1+OrRDWuhj7XNf7B/ycXRYDCoo7N7sF2KYk8quVkEFPM7/w
         AHmw==
X-Received: by 10.66.149.73 with SMTP id ty9mr8914213pab.36.1387018299997;
        Sat, 14 Dec 2013 02:51:39 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id oj6sm15334625pab.9.2013.12.14.02.51.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:32 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239287>

git_path() understands the path given to it. Unrecognized paths by
default go to $GIT_SUPER_DIR/repos/<id>/... in split-repo mode. We
want the %s.lock file to be at the same place %s file is. Avoid
git_path() in this case and use log_file as %s, which should contain
the final path of %s file.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reflog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6eb24c8..dc1accf 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -372,7 +372,7 @@ static int expire_reflog(const char *ref, const uns=
igned char *sha1, int unused,
 	if (!file_exists(log_file))
 		goto finish;
 	if (!cmd->dry_run) {
-		newlog_path =3D git_pathdup("logs/%s.lock", ref);
+		newlog_path =3D mkpathdup("%s.lock", log_file);
 		cb.newlog =3D fopen(newlog_path, "w");
 	}
=20
--=20
1.8.5.1.77.g42c48fa
