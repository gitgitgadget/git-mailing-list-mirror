From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/32] update-index --split-index: do not split if $GIT_DIR is read only
Date: Mon, 28 Apr 2014 17:55:47 +0700
Message-ID: <1398682553-11634-27-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:57:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejFt-0004ZE-2n
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbaD1K46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:58 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39070 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaD1K4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:52 -0400
Received: by mail-pa0-f45.google.com with SMTP id kq14so5031844pab.32
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=K9MYrb8llw9dUeDzgyoeWUJaBcfflhphMBheZVL0vqE=;
        b=tVnjXSUOfKrSsFE+VugNzQI8pEgKBqGyKvcIXZP0sXetxHgHN1HG3X1zbz7msVfyym
         pzR+aIt+hIwz+BYEh/2NIUz8dTl9uGPGYljZMjy4qoGz4j0n4d4tciubY6I9xmZE5Ar/
         MmI99DYDdTknQFn0PYp5FAu4J3JkymFKUeQ1EKsHThvkxlo2zUrup55AzY8IDaeVqesC
         BhScImwIEdB8rJZrg4WcigVe/rWX07I815G/mSJuayguGH4YkmvXFAS0wKIUXhMn+Usz
         Ap5dNRMs70sl0RjYpLobgNwSN7KysGBQVVrPaDR8VTJCK7K6y8ORs0hx2nz/k2zrSyxr
         SwrQ==
X-Received: by 10.66.240.130 with SMTP id wa2mr24878807pac.73.1398682611717;
        Mon, 28 Apr 2014 03:56:51 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id gn3sm34219199pbc.32.2014.04.28.03.56.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:19 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247296>

If $GIT_DIR is read only, we can't write $GIT_DIR/sharedindex. This
could happen when $GIT_INDEX_FILE is set to somehwere outside
$GIT_DIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a6c9407..f9fc3a5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2030,14 +2030,21 @@ static void remove_temporary_sharedindex_on_sig=
nal(int signo)
 	raise(signo);
 }
=20
-static int write_shared_index(struct index_state *istate)
+static int write_shared_index(struct index_state *istate,
+			      struct lock_file *lock, unsigned flags)
 {
 	struct split_index *si =3D istate->split_index;
 	static int installed_handler;
 	int fd, ret;
=20
 	temporary_sharedindex =3D git_pathdup("sharedindex_XXXXXX");
-	fd =3D xmkstemp(temporary_sharedindex);
+	fd =3D mkstemp(temporary_sharedindex);
+	if (fd < 0) {
+		free(temporary_sharedindex);
+		temporary_sharedindex =3D NULL;
+		hashclr(si->base_sha1);
+		return do_write_locked_index(istate, lock, flags);
+	}
 	if (!installed_handler) {
 		atexit(remove_temporary_sharedindex);
 		sigchain_push_common(remove_temporary_sharedindex_on_signal);
@@ -2070,7 +2077,7 @@ int write_locked_index(struct index_state *istate=
, struct lock_file *lock,
 	}
=20
 	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
-		int ret =3D write_shared_index(istate);
+		int ret =3D write_shared_index(istate, lock, flags);
 		if (ret)
 			return ret;
 	}
--=20
1.9.1.346.ga2b5940
