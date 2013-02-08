From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] branch: show rebase/bisect info when possible instead of "(no branch)"
Date: Fri,  8 Feb 2013 17:09:31 +0700
Message-ID: <1360318171-17614-1-git-send-email-pclouds@gmail.com>
References: <1359870520-22644-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 11:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ktR-0001Xn-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 11:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760049Ab3BHKIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 05:08:54 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:62208 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758959Ab3BHKIx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 05:08:53 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1935761pad.25
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 02:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=L9e861pCoiG+eO1AFnt4ieJcktrDzIylpZ6x9BAvH80=;
        b=y4qxCUZD0/0tfCKcJAv1pg69mR4IGXGxov+mcl+5PAZiInnjJyn7HLzmD4b/DhaZ2b
         uqBACW8DE9JRBhZriZA165TB2z8t0/BD1QpCqH66BDAfqi7x14qpdBX2cLnB0nqkTOPB
         Vwrfi+cLh/XCekjAY44lSlfgN+IcYlPRIKrTVUXAER7j1gUpDnzRZtCTxz8MVuKUg8x4
         177rYwDZvy0p3JqO3Q+hX8vVJiJL5AQkiEa0Ugq4OEm2vu+kRENYaaq3ac0nxKA0ueg6
         31XS/uV9SLhzC8gJG4BZovzV1d5ak6UwpxblOnixXk3qs4TiKsgLehOY3rkn9CJLYbJM
         rEmg==
X-Received: by 10.66.9.2 with SMTP id v2mr15748209paa.18.1360318131469;
        Fri, 08 Feb 2013 02:08:51 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id e6sm53216178paw.16.2013.02.08.02.08.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 02:08:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Feb 2013 17:09:33 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1359870520-22644-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215771>

This prints more helpful info when HEAD is detached: is it detached
because of bisect or rebase? What is the original branch name in those
cases?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Keep "no branch" in all cases. Just append "rebasing/bisecting [%s]"
 when applicable.

 builtin/branch.c            | 44 +++++++++++++++++++++++++++++++++++++=
++++++-
 t/t6030-bisect-porcelain.sh |  2 +-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6371bf9..26c0c3d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -550,6 +550,48 @@ static int calc_maxwidth(struct ref_list *refs)
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
+	if (ret <=3D 0) {
+		if (bisect)
+			return xstrdup(_("(no branch, bisecting)"));
+		else
+			return xstrdup(_("_(no branch, rebasing)"));
+	}
+
+	while (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
+		strbuf_setlen(&sb, sb.len - 1);
+
+	if (bisect) {
+		unsigned char sha1[20];
+		if (!get_sha1_hex(sb.buf, sha1))
+			strbuf_addstr(&result, _("(no branch, bisecting)"));
+		else
+			strbuf_addf(&result, _("(no branch, bisecting %s)"), sb.buf);
+	} else {
+		if (!prefixcmp(sb.buf, "refs/heads/"))
+			strbuf_addf(&result, _("(no branch, rebasing %s)"), sb.buf + 11);
+		else
+			strbuf_addstr(&result, _("(no branch, rebasing)"));
+	}
+	strbuf_release(&sb);
+	return strbuf_detach(&result, NULL);
+}
=20
 static void show_detached(struct ref_list *ref_list)
 {
@@ -557,7 +599,7 @@ static void show_detached(struct ref_list *ref_list=
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
index 3e0e15f..9b6f0d0 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git/B=
ISECT_START" not modified if
 	cp .git/BISECT_START saved &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
+	test_i18ngrep "* (no branch, bisecting other)" branch.output > /dev/n=
ull &&
 	test_cmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken =
rev' '
--=20
1.8.1.2.536.gf441e6d
