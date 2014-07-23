From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] prune --repos: fix uninitialized access
Date: Wed, 23 Jul 2014 18:43:12 +0700
Message-ID: <1406115795-24082-3-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 13:44:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9uy6-0002Nz-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 13:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbaGWLoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 07:44:17 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:42296 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbaGWLoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 07:44:15 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so1471948pde.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Es56lm7AJ3UZXixQszwdhUMv/NRuubshNc5IGVmidNM=;
        b=l0Fym9eSqbahujGxtTVbSA+KCSFEAkGGeg1Y2ug9tMmycG7DObbPPDiioSRpH/vrGJ
         guaKXz3Y9QuGFQcuvBMDeyrbHH4+ahjNLL7+w2weBIM1eIyQFe1iEpJuIa17mLigFDhi
         DefCh8+hkeDilYC2y7czISz13OfNLI+17gwV7dwYVtZ1rVBFCzWu7r1zQZcCpO9H2Uxt
         t0yBuaF1Ka9nJxi0WyRd/Op/wqTKKzUzDGe9uo/Pm3iumEPI1R67XJwArzuMDmY0NaQS
         iTeR/gPEyNGzkzm7lRI8mw+OMMyTaTlbXtkVEC8NOJW46bWXFR1Af2Ced7NNPWADLMy0
         O5yg==
X-Received: by 10.66.176.97 with SMTP id ch1mr714590pac.101.1406115854083;
        Wed, 23 Jul 2014 04:44:14 -0700 (PDT)
Received: from lanh ([115.73.248.125])
        by mx.google.com with ESMTPSA id ce13sm2828175pdb.76.2014.07.23.04.44.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2014 04:44:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Jul 2014 18:44:08 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254065>

There's a code path in prune_repo_dir() that does not initialize 'st'
buffer, which is checked by the caller, prune_repos_dir(). Instead
of leaking some prune logic out to prune_repos_dir(), move 'st' into
prune_repo_dir().

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
1.9.1.346.ga2b5940
