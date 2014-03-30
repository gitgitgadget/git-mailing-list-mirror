From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/18] ls-files: support --max-depth
Date: Sun, 30 Mar 2014 20:55:59 +0700
Message-ID: <1396187769-30863-9-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGE0-00035O-Rc
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbaC3N4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:31 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:64492 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaC3N42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:28 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so6834549pdj.31
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rB+vVP/AgKaS7GAkpqL03qwFm7j9500kY1aD5WqGSm4=;
        b=n8sAQSVHFVyLjKmcO2MPys/Ah9IrIq5/POI+9AWYNCk8d/WgXZiihcEGUqOGkieeDp
         5sAP5EQ4YhOoDCnLv8+KuWH1ySjYTpDcw8zCYm5sxeZihutQzdadZLMqu1e0cG9RKWwC
         xb9ltFTsbDtKzjwy+nsRbSS8stwh2IVutD4X675IvrTwHS+EhsGPiOURdu12CB6/1PTm
         OQcOP/iFSmvuvCrl0wVzZGhfa5jy7w852esmEL5GcuMU31VNihsMEw00BReiESZ6reKI
         8vuO70CRSZMBayxmLTIzyww1b5NsNeDnbhEiJjM1hKbc7z9BrI5K3Ne150so1+I4MzXz
         Nf6w==
X-Received: by 10.68.233.99 with SMTP id tv3mr168159pbc.163.1396187787887;
        Sun, 30 Mar 2014 06:56:27 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id el14sm26229802pac.31.2014.03.30.06.56.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:25 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245471>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt | 7 +++++++
 builtin/ls-files.c             | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index a5a30c2..ad621b5 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -160,6 +160,13 @@ a space) at the start of each line:
 	for option syntax. `--column` and `--no-column` without options
 	are equivalent to 'always' and 'never' respectively.
=20
+--max-depth=3D<depth>::
+	For each <pathspec> given on command line, descend at most <depth>
+	levels of directories. A negative value means no limit (default).
+	This option is ignored if <pathspec> contains active wildcards.
+	In other words if "a*" matches a directory named "a*",
+	"*" is matched literally so --max-depth is still effective.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a481c37..130bed0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -503,6 +503,7 @@ static int option_parse_exclude_standard(const stru=
ct option *opt,
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree =3D 0, show_tag =3D 0, i;
+	int max_depth =3D -1;
 	const char *max_prefix;
 	struct dir_struct dir;
 	struct exclude_list *el;
@@ -560,6 +561,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")=
),
 		OPT__COLOR(&use_color, N_("show color")),
 		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
+		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
+			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
+			NULL, 1 },
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
@@ -624,8 +628,11 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
=20
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
+		       (max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
+	pathspec.max_depth =3D max_depth;
+	pathspec.recursive =3D 1;
=20
 	/* Find common prefix for all pathspec's */
 	max_prefix =3D common_prefix(&pathspec);
--=20
1.9.1.345.ga1a145c
