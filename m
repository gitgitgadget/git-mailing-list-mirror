From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] editor: use canonicalized absolute path
Date: Sun, 28 Jul 2013 22:29:42 +0530
Message-ID: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 28 19:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3UNl-00061T-8N
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 19:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab3G1RDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jul 2013 13:03:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39961 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab3G1RDW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 13:03:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so4012266pad.16
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=hE/vpRvuuMek7e38bbnMXba/8nBQ7qRoSLH0k17cXn0=;
        b=umSD8cqvHiLviewDc0gtTYRlu4Ms1dDIfkYpjAgYYG48n7scOH8guf/LZTqDEtYw+o
         1FSWYXVwGKVrSZ3ejQLuCrq2KNSd3u0eKFOlZ6T26eAw5RDG49Ab3AdrFFxTTJ9WXVUd
         ZXL4bMNQ2NIZfrWcj2qTMiKy5bpq/5Aio2Fk+8OTWjZW5BT39t0fzvvzm5TuNwKWEK8G
         MZAFiQt6zM8OTD1hUF27tmYVtAKNNZfTYO8mJHOR+m3WAUDsrC94yBUC0Iwbe10uIVit
         nWswMKmVg6HCziDBGe1wt6iM1QU0s9Yi+BtCyjFCnjBiJp/o4tWYWGHPvEJVW4fM9ckf
         ZD3w==
X-Received: by 10.66.26.194 with SMTP id n2mr55723366pag.151.1375031002441;
        Sun, 28 Jul 2013 10:03:22 -0700 (PDT)
Received: from localhost.localdomain ([122.164.159.87])
        by mx.google.com with ESMTPSA id qh10sm32177651pbb.33.2013.07.28.10.03.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 28 Jul 2013 10:03:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.2.g7ba4592
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231268>

By improving the relative_path() algorithm, e02ca72 (path.c: refactor
relative_path(), not only strip prefix, 2013-06-25) uncovered a latent
bug.  While most editor applications like cat and vim handle
non-canonicalized relative paths fine, emacs does not.  This is due to =
a
long-standing bug in emacs, where it refuses to resolve symlinks in the
supplied path:

  #!/bin/sh
  mkdir z z/a z/b
  echo moodle >z/a/file
  ln -s z/b
  cd b
  emacs ../a/file # fail: opens /tmp/a/file

Even if emacs were to be patched to fix this bug now, we still need to
support users running older versions.

Co-authored-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Urgent candidate for maint.  I wrote to emacs-devel, but nobody seems
 to be interested; the sources are horrendously unmaintainable, and
 the project should die soon.

 editor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/editor.c b/editor.c
index 27bdecd..0abbd8d 100644
--- a/editor.c
+++ b/editor.c
@@ -37,7 +37,7 @@ int launch_editor(const char *path, struct strbuf *bu=
ffer, const char *const *en
 		return error("Terminal is dumb, but EDITOR unset");
=20
 	if (strcmp(editor, ":")) {
-		const char *args[] =3D { editor, path, NULL };
+		const char *args[] =3D { editor, real_path(path), NULL };
 		struct child_process p;
 		int ret, sig;
=20
--=20
1.8.4.rc0.2.g7ba4592
