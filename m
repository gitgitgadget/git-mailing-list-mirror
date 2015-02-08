From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/21] ls-files: support --max-depth
Date: Sun,  8 Feb 2015 16:01:26 +0700
Message-ID: <1423386099-19994-9-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:03:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNlm-000610-QA
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbbBHJDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:05 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41510 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbbBHJDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:03 -0500
Received: by pdno5 with SMTP id o5so2144808pdn.8
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W5yduMsxIMAewdK59+AUM1QVcFMhTzc7zFDG/zs3/dk=;
        b=YsfrnBf0G1XOSo6dp2zMnKQskO8BoQbbO21DAvtrdsTgFM7qvUAknnTexMTb6qHQgG
         IHrmMZykwfQbbwSNtBc74fnTNNTee2H84og2TqXwirwao5OzutxKWCJ8PMKf4nAWJijp
         HESvOSm3F01RMlH7wQ4UOkLhMwujoqHttLDp6sA1UBvewwq0+53BJsMdHlJ1jF2NFeIG
         NwUEt2qd5VmMZ2fPeo45aAwQnAV6A9qDFzDKZPP/EUEOqwc68TGaTgzJA8zngaZpIli3
         CjQgDwrb366eHYxXwlaW+xBtImV7wRSR2QXWY9ka/K4nKlSDn6eRQz/O0t/+fA/4/Rqk
         DgAg==
X-Received: by 10.66.65.195 with SMTP id z3mr19490064pas.104.1423386183235;
        Sun, 08 Feb 2015 01:03:03 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id bc1sm13050972pad.12.2015.02.08.01.03.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:10 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263495>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt | 7 +++++++
 builtin/ls-files.c             | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 99328b9..3d921eb 100644
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
index 44e5628..09a6b8d 100644
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
2.3.0.rc1.137.g477eb31
