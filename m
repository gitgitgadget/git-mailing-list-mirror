From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] branch: show rebase/bisect info when possible instead of "(no branch)"
Date: Sun,  3 Feb 2013 12:48:40 +0700
Message-ID: <1359870520-22644-1-git-send-email-pclouds@gmail.com>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 06:48:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1sRO-0004U4-KT
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 06:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab3BCFsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2013 00:48:09 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:63702 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3BCFsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 00:48:08 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so777454pab.8
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 21:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=SKFRmyw9XBiL0Mbn6b8J4bxYDLqrZeU0jR4ZKj26KtY=;
        b=tk7Lck7bXLirKf4JhLEWzLdVeVkfE0MuBzVsFIJ7Ew6z+jdlh4oWuy65SwBxQbhlNz
         h99ILcBXE879rzP5aLhYR7SOBQP71EHnbAsbYGXrH0lZYz1+P8vqvLTrGIBe10l1x3SW
         I7M77J3wLyhE490dmbfPRhKjSHtjfCHPLq2TPKFlxpVO9RrZ2IcOiPEH3dKe+atKo/xz
         xamk+aOnez8Gf5Sx5mAwgkwsF1xzXNXaeJnc/QP+cBkw75CAEC5ac4ALuQPEe0JkCVoC
         ul49gSALT2JTS3dQZQZWZhKWAWaugxHTxKkGEfJa+tb5hhbRHiFx1hc64oHWsP6qS5qr
         puvA==
X-Received: by 10.66.81.166 with SMTP id b6mr42251878pay.7.1359870487046;
        Sat, 02 Feb 2013 21:48:07 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id ba3sm13763223pbd.29.2013.02.02.21.48.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Feb 2013 21:48:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Feb 2013 12:48:42 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
In-Reply-To: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215300>

This prints more helpful info when HEAD is detached: is it detached
because of bisect or rebase? What is the original branch name in those
cases?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  - Incorporate Jonathan's version of checking
  - Show original branch name, e.g. "(rebasing foo)", when possible

 builtin/branch.c            | 40 +++++++++++++++++++++++++++++++++++++=
++-
 t/t6030-bisect-porcelain.sh |  2 +-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ea6498b..40f20ad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -550,6 +550,44 @@ static int calc_maxwidth(struct ref_list *refs)
 	return w;
 }
=20
+static char *get_head_description()
+{
+	struct stat st;
+	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf result =3D STRBUF_INIT;
+	int bisect =3D 0;
+	int ret;
+	if (!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode))
+		ret =3D strbuf_read_file(&sb, git_path("rebase-merge/head-name"), 0)=
;
+	else if (!access(git_path("rebase-apply/rebasing"), F_OK))
+		ret =3D strbuf_read_file(&sb, git_path("rebase-apply/head-name"), 0)=
;
+	else if (!access(git_path("BISECT_LOG"), F_OK)) {
+		ret =3D strbuf_read_file(&sb, git_path("BISECT_START"), 0);
+		bisect =3D 1;
+	} else
+		return xstrdup(_("(no branch)"));
+
+	if (ret <=3D 0)
+		return xstrdup(bisect ? _("(bisecting)") : _("_(rebasing)"));
+
+	while (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
+		strbuf_setlen(&sb, sb.len - 1);
+
+	if (bisect) {
+		unsigned char sha1[20];
+		if (!get_sha1_hex(sb.buf, sha1))
+			strbuf_addstr(&result, _("(bisecting)"));
+		else
+			strbuf_addf(&result, _("(bisecting %s)"), sb.buf);
+	} else {
+		if (!prefixcmp(sb.buf, "refs/heads/"))
+			strbuf_addf(&result, _("(rebasing %s)"), sb.buf + 11);
+		else
+			strbuf_addstr(&result, _("(rebasing)"));
+	}
+	strbuf_release(&sb);
+	return strbuf_detach(&result, NULL);
+}
=20
 static void show_detached(struct ref_list *ref_list)
 {
@@ -557,7 +595,7 @@ static void show_detached(struct ref_list *ref_list=
)
=20
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
-		item.name =3D xstrdup(_("(no branch)"));
+		item.name =3D get_head_description();
 		item.width =3D utf8_strwidth(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3e0e15f..90968d5 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git/B=
ISECT_START" not modified if
 	cp .git/BISECT_START saved &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
+	test_i18ngrep "* (bisecting other)" branch.output > /dev/null &&
 	test_cmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken =
rev' '
--=20
1.8.1.1.459.g5970e58
