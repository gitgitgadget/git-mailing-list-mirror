From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/6] config.c: allow to un-share certain config in multi-worktree setup
Date: Sun, 27 Dec 2015 10:14:38 +0700
Message-ID: <1451186079-6119-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Dec 27 04:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD1nv-0003ge-RM
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbbL0DP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:15:26 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33276 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbbL0DPY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:15:24 -0500
Received: by mail-pa0-f45.google.com with SMTP id cy9so93827562pac.0
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m2ET+lGkK8jvKv8Za9cgqcXEmPrF3Wu0Ysq59+1Ge/E=;
        b=xlxtk2iaNPnZqtLbi5SPdfSACNhxqr3UHizcXRuiZszJ/6ybLy6kE+pg242XmD8n2H
         d/iLlnaYcboZzCdGc1R0q1CvrhG6xEwcY34Rkxnktach1t3rqY4oAVriUwftxWyMDPmo
         mEEiPM6sUjFpE8KOC2eje8+iqUscWZknAxEu81paGI/XPj5m2GS0ly2fmeTX2RHXBeV8
         RQpCbJFA8ffZQc7Nmd9qNhB2GPFlZzZ93yp0meQXL2R0EQ+4YyrmSQ4uCfgPiurYVlbl
         fBtDp2/tIsRvjajp5JAyprPfllQ4ikvJqd7UM0hc5wp00abqxp7fY3w6hqyv8DSGIZrK
         rlHg==
X-Received: by 10.67.5.69 with SMTP id ck5mr68847132pad.125.1451186124273;
        Sat, 26 Dec 2015 19:15:24 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id n64sm67906604pfi.19.2015.12.26.19.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:15:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:15:29 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283013>

Repo ext worktree=3D1 provides a set of config vars that _must_ be
per-worktree. However, the user may want to make some more config vars
per-worktree, depending on their workflow.

include.path is extended to make this possible. If the given path is
in the form "$GIT_xyz/abc" then "$GIT_xyz" will be expanded using the
corresponding environment variable. To unshare, the user can save
config in, for example, $GIT_DIR/worktrees/<id>/config.worktree and
specify this in $GIT_DIR/config

    include.path =3D $GIT_DIR/config.worktree

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h       |  1 +
 config.c      | 26 ++++++++++++++++++++++++++
 environment.c | 13 +++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/cache.h b/cache.h
index 10f4ff8..cc00ca1 100644
--- a/cache.h
+++ b/cache.h
@@ -454,6 +454,7 @@ extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
+extern const char *get_git_env(const char *name);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern int is_git_directory(const char *path);
diff --git a/config.c b/config.c
index 5aa1379..eb951f5 100644
--- a/config.c
+++ b/config.c
@@ -155,6 +155,32 @@ static int handle_path_include(const char *path, s=
truct config_include_data *inc
 	expanded =3D expand_user_path(path);
 	if (!expanded)
 		return error("Could not expand include path '%s'", path);
+
+	if (starts_with(expanded, "$GIT_")) {
+		char *slash =3D expanded;
+		const char *base =3D NULL;
+		struct strbuf sb =3D STRBUF_INIT;
+
+		while (*slash && !is_dir_sep(*slash))
+			slash++;
+
+		if (*slash) {
+			char saved_slash =3D *slash;
+			*slash =3D '\0';
+			base =3D get_git_env(expanded + 1);
+			*slash =3D saved_slash;
+		}
+
+		if (!base) {
+			free(expanded);
+			return error("Could not expand include path '%s'", path);
+		}
+
+		strbuf_addstr(&sb, real_path(base));
+		strbuf_addstr(&sb, slash);
+		free(expanded);
+		expanded =3D strbuf_detach(&sb, NULL);
+	}
 	path =3D expanded;
=20
 	/*
diff --git a/environment.c b/environment.c
index a3f17ed..7a1d62e 100644
--- a/environment.c
+++ b/environment.c
@@ -321,3 +321,16 @@ const char *get_commit_output_encoding(void)
 {
 	return git_commit_encoding ? git_commit_encoding : "UTF-8";
 }
+
+const char *get_git_env(const char *name)
+{
+	if (!strcmp(name, GIT_DIR_ENVIRONMENT))
+		return get_git_dir();
+	else if (!strcmp(name, GIT_WORK_TREE_ENVIRONMENT))
+		return get_git_work_tree();
+	else if (!strcmp(name, GIT_COMMON_DIR_ENVIRONMENT))
+		return get_git_common_dir();
+	// else if ... check environment.c
+	else
+		return getenv(name);
+}
--=20
2.3.0.rc1.137.g477eb31
