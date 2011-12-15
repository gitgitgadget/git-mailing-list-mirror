From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] commit: refuse commit messages that contain NULs
Date: Thu, 15 Dec 2011 20:47:23 +0700
Message-ID: <1323956843-5326-3-git-send-email-pclouds@gmail.com>
References: <1323871699-8839-2-git-send-email-pclouds@gmail.com>
 <1323956843-5326-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 14:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbBes-0002xb-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 14:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758856Ab1LONre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 08:47:34 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52945 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab1LONrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 08:47:33 -0500
Received: by ggdk6 with SMTP id k6so1785906ggd.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rODfvGu90I6EBVeD9vNtws+t7XPayFew3lEFwtGT+Qg=;
        b=HAGuYOxScM0eOy/8RJ0hxceMHbb+2UKyT56Iu1bJDTGhFw2Rv1sGVHMxf6VnHelQmN
         a0e+efasvLc2uJs6/aG2zYNxT9iKJAseq6cZtL+r86kCSmbuuePE+Q4Pa3TgrBAqdU3r
         cx1BDU9q8BY6WLYAsY8Qyr2urlbpcLWM+uriE=
Received: by 10.50.85.136 with SMTP id h8mr3108431igz.56.1323956852912;
        Thu, 15 Dec 2011 05:47:32 -0800 (PST)
Received: from tre ([115.74.57.162])
        by mx.google.com with ESMTPS id wp7sm10696054igc.6.2011.12.15.05.47.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 05:47:32 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 15 Dec 2011 20:47:44 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323956843-5326-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187209>

Current implementation sees NUL as terminator. If users give a
NUL-included message (e.g. editor accidentally set to save as UTF-16),
the new commit message will have NULs. However following operations
(displaying or amending a commit for example) will not show anything
after the first NUL.

Stop user right when they do this. If NUL is added by mistake, they
have their chance to fix. If they know that they are doing,
commit-tree will gladly commit whatever is given.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Advice stuff dropped. I realized quite late that commit_tree() is
 also used for plumbing commands (also thanks to Junio's comments),
 while I wanted to check at porcelain level only. So I moved the check
 up to builtin/commit.c. If we need the same check for other commands,
 which I doubt, similar checks can be added.

 builtin/commit.c       |    7 +++++++
 t/t3900-i18n-commit.sh |    6 ++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 849151e..5db7673 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,6 +1483,13 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 		exit(1);
 	}
=20
+	if (memchr(sb.buf, '\0', sb.len)) {
+		rollback_index_files();
+		die(_("your commit message contains NUL characters.\n"
+		      "hint: This is often caused by using wide encodings such as\n"
+		      "hint: UTF-16. Please check your editor settings."));
+	}
+
 	if (commit_tree(&sb, active_cache_tree->sha1, parents, sha1,
 			author_ident.buf)) {
 		rollback_index_files();
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 1f62c15..d48a7c0 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -34,6 +34,12 @@ test_expect_success 'no encoding header for base cas=
e' '
 	test z =3D "z$E"
 '
=20
+test_expect_failure 'UTF-16 refused because of NULs' '
+	echo UTF-16 >F &&
+	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
+'
+
+
 for H in ISO8859-1 eucJP ISO-2022-JP
 do
 	test_expect_success "$H setup" '
--=20
1.7.8.36.g69ee2
