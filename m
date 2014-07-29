From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/8] prune --repos: fix uninitialized access
Date: Tue, 29 Jul 2014 20:50:26 +0700
Message-ID: <1406641831-2390-4-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7pj-0005dv-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbaG2Nwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:52:47 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57108 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbaG2Nwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:52:47 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so12361469pac.18
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ntx25UU8oOE1Phigf0BxkPGWlaRnBZCM1gU6ss34Xnc=;
        b=F24pY9szE5ypeOjafQm45kRPt+rIqmK0WcI0uHvv+Cd4/RXJFdruGJvnoS6iLEtJSg
         V6Ru+DUKqnI/F/TGJtFTsiuf/d/tlD53739uUVPmuITNcsUEyLWMsVj4Q3ehaNws+KiY
         OeM0SH9m/J0kZqFERGZB/6o3zK1wmGkajyM+lozWOOO7rXFKc4K8hGo+ltZ9PA9vuLEy
         UMFfIRxdGNKFlYsEhXRnN45Qedz97saHOI1UyjP5mLnqbTSKN4Xm5rpp7ybJS6Or/dTX
         F5Pq70L9B9XvWdPAV7Dp+BYUgTvwNiPh7TgfO2a2O0klRBNfuA7aAi1ZRTmz0uges4Vt
         IJGw==
X-Received: by 10.70.90.7 with SMTP id bs7mr2129265pdb.141.1406641966575;
        Tue, 29 Jul 2014 06:52:46 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id fo2sm20833462pbb.53.2014.07.29.06.52.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:52:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:52:49 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254437>

There's a code path in prune_repo_dir() that does not initialize 'st'
buffer, which is checked by the caller, prune_repos_dir(). Instead
of leaking some prune logic out to prune_repos_dir(), move 'st' into
prune_repo_dir().

Another bug that is fixed while at there is the "return 0" at the end
of prune_repo_dir() instead of '1', meaning "keep the checkout" while
we want "keep the checkout _unless_ its last update is older than
expire limit". Set correct expire limit in the test as well.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/prune.c                   | 16 ++++++----------
 t/t2026-prune-linked-checkouts.sh |  2 +-
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 28b7adf..e72c391 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -112,8 +112,9 @@ static void prune_object_dir(const char *path)
 	}
 }
=20
-static int prune_repo_dir(const char *id, struct stat *st, struct strb=
uf *reason)
+static int prune_repo_dir(const char *id, struct strbuf *reason)
 {
+	struct stat st;
 	char *path;
 	int fd, len;
=20
@@ -123,26 +124,23 @@ static int prune_repo_dir(const char *id, struct =
stat *st, struct strbuf *reason
 	}
 	if (file_exists(git_path("repos/%s/locked", id)))
 		return 0;
-	if (stat(git_path("repos/%s/gitdir", id), st)) {
-		st->st_mtime =3D expire;
+	if (stat(git_path("repos/%s/gitdir", id), &st)) {
 		strbuf_addf(reason, _("Removing repos/%s: gitdir file does not exist=
"), id);
 		return 1;
 	}
 	fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
 	if (fd < 0) {
-		st->st_mtime =3D expire;
 		strbuf_addf(reason, _("Removing repos/%s: unable to read gitdir file=
 (%s)"),
 			    id, strerror(errno));
 		return 1;
 	}
-	len =3D st->st_size;
+	len =3D st.st_size;
 	path =3D xmalloc(len + 1);
 	read_in_full(fd, path, len);
 	close(fd);
 	while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r'=
))
 		len--;
 	if (!len) {
-		st->st_mtime =3D expire;
 		strbuf_addf(reason, _("Removing repos/%s: invalid gitdir file"), id)=
;
 		free(path);
 		return 1;
@@ -162,7 +160,7 @@ static int prune_repo_dir(const char *id, struct st=
at *st, struct strbuf *reason
 		return 1;
 	}
 	free(path);
-	return 0;
+	return st.st_mtime <=3D expire;
 }
=20
 static void prune_repos_dir(void)
@@ -172,15 +170,13 @@ static void prune_repos_dir(void)
 	DIR *dir =3D opendir(git_path("repos"));
 	struct dirent *d;
 	int ret;
-	struct stat st;
 	if (!dir)
 		return;
 	while ((d =3D readdir(dir)) !=3D NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 		strbuf_reset(&reason);
-		if (!prune_repo_dir(d->d_name, &st, &reason) ||
-		    st.st_mtime > expire)
+		if (!prune_repo_dir(d->d_name, &reason))
 			continue;
 		if (show_only || verbose)
 			printf("%s\n", reason.buf);
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-c=
heckouts.sh
index 4ccfa4e..79d84cb 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -77,7 +77,7 @@ test_expect_success 'not prune recent checkouts' '
 	mkdir zz &&
 	mkdir -p .git/repos/jlm &&
 	echo "$TRASH_DIRECTORY"/zz >.git/repos/jlm/gitdir &&
-	git prune --repos --verbose &&
+	git prune --repos --verbose --expire=3D2.days.ago &&
 	test -d .git/repos/jlm
 '
=20
--=20
2.1.0.rc0.78.gc0d8480
