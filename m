From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v8 2/5] setup: sanity check file size in read_gitfile_gently
Date: Mon, 15 Jun 2015 21:39:52 +0200
Message-ID: <1434397195-1823-3-git-send-email-erik.elfstrom@gmail.com>
References: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 21:40:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aFJ-00045T-26
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009AbbFOTkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 15:40:33 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:35209 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbbFOTkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:40:31 -0400
Received: by labko7 with SMTP id ko7so64830832lab.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iyUuUV5CYr4yUV6a8KJIABtYgxj3e+PBSaWzY36bPdM=;
        b=eclGYExM7Xfd1WwBHwixRV2dgxlsrKFNr4e/IEFVvnyVxPULeNfzRExsvnZl9G4jVo
         CbxJTiFN6lcaTaEIoB5GiAuJjwd+pTdGClTNs2HSPQZgEYbWB+bj/aKOaofUZ7dtVchJ
         veLggLofftbhs78q6rI4Ohsmuj6E39P+fG4WQjPBcJXJIjsHjugUI+BbU0IsljRS/X/g
         wblqIjI7hLpBDUGYfChanM7n/NGL+eRqlblMYSnsCz1+joIvsMlLHCi6fmEoTS/wgnin
         vk1YlNfO2Zn7a1AZUgyVy0OHBw6+QxJjkrO0IpzKrbz+9CXj2qBlkDsuBOth4RL33ThO
         zuXw==
X-Received: by 10.112.126.42 with SMTP id mv10mr1773162lbb.58.1434397230182;
        Mon, 15 Jun 2015 12:40:30 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id a7sm2923526lbc.36.2015.06.15.12.40.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 12:40:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.373.gc496bfb.dirty
In-Reply-To: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271712>

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
index 4748b63..a03ca94 100644
--- a/setup.c
+++ b/setup.c
@@ -414,6 +414,7 @@ static void update_linked_gitdir(const char *gitfil=
e, const char *gitdir)
  */
 const char *read_gitfile_gently(const char *path, int *return_error_co=
de)
 {
+	const int max_file_size =3D 1 << 20;  /* 1MB */
 	int error_code =3D 0;
 	char *buf =3D NULL;
 	char *dir =3D NULL;
@@ -430,6 +431,10 @@ const char *read_gitfile_gently(const char *path, =
int *return_error_code)
 		error_code =3D READ_GITFILE_ERR_NOT_A_FILE;
 		goto cleanup_return;
 	}
+	if (st.st_size > max_file_size) {
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
2.4.3.373.gc496bfb.dirty
