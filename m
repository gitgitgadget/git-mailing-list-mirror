From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v7 2/5] setup: sanity check file size in read_gitfile_gently
Date: Tue,  9 Jun 2015 20:24:36 +0200
Message-ID: <1433874279-30720-3-git-send-email-erik.elfstrom@gmail.com>
References: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:25:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ODP-00052o-3O
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbbFISZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 14:25:31 -0400
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33679 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbbFISZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:25:29 -0400
Received: by lbio15 with SMTP id o15so2622658lbi.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=T0JwuFM0GaM04rxEI/P3k6ioi2pCzryg93J5KvKLmWA=;
        b=F7qsXIZk3/UPibjchnXBI+Kl0gUGju9mZrEt+XsndQHdHn+ffzsbYIyiZ6TAOoQUZ1
         /HjrPL1hpB9qd4l61858SXAQSxQVU/J6T+Xxr1zq9a4lbWXY7Vdu+SeNxdySxf0Rjj4G
         005B2+tQKkzKhz7rVtx8jqo2LUfF684UIEvgUfInHuaWX7+FtgHTdzgDP6sXrKB3DZP1
         whhpd0sF52sH6t24wcOB0n6epm2NjhxTZ1Gauh/kimXro+NViXk0Uk2t8vc5XExCFqdU
         rtnCxKFV7XbCtM1YC9CHiwtOhGf9+AxJCE2Y8oDD9NrokKylYIRpsJ+ATJyDRAl5J3M2
         6ADw==
X-Received: by 10.152.26.230 with SMTP id o6mr24465415lag.7.1433874326339;
        Tue, 09 Jun 2015 11:25:26 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id bm5sm285250lbc.45.2015.06.09.11.25.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jun 2015 11:25:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.373.gc496bfb
In-Reply-To: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271217>

read_gitfile_gently will allocate a buffer to fit the entire file that
should be read. Add a sanity check of the file size before opening to
avoid allocating a potentially huge amount of memory if we come across
a large file that someone happened to name ".git". The limit is set to
a sufficiently unreasonable size that should never be exceeded by a
genuine .git file.

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 cache.h | 1 +
 setup.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 25578cb..858d9b3 100644
--- a/cache.h
+++ b/cache.h
@@ -454,6 +454,7 @@ extern const char *get_git_work_tree(void);
 #define READ_GITFILE_ERR_INVALID_FORMAT 5
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
+#define READ_GITFILE_ERR_TOO_LARGE 8
 extern const char *read_gitfile_gently(const char *path, int *return_e=
rror_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 extern const char *resolve_gitdir(const char *suspect);
diff --git a/setup.c b/setup.c
index 4748b63..e76955e 100644
--- a/setup.c
+++ b/setup.c
@@ -414,6 +414,7 @@ static void update_linked_gitdir(const char *gitfil=
e, const char *gitdir)
  */
 const char *read_gitfile_gently(const char *path, int *return_error_co=
de)
 {
+	static const int one_MB =3D 1 << 20;
 	int error_code =3D 0;
 	char *buf =3D NULL;
 	char *dir =3D NULL;
@@ -430,6 +431,10 @@ const char *read_gitfile_gently(const char *path, =
int *return_error_code)
 		error_code =3D READ_GITFILE_ERR_NOT_A_FILE;
 		goto cleanup_return;
 	}
+	if (st.st_size > one_MB) {
+		error_code =3D READ_GITFILE_ERR_TOO_LARGE;
+		goto cleanup_return;
+	}
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0) {
 		error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
@@ -489,6 +494,8 @@ cleanup_return:
 			return NULL;
 		case READ_GITFILE_ERR_OPEN_FAILED:
 			die_errno("Error opening '%s'", path);
+		case READ_GITFILE_ERR_TOO_LARGE:
+			die("Too large to be a .git file: '%s'", path);
 		case READ_GITFILE_ERR_READ_FAILED:
 			die("Error reading %s", path);
 		case READ_GITFILE_ERR_INVALID_FORMAT:
--=20
2.4.3.373.gc496bfb
