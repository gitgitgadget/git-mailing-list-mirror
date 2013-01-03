From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/5] format-patch: pick up branch description when no ref is specified
Date: Thu,  3 Jan 2013 21:03:11 +0700
Message-ID: <1357221791-7496-6-git-send-email-pclouds@gmail.com>
References: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 15:04:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqlOr-0001Rf-TU
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 15:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3ACODk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 09:03:40 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42129 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab3ACODj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 09:03:39 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so8505667pbc.8
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gOlu5eFDEoOpMnN0GBPrFFLlhCliWZZbTaDrB9bkhEg=;
        b=cMicdZTausbtzdH+5t4h4LKEo7KJ9W8miVAcnGFNIIkubm95pwOuSo8DcDHflINbDy
         II0YoD/OndPnUCy6jRJH6emwmilfhmGGWz+uhIaLeZE1FBFj0sVxpiTWgG6RWqBiTdUv
         5vXtvXnhxK4XoSOdRx7jZMm/xytWpEjpFgdgq7lhnsMav2CQi8sZ8fiygfKNYvYDnldC
         HrwazVfavGIPZbyhHfEWZj7MRG3OauBsnkoMBC9UnaYzQDWu1gpALpLOfjdOujcsA3+B
         iFSYMP/AGdV+Tc77K7Ht0rUgCgtnnEKdGOOgsA+cI04uob4WxOHIsflz9UJppU/WLzG1
         H/uw==
X-Received: by 10.66.83.134 with SMTP id q6mr145990449pay.34.1357221817970;
        Thu, 03 Jan 2013 06:03:37 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id is6sm30379553pbc.55.2013.01.03.06.03.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 06:03:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 03 Jan 2013 21:03:44 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212588>

We only try to get branch name in "format-patch origin" case or
similar and not "format-patch -22" where HEAD is automatically
added. Without correct branch name, branch description cannot be
added. Make sure we always get branch name.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c           | 16 +++++++++++++---
 t/t4014-format-patch.sh |  7 +++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 039bf67..81683f6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1027,12 +1027,22 @@ static char *find_branch_name(struct rev_info *=
rev)
 		else
 			return NULL;
 	}
-	if (positive < 0)
+	if (positive >=3D 0)
+		ref =3D rev->cmdline.rev[positive].name;
+	else if (!rev->cmdline.nr && rev->pending.nr =3D=3D 1 &&
+		 !strcmp(rev->pending.objects[0].name, "HEAD"))
+		/*
+		 * No actual ref from command line, but "HEAD" from
+		 * rev->def was added in setup_revisions()
+		 * e.g. format-patch --cover-letter -12
+		 */
+		ref =3D "HEAD";
+	else
 		return NULL;
-	ref =3D rev->cmdline.rev[positive].name;
 	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
 	    !prefixcmp(full_ref, "refs/heads/") &&
-	    !hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
+	    (positive < 0 ||
+	     !hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1)))
 		branch =3D xstrdup(full_ref + strlen("refs/heads/"));
 	free(full_ref);
 	return branch;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 903a797..7e52941 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -998,4 +998,11 @@ test_expect_success 'cover letter using branch des=
cription (5)' '
 	grep hello actual >/dev/null
 '
=20
+test_expect_success 'cover letter using branch description (6)' '
+	git checkout rebuild-1 &&
+	test_config branch.rebuild-1.description hello &&
+	git format-patch --stdout --cover-letter -2 >actual &&
+	grep hello actual >/dev/null
+'
+
 test_done
--=20
1.8.0.rc2.23.g1fb49df
