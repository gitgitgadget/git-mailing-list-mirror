From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/17] ls-files: support --max-depth
Date: Wed, 26 Mar 2014 20:48:08 +0700
Message-ID: <1395841697-11742-9-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:48:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoC8-0008Sm-NU
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbaCZNsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:36 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59780 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCZNsf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:48:35 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so1972577pab.11
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hqVoCPzpAxQ6gchU10nn700FrWOyhmJL2eCnhCRUnIc=;
        b=rzjD18GlW91yocvyOAcDQQf+PiTpy5X1LyXLjWo0MDVduq0dL1eHnVxhBaMtNW1Ydm
         aSjDSu8HisK6ShFJLAUg0IsYb3kKrJHZ/mZYCBftjRJ4hRtYMaPqjMPoK4H+04fYx9fF
         b1KIR+ku9rh6cYRb3AqPVQpPVrmgu4NdM6X+Pnrq/gWs1eumZVhryLyV2Lcyy0QtG5Lg
         VgxcM81lIpBmEd+Y7+qvqqrO6M8e5u6zuB2Yvq5Mx6wGQ+EXVlqBCQzXb42jPeLyeTWD
         rP4pmSnjnC+L+Ko2e/gjF2KtAl+8ue92TYHn0g9fM7ldD6Bwp27mz0ku+eOiM8KLfNvb
         CwkQ==
X-Received: by 10.68.52.132 with SMTP id t4mr86153252pbo.102.1395841715380;
        Wed, 26 Mar 2014 06:48:35 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id vf7sm58552903pbc.5.2014.03.26.06.48.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:48:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:49:28 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245187>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt | 7 +++++++
 builtin/ls-files.c             | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index cd52461..3c022eb 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -162,6 +162,13 @@ a space) at the start of each line:
 	for option syntax.`--column` and `--no-column` without options
 	are equivalent to 'always' and 'never' respectively.
=20
+--max-depth <depth>::
+	For each <pathspec> given on command line, descend at most <depth>
+	levels of directories. A negative value means no limit.
+	This option is ignored if <pathspec> contains active wildcards.
+	In other words if "a*" matches a directory named "a*",
+	"*" is matched literally so --max-depth is still effective.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 335d3b0..8eef423 100644
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
