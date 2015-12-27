From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/6] worktree: bump worktree version to 1 on "worktree add"
Date: Sun, 27 Dec 2015 10:14:39 +0700
Message-ID: <1451186079-6119-7-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, max@max630.net, Jens.Lehmann@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 04:15:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD1o0-0003me-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbbL0DPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:15:32 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33304 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbbL0DPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:15:31 -0500
Received: by mail-pa0-f46.google.com with SMTP id cy9so93828339pac.0
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hmb2JrsutD40hSGBDM40IOiB3NdMrRy5amh4FjIY/oI=;
        b=JpQ2/TypjX9UscHm/eqR/kBTYARq06bru8QejSYjPOziRGvyrm62XADtLZIpWJDaWQ
         R5YKfogI4DWUoVjl8LhW7Etxu20FSm09D4MRXhIDwjN7lLfF6M7NysYtAnbZ2JsNNzeI
         cTXcyHYwilaacY92N9fOOPjZ8gz5J7+DC6oOx0UjnZdrafuqySbrxVSYItmd7kpaTV/w
         PvpiR1nc993PZ7H5cx45qXJlGp7qiBJxKS4bVJfYkEfivFy3myRK5e4WUYJe1t7C9APT
         k2k8Ay4Nxa4qaBdv1C8Z+CESpcg6uIcL0L9cC/4WxtC6D/YHzYRynX/XmXrkWGiGoAsf
         FikA==
X-Received: by 10.66.100.198 with SMTP id fa6mr27226990pab.123.1451186131321;
        Sat, 26 Dec 2015 19:15:31 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id xz6sm72723496pab.42.2015.12.26.19.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:15:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:15:36 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283014>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 475b958..2ec9c36 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -184,6 +184,37 @@ static const char *worktree_basename(const char *p=
ath, int *olen)
 	return name;
 }
=20
+static int git_config_set_int(const char *key, int value)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret;
+
+	strbuf_addf(&sb, "%d", value);
+	ret =3D git_config_set(key, sb.buf);
+	strbuf_release(&sb);
+	return ret;
+}
+
+static void upgrade_worktree_version(void)
+{
+	if (repository_format_worktree_version !=3D 0)
+		/*
+		 * XXX: anything else to do when upgrading from
+		 * version X to Y? Also, the user may want to stick to
+		 * a particular version if multiple git versions
+		 * operate on this repo. In that case, do not
+		 * automatically bump version up.
+		 */
+		return;
+	repository_format_worktree_version =3D 1;
+	if (repository_format_version < 2)
+		repository_format_version =3D 2;
+	git_config_set_int("core.repositoryformatversion",
+			   repository_format_version);
+	git_config_set_int("extensions.worktree",
+			   repository_format_worktree_version);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -268,6 +299,8 @@ static int add_worktree(const char *path, const cha=
r *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
=20
+	upgrade_worktree_version();
+
 	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
=20
 	argv_array_pushf(&child_env, "%s=3D%s", GIT_DIR_ENVIRONMENT, sb_git.b=
uf);
--=20
2.3.0.rc1.137.g477eb31
