From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v4 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sat, 25 Apr 2015 11:06:38 +0200
Message-ID: <1429952801-2646-3-git-send-email-erik.elfstrom@gmail.com>
References: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 11:07:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylw3L-00051K-C9
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 11:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750AbbDYJHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 05:07:09 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33725 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787AbbDYJHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 05:07:04 -0400
Received: by layy10 with SMTP id y10so50379397lay.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AxaA6CeA4kqIiBcKH3BfI+IE1nCeJ+DK9K2WeLzZXQ0=;
        b=ZhbZkKhY7rde/EkT8B8r9B6P+OkmCrGgXFNIqQQ0ODl3TD1bEcaXRsLm8elZFCsI3e
         bBMzFra6VNlx2ZLbVApURX04YWr7r6AjASLRuwrl6Q6rCW268YLmPjUzK1B+mph9Eoo1
         W6mVVh6fQTcX+fSHJXrCpc/+QUuSRwxMag6uF64jvHDr1jeR7MmgPfRhWkSO5FWsLBwB
         Erhr3hHogigy5PK/zm0dVXZITodKHCZR787Fb8yGyVRNDWjlsPTND6wAvDCZO5Tm/BvJ
         +d2mrETf9GhTLNuh/6B1fmKT9oH9Rjhi38hQBCj2pJlYoUiWwUuaH1Su+dcl2wgG7fpN
         ppzg==
X-Received: by 10.152.88.46 with SMTP id bd14mr2080812lab.71.1429952823391;
        Sat, 25 Apr 2015 02:07:03 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id r6sm3249243lbw.10.2015.04.25.02.07.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 02:07:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.g86acfbd
In-Reply-To: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267783>

read_gitfile_gently will allocate a buffer to fit the entire file that
should be read. Add a sanity check of the file size before opening to
avoid allocating a potentially huge amount of memory if we come across
a large file that someone happened to name ".git". The limit is set to
a sufficiently unreasonable size that should never be exceeded by a
genuine .git file.

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---

I'm not sure about this one but it felt like the safe thing to do.
This patch can be dropped if it is not desired.

I considered testing it using
 "mkdir foo && truncate -s 200G foo/.git && git clean -f -d"
but that feels like a pretty evil test that is likely to cause lots
of problems and not fail in any good way.

 setup.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index e1897cc..ed87334 100644
--- a/setup.c
+++ b/setup.c
@@ -364,22 +364,26 @@ const char *read_gitfile_gently(const char *path,=
 int *return_error_code)
 		error_code =3D 3;
 		goto cleanup_return;
 	}
+	if (st.st_size > PATH_MAX * 4) {
+		error_code =3D 4;
+		goto cleanup_return;
+	}
 	buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
 	if (len !=3D st.st_size) {
-		error_code =3D 4;
+		error_code =3D 5;
 		goto cleanup_return;
 	}
 	buf[len] =3D '\0';
 	if (!starts_with(buf, "gitdir: ")) {
-		error_code =3D 5;
+		error_code =3D 6;
 		goto cleanup_return;
 	}
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
 	if (len < 9) {
-		error_code =3D 6;
+		error_code =3D 7;
 		goto cleanup_return;
 	}
 	buf[len] =3D '\0';
@@ -397,7 +401,7 @@ const char *read_gitfile_gently(const char *path, i=
nt *return_error_code)
 	}
=20
 	if (!is_git_directory(dir)) {
-		error_code =3D 7;
+		error_code =3D 8;
 		goto cleanup_return;
 	}
 	path =3D real_path(dir);
@@ -419,12 +423,14 @@ cleanup_return:
 		case 3:
 			die_errno("Error opening '%s'", path);
 		case 4:
-			die("Error reading %s", path);
+			die("Too large to be a .git file: '%s'", path);
 		case 5:
-			die("Invalid gitfile format: %s", path);
+			die("Error reading %s", path);
 		case 6:
-			die("No path in gitfile: %s", path);
+			die("Invalid gitfile format: %s", path);
 		case 7:
+			die("No path in gitfile: %s", path);
+		case 8:
 			die("Not a git repository: %s", dir);
 		default:
 			assert(0);
--=20
2.4.0.rc3.8.g4ebd28d
