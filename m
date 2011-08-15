From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] commit: check return value of lookup_commit()
Date: Mon, 15 Aug 2011 22:38:36 +0700
Message-ID: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 17:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QszFc-0006aT-2Z
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 17:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab1HOPiq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Aug 2011 11:38:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55228 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab1HOPip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 11:38:45 -0400
Received: by yie30 with SMTP id 30so3218603yie.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mJ7sCGL98m8+LOvOq3S3xHFyeUew5PD5t5SuO7AFQ4c=;
        b=hD8qjGA/Je3xaorRINdBmzaKypcw3GTdzZMQsQhSdt94m07J76Llf4DweZhWKx8bem
         smmoi3IG9hj6AyqeAUmyQuNqFk2onoVLAgiYjJaBoyAhGcxTe7p+tpS8q3F6jr3l7CCE
         V0PlqavNqJ1KtAFWXEZF20oogpj18g+RomDEo=
Received: by 10.42.159.69 with SMTP id k5mr4355893icx.389.1313422724769;
        Mon, 15 Aug 2011 08:38:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.208.228])
        by mx.google.com with ESMTPS id o8sm7586994icc.5.2011.08.15.08.38.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 08:38:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Aug 2011 22:38:37 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179375>

If lookup_commit() returns NULL, there's usually serious error and the
command aborts anyway. However it's still nicer to have a message
telling us where it aborts, rather than segmentation fault.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I suppose die() also cleans up $GIT_DIR/index.lock while sigsegv does =
not.

 builtin/commit.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2088b6b..bfb7a5a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1387,6 +1387,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents =3D NULL, **pptr =3D &parents;
+	struct commit *commit;
 	struct stat statbuf;
 	int allow_fast_forward =3D 1;
 	struct wt_status s;
@@ -1423,7 +1424,6 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			reflog_msg =3D "commit (initial)";
 	} else if (amend) {
 		struct commit_list *c;
-		struct commit *commit;
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (amend)";
@@ -1439,7 +1439,10 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (merge)";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		commit =3D lookup_commit(head_sha1);
+		if (!commit)
+			die(_("could not parse HEAD commit"));
+		pptr =3D &commit_list_insert(commit, pptr)->next;
 		fp =3D fopen(git_path("MERGE_HEAD"), "r");
 		if (fp =3D=3D NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1448,7 +1451,10 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
 				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
-			pptr =3D &commit_list_insert(lookup_commit(sha1), pptr)->next;
+			commit =3D lookup_commit(sha1);
+			if (!commit)
+				die(_("could not parse commit %s"), sha1_to_hex(sha1));
+			pptr =3D &commit_list_insert(commit, pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
@@ -1465,7 +1471,10 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 			reflog_msg =3D (whence =3D=3D FROM_CHERRY_PICK)
 					? "commit (cherry-pick)"
 					: "commit";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		commit =3D lookup_commit(head_sha1);
+		if (!commit)
+			die(_("could not parse HEAD commit"));
+		pptr =3D &commit_list_insert(commit, pptr)->next;
 	}
=20
 	/* Finally, get the commit message */
--=20
1.7.4.74.g639db
