From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v5 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sun, 26 Apr 2015 08:49:42 +0200
Message-ID: <1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 26 08:50:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmGOh-0007HO-6T
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 08:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbDZGu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 02:50:29 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35783 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbDZGu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 02:50:28 -0400
Received: by lbbuc2 with SMTP id uc2so61998233lbb.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bCAIgAgC9tyLDiDpvdr0Ivo53uo7TDxDC4N1kmGEShI=;
        b=uf6Hk4cNCvsane8gZf0bWxtFL9UDDnQY6s9yI8JWigoJDj3aZpmjYx6FTLMIPAyJfZ
         ZgJb5AMcWKwY9UGtYo2cqP+xThva++hyWTR1eQUZjF0zOefkWIpcVkXIyV6hVD515g7v
         QPOZq4QWQSy8T4lqNgLBB1nEDYLx7e599ySoURnttyeRRlJTZ0vTkjOxTmlJbQo1DB6+
         1yZoS5ALF9RwY9zsIXEQvtx6IoHBn1Ub6FymNDLMlAzQQXXGYzq5maxAj1FZEZGrwwPz
         iG4M319C7a7HC6c7/6bevAt34mvhboXrcNwUPZC+rszeLIGxJLeR9yfx0rRnUb/4tFuR
         J8Vg==
X-Received: by 10.152.164.166 with SMTP id yr6mr450951lab.6.1430031027032;
        Sat, 25 Apr 2015 23:50:27 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id x2sm3884938laj.8.2015.04.25.23.50.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 23:50:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.gbb31afb
In-Reply-To: <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267824>

read_gitfile_gently will allocate a buffer to fit the entire file that
should be read. Add a sanity check of the file size before opening to
avoid allocating a potentially huge amount of memory if we come across
a large file that someone happened to name ".git". The limit is set to
a sufficiently unreasonable size that should never be exceeded by a
genuine .git file.

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 cache.h | 1 +
 setup.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/cache.h b/cache.h
index 868e4d3..c9f1f8e 100644
--- a/cache.h
+++ b/cache.h
@@ -439,6 +439,7 @@ extern const char *get_git_work_tree(void);
 #define READ_GITFILE_ERR_INVALID_FORMAT 5
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
+#define READ_GITFILE_ERR_TOO_LARGE 8
 extern const char *read_gitfile_gently(const char *path, int *return_e=
rror_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 extern const char *resolve_gitdir(const char *suspect);
diff --git a/setup.c b/setup.c
index c4538ca..792c37b 100644
--- a/setup.c
+++ b/setup.c
@@ -364,6 +364,10 @@ const char *read_gitfile_gently(const char *path, =
int *return_error_code)
 		error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
 		goto cleanup_return;
 	}
+	if (st.st_size > PATH_MAX * 4) {
+		error_code =3D READ_GITFILE_ERR_TOO_LARGE;
+		goto cleanup_return;
+	}
 	buf =3D xmalloc(st.st_size + 1);
 	len =3D read_in_full(fd, buf, st.st_size);
 	close(fd);
@@ -418,6 +422,8 @@ cleanup_return:
 			return NULL;
 		case READ_GITFILE_ERR_OPEN_FAILED:
 			die_errno("Error opening '%s'", path);
+		case READ_GITFILE_ERR_TOO_LARGE:
+			die("Too large to be a .git file: '%s'", path);
 		case READ_GITFILE_ERR_READ_FAILED:
 			die("Error reading %s", path);
 		case READ_GITFILE_ERR_INVALID_FORMAT:
--=20
2.4.0.rc3.8.gbb31afb
