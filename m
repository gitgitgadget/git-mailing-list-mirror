From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] ls-files: support --max-depth
Date: Thu, 20 Mar 2014 17:15:50 +0700
Message-ID: <1395310551-23201-8-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa1e-0001kY-Fh
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbaCTKQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:16:29 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39881 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbaCTKQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:16:27 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so734317pab.27
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3NlQmX3f6QDGvko8IaPpamUD8vAl39rCfzAvOiulceY=;
        b=EMf0VLe15egwd/CzJl+me28X5KsvGm/7gAFJzNK6tNjkB5s5PVIXmUs1OWL24697F4
         speyjqT21v/LW87oHsIKQ1tu/EXrDGNyZjX/wSwiHwvg3PPsERp1NPg4U1JpJG6TS2m5
         6VV5oQg8Rn4Y4P2WuyMgPdc2TIJkZJ9SsUIZJ6S7J6rjyQApsJDnNFQI+CcuLuWi1QtR
         ZXHs1sOldAANWS4WkqV+vc6BZHVW8Wx20QMROxgzBbbv7glQM8LRN/z0BYbWUUTMLiaf
         oX/5+yatl4xujePqDx2bo8EAEwV9KzFjWPFgtgQkJ2sNB/anvdLlncZQksDOM68IFQrC
         ggrw==
X-Received: by 10.66.146.199 with SMTP id te7mr45619709pab.106.1395310586901;
        Thu, 20 Mar 2014 03:16:26 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id i10sm7748844pat.36.2014.03.20.03.16.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:16:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:17:05 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244537>

The use case in mind is --max-depth=3D0 to stop recursion. With this we=
 can do

git config --global alias.ls 'ls-files --column --color --max-depth=3D0=
'

and have "git ls" with an output very similar to GNU ls. Another
interesting one is

git config --global alias.lso 'ls-files --column --color --max-depth=3D=
0 -o --exclude-standard'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a43abdb..2c51b0a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -478,6 +478,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 {
 	int require_work_tree =3D 0, show_tag =3D 0, i;
 	unsigned int colopts =3D 0;
+	int max_depth =3D -1;
 	const char *max_prefix;
 	struct dir_struct dir;
 	struct exclude_list *el;
@@ -535,6 +536,9 @@ int cmd_ls_files(int argc, const char **argv, const=
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
@@ -591,8 +595,11 @@ int cmd_ls_files(int argc, const char **argv, cons=
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
1.9.0.40.gaa8c3ea
