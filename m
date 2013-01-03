From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/5] format-patch: pick up correct branch name from symbolic ref
Date: Thu,  3 Jan 2013 21:03:10 +0700
Message-ID: <1357221791-7496-5-git-send-email-pclouds@gmail.com>
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
	id 1TqlOr-0001Rf-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 15:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab3ACODf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 09:03:35 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65363 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab3ACODc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 09:03:32 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so8620932pad.4
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 06:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Ob6cjDUNVSAGEr82vYaD1iS8TV0ZT8CZA39uzp2aJ0k=;
        b=wETtakKHBCIcDjqe+5NOx6o1d4yjddz38CcdiJFMz1G/nwZyq7kbmAIK7jf8qcECmy
         WSPd9g5NYcygygxALW4fyiWTog4fteUBjrnoD6vMzXNbfxk7qXlMlTxC4pfN3tID21JC
         aFH436fLFI8oUhTpXv9K7J10/q976ZMzehqLU8qd59Z2sj5K9Edi9sHGzP6S3Y16/+BG
         1fh0ttOKtavkEdkRzKb/0eNSeYMh9mrUmIic2AUoQ0KTyX3J8rppJ2b0rNGocrW8uLhG
         l8UCfejcDSw7JN7sGCKGyC99xBoUvTt092ao4VLXu2tICEC/Ixjp7tmS4YX72KpB9Uk+
         hrzA==
X-Received: by 10.68.203.198 with SMTP id ks6mr153109875pbc.35.1357221811675;
        Thu, 03 Jan 2013 06:03:31 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id oj1sm30390094pbb.19.2013.01.03.06.03.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 06:03:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 03 Jan 2013 21:03:37 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212587>

find_branch_name() assumes to take refs/heads/<branch>. But we also
have symbolic refs, such as HEAD, that can point to a valid branch in
refs/heads and do not follow refs/heads/<branch> syntax. Remove the
assumption and apply normal ref resolution. After all it would be
confusing if rev machinery resolves a ref in one way and
find_branch_name() another.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c           | 21 +++++++++------------
 t/t4014-format-patch.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..039bf67 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1016,8 +1016,8 @@ static char *find_branch_name(struct rev_info *re=
v)
 {
 	int i, positive =3D -1;
 	unsigned char branch_sha1[20];
-	struct strbuf buf =3D STRBUF_INIT;
-	const char *branch;
+	const char *ref;
+	char *full_ref, *branch =3D NULL;
=20
 	for (i =3D 0; i < rev->cmdline.nr; i++) {
 		if (rev->cmdline.rev[i].flags & UNINTERESTING)
@@ -1029,16 +1029,13 @@ static char *find_branch_name(struct rev_info *=
rev)
 	}
 	if (positive < 0)
 		return NULL;
-	strbuf_addf(&buf, "refs/heads/%s", rev->cmdline.rev[positive].name);
-	branch =3D resolve_ref_unsafe(buf.buf, branch_sha1, 1, NULL);
-	if (!branch ||
-	    prefixcmp(branch, "refs/heads/") ||
-	    hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
-		branch =3D NULL;
-	strbuf_release(&buf);
-	if (branch)
-		return xstrdup(rev->cmdline.rev[positive].name);
-	return NULL;
+	ref =3D rev->cmdline.rev[positive].name;
+	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
+	    !prefixcmp(full_ref, "refs/heads/") &&
+	    !hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
+		branch =3D xstrdup(full_ref + strlen("refs/heads/"));
+	free(full_ref);
+	return branch;
 }
=20
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ec9ef9e..903a797 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -984,4 +984,18 @@ test_expect_success 'cover letter using branch des=
cription (3)' '
 	grep hello actual >/dev/null
 '
=20
+test_expect_success 'cover letter using branch description (4)' '
+	git checkout rebuild-1 &&
+	test_config branch.rebuild-1.description hello &&
+	git format-patch --stdout --cover-letter master.. >actual &&
+	grep hello actual >/dev/null
+'
+
+test_expect_success 'cover letter using branch description (5)' '
+	git checkout rebuild-1 &&
+	test_config branch.rebuild-1.description hello &&
+	git format-patch --stdout --cover-letter -2 HEAD >actual &&
+	grep hello actual >/dev/null
+'
+
 test_done
--=20
1.8.0.rc2.23.g1fb49df
