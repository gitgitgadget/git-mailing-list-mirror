From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] branch: show (rebasing) or (bisecting) instead of (no branch) when possible
Date: Tue, 29 Jan 2013 19:12:54 +0700
Message-ID: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 13:12:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0A3R-0004yX-1o
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 13:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433Ab3A2MMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 07:12:23 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56972 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab3A2MMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 07:12:22 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so246750pbc.31
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 04:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NQ+ZhxroTLhJ86J0w/+Gj21WU9PLVYa4LtCGY5qoavg=;
        b=toy+bSCAijD7KKNgYp5UIISjC4ntEqiiMs0kpTYeAfy0mz2X6VwCUsxbN/wyORtUWe
         aIp0h6M2vBqcnxBeMqkpY5oGnVK1ZTeDpXWIF9GCqXHzHPGrnplQuqpYZTWVjDC6GzVr
         zgrPIlzIl0adHFMQsNIVp5Se8T6XDLBlfQDedSsOI2RNFHFkKx8cJekyfoDsxfnt0mQq
         Gmr8je9B8IsxUGAYjZpd/EFbBXTw96t6F19kO1wGAUMmrLMc3oV9CM+uEHeV8aptVoI9
         vMIsw7HefgzaCoXgcZDzOnhgPNcjs+QL4SzO9a5P8F/mvunsB5xqG/0CWr8U7a7jKfZE
         QSUw==
X-Received: by 10.68.132.232 with SMTP id ox8mr1884255pbb.46.1359461542012;
        Tue, 29 Jan 2013 04:12:22 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id z10sm8815705pax.38.2013.01.29.04.12.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 04:12:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jan 2013 19:12:55 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214933>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 In the spirit of status' in-progress info. I think showing this is
 more useful than "(no branch)". I tend to do "git br" more often than
 "git st" and this catches my eyes.

 builtin/branch.c            | 10 +++++++++-
 t/t6030-bisect-porcelain.sh |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 873f624..b0c5a20 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -557,7 +557,15 @@ static void show_detached(struct ref_list *ref_lis=
t)
=20
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commi=
t)) {
 		struct ref_item item;
-		item.name =3D xstrdup(_("(no branch)"));
+		struct stat st;
+		if ((!stat(git_path("rebase-apply"), &st) &&
+		     stat(git_path("rebase-apply/applying"), &st)) ||
+		    !stat(git_path("rebase-merge"), &st))
+			item.name =3D xstrdup(_("(rebasing)"));
+		else if (!stat(git_path("BISECT_LOG"), &st))
+			item.name =3D xstrdup(_("(bisecting)"));
+		else
+			item.name =3D xstrdup(_("(no branch)"));
 		item.width =3D utf8_strwidth(item.name);
 		item.kind =3D REF_LOCAL_BRANCH;
 		item.dest =3D NULL;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3e0e15f..bc21bc9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git/B=
ISECT_START" not modified if
 	cp .git/BISECT_START saved &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
+	test_i18ngrep "* (bisecting)" branch.output > /dev/null &&
 	test_cmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken =
rev' '
--=20
1.8.1.1.459.g5970e58
